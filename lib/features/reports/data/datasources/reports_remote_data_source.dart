import 'dart:io';

abstract class ReportsRemoteDataSource {
  Future<void> sendCrashReport({required String notes, required File image});
}
