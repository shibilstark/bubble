import 'package:bubble/config/themes/themes.dart';
import 'package:bubble/presentation/router/router.dart';
import 'package:bubble/presentation/widgets/custom_buttons.dart';
import 'package:bubble/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController conformPasswordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    conformPasswordController = TextEditingController();

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
        titleSpacing: -5,
        leading: IconButton(
            onPressed: () {
              AppNavigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: Palette.blue,
            )),
        title: Text(
          "Create New Account",
          style: TextStyle(
            fontSize: AppFontSize.bodyLarge,
            fontWeight: AppFontWeight.medium,
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Login to your account",
                      style: TextStyle(
                        fontSize: AppFontSize.bodyLarge,
                        fontWeight: AppFontWeight.regular,
                        color: Palette.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  const SignupFieldWidgetWithButton(),
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: () {
                      AppNavigator.pop(context);
                    },
                    child: Text(
                      "Already have an account? Login",
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
    );
  }
}

class SignupFieldWidgetWithButton extends StatelessWidget {
  const SignupFieldWidgetWithButton({
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
        CustomTextFildWidget(
          controller: TextEditingController(),
          focusNode: FocusNode(),
          hintText: "Conform Password",
        ),
        WhiteSpace.gapH25,
        RoundedButton(
          title: "Create Account",
          ontap: () {},
        ),
      ],
    );
  }
}
