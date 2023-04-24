import 'dart:developer';

import 'package:bubble/domain/auth/auth_repository/auth_repository.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
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
    on<LoadAuth>(_loadAuth);
  }

  void _loadAuth(LoadAuth event, Emitter<AuthState> emit) {
    final auth = repository.getFromDB();

    if (auth == null) {
      emit(AuthNotFound());
    } else {
      emit(AuthSuccess(auth));
    }
  }

  void _createUser(CreateUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (await _haveConnection()) {
      await repository.loginWithPhone(event.phoneNumber).then((result) {
        result.fold((l) => emit(AuthError(l)), (auth) {
          // emit(AuthVerfication(
          //   auth: auth,
          //   countryCode: event.countryCode,
          // ));
          // TODO CURRENTLY JUST DISABLED THE OTP FOR DEV PURPOSE SO PROCEEDING WITH OUT OTP
          emit(AuthSuccess(auth));
        });
      });
    } else {
      _handleInternetError(emit);
    }
  }

  void _verifyWithOtp(VerifyWithOtp event, Emitter<AuthState> emit) async {
    emit(AuthVerfication(
        auth: event.auth, countryCode: event.countryCode, isLoading: true));
    if (await _haveConnection()) {
      await repository
          .verifyUserWithOtp(
        phoneNumber: event.auth.phone,
        secretCode: event.secretCode,
        userId: event.auth.userId,
      )
          .then((result) {
        result.fold(
            (error) => emit(AuthVerfication(
                  auth: event.auth,
                  countryCode: event.countryCode,
                  isError: true,
                  error: error,
                )), (auth) {
          emit(AuthSuccess(auth));
        });
      });
    } else {
      emit(AuthVerfication(
          auth: event.auth,
          countryCode: event.countryCode,
          isError: true,
          error: const AppFailure(
            message: "Seems like no internet connection, check your connection",
            type: FailureType.internet,
          )));
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
