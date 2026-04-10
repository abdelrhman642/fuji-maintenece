import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_project/features/reports/data/datasources/reports_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ReportsRemoteDataSource)
class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource {
  final Dio dio;

  ReportsRemoteDataSourceImpl(this.dio);

  @override
  Future<void> sendCrashReport({
    required String notes,
    required File image,
  }) async {
    final formData = FormData.fromMap({
      'notes': notes,
      'image': await MultipartFile.fromFile(image.path),
    });
    await dio.post('/api/reports/crash', data: formData);
  }
}
