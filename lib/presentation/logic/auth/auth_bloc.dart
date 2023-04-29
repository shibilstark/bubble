// ignore_for_file: use_build_context_synchronously

import 'package:bubble/core/global/data_singleton.dart';
import 'package:bubble/domain/auth/auth_repository/auth_repository.dart';
import 'package:bubble/domain/auth/models/auth_model.dart';
import 'package:bubble/presentation/widgets/custom_snackbar.dart';
import 'package:bubble/utils/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bubble/domain/app_failure/app_failure.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<GetAuthFromDb>(_getAuthFromDb);
    on<AuthSignupUser>(_signupUser);
    on<AuthLoginUser>(_loginUser);
    on<AuthLogoutUser>(_logoutUser);
  }

  void _getAuthFromDb(GetAuthFromDb event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final authData = authRepository.getAuthFromDb();

    if (authData == null) {
      emit(AuthLoggedOut());
    } else {
      DataCache.authModel = authData;
      emit(AuthLoggedIn());
    }
  }

  void _signupUser(AuthSignupUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (await _checkHaveConnection()) {
      await authRepository
          .signUp(email: event.email, password: event.password)
          .then((response) {
        response.fold((l) => _handleError(emit, l, event.context), (r) {
          showCustomSnackBar(event.context,
              message: "Account created Successfully, please login");

          emit(AuthCreatedAccount());
        });
      });
    } else {
      _handleInternetError(emit, event.context);
    }
  }

  void _loginUser(AuthLoginUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    if (await _checkHaveConnection()) {
      await authRepository
          .login(email: event.email, password: event.password)
          .then((response) {
        response.fold((l) => _handleError(emit, l, event.context), (r) {
          DataCache.authModel = r;
          emit(AuthLoggedIn());
        });
      });
    } else {
      _handleInternetError(emit, event.context);
    }
  }

  void _logoutUser(AuthLogoutUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    if (await _checkHaveConnection()) {
      final auth = authRepository.getAuthFromDb() as AuthModel;

      await authRepository.logOut(auth.sessionId).then((response) {
        response.fold((l) => _handleError(emit, l, event.context),
            (r) => emit(AuthLoggedOut()));
      });
    } else {
      _handleInternetError(emit, event.context);
    }
  }

  Future<bool> _checkHaveConnection() async =>
      await ConnectivityUtil.checkInternetConnection();

  void _handleError(
      Emitter<AuthState> emit, AppFailure error, BuildContext context) {
    emit(AuthError(error));
    showCustomSnackBar(context, message: error.message);
  }

  void _handleInternetError(Emitter<AuthState> emit, BuildContext context) {
    final failure = AppFailure.internet();
    showCustomSnackBar(context, message: failure.message);
    emit(AuthError(failure));
  }
}
