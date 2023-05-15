import 'package:bubble/domain/user/models/user_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserEntity {
  int id;
  final String uid;
  final String userName;
  final String bio;
  final String statusText;
  final String profilePic;
  final String coverPic;
  final String email;
  final bool isOnline;
  final List<String> groupIds;

  UserEntity({
    this.id = 0,
    required this.uid,
    required this.userName,
    required this.bio,
    required this.statusText,
    required this.profilePic,
    required this.coverPic,
    required this.email,
    required this.isOnline,
    required this.groupIds,
  });

  factory UserEntity.fromModel(UserModel model) {
    return UserEntity(
      id: model.id,
      uid: model.uid,
      userName: model.userName,
      bio: model.bio,
      statusText: model.statusText,
      profilePic: model.profilePic,
      coverPic: model.coverPic,
      email: model.email,
      isOnline: model.isOnline,
      groupIds: model.groupIds,
    );
  }
  UserModel toModel() {
    return UserModel(
      uid: uid,
      userName: userName,
      bio: bio,
      statusText: statusText,
      profilePic: profilePic,
      coverPic: coverPic,
      email: email,
      isOnline: isOnline,
      groupIds: groupIds,
    );
  }
}
