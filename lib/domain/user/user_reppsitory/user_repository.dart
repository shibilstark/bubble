import 'package:bubble/domain/common_types/type_defs.dart';
import 'package:bubble/domain/user/models/user_model.dart';

abstract class UserRepository {
  FutureEither<void> createUser(UserModel user);

  FutureEither<void> updateUser(UserModel user);

  FutureEither<UserModel> getUser(String uid);

  UserModel? getUserFromDb();

  int saveUser(UserModel model);

  void updateUserInDb(UserModel model);
}
