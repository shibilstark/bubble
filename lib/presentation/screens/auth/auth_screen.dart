import 'package:bubble/config/assets/assets.dart';
import 'package:bubble/config/themes/themes.dart';
import 'package:bubble/presentation/bloc/theme/theme_bloc.dart';
import 'package:bubble/presentation/widgets/asset_image.dart';
import 'package:bubble/presentation/widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          const AuthBackgroundWidget(),
          Padding(
            padding: AppPadding.largeScreenPadding,
            child: Column(
              children: const [
                WelcomeTextsWidget(),
                Spacer(),
                AuthButtonWidget(),
              ],
            ),
          )
        ],
      )),
    );
  }
}

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialButton(
                elevation: 3,
                color:
                    state.isDarkMode ? AppColors.lightBlack : AppColors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppAssetImageView(
                      SvgAsset.googleLogo,
                      fit: BoxFit.scaleDown,
                    ),
                    WhiteSpace.gapW10,
                    Text(
                      "Login or Signup",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        WhiteSpace.gapH10,
        Text.rich(
          TextSpan(
              text: "By creating account you are agreed to our ",
              style: Theme.of(context).textTheme.bodySmall!,
              children: [
                TextSpan(
                  text: "terms and conditions ",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.theme,
                        fontWeight: AppFontWeight.medium,
                      ),
                ),
                const TextSpan(
                  text: "& ",
                ),
                TextSpan(
                  text: "privacy policy  ",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.theme,
                        fontWeight: AppFontWeight.medium,
                      ),
                ),
              ]),
        )
      ],
    );
  }
}

class WelcomeTextsWidget extends StatelessWidget {
  const WelcomeTextsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "BUBBLE",
          style: TextStyle(
            color: AppColors.theme,
            fontSize: AppFontSize.titleLarge,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        WhiteSpace.gapH20,
        Text(
          "Welcome to Bubble",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        WhiteSpace.gapH10,
        Text(
          "Expand your vision, connect with world ",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class AuthBackgroundWidget extends StatelessWidget {
  const AuthBackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerRight,
      child: AppAssetImageView(
        SvgAsset.appLogo,
        fit: BoxFit.cover,
      ),
    );
  }
}
