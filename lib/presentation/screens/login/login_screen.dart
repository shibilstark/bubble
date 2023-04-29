import 'package:bubble/config/themes/themes.dart';
import 'package:bubble/presentation/logic/auth/auth_bloc.dart';
import 'package:bubble/presentation/router/router.dart';
import 'package:bubble/presentation/widgets/custom_buttons.dart';
import 'package:bubble/presentation/widgets/custom_snackbar.dart';
import 'package:bubble/presentation/widgets/custom_textfield.dart';
import 'package:bubble/presentation/widgets/indicator.dart';
import 'package:bubble/presentation/widgets/keyboard_dismisser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedIn) {
          AppNavigator.pushReplacement(
              context: context, screenName: AppRouter.HOME_SCREEN);
        }
      },
      child: Scaffold(
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
        body: KeyBoardDismisser(
          focusNode: FocusScope.of(context),
          child: Container(
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
        ),
      ),
    );
  }
}

class LoginFieldWithButtonWidget extends StatefulWidget {
  const LoginFieldWithButtonWidget({
    super.key,
  });

  @override
  State<LoginFieldWithButtonWidget> createState() =>
      _LoginFieldWithButtonWidgetState();
}

class _LoginFieldWithButtonWidgetState
    extends State<LoginFieldWithButtonWidget> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FocusNode emailNode;
  late final FocusNode passwordNode;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  bool _checkIsFormValid() {
    final email = emailController.text.trim();
    final pass = passwordController.text.trim();

    if (email.isNotEmpty && pass.isNotEmpty) {
      return true;
    } else {
      showCustomSnackBar(context, message: "Fields can't be empty");

      return false;
    }
  }

  void _onTapLogin() {
    FocusScope.of(context).unfocus();
    if (_checkIsFormValid()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      context.read<AuthBloc>().add(AuthLoginUser(
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
        WhiteSpace.gapH25,
        WidgetButton(
          ontap: _onTapLogin,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state is AuthLoading
                  ? const CircularIndicatorWidget(
                      indicatorColor: Palette.white,
                    )
                  : Text(
                      "Login",
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
