import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/data/models/order_model.dart'
    as order_model;
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/data/models/see_details_order_model.dart';

abstract class OrderRepository {
  Future<Either<Failure, order_model.OrdersModel>> fetchOrders();
  Future<Either<Failure, SeeDetailsOrderModel>> fetchOrderDetails(int orderId);
  Future<Either<Failure, dynamic>> createOrder(Map<String, dynamic> orderData);
  Future<Either<Failure, dynamic>> updateOrder(Map<String, dynamic> orderData);
  Future<Either<Failure, String>> exportReportAsPdf(int reportId);
}

class OrderRepositoryImpl extends OrderRepository {
  final ApiService _apiService;
  OrderRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, order_model.OrdersModel>> fetchOrders() async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getContractRenewalRequests,
      );
      return response.fold((failure) => Left(failure), (result) {
        // API returns a List directly, wrap it in ordersModel structure
        final List<order_model.Data> dataList =
            (result as List)
                .map(
                  (item) =>
                      order_model.Data.fromJson(item as Map<String, dynamic>),
                )
                .toList();
        final order_model.OrdersModel orders = order_model.OrdersModel(
          success: true,
          message: 'Success',
          data: dataList,
          count: dataList.length,
        );
        return Right(orders);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SeeDetailsOrderModel>> fetchOrderDetails(
    int orderId,
  ) async {
    try {
      final response = await _apiService.get(
        url: 'api/admin/contract-renewal-requests/$orderId/show-request',
      );
      return response.fold((failure) => Left(failure), (result) {
        final SeeDetailsOrderModel orderDetails = SeeDetailsOrderModel.fromJson(
          result,
        );
        return Right(orderDetails);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> createOrder(
    Map<String, dynamic> orderData,
  ) async {
    try {
      final res = await _apiService.post(
        url: ApiPath.createWorkOrder,
        requestBody: orderData,
      );
      return res.fold((failure) => Left(failure), (result) {
        return Right(result);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateOrder(
    Map<String, dynamic> orderData,
  ) async {
    try {
      final res = await _apiService.post(
        url: ApiPath.getContractRenewalRequests,
        requestBody: orderData,
      );
      return res.fold((failure) => Left(failure), (result) {
        return Right(result);
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
