import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/error/failures.dart';

abstract class ReportsRepository {
  Future<Either<Failure, void>> sendCrashReport({
    required String notes,
    required File image,
  });
}
