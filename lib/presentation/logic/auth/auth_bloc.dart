import 'package:bubble/domain/auth/auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bubble/domain/app_failure/app_failure.dart';
import 'package:bubble/domain/app_failure/app_failure_enums.dart';
import 'package:bubble/domain/auth/models/auth_model.dart';
import 'package:bubble/utils/connectivity_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<CreateUser>(_createUser);
    on<VerifyWithOtp>(_verifyWithOtp);
  }

  void _createUser(CreateUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (await _haveConnection()) {
      await repository.loginWithPhone(event.phoneNumber).then((result) {
        result.fold((l) => emit(AuthError(l)), (auth) {
          emit(AuthVerfication(auth));
        });
      });
    } else {
      _handleInternetError(emit);
    }
  }

  void _verifyWithOtp(VerifyWithOtp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    if (await _haveConnection()) {
      await repository
          .verifyUserWithOtp(
              phoneNumber: event.phoneNumber,
              secretCode: event.secretCode,
              userId: event.userId)
          .then((result) {
        result.fold((l) => emit(AuthError(l)), (auth) {
          emit(AuthSuccess(auth));
        });
      });
    } else {
      _handleInternetError(emit);
    }
  }

  Future<bool> _haveConnection() async =>
      await ConnectivityUtil.checkInternetConnection();

  void _handleInternetError(Emitter<AuthState> emit) {
    emit(const AuthError(AppFailure(
      message: "Seems like no internet connection, check your connection",
      type: FailureType.internet,
    )));
  }
}
