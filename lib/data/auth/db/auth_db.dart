import 'package:bubble/data/app_db/app_db.dart';
import 'package:bubble/data/auth/db/entities/user_account_entity.dart';
import 'package:bubble/domain/auth/models/auth_model.dart';

class AuthDb {
  static final _box = ObjectBox.instance.store.box<AuthEntity>();

  static void setAuthorizationData(AuthModel model) {
    _box.removeAll();
    final entity = AuthEntity.fromModel(model);
    _box.put(entity);
    return;
  }

  static AuthModel? getCredential() {
    final boxData = _box.getAll().toList();

    if (boxData.isEmpty) {
      return null;
    }

    return boxData.first.toModel();
  }

  static void clearCredentials() {
    _box.removeAll();
    return;
  }
}
