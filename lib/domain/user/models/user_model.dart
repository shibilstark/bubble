import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String uid;
  final String userName;
  final String bio;
  final String statusText;
  final String profilePic;
  final String coverPic;
  final String email;
  final bool isOnline;
  final List<String> groupIds;

  UserModel({
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

  UserModel copyWith({
    String? uid,
    String? userName,
    String? bio,
    String? statusText,
    String? profilePic,
    String? coverPic,
    String? email,
    bool? isOnline,
    List<String>? groupIds,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      bio: bio ?? this.bio,
      statusText: statusText ?? this.statusText,
      profilePic: profilePic ?? this.profilePic,
      coverPic: coverPic ?? this.coverPic,
      email: email ?? this.email,
      isOnline: isOnline ?? this.isOnline,
      groupIds: groupIds ?? this.groupIds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'bio': bio,
      'statusText': statusText,
      'profilePic': profilePic,
      'coverPic': coverPic,
      'email': email,
      'isOnline': isOnline,
      'groupIds': groupIds,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['\$id'] as String,
      userName: map['userName'] as String,
      bio: map['bio'] as String,
      statusText: map['statusText'] as String,
      profilePic: map['profilePic'] as String,
      coverPic: map['coverPic'] as String,
      email: map['email'] as String,
      isOnline: map['isOnline'] as bool,
      groupIds: List<dynamic>.from((map['groupIds']))
          .map((e) => e.toString())
          .toList(),
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, userName: $userName, bio: $bio, statusText: $statusText, profilePic: $profilePic, coverPic: $coverPic, email: $email, isOnline: $isOnline, groupIds: $groupIds)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.userName == userName &&
        other.bio == bio &&
        other.statusText == statusText &&
        other.profilePic == profilePic &&
        other.coverPic == coverPic &&
        other.email == email &&
        other.isOnline == isOnline &&
        listEquals(other.groupIds, groupIds);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        userName.hashCode ^
        bio.hashCode ^
        statusText.hashCode ^
        profilePic.hashCode ^
        coverPic.hashCode ^
        email.hashCode ^
        isOnline.hashCode ^
        groupIds.hashCode;
  }
}
