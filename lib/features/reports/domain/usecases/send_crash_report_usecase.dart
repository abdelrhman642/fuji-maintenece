import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/error/failures.dart';
import 'package:flutter_project/features/reports/domain/repositories/reports_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendCrashReportUseCase {
  final ReportsRepository repository;

  SendCrashReportUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String notes,
    required File image,
  }) {
    return repository.sendCrashReport(notes: notes, image: image);
  }
}
