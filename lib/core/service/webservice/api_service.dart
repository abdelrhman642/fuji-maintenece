/// A service class for handling API requests using the Dio HTTP client.
///
/// Provides methods for making HTTP requests (GET, POST, PUT, PATCH, DELETE, DOWNLOAD)
/// with configurable headers, timeouts, logging, and error handling.
///
/// Uses functional programming with `Either<Failure, T>` to return results or errors.
///
/// Features:
/// - Handles authentication tokens and localization headers.
/// - Supports custom headers and additional headers per request.
/// - Handles file downloads and saves them to a temporary directory.
/// - Logs requests and responses for debugging.
/// - Provides detailed error handling and maps Dio errors to custom `Failure` types.
///
/// Usage:
/// ```dart
/// final apiService = ApiService();
/// final result = await apiService.get(url: '/endpoint');
/// result.fold(
///   (failure) => handleError(failure),
///   (data) => handleData(data),
/// );
/// ```
///
/// Methods:
/// - [post]    : Sends a POST request.
/// - [patch]   : Sends a PATCH request.
/// - [put]     : Sends a PUT request.
/// - [get]     : Sends a GET request.
/// - [download]: Downloads a file from the given URL.
/// - [delete]  : Sends a DELETE request.
///
/// Call [ApiService.init] before making requests to allow self-signed certificates (for development).
library;

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/app_config.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// ignore: avoid_web_libraries_in_flutter
import 'package:fuji_maintenance_system/core/service/webservice/web_download_helper.dart';

import '../../config/api_path.dart';
import '../../errors/failure.dart';
import '../../helper/riverpod.dart';
import '../local_data_service/local_data_manager.dart';
import '../localization_service/localization_service.dart';

Logger logger = Logger();

enum _MethodType { post, get, put, patch, delete, download }

class ApiService {
  static const _connectTimeout = Duration(seconds: 30);
  static const _receiveTimeout = Duration(seconds: 30);
  static const _sendTimeout = Duration(seconds: 30);

  Map<String, String> get _defaultHeaders {
    final token = dataManager.getToken();
    return {
      'Accept-Language': getIt<LocaleService>().handleLocaleInMain.languageCode,
      "Content-Type": Headers.jsonContentType,
      "Accept": Headers.jsonContentType,
      if (token != null) 'Authorization': "Bearer $token",
    };
  }

  static final Dio _dio = Dio(
      BaseOptions(
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout,
        baseUrl: ApiPath.baseurl,
      ),
    )
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          // don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );

  static init() {
    // On web, Dio uses the browser's HTTP client automatically
    // No configuration needed for web platform
    // For mobile/desktop platforms, this would configure self-signed certificates
    // but that requires dart:io which is not available on web
    if (!kIsWeb) {
      // Note: IOHttpClientAdapter configuration is skipped on web
      // For mobile/desktop, you may need to configure it separately
      // if self-signed certificates are required
    }
  }

  // POST method
  Future<Either<Failure, T>> post<T>({
    dynamic requestBody,
    Map<String, dynamic>? header,
    bool returnDataOnly = true,
    CancelToken? cancelToken,
    bool ignoreError = false,
    bool logging = true,
    Duration? sendTimeOut = _sendTimeout,
    Duration? receiveTimeout = _receiveTimeout,
    required String url,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      cancelToken: cancelToken,
      url: url,
      header: header,
      returnDataOnly: returnDataOnly,
      methodType: _MethodType.post,
      requestBody: requestBody,
      logging: logging,
      additionalHeaders: additionalHeaders,
      receiveTimeout: receiveTimeout,
      ignoreError: ignoreError,
      sendTimeOut: sendTimeOut,
    );
  }

  Future<Either<Failure, T>> patch<T>({
    dynamic requestBody,
    Map<String, dynamic>? header,
    bool ignoreError = false,
    bool returnDataOnly = true,
    bool logging = true,
    bool waitError = false,
    CancelToken? cancelToken,
    Duration? sendTimeOut = _sendTimeout,
    Duration? receiveTimeout = _receiveTimeout,
    required String url,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      cancelToken: cancelToken,
      url: url,
      header: header,
      returnDataOnly: returnDataOnly,
      methodType: _MethodType.patch,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,
      logging: logging,
      receiveTimeout: receiveTimeout,
      sendTimeOut: sendTimeOut,
      ignoreError: ignoreError,
    );
  }

  // PUT method
  Future<Either<Failure, T>> put<T>({
    dynamic requestBody,
    Map<String, dynamic>? header,
    bool returnDataOnly = true,
    bool logging = true,
    bool waitError = false,
    CancelToken? cancelToken,
    Duration? sendTimeOut = _sendTimeout,
    Duration? receiveTimeout = _receiveTimeout,
    required String url,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      cancelToken: cancelToken,
      url: url,
      header: header,
      returnDataOnly: returnDataOnly,
      methodType: _MethodType.put,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,
      logging: logging,
      receiveTimeout: receiveTimeout,
      sendTimeOut: sendTimeOut,
    );
  }

  Future<Either<Failure, T>> get<T>({
    required String url,
    bool returnDataOnly = true,
    dynamic queryParameters,
    Duration? sendTimeOut = _sendTimeout,
    CancelToken? cancelToken,
    bool logging = true,
    bool waitError = false,
    Duration? receiveTimeout = _receiveTimeout,
    bool ignoreError = false,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      cancelToken: cancelToken,
      url: url,
      returnDataOnly: returnDataOnly,
      methodType: _MethodType.get,
      requestBody: queryParameters,
      additionalHeaders: additionalHeaders,
      logging: logging,
      receiveTimeout: receiveTimeout,
      sendTimeOut: sendTimeOut,
      ignoreError: ignoreError,
    );
  }

  Future<Either<Failure, T>> download<T>({
    required String url,
    CancelToken? cancelToken,
    bool waitError = false,
    dynamic queryParameters,
  }) async {
    return _hitApi(
      cancelToken: cancelToken,
      url: url,
      methodType: _MethodType.download,
      returnDataOnly: false,
      requestBody: queryParameters,
      receiveTimeout: Duration.zero,
      sendTimeOut: Duration.zero,
    );
  }

  Future<Either<Failure, T>> delete<T>({
    required String url,
    bool returnDataOnly = true,
    bool logging = true,
    CancelToken? cancelToken,
    dynamic queryParameters,
    Duration? sendTimeOut = _sendTimeout,
    bool ignoreError = false,
    Duration? receiveTimeout = _receiveTimeout,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      cancelToken: cancelToken,
      url: url,
      returnDataOnly: returnDataOnly,
      methodType: _MethodType.delete,
      requestBody: queryParameters,
      additionalHeaders: additionalHeaders,
      logging: logging,
      receiveTimeout: receiveTimeout,
      sendTimeOut: sendTimeOut,
      ignoreError: ignoreError,
    );
  }

  Future<Either<Failure, T>> _hitApi<T>({
    required _MethodType methodType,
    required String url,
    bool returnDataOnly = true,
    CancelToken? cancelToken,
    dynamic requestBody,
    bool logging = true,
    bool ignoreError = false,
    Map<String, dynamic>? header,
    Duration? sendTimeOut = _sendTimeout,
    Duration? receiveTimeout = _receiveTimeout,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    try {
      AppConfig.providerContainer.refresh(hasInternetProvider2);
      final Map<String, dynamic> headers =
          header ?? {..._defaultHeaders, ...additionalHeaders};

      if (logging) {
        logger.f(
          "$methodType:${_dio.options.baseUrl + url}\n$headers\n${requestBody ?? ''}",
        );
        if (requestBody is FormData) {
          logger.f((requestBody).fields);
          logger.f((requestBody).files);
        }
      }

      late String path;
      Response<dynamic> response;

      switch (methodType) {
        case _MethodType.post:
          response = await _dio.post(
            url,
            options: Options(
              headers: headers,
              receiveTimeout: receiveTimeout,
              sendTimeout: sendTimeOut,
            ),
            data: requestBody,
            cancelToken: cancelToken,
          );
          break;
        case _MethodType.get:
          response = await _dio.get(
            url,
            options: Options(headers: headers),
            queryParameters: requestBody,
            cancelToken: cancelToken,
          );
          break;
        case _MethodType.put:
          response = await _dio.put(
            url,
            options: Options(
              headers: headers,
              receiveTimeout: receiveTimeout,
              sendTimeout: sendTimeOut,
            ),
            data: requestBody,
            cancelToken: cancelToken,
          );
          break;
        case _MethodType.patch:
          response = await _dio.patch(
            url,
            options: Options(
              headers: headers,
              receiveTimeout: receiveTimeout,
              sendTimeout: sendTimeOut,
            ),
            data: requestBody,
            cancelToken: cancelToken,
          );
          break;
        case _MethodType.delete:
          response = await _dio.delete(
            url,
            options: Options(headers: headers),
            queryParameters: requestBody,
            cancelToken: cancelToken,
          );
          break;
        case _MethodType.download:
          if (kIsWeb) {
            // On web, download as bytes and trigger browser download
            response = await _dio.get(
              url,
              options: Options(
                headers: headers,
                responseType: ResponseType.bytes,
              ),
              queryParameters: requestBody,
              cancelToken: cancelToken,
            );
            if (response.statusCode! >= 200 && response.statusCode! < 300) {
              final bytes = response.data as Uint8List;
              final fileName =
                  "report_${DateTime.now().millisecondsSinceEpoch}.pdf";
              WebDownloadHelper.downloadFile(bytes, fileName);
              return Right(fileName as T);
            }
          } else {
            path = join(
              await (getTemporaryDirectory().then((value) => value.path)),
              "${DateTime.now().millisecondsSinceEpoch}.pdf",
            );
            response = await _dio.download(
              url,
              path,
              cancelToken: cancelToken,
              queryParameters: requestBody,
              options: Options(headers: headers),
            );
          }
          break;
      }

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        // if (Constants.loggerResponse && logging)
        logger.w(response.data);
        if (_MethodType.download == methodType) {
          return Right(path as T);
        } else {
          if (returnDataOnly) {
            return Right(response.data['data'] as T);
          } else {
            return Right(response.data as T);
          }
        }
      } else {
        logger.w(response.data);
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      logger.w(e.response?.data['message']);
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure('Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return const AuthFailure('Unauthorized access');
        } else if (statusCode == 403) {
          return const AuthFailure('Access forbidden');
        } else if (statusCode == 404) {
          return const ServerFailure('Resource not found');
        } else if (statusCode == 422) {
          return ServerFailure(
            error.response?.data['message'] ?? 'Unprocessable entity',
          );
        } else if (statusCode == 500) {
          return const ServerFailure('Internal server error');
        } else {
          return ServerFailure(
            'Server error: ${error.response?.data['message']}',
          );
        }
      case DioExceptionType.cancel:
        return const NetworkFailure('Request cancelled');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');
      case DioExceptionType.unknown:
        return UnknownFailure(error.message ?? 'Unknown error occurred');
      default:
        return UnknownFailure(error.message ?? 'Unknown error occurred');
    }
  }
}
