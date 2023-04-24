class AuthModel {
  final String userId;
  final String tokenId;
  final DateTime expireAt;
  final String phone;

  AuthModel({
    required this.userId,
    required this.tokenId,
    required this.expireAt,
    required this.phone,
  });
}
