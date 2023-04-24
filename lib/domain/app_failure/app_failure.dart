import 'app_failure_enums.dart';

class AppFailure {
  final String message;
  final FailureType type;

  const AppFailure({
    required this.message,
    required this.type,
  });
}
