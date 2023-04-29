// ignore_for_file: constant_identifier_names

import 'package:bubble/presentation/screens/home/home_screen.dart';
import 'package:bubble/presentation/screens/login/login_screen.dart';
import 'package:bubble/presentation/screens/signup/sign_up_screen.dart';
import 'package:bubble/presentation/screens/splash/splash_screen.dart';
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
          builder: (context) => const SplashScreen(),
        );

      case LOGIN_SCREEN:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      case SIGNUP_SCREEN:
        return MaterialPageRoute(
          builder: (context) => const SignupScreen(),
        );

      case HOME_SCREEN:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      default:
        return null;
    }
  }
}
