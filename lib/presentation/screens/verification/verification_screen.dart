import 'package:bubble/config/themes/dimensions.dart';
import 'package:bubble/config/themes/palette.dart';
import 'package:bubble/presentation/router/router.dart';
import 'package:bubble/presentation/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final welcomeTextStyle = TextStyle(
      fontWeight: AppFontWeight.regular,
      fontSize: AppFontSize.bodySmall,
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Palette.blue,
        child: const Icon(
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
                    text: "8606052640, ",
                    style: welcomeTextStyle.copyWith(
                      color: Palette.blue,
                      height: 1.4,
                    ),
                  ),
                  TextSpan(
                    text: "please verify",
                    style: welcomeTextStyle,
                  ),
                ],
              ),
              style: welcomeTextStyle,
            ),
            SizedBox(height: 100.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LengthLimitedTextFieldWidget(
                  controller: TextEditingController(),
                  focusNode: FocusNode(),
                ),
                WhiteSpace.gapW10,
                LengthLimitedTextFieldWidget(
                  controller: TextEditingController(),
                  focusNode: FocusNode(),
                ),
                WhiteSpace.gapW10,
                LengthLimitedTextFieldWidget(
                  controller: TextEditingController(),
                  focusNode: FocusNode(),
                ),
                WhiteSpace.gapW10,
                LengthLimitedTextFieldWidget(
                  controller: TextEditingController(),
                  focusNode: FocusNode(),
                ),
              ],
            ),
            WhiteSpace.gapH20,
            GestureDetector(
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
                AppNavigator.pop(context);
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
            AppNavigator.pop(context);
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
