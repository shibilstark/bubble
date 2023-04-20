import 'package:bubble/presentation/logic/auth/auth_bloc.dart';
import 'package:bubble/presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _loadAuth();
    super.initState();
  }

  _loadAuth() async {
    await Future.delayed(const Duration(seconds: 2)).then((_) {
      context.read<AuthBloc>().add(const LoadAuth());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthNotFound) {
          AppNavigator.pushReplacement(
              context: context, screenName: AppRouter.AUTH_SCREEN);
        } else {
          AppNavigator.pushReplacement(
              context: context, screenName: AppRouter.HOME_SCREEN);
        }
      },
      child: const Scaffold(),
    );
  }
}
