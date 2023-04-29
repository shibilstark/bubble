import 'package:bubble/config/themes/themes.dart';
import 'package:bubble/presentation/logic/auth/auth_bloc.dart';
import 'package:bubble/presentation/router/router.dart';
import 'package:bubble/presentation/widgets/custom_buttons.dart';
import 'package:bubble/presentation/widgets/custom_snackbar.dart';
import 'package:bubble/presentation/widgets/custom_textfield.dart';
import 'package:bubble/presentation/widgets/indicator.dart';
import 'package:bubble/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthCreatedAccount) {
          AppNavigator.pushReplacement(
              context: context, screenName: AppRouter.LOGIN_SCREEN);
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}

class SignupFieldWidgetWithButton extends StatefulWidget {
  const SignupFieldWidgetWithButton({
    super.key,
  });

  @override
  State<SignupFieldWidgetWithButton> createState() =>
      _SignupFieldWidgetWithButtonState();
}

class _SignupFieldWidgetWithButtonState
    extends State<SignupFieldWidgetWithButton> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController conformPasswordController;
  late final FocusNode conformPasswordNode;
  late final FocusNode passwordNode;
  late final FocusNode emailNode;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    conformPasswordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    conformPasswordNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    conformPasswordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    conformPasswordNode.dispose();

    super.dispose();
  }

  bool _checkIsFormValid() {
    final email = emailController.text.trim();
    final pass = passwordController.text.trim();
    final cnfPass = conformPasswordController.text.trim();

    if (email.isEmailValid() && pass.isPasswordValid() && pass == cnfPass) {
      return true;
    } else {
      List<String> errors = [];

      if (email.isEmpty || pass.isEmpty || cnfPass.isEmpty) {
        errors.add("Fields can't be empty");
      }

      if (!email.isEmailValid()) {
        errors.add("Email format is incorrect");
      }

      if (!pass.isPasswordValid()) {
        errors.add("Password must be atleast 8 charecters long");
      }

      showCustomSnackBar(context, message: errors.join(", "));

      return false;
    }
  }

  void _onTapCreate() {
    if (_checkIsFormValid()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      context.read<AuthBloc>().add(AuthSignupUser(
            email: email,
            password: password,
            context: context,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFildWidget(
          controller: emailController,
          focusNode: emailNode,
          hintText: "E mail",
          type: TextInputType.emailAddress,
        ),
        WhiteSpace.gapH25,
        CustomTextFildWidget(
          controller: passwordController,
          focusNode: passwordNode,
          hintText: "Password",
          type: TextInputType.visiblePassword,
          isObcured: true,
        ),
        WhiteSpace.gapH5,
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(
              "Password must be 8 charecters long",
              style: TextStyle(
                fontSize: AppFontSize.displayLarge,
                fontWeight: AppFontWeight.regular,
                color: Palette.grey.withOpacity(0.6),
              ),
            ),
          ),
        ),
        WhiteSpace.gapH15,
        CustomTextFildWidget(
          controller: conformPasswordController,
          focusNode: conformPasswordNode,
          hintText: "Conform Password",
          type: TextInputType.visiblePassword,
          isObcured: true,
        ),
        WhiteSpace.gapH25,
        WidgetButton(
          ontap: _onTapCreate,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state is AuthLoading
                  ? const CircularIndicatorWidget(
                      indicatorColor: Palette.white,
                    )
                  : Text(
                      "Create Account",
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: AppFontSize.bodySmall,
                        fontWeight: AppFontWeight.semiBold,
                        letterSpacing: 1.2,
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}
