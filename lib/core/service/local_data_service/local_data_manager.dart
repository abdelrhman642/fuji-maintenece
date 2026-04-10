import 'package:fuji_maintenance_system/core/service/localization_service/language.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'local_data_manager_key.dart';

abstract class LocalDataManager {
  // Authentication methods
  Future<void> setToken(String token);
  String? getToken();
  Future<void> setRefreshToken(String refreshToken);
  String? getRefreshToken();
  Future<void> setUserId(String userId);
  String? getUserId();
  Future<void> setUserRole(String role);
  String? getUserRole();
  Future<void> setUserName(String name);
  String? getUserName();
  Future<void> setUserEmail(String email);
  String? getUserEmail();
  Future<void> setIsLoggedIn(bool isLoggedIn);
  bool getIsLoggedIn();
  Future<void> setRememberMe(bool remember);
  bool getRememberMe();

  // User preferences
  Future<void> setLanguage(Language lang);
  Language? get getLanguage;
  Future<void> setThemeMode(bool isDark);
  bool getThemeMode();
  Future<void> setNotificationsEnabled(bool enabled);
  bool getNotificationsEnabled();
  Future<void> setSoundEnabled(bool enabled);
  bool getSoundEnabled();
  Future<void> setVibrationEnabled(bool enabled);
  bool getVibrationEnabled();

  // App settings
  Future<void> setFirstTimeUser(bool isFirst);
  bool getFirstTimeUser();
  Future<void> setLastSyncTime(DateTime time);
  DateTime? getLastSyncTime();
  Future<void> setOfflineMode(bool enabled);
  bool getOfflineMode();
  Future<void> setAutoSync(bool enabled);
  bool getAutoSync();

  // Cache methods
  Future<void> setWorkOrdersCache(String data);
  String? getWorkOrdersCache();
  Future<void> setEquipmentCache(String data);
  String? getEquipmentCache();
  Future<void> setUsersCache(String data);
  String? getUsersCache();
  Future<void> setDashboardCache(String data);
  String? getDashboardCache();

  // Security
  Future<void> setSessionTimeout(int minutes);
  int getSessionTimeout();
  Future<void> setLastActivity(DateTime time);
  DateTime? getLastActivity();
  Future<void> setBiometricEnabled(bool enabled);
  bool getBiometricEnabled();

  // Generic methods
  Future<void> setString(String key, String value);
  String? getString(String key);
  Future<void> setBool(String key, bool value);
  bool getBool(String key, {bool defaultValue = false});
  Future<void> setInt(String key, int value);
  int getInt(String key, {int defaultValue = 0});
  Future<void> setDouble(String key, double value);
  double getDouble(String key, {double defaultValue = 0.0});
  Future<void> remove(String key);
  Future<void> clear();

  // Convenience methods
  Future<void> clearToken();
  Future<void> clearUserRole();
  bool get isFirstTime;

  // Methods to match fuji_agents pattern
  Future<String?> readString(String key);
  Future<bool?> readBool(String key);
  static LocalDataManager get instance {
    return GetStorageManagerImpl();
  }
}

class GetStorageManagerImpl implements LocalDataManager {
  static GetStorage? _box;

  Future<GetStorageManagerImpl> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  GetStorage get box {
    if (_box == null) {
      throw Exception('GetStorage not initialized. Call init() first.');
    }
    return _box!;
  }

  // Authentication methods
  @override
  Future<void> setToken(String token) async {
    await box.write(LocalDataManagerKey.token, token);
  }

  @override
  String? getToken() {
    return box.read(LocalDataManagerKey.token);
  }

  @override
  Future<void> setRefreshToken(String refreshToken) async {
    await box.write(LocalDataManagerKey.refreshToken, refreshToken);
  }

  @override
  String? getRefreshToken() {
    return box.read(LocalDataManagerKey.refreshToken);
  }

  @override
  Future<void> setUserId(String userId) async {
    await box.write(LocalDataManagerKey.userId, userId);
  }

  @override
  String? getUserId() {
    return box.read(LocalDataManagerKey.userId);
  }

  @override
  Future<void> setUserRole(String role) async {
    await box.write(LocalDataManagerKey.userRole, role);
  }

  @override
  String? getUserRole() {
    return box.read(LocalDataManagerKey.userRole);
  }

  @override
  Future<void> setUserName(String name) async {
    await box.write(LocalDataManagerKey.userName, name);
  }

  @override
  String? getUserName() {
    return box.read(LocalDataManagerKey.userName);
  }

  @override
  Future<void> setUserEmail(String email) async {
    await box.write(LocalDataManagerKey.userEmail, email);
  }

  @override
  String? getUserEmail() {
    return box.read(LocalDataManagerKey.userEmail);
  }

  @override
  Future<void> setIsLoggedIn(bool isLoggedIn) async {
    await box.write(LocalDataManagerKey.isLoggedIn, isLoggedIn);
  }

  @override
  bool getIsLoggedIn() {
    return box.read(LocalDataManagerKey.isLoggedIn) ?? false;
  }

  @override
  Future<void> setRememberMe(bool remember) async {
    await box.write(LocalDataManagerKey.rememberMe, remember);
  }

  @override
  bool getRememberMe() {
    return box.read(LocalDataManagerKey.rememberMe) ?? false;
  }

  @override
  Future<void> setLanguage(Language lang) async {
    return setValue(LocalDataManagerKey.language, lang.locale.languageCode);
  }

  @override
  Language? get getLanguage {
    return Language.values.firstWhereOrNull(
          (element) =>
              element.locale.languageCode ==
              getValue(LocalDataManagerKey.language),
        ) ??
        Language.arabic;
  }

  T? getValue<T>(String key) {
    final T? value = box.read(key);

    return value;
  }

  @override
  Future<void> setThemeMode(bool isDark) async {
    await box.write(LocalDataManagerKey.themeMode, isDark);
  }

  @override
  bool getThemeMode() {
    return box.read(LocalDataManagerKey.themeMode) ?? false;
  }

  @override
  Future<void> setNotificationsEnabled(bool enabled) async {
    await box.write(LocalDataManagerKey.notificationsEnabled, enabled);
  }

  @override
  bool getNotificationsEnabled() {
    return box.read(LocalDataManagerKey.notificationsEnabled) ?? true;
  }

  @override
  Future<void> setSoundEnabled(bool enabled) async {
    await box.write(LocalDataManagerKey.soundEnabled, enabled);
  }

  @override
  bool getSoundEnabled() {
    return box.read(LocalDataManagerKey.soundEnabled) ?? true;
  }

  @override
  Future<void> setVibrationEnabled(bool enabled) async {
    await box.write(LocalDataManagerKey.vibrationEnabled, enabled);
  }

  Future<void> setValue<T>(String key, T value) async {
    return box.write(key, value);
  }

  @override
  bool getVibrationEnabled() {
    return box.read(LocalDataManagerKey.vibrationEnabled) ?? true;
  }

  // App settings
  @override
  Future<void> setFirstTimeUser(bool isFirst) async {
    await box.write(LocalDataManagerKey.firstTimeUser, isFirst);
  }

  @override
  bool getFirstTimeUser() {
    return box.read(LocalDataManagerKey.firstTimeUser) ?? true;
  }

  @override
  Future<void> setLastSyncTime(DateTime time) async {
    await box.write(LocalDataManagerKey.lastSyncTime, time.toIso8601String());
  }

  @override
  DateTime? getLastSyncTime() {
    final timeString = box.read(LocalDataManagerKey.lastSyncTime);
    return timeString != null ? DateTime.parse(timeString) : null;
  }

  @override
  Future<void> setOfflineMode(bool enabled) async {
    await box.write(LocalDataManagerKey.offlineMode, enabled);
  }

  @override
  bool getOfflineMode() {
    return box.read(LocalDataManagerKey.offlineMode) ?? false;
  }

  @override
  Future<void> setAutoSync(bool enabled) async {
    await box.write(LocalDataManagerKey.autoSync, enabled);
  }

  @override
  bool getAutoSync() {
    return box.read(LocalDataManagerKey.autoSync) ?? true;
  }

  // Cache methods
  @override
  Future<void> setWorkOrdersCache(String data) async {
    await box.write(LocalDataManagerKey.workOrdersCache, data);
  }

  @override
  String? getWorkOrdersCache() {
    return box.read(LocalDataManagerKey.workOrdersCache);
  }

  @override
  Future<void> setEquipmentCache(String data) async {
    await box.write(LocalDataManagerKey.equipmentCache, data);
  }

  @override
  String? getEquipmentCache() {
    return box.read(LocalDataManagerKey.equipmentCache);
  }

  @override
  Future<void> setUsersCache(String data) async {
    await box.write(LocalDataManagerKey.usersCache, data);
  }

  @override
  String? getUsersCache() {
    return box.read(LocalDataManagerKey.usersCache);
  }

  @override
  Future<void> setDashboardCache(String data) async {
    await box.write(LocalDataManagerKey.dashboardCache, data);
  }

  @override
  String? getDashboardCache() {
    return box.read(LocalDataManagerKey.dashboardCache);
  }

  // Security
  @override
  Future<void> setSessionTimeout(int minutes) async {
    await box.write(LocalDataManagerKey.sessionTimeout, minutes);
  }

  @override
  int getSessionTimeout() {
    return box.read(LocalDataManagerKey.sessionTimeout) ?? 30;
  }

  @override
  Future<void> setLastActivity(DateTime time) async {
    await box.write(LocalDataManagerKey.lastActivity, time.toIso8601String());
  }

  @override
  DateTime? getLastActivity() {
    final timeString = box.read(LocalDataManagerKey.lastActivity);
    return timeString != null ? DateTime.parse(timeString) : null;
  }

  @override
  Future<void> setBiometricEnabled(bool enabled) async {
    await box.write(LocalDataManagerKey.biometricEnabled, enabled);
  }

  @override
  bool getBiometricEnabled() {
    return box.read(LocalDataManagerKey.biometricEnabled) ?? false;
  }

  // Generic methods
  @override
  Future<void> setString(String key, String value) async {
    await box.write(key, value);
  }

  @override
  String? getString(String key) {
    return box.read(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await box.write(key, value);
  }

  @override
  bool getBool(String key, {bool defaultValue = false}) {
    return box.read(key) ?? defaultValue;
  }

  @override
  Future<void> setInt(String key, int value) async {
    await box.write(key, value);
  }

  @override
  int getInt(String key, {int defaultValue = 0}) {
    return box.read(key) ?? defaultValue;
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await box.write(key, value);
  }

  @override
  double getDouble(String key, {double defaultValue = 0.0}) {
    return box.read(key) ?? defaultValue;
  }

  @override
  Future<void> remove(String key) async {
    await box.remove(key);
  }

  @override
  Future<void> clear() async {
    await box.erase();
  }

  // Convenience methods
  @override
  Future<void> clearToken() async {
    await box.remove(LocalDataManagerKey.token);
  }

  @override
  Future<void> clearUserRole() async {
    await box.remove(LocalDataManagerKey.userRole);
  }

  @override
  bool get isFirstTime {
    return getFirstTimeUser();
  }

  // Methods to match fuji_agents pattern
  @override
  Future<String?> readString(String key) async {
    return box.read(key);
  }

  @override
  Future<bool?> readBool(String key) async {
    return box.read(key);
  }

  static LocalDataManager get instance => GetStorageManagerImpl();
}

// Global instance
final LocalDataManager dataManager = GetStorageManagerImpl();
