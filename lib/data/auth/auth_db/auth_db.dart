import 'package:bubble/data/app_db/app_db.dart';
import 'package:bubble/data/auth/auth_db/auth_entity.dart';
import 'package:bubble/domain/auth/models/auth_model.dart';

class AuthDB {
  final box = ObjectBox.instance.store.box<AuthEntity>();

  void saveToDb(AuthModel model) {
    box.put(AuthEntity.fromModel(model));
    return;
  }

  void clear() {
    box.removeAll();
    return;
  }

  AuthModel? get() {
    final data = box.getAll().toList();

    if (data.isEmpty) return null;

    return data.first.toModel();
  }
}
