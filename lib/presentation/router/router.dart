// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
part 'app_navigator.dart';

class AppRouter {
  static const SPLASH_SCREEN = "/";
  static const LOGIN_SCREEN = "login/";
  static const SIGNUP_SCREEN = "signup/";
  static const HOME_SCREEN = "home/";

  static Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH_SCREEN:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
        );

      default:
        return null;
    }
  }
}
