import 'package:objectbox/objectbox.dart';
import 'package:bubble/domain/auth/models/auth_model.dart';

@Entity()
class AuthEntity {
  int id;
  final String uid;
  final DateTime expireAt;
  final String email;
  final bool isEmailVerified;

  AuthEntity({
    this.id = 0,
    required this.uid,
    required this.expireAt,
    required this.email,
    required this.isEmailVerified,
  });

  factory AuthEntity.fromModel(AuthModel model) {
    return AuthEntity(
      id: model.id,
      uid: model.userId,
      expireAt: model.expireAt,
      email: model.email,
      isEmailVerified: model.isEmailVerified,
    );
  }
  AuthModel toModel() {
    return AuthModel(
      id: id,
      userId: uid,
      expireAt: expireAt,
      email: email,
      isEmailVerified: isEmailVerified,
    );
  }
}
