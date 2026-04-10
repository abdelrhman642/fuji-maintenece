import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/shared/features/notifications/data/models/notification_model/notification_model.dart';

/// Repository interface for notifications operations
abstract class NotificationsRepo {
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
  Future<Either<Failure, void>> markAsRead(int notificationId);
  Future<Either<Failure, void>> markAllAsRead();
}

/// Implementation of [NotificationsRepo]
class NotificationsRepoImpl implements NotificationsRepo {
  final ApiService _apiService;

  NotificationsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      final response = await _apiService.get(url: ApiPath.notifications);
      return response.fold((failure) => Left(failure), (data) {
        try {
          final List<dynamic> notificationsList =
              data is List ? data : (data['data'] as List? ?? []);
          final notifications =
              notificationsList
                  .map(
                    (item) =>
                        NotificationModel.fromMap(item as Map<String, dynamic>),
                  )
                  .toList();
          return Right(notifications);
        } catch (e) {
          return Left(ServerFailure('Failed to parse notifications: $e'));
        }
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(int notificationId) async {
    try {
      final response = await _apiService.post(
        url: '${ApiPath.markAsRead}/$notificationId',
      );
      return response.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    try {
      final response = await _apiService.post(url: ApiPath.markAllAsRead);
      return response.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
