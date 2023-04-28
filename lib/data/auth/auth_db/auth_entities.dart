import 'package:bubble/domain/auth/models/auth_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class AuthEntity {
  int id;
  final String userId;
  final String sessionId;
  final DateTime expireAt;
  final String email;
  final bool isEmailVerified;

  AuthEntity({
    this.id = 0,
    required this.userId,
    required this.sessionId,
    required this.expireAt,
    required this.email,
    required this.isEmailVerified,
  });

  factory AuthEntity.fromModel(AuthModel model) => AuthEntity(
        id: model.id,
        userId: model.userId,
        sessionId: model.sessionId,
        expireAt: model.expireAt,
        email: model.email,
        isEmailVerified: model.isEmailVerified,
      );

  AuthModel toModel() => AuthModel(
        id: id,
        userId: userId,
        sessionId: sessionId,
        expireAt: expireAt,
        email: email,
        isEmailVerified: isEmailVerified,
      );
}
