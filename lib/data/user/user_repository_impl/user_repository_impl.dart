import 'package:appwrite/appwrite.dart';
import 'package:bubble/config/constants/appwrite_constants.dart';
import 'package:bubble/core/server/server.dart';
import 'package:bubble/domain/app_failure/app_failure.dart';
import 'package:bubble/domain/user/models/user_model.dart';
import 'package:bubble/domain/common_types/type_defs.dart';
import 'package:bubble/domain/user/user_reppsitory/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  @override
  FutureEither<void> createUser(UserModel user) async {
    try {
      await AppServer.databases.createDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.usersCollection,
        documentId: user.uid,
        data: user.toMap(),
      );

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(
          kDebugMode ? AppFailure.client(e.toString()) : AppFailure.common());
    }
  }

  @override
  FutureEither<UserModel> getUser(String uid) async {
    try {
      final doc = await AppServer.databases.getDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.usersCollection,
        documentId: uid,
      );

      final user = UserModel.fromMap(doc.data);

      return Right(user);
    } on AppwriteException catch (e) {
      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(
          kDebugMode ? AppFailure.client(e.toString()) : AppFailure.common());
    }
  }

  @override
  FutureEither<void> updateUser(UserModel user) async {
    try {
      await AppServer.databases.updateDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.usersCollection,
        documentId: user.uid,
        data: user.toMap(),
      );

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(
          kDebugMode ? AppFailure.client(e.toString()) : AppFailure.common());
    }
  }
}
