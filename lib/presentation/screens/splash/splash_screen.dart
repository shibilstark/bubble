import 'package:bubble/config/assets/assets.dart';
import 'package:bubble/config/themes/dimensions.dart';
import 'package:bubble/presentation/router/router.dart';
import 'package:bubble/presentation/widgets/asset_image.dart';
import 'package:bubble/presentation/widgets/custom_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(const AuthLoadFromDb());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.08;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        await Future.delayed(const Duration(seconds: 2)).then((_) {
          if (state is AuthNotFound) {
            AppNavigator.pushReplacement(
              context: context,
              screenName: AppRouter.AUTH_SCREEN,
            );
          } else {
            AppNavigator.pushReplacement(
              context: context,
              screenName: AppRouter.HOME_SCREEN,
            );
          }
        });
      },
      child: Scaffold(
        body: Center(
            child: Stack(
          alignment: Alignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: width,
              width: width,
              child: const AppAssetImageView(
                SvgAsset.appLogo,
              ),
            ),
            WhiteSpace.gapH25,
            CustomLoadingIndicator(
              width: width * 0.7,
            ),
          ],
        )),
      ),
    );
  }
}
