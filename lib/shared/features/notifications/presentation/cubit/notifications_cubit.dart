import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/shared/features/notifications/data/models/notification_model/notification_model.dart';
import 'package:fuji_maintenance_system/shared/features/notifications/data/repositories/notifications_repo.dart';

part 'notifications_state.dart';

/// Cubit responsible for managing notifications state
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repo) : super(NotificationsInitial());

  final NotificationsRepo _repo;
  final List<NotificationModel> _allNotifications = [];

  /// Load all notifications from repository
  Future<void> loadNotifications() async {
    emit(NotificationsLoading());
    final result = await _repo.getNotifications();
    result.fold((failure) => emit(NotificationsError(failure.message)), (
      notifications,
    ) {
      _allNotifications.clear();
      _allNotifications.addAll(notifications);
      emit(NotificationsLoaded(notifications: _allNotifications));
    });
  }

  /// Mark a specific notification as read
  Future<void> markAsRead(int notificationId) async {
    final result = await _repo.markAsRead(notificationId);
    result.fold((failure) => emit(NotificationsError(failure.message)), (_) {
      // Update local state
      final index = _allNotifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        _allNotifications[index] = _allNotifications[index].copyWith(
          isRead: true,
        );
        emit(NotificationsLoaded(notifications: List.from(_allNotifications)));
      }
    });
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    emit(NotificationsActionLoading());
    final result = await _repo.markAllAsRead();
    result.fold((failure) => emit(NotificationsError(failure.message)), (_) {
      // Update local state
      for (int i = 0; i < _allNotifications.length; i++) {
        _allNotifications[i] = _allNotifications[i].copyWith(isRead: true);
      }
      emit(NotificationsLoaded(notifications: List.from(_allNotifications)));
    });
  }

  /// Refresh notifications
  Future<void> refreshNotifications() async {
    await loadNotifications();
  }
}
