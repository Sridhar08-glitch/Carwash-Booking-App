import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_config.dart';

/// Overridden at app startup with the correct flavor.
final appConfigProvider = Provider<AppConfig>(
  (_) => throw UnimplementedError('appConfigProvider must be overridden in main()'),
);
