import 'dart:async';

import 'package:bubble/data/app_db/app_db.dart';
import 'package:bubble/data/user/db/db/entities/user_entity.dart';
import 'package:bubble/domain/user/models/user_model.dart';

class UserDb {
  static final _box = ObjectBox.instance.store.box<UserEntity>();

  static UserModel getUser() {
    final boxData = _box.getAll().toList();
    return boxData.first.toModel();
  }

  static int setUser(UserModel model) {
    _box.removeAll();
    final entity = UserEntity.fromModel(model);
    return _box.put(entity);
  }

  static void update(UserModel model) {
    final entity = UserEntity.fromModel(model);
    _box.put(entity);
  }

  static void clearUser() {
    _box.removeAll();
  }

  static Stream<UserModel> getStream() {
    final stream = _box.query().build().stream();

    void handleData(UserEntity data, EventSink<UserModel> sink) {
      sink.add(data.toModel());
    }

    final transformer = StreamTransformer.fromHandlers(handleData: handleData);
    return stream.transform<UserModel>(transformer);
  }
}
