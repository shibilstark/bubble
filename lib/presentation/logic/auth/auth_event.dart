part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CreateUser extends AuthEvent {
  final String phoneNumber;
  final CountryCode countryCode;
  const CreateUser({
    required this.phoneNumber,
    required this.countryCode,
  });

  @override
  List<Object> get props => [
        phoneNumber,
      ];
}

class VerifyWithOtp extends AuthEvent {
  final AuthModel auth;
  final String secretCode;
  final CountryCode countryCode;
  const VerifyWithOtp({
    required this.auth,
    required this.secretCode,
    required this.countryCode,
  });

  @override
  List<Object> get props => [
        auth,
        secretCode,
        countryCode,
      ];
}

class LoadAuth extends AuthEvent {
  const LoadAuth();

  @override
  List<Object> get props => [];
}
