import 'package:bubble/domain/common_types/type_defs.dart';
import 'package:bubble/domain/user/models/user_model.dart';

abstract class UserRepository {
  FutureEither<UserModel> createUserIfNotAvailable(UserModel user);

  FutureEither<void> updateUser(
      {required String uid, required Map<String, dynamic> updates});

  UserModel getUserFromDb();

  Stream<UserModel> getUserStream();
}
