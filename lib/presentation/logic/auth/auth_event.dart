part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CreateUser extends AuthEvent {
  final String phoneNumber;
  const CreateUser(this.phoneNumber);

  @override
  List<Object> get props => [
        phoneNumber,
      ];
}

class VerifyWithOtp extends AuthEvent {
  final String userId;
  final String secretCode;
  final String phoneNumber;
  const VerifyWithOtp({
    required this.userId,
    required this.secretCode,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [
        secretCode,
        userId,
        phoneNumber,
      ];
}
