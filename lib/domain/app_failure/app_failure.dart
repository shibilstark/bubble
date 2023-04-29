import 'app_failure_enums.dart';

class AppFailure {
  final String message;
  final FailureType type;

  const AppFailure({
    required this.message,
    required this.type,
  });

  factory AppFailure.internet() => const AppFailure(
        message:
            "It seems like you don't have proper connection, please try again later",
        type: FailureType.internet,
      );
  factory AppFailure.common() => const AppFailure(
        message: "Something went wrong, please try again later",
        type: FailureType.client,
      );
  factory AppFailure.client(String message) => AppFailure(
        message: message,
        type: FailureType.client,
      );
  factory AppFailure.server(String? message) => AppFailure(
        message: message ?? "Something went wrong, please try again later",
        type: FailureType.client,
      );
}
