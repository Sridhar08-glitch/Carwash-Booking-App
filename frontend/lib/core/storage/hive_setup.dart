import 'package:hive_flutter/hive_flutter.dart';

/// One-time Hive initialization called from main().
/// Register Hive adapters here as boxes are added.
class HiveSetup {
  HiveSetup._();

  /// Box names — use these constants everywhere to avoid typos
  static const servicesCacheBox = 'services_cache';
  static const branchesCacheBox = 'branches_cache';
  static const homeLayoutCacheBox = 'home_layout_cache';
  static const cartBox = 'cart';

  static Future<void> initialize() async {
    await Hive.initFlutter();

    // Open boxes used for offline caching
    await Future.wait([
      Hive.openBox<String>(servicesCacheBox),
      Hive.openBox<String>(branchesCacheBox),
      Hive.openBox<String>(homeLayoutCacheBox),
      Hive.openBox<String>(cartBox),
    ]);
  }

  static Box<String> get servicesCache => Hive.box(servicesCacheBox);
  static Box<String> get branchesCache => Hive.box(branchesCacheBox);
  static Box<String> get homeLayoutCache => Hive.box(homeLayoutCacheBox);
  static Box<String> get cart => Hive.box(cartBox);
}
