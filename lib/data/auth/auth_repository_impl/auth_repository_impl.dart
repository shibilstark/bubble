import 'package:bubble/core/injections/injection_setup.dart';
import 'package:bubble/core/server/server.dart';
import 'package:bubble/domain/auth/auth_repository/auth_repository.dart';
import 'package:bubble/domain/user/models/user_model.dart';
import 'package:bubble/domain/user/user_reppsitory/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:bubble/data/auth/auth_db/auth_db.dart';
import 'package:bubble/domain/app_failure/app_failure.dart';
import 'package:bubble/domain/common_types/type_defs.dart';
import 'package:bubble/domain/auth/models/auth_model.dart';
import 'package:appwrite/appwrite.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDb authDb = AuthDb();

  @override
  FutureEither<void> logOut(String sessionId) async {
    try {
      await AppServer.account.deleteSession(sessionId: sessionId);
      authDb.clear();

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(
          kDebugMode ? AppFailure.client(e.toString()) : AppFailure.common());
    }
  }

  @override
  FutureEither<AuthModel> login(
      {required String email, required String password}) async {
    try {
      final session = await AppServer.account.createEmailSession(
        email: email,
        password: password,
      );

      final user = await AppServer.account.get();

      final authModel = AuthModel(
        id: 0,
        userId: user.$id,
        sessionId: session.$id,
        expireAt: DateTime.parse(session.expire),
        email: user.email,
        isEmailVerified: user.emailVerification,
      );

      return getIt<UserRepository>().getUser(user.$id).then((value) {
        return value.fold((l) => Left(l), (r) {
          getIt<UserRepository>().saveUser(r);
          final newAuthModel = authModel.copyWith(id: authDb.save(authModel));
          return Right(newAuthModel);
        });
      });
    } on AppwriteException catch (e) {
      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(
          kDebugMode ? AppFailure.client(e.toString()) : AppFailure.common());
    }
  }

  @override
  FutureEither<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final user = await AppServer.account.create(
        email: email,
        password: password,
        userId: ID.unique(),
      );

      final userModel = UserModel(
        uid: user.$id,
        userName: _getNameFromEmail(email),
        bio: "",
        statusText: "",
        profilePic: "",
        coverPic: "",
        email: email,
        isOnline: true,
        groupIds: const [],
      );

      return await getIt<UserRepository>().createUser(userModel).then((value) {
        return value.fold((l) => Left(l), (r) => const Right(null));
      });
    } on AppwriteException catch (e) {
      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(
          kDebugMode ? AppFailure.client(e.toString()) : AppFailure.common());
    }
  }

  String _getNameFromEmail(String email) => email.split("@").first;

  @override
  AuthModel? getAuthFromDb() {
    return authDb.get();
  }
}
