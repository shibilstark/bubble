import 'environment.dart';
import 'env_config.dart';
export 'environment.dart';
export 'env_config.dart';

class BuildConfig {
  late final EvnType environment;
  late final EnvironmentConfig config;

  static final BuildConfig instance = BuildConfig._internal();

  BuildConfig._internal();

  factory BuildConfig.instantiate({
    required EvnType environment,
    required EnvironmentConfig config,
  }) {
    instance.environment = environment;
    instance.config = config;

    return instance;
  }
}
