import 'package:appwrite/appwrite.dart';
import 'package:bubble/config/constants/appwrite_constants.dart';
import 'package:bubble/core/server/server.dart';
import 'package:bubble/data/user/db/db/user_db.dart';
import 'package:bubble/domain/user/models/user_model.dart';
import 'package:bubble/domain/common_types/type_defs.dart';
import 'package:bubble/domain/user/user_reppsitory/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/app_failure/app_failure.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  @override
  FutureEither<UserModel> createUserIfNotAvailable(UserModel user) async {
    try {
      final document = await AppServer.databases.getDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.usersCollection,
          documentId: user.uid);

      final model = UserModel.fromMap(document.data);

      UserDb.setUser(model);

      return Right(model);
    } on AppwriteException catch (e) {
      if (e.code == 404) {
        final newDocument = await AppServer.databases.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.usersCollection,
          documentId: user.uid,
          data: user.toMap(),
        );

        final model = UserModel.fromMap(newDocument.data);

        UserDb.setUser(model);

        return Right(UserModel.fromMap(newDocument.data));
      }

      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(AppFailure.client(e.toString()));
    }
  }

  @override
  UserModel getUserFromDb() {
    return UserDb.getUser();
  }

  @override
  Stream<UserModel> getUserStream() {
    return UserDb.getStream();
  }

  @override
  FutureEither<void> updateUser(
      {required String uid, required Map<String, dynamic> updates}) async {
    try {
      final updatedDocument = await AppServer.databases.updateDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.usersCollection,
        documentId: uid,
        data: updates,
      );
      final model = UserModel.fromMap(updatedDocument.data);

      UserDb.update(model);

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(AppFailure.client(e.toString()));
    }
  }
}
