part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginUser extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  const AuthLoginUser({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object> get props => [email, password, context];
}

class AuthSignupUser extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  const AuthSignupUser({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object> get props => [email, password, context];
}

class AuthLogoutUser extends AuthEvent {
  final BuildContext context;
  const AuthLogoutUser({required this.context});

  @override
  List<Object> get props => [context];
}

class GetAuthFromDb extends AuthEvent {}
