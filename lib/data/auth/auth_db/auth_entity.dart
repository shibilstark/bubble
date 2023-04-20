import 'package:bubble/domain/auth/models/auth_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class AuthEntity {
  int id;
  final String userId;
  final String tokenId;
  final DateTime expireAt;
  final String phone;

  AuthEntity({
    this.id = 0,
    required this.userId,
    required this.tokenId,
    required this.expireAt,
    required this.phone,
  });

  factory AuthEntity.fromModel(AuthModel model) => AuthEntity(
        userId: model.userId,
        tokenId: model.tokenId,
        expireAt: model.expireAt,
        phone: model.phone,
      );

  AuthModel toModel() => AuthModel(
        userId: userId,
        tokenId: tokenId,
        expireAt: expireAt,
        phone: phone,
      );
}
