import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';
import 'core/config/providers.dart';
import 'core/storage/hive_setup.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Background FCM handling — silent data messages only in dev
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase — no web FirebaseOptions configured yet (run `flutterfire
  // configure` to generate firebase_options.dart for web push support).
  // Skip on web for now so the dev app can still run.
  if (!kIsWeb) {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Hive (offline cache)
  await HiveSetup.initialize();

  // Sentry — only capture in dev if SENTRY_DSN is provided
  const sentryDsn = String.fromEnvironment('SENTRY_DSN');
  if (sentryDsn.isNotEmpty) {
    await SentryFlutter.init(
      (options) {
        options.dsn = sentryDsn;
        options.environment = 'dev';
        // Reduced from 1.0 — capturing 100% of traces in dev produces noise
        // and can exhaust free-tier Sentry quotas shared with production.
        // Use 0.2 in dev; prod already uses 0.1 (see main_prod.dart).
        options.tracesSampleRate = 0.2;
        options.debug = true;
        // Never attach PII in any environment
        options.sendDefaultPii = false;
      },
      appRunner: () => _runApp(AppConfig.dev),
    );
  } else {
    _runApp(AppConfig.dev);
  }
}

void _runApp(AppConfig config) {
  runApp(
    ProviderScope(
      overrides: [appConfigProvider.overrideWithValue(config)],
      child: const SridharCarWashApp(),
    ),
  );
}
