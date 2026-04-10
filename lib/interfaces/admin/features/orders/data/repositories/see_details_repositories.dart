import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/data/models/see_details_order_model.dart';

abstract class SeeDetailsRepository {
  Future<Either<Failure, SeeDetailsOrderModel>> fetchOrderDetails(int orderId);

  Future<Either<Failure, String>> approveOrder(int orderId, String note);
  Future<Either<Failure, String>> rejectOrder(int orderId, String reason);
  Future<Either<Failure, String>> exportReportAsPdf(int reportId);
}

class SeeDetailsRepositoryImpl extends SeeDetailsRepository {
  final ApiService _apiService;
  SeeDetailsRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, SeeDetailsOrderModel>> fetchOrderDetails(
    int orderId,
  ) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.showContractRenewalRequest(orderId),
        returnDataOnly: false,
      );
      return response.fold((failure) => Left(failure), (result) {
        print('🔍 Raw API Response: $result');
        print('🔍 Response Type: ${result.runtimeType}');

        final SeeDetailsOrderModel orderDetails = SeeDetailsOrderModel.fromJson(
          result,
        );

        print('🔍 Parsed Model - Success: ${orderDetails.success}');
        print('🔍 Parsed Model - Message: ${orderDetails.message}');
        print('🔍 Parsed Model - Data: ${orderDetails.data}');

        return Right(orderDetails);
      });
    } catch (e) {
      print('❌ Error in fetchOrderDetails: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> approveOrder(int orderId, String note) async {
    try {
      final res = await _apiService.post(
        url: ApiPath.approveContractRenewalRequest(orderId),
        requestBody: {"admin_notes": note},
        returnDataOnly: false,
      );
      return res.fold((failure) => Left(failure), (result) {
        return Right(result['message']);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> rejectOrder(
    int orderId,
    String reason,
  ) async {
    try {
      final res = await _apiService.post(
        url: ApiPath.rejectContractRenewalRequest(orderId),
        requestBody: {"admin_reason": reason},
        returnDataOnly: false,
      );
      return res.fold((failure) => Left(failure), (result) {
        return Right(result['message']);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> exportReportAsPdf(int reportId) async {
    try {
      final response = await _apiService.download(
        url: ApiPath.downloadContractRenewalRequestPdf(reportId),
      );

      return response.fold(
        (failure) {
          return Left(failure);
        },
        (filePath) {
          log('Downloaded file path: $filePath');
          return Right(filePath);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
