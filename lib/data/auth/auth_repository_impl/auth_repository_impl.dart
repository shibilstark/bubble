import 'package:appwrite/appwrite.dart';
import 'package:bubble/core/server/server.dart';
import 'package:bubble/data/auth/auth_db/auth_db.dart';
import 'package:bubble/domain/app_failure/app_failure.dart';
import 'package:bubble/domain/app_failure/app_failure_enums.dart';
import 'package:bubble/domain/common_types/type_defs.dart';
import 'package:bubble/domain/auth/models/auth_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bubble/domain/auth/auth_repository/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final authDb = AuthDB();
  @override
  FutureEither<AuthModel> loginWithPhone(String phoneNumber) async {
    try {
      final token = await AppServer.account
          .createPhoneSession(phone: phoneNumber, userId: ID.unique());

      final authModel = AuthModel(
          userId: token.userId,
          tokenId: token.$id,
          expireAt: DateTime.parse(token.expire),
          phone: phoneNumber);

      return Right(authModel);
    } on AppwriteException catch (e) {
      return Left(AppFailure(
        message:
            e.message ?? "Something went wrong with server try again later",
        type: FailureType.server,
      ));
    } catch (e) {
      return const Left(AppFailure(
        message: "Something went wrong, try again later",
        type: FailureType.client,
      ));
    }
  }

  @override
  FutureEither<AuthModel> verifyUserWithOtp({
    required String userId,
    required String secretCode,
    required String phoneNumber,
  }) async {
    try {
      final session = await AppServer.account
          .updatePhoneSession(secret: secretCode, userId: userId);

      final authModel = AuthModel(
        userId: session.userId,
        tokenId: session.$id,
        expireAt: DateTime.parse(session.expire),
        phone: phoneNumber,
      );

      saveToDb(authModel);

      return Right(authModel);
    } on AppwriteException catch (e) {
      return Left(AppFailure(
        message:
            e.message ?? "Something went wrong with server try again later",
        type: FailureType.server,
      ));
    } catch (e) {
      return const Left(AppFailure(
        message: "Something went wrong, try again later",
        type: FailureType.client,
      ));
    }
  }

  void saveToDb(AuthModel model) {
    return authDb.saveToDb(model);
  }

  void clear() {
    return authDb.clear();
  }

  @override
  AuthModel? getFromDB() {
    return authDb.get();
  }
}
