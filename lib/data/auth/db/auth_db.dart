import 'package:bubble/data/app_db/app_db.dart';
import 'package:bubble/data/auth/db/entities/user_account_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:bubble/domain/app_failure/app_failure.dart';
import 'package:bubble/domain/app_failure/app_failure_enums.dart';
import 'package:bubble/domain/auth/models/auth_model.dart';
import 'package:bubble/domain/common_types/type_defs.dart';

class AuthDb {
  final _box = ObjectBox.instance.store.box<AuthEntity>();

  EitherFailure<void> setAuthorizationData(AuthModel model) {
    try {
      _box.removeAll();
      final entity = AuthEntity.fromModel(model);

      _box.put(entity);
      return const Right(null);
    } catch (e) {
      return const Left(AppFailure(
        message: "Something went wrong, try again later",
        type: FailureType.client,
      ));
    }
  }

  EitherFailure<AuthModel?> getCredential() {
    try {
      final boxData = _box.getAll().toList();

      if (boxData.isEmpty) {
        return const Right(null);
      } else {
        return Right(boxData.first.toModel());
      }
    } catch (e) {
      return const Left(AppFailure(
        message: "Something went wrong, try again later",
        type: FailureType.client,
      ));
    }
  }

  void clearCredentials() {
    _box.removeAll();
    return;
  }
}
