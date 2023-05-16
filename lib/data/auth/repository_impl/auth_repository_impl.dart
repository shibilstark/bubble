import 'package:appwrite/appwrite.dart';
import 'package:bubble/core/injections/injection_setup.dart';
import 'package:bubble/data/auth/db/auth_db.dart';
import 'package:bubble/data/user/db/db/user_db.dart';
import 'package:bubble/domain/app_failure/app_failure.dart';
import 'package:bubble/domain/app_failure/app_failure_enums.dart';
import 'package:bubble/domain/auth/auth_repository/auth_repository.dart';
import 'package:bubble/domain/common_types/type_defs.dart';
import 'package:bubble/domain/auth/models/auth_model.dart';
import 'package:bubble/domain/user/models/user_model.dart';
import 'package:bubble/domain/user/user_reppsitory/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final google = GoogleSignIn();

  @override
  AuthModel? getAuthFromDb() {
    return AuthDb.getCredential();
  }

  @override
  FutureEither<AuthModel> googleLogin() async {
    try {
      final googleUser = await google.signIn();

      if (googleUser == null) {
        return const Left(AppFailure(
            message: "Please select an account", type: FailureType.server));
      }

      final googleAuth = await googleUser.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final firebaseAuth =
          await FirebaseAuth.instance.signInWithCredential(credentials);

      final user = firebaseAuth.user!;

      final model = AuthModel(
        id: 0,
        userId: user.uid,
        expireAt: DateTime.now().add(const Duration(days: 14)),
        email: user.email!,
        isEmailVerified: user.emailVerified,
      );
      AuthDb.setAuthorizationData(model);

      final userModel = UserModel(
        uid: user.uid,
        userName: "",
        bio: "",
        statusText: "Hi, I am available",
        profilePic: "",
        coverPic: "",
        email: model.email,
        isOnline: true,
        groupIds: const [],
      );

      return await getIt<UserRepository>()
          .createUserIfNotAvailable(userModel)
          .then((value) {
        return value.fold((l) => Left(l), (r) => Right(model));
      });
    } on AppwriteException catch (e) {
      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(AppFailure.client(e.toString()));
    }
  }

  @override
  FutureEither<void> logOut() async {
    try {
      AuthDb.clearCredentials();
      await google.disconnect();
      FirebaseAuth.instance.signOut();
      UserDb.clearUser();
      return const Right(null);
    } catch (e) {
      return Left(AppFailure.client(e.toString()));
    }
  }
}
