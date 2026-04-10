import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Hive database manager for local storage
class HiveManager {
  // Box names
  static const String maintenanceBoxName = 'maintenanceBox';
  static const String workOrderBoxName = 'workOrderBox';
  static const String equipmentBoxName = 'equipmentBox';
  static const String userBoxName = 'userBox';

  // Singleton instance
  static final HiveManager _instance = HiveManager._internal();

  factory HiveManager() => _instance;
  HiveManager._internal();

  /// Initialize Hive database
  Future<void> init() async {
    // Hive.initFlutter() works on both web and mobile
    // On web, it automatically uses IndexedDB
    // On mobile, it uses the app's document directory
    await Hive.initFlutter();

    // TODO: Register adapters when models are created
    // Hive.registerAdapter(WorkOrderModelAdapter());
    // Hive.registerAdapter(EquipmentModelAdapter());
    // Hive.registerAdapter(UserModelAdapter());

    // Open boxes
    await Future.wait([
      Hive.openBox(maintenanceBoxName),
      Hive.openBox(workOrderBoxName),
      Hive.openBox(equipmentBoxName),
      Hive.openBox(userBoxName),
    ]);
  }

  /// Get maintenance box
  Box getMaintenanceBox() => Hive.box(maintenanceBoxName);

  /// Get work order box
  Box getWorkOrderBox() => Hive.box(workOrderBoxName);

  /// Get equipment box
  Box getEquipmentBox() => Hive.box(equipmentBoxName);

  /// Get user box
  Box getUserBox() => Hive.box(userBoxName);

  /// Close all open boxes
  Future<void> closeBoxes() async {
    await Hive.close();
  }

  /// Clear all data from a specific box
  Future<void> clearBox(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  /// Clear all data from all boxes
  Future<void> clearAllBoxes() async {
    await Future.wait([
      getMaintenanceBox().clear(),
      getWorkOrderBox().clear(),
      getEquipmentBox().clear(),
      getUserBox().clear(),
    ]);
  }
}
