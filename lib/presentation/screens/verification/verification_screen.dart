import 'package:bubble/config/themes/dimensions.dart';
import 'package:bubble/config/themes/palette.dart';
import 'package:bubble/presentation/logic/auth/auth_bloc.dart';
import 'package:bubble/presentation/router/router.dart';
import 'package:bubble/presentation/widgets/custom_snackbar.dart';
import 'package:bubble/presentation/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as df;

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late final TextEditingController digit1Controller;
  late final TextEditingController digit2Controller;
  late final TextEditingController digit3Controller;
  late final TextEditingController digit4Controller;
  late final TextEditingController digit5Controller;
  late final TextEditingController digit6Controller;

  @override
  void initState() {
    digit1Controller = TextEditingController();
    digit2Controller = TextEditingController();
    digit3Controller = TextEditingController();
    digit4Controller = TextEditingController();
    digit5Controller = TextEditingController();
    digit6Controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    digit1Controller.dispose();
    digit2Controller.dispose();
    digit3Controller.dispose();
    digit4Controller.dispose();
    digit5Controller.dispose();
    digit6Controller.dispose();
    super.dispose();
  }

  _clearControllers() {
    digit1Controller.clear();
    digit2Controller.clear();
    digit3Controller.clear();
    digit4Controller.clear();
    digit5Controller.clear();
    digit6Controller.clear();
  }

  void verifyNumber(BuildContext context, AuthVerfication state) {
    final digit1 = digit1Controller.text.trim();
    final digit2 = digit2Controller.text.trim();
    final digit3 = digit3Controller.text.trim();
    final digit4 = digit4Controller.text.trim();
    final digit5 = digit5Controller.text.trim();
    final digit6 = digit6Controller.text.trim();

    if (digit1.isNotEmpty &&
        digit2.isNotEmpty &&
        digit3.isNotEmpty &&
        digit4.isNotEmpty &&
        digit5.isNotEmpty &&
        digit6.isNotEmpty) {
      final secretCode = digit1 + digit2 + digit3 + digit4 + digit5 + digit6;

      context.read<AuthBloc>().add(
            VerifyWithOtp(
              auth: state.auth,
              secretCode: secretCode,
              countryCode: state.countryCode,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gestureTextStyle = TextStyle(
      fontWeight: AppFontWeight.regular,
      fontSize: AppFontSize.bodySmall,
    );
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          _clearControllers();
          AppNavigator.pop(context);
          showCustomSnackBar(context, message: state.error.message);
        }

        if (state is AuthVerfication) {
          if (state.isError && state.error != null) {
            _clearControllers();
            showCustomSnackBar(context, message: state.error!.message);
          }
        }

        if (state is AuthSuccess) {
          showCustomSnackBar(context,
              message: "Sucessfully Logged in to your Account");
          AppNavigator.clearRouteIfFirst(context);
          AppNavigator.pushReplacement(
            context: context,
            screenName: AppRouter.HOME_SCREEN,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthVerfication) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => verifyNumber(context, state),
              backgroundColor: Palette.blue,
              child: state is AuthLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Palette.white,
                      ),
                    )
                  : const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Palette.white,
                    ),
            ),
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: VerficationAppBarWidget()),
            body: Padding(
              padding: AppPadding.largeScreenPadding,
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      text: "We have send an  otp to your number ",
                      children: [
                        TextSpan(
                          text: "${state.auth.phone}, ",
                          style: gestureTextStyle.copyWith(
                            color: Palette.blue,
                            fontWeight: AppFontWeight.medium,
                            height: 1.4,
                          ),
                        ),
                        TextSpan(
                          text: "please verify",
                          style: gestureTextStyle,
                        ),
                      ],
                    ),
                    style: gestureTextStyle,
                  ),
                  SizedBox(height: 100.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LengthLimitedTextFieldWidget(
                        controller: digit1Controller,
                        focusNode: FocusNode(),
                      ),
                      WhiteSpace.gapW10,
                      LengthLimitedTextFieldWidget(
                        controller: digit2Controller,
                        focusNode: FocusNode(),
                      ),
                      WhiteSpace.gapW10,
                      LengthLimitedTextFieldWidget(
                        controller: digit3Controller,
                        focusNode: FocusNode(),
                      ),
                      WhiteSpace.gapW10,
                      LengthLimitedTextFieldWidget(
                        controller: digit4Controller,
                        focusNode: FocusNode(),
                      ),
                      WhiteSpace.gapW10,
                      LengthLimitedTextFieldWidget(
                        controller: digit5Controller,
                        focusNode: FocusNode(),
                      ),
                      WhiteSpace.gapW10,
                      LengthLimitedTextFieldWidget(
                        controller: digit6Controller,
                        focusNode: FocusNode(),
                      ),
                    ],
                  ),
                  WhiteSpace.gapH20,
                  state.auth.expireAt.isAfter(DateTime.now())
                      ? StreamBuilder(
                          builder: (context, snapshot) {
                            final remaining =
                                DateTime.fromMillisecondsSinceEpoch(
                                    state.auth.expireAt.millisecondsSinceEpoch -
                                        DateTime.now().millisecondsSinceEpoch);
                            return Text(
                              "OTP will Expire in ${df.DateFormat("hh:mm:ss").format(remaining)}",
                              style: TextStyle(
                                fontWeight: AppFontWeight.regular,
                                fontSize: AppFontSize.bodySmall,
                                color: Palette.grey,
                              ),
                            );
                          },
                          stream: Stream.periodic(const Duration(seconds: 1)),
                        )
                      : GestureDetector(
                          child: Text(
                            "Didn't got your code?, send again",
                            style: TextStyle(
                              fontWeight: AppFontWeight.regular,
                              fontSize: AppFontSize.bodySmall,
                              color: Palette.blue,
                            ),
                          ),
                        ),
                  WhiteSpace.gapH10,
                  GestureDetector(
                    onTap: () {
                      AppNavigator.pushReplacement(
                          context: context, screenName: AppRouter.AUTH_SCREEN);
                    },
                    child: Text(
                      "Edit your Number",
                      style: TextStyle(
                        fontWeight: AppFontWeight.regular,
                        fontSize: AppFontSize.bodySmall,
                        color: Palette.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class VerficationAppBarWidget extends StatelessWidget {
  const VerficationAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            AppNavigator.pushReplacement(
                context: context, screenName: AppRouter.AUTH_SCREEN);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Palette.blue,
            size: 25,
          )),
      titleSpacing: -5,
      title: Text(
        "Verfication",
        style: TextStyle(
          color: Palette.black,
          fontSize: AppFontSize.bodyMedium,
          fontWeight: AppFontWeight.medium,
        ),
      ),
    );
  }
}

class LengthLimitedTextFieldWidget extends StatelessWidget {
  const LengthLimitedTextFieldWidget({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return RoundedContainerWidget(
      borderRadius: BorderRadius.circular(5),
      height: 60,
      width: 40,
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        controller: controller,
        focusNode: focusNode,
        onChanged: (val) {
          if (val.trim().isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: const InputDecoration(
          filled: true,
          fillColor: Palette.lightWhite,
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: Palette.black,
          fontWeight: AppFontWeight.medium,
          fontSize: AppFontSize.bodyLarge,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
