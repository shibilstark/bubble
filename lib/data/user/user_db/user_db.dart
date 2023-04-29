import 'package:bubble/data/app_db/app_db.dart';
import 'package:bubble/data/user/user_db/entities/user_entity.dart';
import 'package:bubble/domain/user/models/user_model.dart';

class UserDb {
  final box = ObjectBox.instance.store.box<UserEntity>();

  int saveUser(UserModel model) {
    box.removeAll();
    return box.put(UserEntity.fromModel(model));
  }

  UserModel? getUser() {
    final data = box.getAll().toList();

    if (data.isEmpty) {
      return null;
    }

    return data.first.toModel();
  }

  void updateUser(UserModel model) {
    final entity = box.getAll().toList().first;
    final updated = UserEntity.fromModel(model)..id = entity.id;
    box.put(updated);
  }
}
