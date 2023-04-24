part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthError extends AuthState {
  final AppFailure error;

  const AuthError(this.error);

  @override
  List<Object> get props => [error];
}

class AuthLoading extends AuthState {}

class AuthNotFound extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthModel auth;
  const AuthSuccess(this.auth);

  @override
  List<Object> get props => [auth];
}

class AuthVerfication extends AuthState {
  final AuthModel auth;
  final CountryCode countryCode;
  final bool isLoading;
  final bool isError;
  final AppFailure? error;

  const AuthVerfication({
    required this.auth,
    required this.countryCode,
    this.isLoading = false,
    this.isError = false,
    this.error,
  });

  @override
  List<Object?> get props => [
        auth,
        countryCode,
        error,
        isLoading,
        isError,
      ];
}
