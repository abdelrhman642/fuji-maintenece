import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/models/report_model/report_model.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/models/contract_model/contract_model.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/data/models/renew_contract_request.dart';

abstract class ClientHomeRepo {
  Future<Either<Failure, List<ContractModel>>> getMyContracts();
  Future<Either<Failure, List<ReportModel>>> getMyReports();
  Future<Either<Failure, String>> renewContract(
    RenewContractRequest requestModel,
  );
  Future<Either<Failure, String>> exportReportAsPdf(int reportId);
}

class ClientHomeRepoImpl implements ClientHomeRepo {
  final ApiService _apiService;
  ClientHomeRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<ContractModel>>> getMyContracts() async {
    try {
      final response = await _apiService.get(url: ApiPath.getMyContracts);
      return response.fold((failure) => Left(failure), (data) {
        final contracts =
            (data as List).map((e) => ContractModel.fromMap(e)).toList();
        return Right(contracts);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReportModel>>> getMyReports() async {
    try {
      final response = await _apiService.get(url: ApiPath.getMyReports);
      return response.fold((failure) => Left(failure), (data) {
        final reports =
            (data as List).map((e) => ReportModel.fromMap(e)).toList();
        return Right(reports);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> renewContract(
    RenewContractRequest requestModel,
  ) async {
    try {
      final formData = await requestModel.toFormData();
      final response = await _apiService.post(
        url: ApiPath.storeContractRenewal,
        requestBody: formData,
        returnDataOnly: false,
      );
      return response.fold(
        (failure) {
          log(failure.message);
          return Left(failure);
        },
        (data) {
          return Right(
            data['message'] ??
                'Contract renewal request not submitted successfully',
          );
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> exportReportAsPdf(int reportId) async {
    try {
      final response = await _apiService.download(
        url: ApiPath.downloadReportClient(reportId),
      );

      return response.fold(
        (failure) {
          return Left(failure);
        },
        (filePath) {
          return Right(filePath);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
