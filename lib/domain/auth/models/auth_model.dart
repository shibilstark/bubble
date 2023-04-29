// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class AuthModel {
  final int id;
  final String userId;
  final String sessionId;
  final DateTime expireAt;
  final String email;
  final bool isEmailVerified;

  const AuthModel({
    required this.id,
    required this.userId,
    required this.sessionId,
    required this.expireAt,
    required this.email,
    required this.isEmailVerified,
  });

  AuthModel copyWith({
    int? id,
    String? userId,
    String? sessionId,
    DateTime? expireAt,
    String? email,
    bool? isEmailVerified,
  }) {
    return AuthModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      sessionId: sessionId ?? this.sessionId,
      expireAt: expireAt ?? this.expireAt,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }
}
