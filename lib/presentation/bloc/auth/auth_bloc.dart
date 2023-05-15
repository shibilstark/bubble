import 'package:bubble/core/global/data_singleton.dart';
import 'package:bubble/domain/app_failure/app_failure.dart';
import 'package:bubble/domain/auth/auth_repository/auth_repository.dart';
import 'package:bubble/presentation/widgets/custom_snackbar.dart';
import 'package:bubble/utils/connectivity/connectivity_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(const AuthInitial()) {
    on<AuthGoogleLogin>(_googleLogin);
    on<AuthLogout>(_logout);
    on<AuthLoadFromDb>(_loadFromDb);
  }

  void _loadFromDb(AuthLoadFromDb event, Emitter<AuthState> emit) async {
    final auth = authRepository.getAuthFromDb();

    if (auth == null) {
      emit(const AuthNotFound());
    } else {
      DataCache.authModel = auth;
      emit(const AuthSuccess());
    }
  }

  void _googleLogin(AuthGoogleLogin event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    if (await _haveConnection()) {
      await authRepository.googleLogin().then((res) {
        res.fold(
          (err) {
            emit(AuthError(err));
            showCustomSnackBar(message: err.message, type: SnackBarType.error);
          },
          (auth) {
            DataCache.authModel = auth;
            emit(const AuthSuccess());
            showCustomSnackBar(
              message: "Successfully logged in to your account",
              type: SnackBarType.success,
            );
          },
        );
      });
    } else {
      _handleInternetError(emit);
    }
  }

  void _logout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    if (await _haveConnection()) {
      await authRepository.logOut().then((res) {
        res.fold(
          (err) => {
            emit(AuthError(err)),
            showCustomSnackBar(message: err.message, type: SnackBarType.error)
          },
          (auth) => {
            emit(const AuthSuccess()),
            showCustomSnackBar(
              message: "Successfully logged out from your account",
              type: SnackBarType.success,
            )
          },
        );
      });
    } else {
      _handleInternetError(emit);
    }
  }

  Future<bool> _haveConnection() async =>
      await ConnectivityUtil.checkInternetConnection();

  void _handleInternetError(Emitter<AuthState> emit) {
    emit(AuthError(AppFailure.internet()));
  }
}
