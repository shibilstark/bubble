// ignore_for_file: depend_on_referenced_packages

class EnvironmentConfig {
  final String appName;
  final String baseUrl;
  final Duration requestTimeOut;

  EnvironmentConfig({
    required this.appName,
    required this.baseUrl,
    required this.requestTimeOut,
  });
}
