import 'package:bubble/domain/auth/models/auth_model.dart';
import 'package:bubble/domain/common_types/type_defs.dart';

abstract class AuthRepository {
  FutureEither<void> logOut();

  FutureEither<AuthModel> googleLogin();

  AuthModel? getAuthFromDb();
}
