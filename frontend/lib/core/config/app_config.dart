/// Runtime configuration injected via --dart-define at build time.
/// Never put secrets (private keys, etc.) here — only publishable keys and URLs.
class AppConfig {
  const AppConfig._({
    required this.env,
    required this.baseUrl,
    required this.wsBaseUrl,
    required this.stripePk,
    required this.googleMapsKey,
    required this.sentryDsn,
  });

  final AppEnv env;
  final String baseUrl;
  final String wsBaseUrl;
  final String stripePk;
  final String googleMapsKey;
  final String sentryDsn;

  // ---------------------------------------------------------------------------
  // Flavors — created from --dart-define values
  // ---------------------------------------------------------------------------

  static const AppConfig dev = AppConfig._(
    env: AppEnv.dev,
    baseUrl: String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'http://10.0.2.2:8000/api/v1',
    ),
    wsBaseUrl: String.fromEnvironment(
      'WS_BASE_URL',
      defaultValue: 'ws://10.0.2.2:8000/ws',
    ),
    stripePk: String.fromEnvironment('STRIPE_PK', defaultValue: ''),
    googleMapsKey: String.fromEnvironment('MAPS_KEY', defaultValue: ''),
    sentryDsn: String.fromEnvironment('SENTRY_DSN', defaultValue: ''),
  );

  static const AppConfig staging = AppConfig._(
    env: AppEnv.staging,
    baseUrl: String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'https://staging-api.sridharcarwash.com/api/v1',
    ),
    wsBaseUrl: String.fromEnvironment(
      'WS_BASE_URL',
      defaultValue: 'wss://staging-api.sridharcarwash.com/ws',
    ),
    stripePk: String.fromEnvironment('STRIPE_PK', defaultValue: ''),
    googleMapsKey: String.fromEnvironment('MAPS_KEY', defaultValue: ''),
    sentryDsn: String.fromEnvironment('SENTRY_DSN', defaultValue: ''),
  );

  static const AppConfig prod = AppConfig._(
    env: AppEnv.prod,
    baseUrl: String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'https://api.sridharcarwash.com/api/v1',
    ),
    wsBaseUrl: String.fromEnvironment(
      'WS_BASE_URL',
      defaultValue: 'wss://api.sridharcarwash.com/ws',
    ),
    stripePk: String.fromEnvironment('STRIPE_PK', defaultValue: ''),
    googleMapsKey: String.fromEnvironment('MAPS_KEY', defaultValue: ''),
    sentryDsn: String.fromEnvironment('SENTRY_DSN', defaultValue: ''),
  );

  // ---------------------------------------------------------------------------
  // Feature flags — driven by API response / server env vars
  // The app reads these from AppConfig at startup; some are revealed via the
  // server's /healthz or a future /config endpoint. The defaults here match the
  // "all disabled" safe state so the app never hard-crashes if the server omits them.
  // ---------------------------------------------------------------------------

  bool get isSocialAuthEnabled =>
      const bool.fromEnvironment('SOCIAL_AUTH_ENABLED', defaultValue: false);

  bool get isGeoEnabled =>
      const bool.fromEnvironment('GEO_ENABLED', defaultValue: false);

  bool get isChannelsEnabled =>
      const bool.fromEnvironment('CHANNELS_ENABLED', defaultValue: false);

  bool get isFcmEnabled =>
      const bool.fromEnvironment('FCM_ENABLED', defaultValue: true);

  // In dev, OTP codes are logged server-side — any 6-digit code works.
  bool get isSmsEnabled =>
      const bool.fromEnvironment('SMS_ENABLED', defaultValue: true);

  bool get isDebug => env == AppEnv.dev;
}

enum AppEnv { dev, staging, prod }
