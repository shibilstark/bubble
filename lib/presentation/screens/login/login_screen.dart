import 'package:bubble/config/themes/themes.dart';
import 'package:bubble/presentation/router/router.dart';
import 'package:bubble/presentation/widgets/custom_buttons.dart';
import 'package:bubble/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Bubble",
          style: TextStyle(
            fontSize: AppFontSize.bigTitle,
            fontWeight: AppFontWeight.semiBold,
            color: Palette.blue,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.commonGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: AppPadding.largeScreenPadding,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Login to your account",
                      style: TextStyle(
                        fontSize: AppFontSize.bodyLarge,
                        fontWeight: AppFontWeight.regular,
                        color: Palette.black,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    const LoginFieldWithButtonWidget(),
                    SizedBox(height: 30.h),
                    GestureDetector(
                      onTap: () {
                        AppNavigator.push(
                            context: context,
                            screenName: AppRouter.SIGNUP_SCREEN);
                      },
                      child: Text(
                        "Don't have an Account? Sign up",
                        style: TextStyle(
                          fontSize: AppFontSize.displayLarge,
                          fontWeight: AppFontWeight.regular,
                          color: Palette.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginFieldWithButtonWidget extends StatelessWidget {
  const LoginFieldWithButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFildWidget(
          controller: TextEditingController(),
          focusNode: FocusNode(),
          hintText: "E mail",
        ),
        WhiteSpace.gapH25,
        CustomTextFildWidget(
          controller: TextEditingController(),
          focusNode: FocusNode(),
          hintText: "Password",
        ),
        WhiteSpace.gapH25,
        RoundedButton(
          title: "Login",
          ontap: () {},
        ),
      ],
    );
  }
}
