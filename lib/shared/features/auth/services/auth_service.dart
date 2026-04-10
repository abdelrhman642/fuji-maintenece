import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/user_model.dart';

/// Authentication service for managing user authentication state
class AuthService {
  static final AuthService instance = AuthService._internal();
  AuthService._internal();

  User? _currentUser;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  String? get currentUserType => _currentUser?.userType;

  /// Login user with credentials
  Future<bool> login(String email, String password, String userType) async {
    try {
      // TODO: Implement actual authentication logic
      _currentUser = User(
        id: '1',
        email: email,
        userType: userType,
        name: 'Demo User',
      );
      _isLoggedIn = true;
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Logout current user
  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;
  }

  /// Check if user has specific permission
  bool hasPermission(String permission) {
    if (!_isLoggedIn || _currentUser == null) return false;

    switch (_currentUser!.userType) {
      case 'admin':
        return true; // Admin has all permissions
      case 'technician':
        return _technicianPermissions.contains(permission);
      case 'client':
        return _clientPermissions.contains(permission);
      default:
        return false;
    }
  }

  static const List<String> _technicianPermissions = [
    'view_work_orders',
    'update_work_orders',
    'view_schedule',
    'update_profile',
  ];

  static const List<String> _clientPermissions = [
    'create_requests',
    'view_requests',
    'view_history',
    'update_profile',
  ];
}

/// Provider for AuthService
final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService.instance,
);

/// Provider for current user
final currentUserProvider = StreamProvider<User?>((ref) {
  // TODO: Implement stream of user changes
  return Stream.value(AuthService.instance.currentUser);
});
