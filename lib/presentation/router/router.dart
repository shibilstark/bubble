// ignore_for_file: constant_identifier_names

import 'package:bubble/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
part 'app_navigator.dart';

class AppRouter {
  static const SPLASH_SCREEN = "/";
  static const AUTH_SCREEN = "auth/";
  static const VERIFICATION_SCREEN = "verification/";
  static const HOME_SCREEN = "home/";

  static Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      // case SPLASH_SCREEN:
      //   return MaterialPageRoute(
      //     builder: (context) => const SplashScreen(),
      //   );

      case HOME_SCREEN:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      default:
        return null;
    }
  }
}
