part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthGoogleLogin extends AuthEvent {
  const AuthGoogleLogin();

  @override
  List<Object> get props => [];
}

class AuthLoadFromDb extends AuthEvent {
  const AuthLoadFromDb();

  @override
  List<Object> get props => [];
}

class AuthLogout extends AuthEvent {
  const AuthLogout();

  @override
  List<Object> get props => [];
}
