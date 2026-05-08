class AppConfig {
  const AppConfig._();

  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://rota.inteligenciacomercial.net.br',
  );

  static const apiTimeout = Duration(seconds: 10);
  static const scanTimeout = Duration(seconds: 30);

  static const offlinePreview = bool.fromEnvironment(
    'OFFLINE_PREVIEW',
    defaultValue: false,
  );
}
