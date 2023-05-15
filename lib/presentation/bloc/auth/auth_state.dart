part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthSuccess extends AuthState {
  const AuthSuccess();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthNotFound extends AuthState {
  const AuthNotFound();
}

class AuthError extends AuthState {
  final AppFailure failure;
  const AuthError(this.failure);

  @override
  List<Object> get props => [failure];
}
