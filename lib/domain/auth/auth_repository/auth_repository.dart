import 'package:bubble/domain/auth/models/auth_model.dart';
import 'package:bubble/domain/common_types/type_defs.dart';

abstract class AuthRepository {
  FutureEither<AuthModel> loginWithPhone(String phoneNumber);

  FutureEither<AuthModel> verifyUserWithOtp({
    required String userId,
    required String secretCode,
    required String phoneNumber,
  });

  AuthModel? getFromDB();
}
