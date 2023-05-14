import 'package:bubble/domain/app_failure/app_failure.dart';
import 'package:bubble/domain/auth/auth_repository/auth_repository.dart';
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
  }

  void _googleLogin(AuthGoogleLogin event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
  }

  void _logout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    if (await _haveConnection()) {
      await authRepository.googleLogin().then((res) {
        res.fold(
          (err) => emit(AuthError(err)),
          (auth) => auth.isEmailVerified
              ? emit(const AuthSuccess())
              : emit(AuthNeedVerfication(auth.email)),
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
