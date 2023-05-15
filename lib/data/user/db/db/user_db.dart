import 'package:bubble/data/app_db/app_db.dart';
import 'package:bubble/data/user/db/db/entities/user_entity.dart';
import 'package:bubble/domain/user/models/user_model.dart';

class AuthDb {
  final _box = ObjectBox.instance.store.box<UserEntity>();
}
