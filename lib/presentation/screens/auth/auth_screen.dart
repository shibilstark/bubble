// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';

import 'package:bubble/config/assets/svgs.dart';
import 'package:bubble/config/themes/dimensions.dart';
import 'package:bubble/config/themes/palette.dart';
import 'package:bubble/presentation/logic/auth/auth_bloc.dart';
import 'package:bubble/presentation/router/router.dart';
import 'package:bubble/presentation/widgets/asset_image.dart';
import 'package:bubble/presentation/widgets/custom_snackbar.dart';
import 'package:bubble/presentation/widgets/custom_textfield.dart';
import 'package:bubble/utils/string_extensions.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final ValueNotifier<CountryCode?> countryCodeNotifier;
  late final ValueNotifier<String?> errorStatus;
  late final TextEditingController phoneNumberController;
  late final FocusNode focusNode;

  @override
  void initState() {
    countryCodeNotifier = ValueNotifier(null);
    errorStatus = ValueNotifier(null);
    phoneNumberController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    countryCodeNotifier.dispose();
    errorStatus.dispose();
    phoneNumberController.dispose();
    focusNode.dispose();

    super.dispose();
  }

  final countryPicker = const FlCountryCodePicker();
  final countryPickerWithParams = FlCountryCodePicker(
      localize: true,
      showDialCode: true,
      showSearchBar: true,
      title: Padding(
        padding: AppPadding.largeScreenPadding,
        child: Text(
          "Select your Country",
          style: TextStyle(
            fontSize: AppFontSize.bodyMedium,
            color: Palette.black,
            fontWeight: AppFontWeight.medium,
          ),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthVerfication) {
          AppNavigator.pushReplacement(
              context: context, screenName: AppRouter.VERIFICATION_SCREEN);
        }

        if (state is AuthError) {
          showCustomSnackBar(
            context,
            message: state.error.message,
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: AuthenticationButtonWidget(
          countryCodeNotifier: countryCodeNotifier,
          phoneNumberController: phoneNumberController,
          errorStatus: errorStatus,
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: AppPadding.largeScreenPadding,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Bubble",
                      style: TextStyle(
                        color: Palette.blue,
                        fontSize: AppFontSize.bigTitle,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      "Signup/Login to your Account",
                      style: TextStyle(
                        color: Palette.black,
                        fontSize: AppFontSize.bodySmall,
                        fontWeight: AppFontWeight.regular,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 60.h),
                    AssetImageView(
                      fileName: SvgAsset.loginBg,
                      width: width * 0.6,
                    ),
                    SizedBox(height: 60.h),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final code = await countryPickerWithParams
                                .showPicker(context: context);

                            if (code == null) return;

                            countryCodeNotifier.value = code;
                            countryCodeNotifier.notifyListeners();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: ValueListenableBuilder(
                                valueListenable: countryCodeNotifier,
                                builder: (context, val, _) {
                                  return LimitedBox(
                                    child: Row(
                                      children: [
                                        val == null
                                            ? const SizedBox()
                                            : Image.asset(
                                                val.flagUri,
                                                fit: BoxFit.fill,
                                                width: 17,
                                                height: 12,
                                                package: val.flagImagePackage,
                                              ),
                                        WhiteSpace.gapW10,
                                        Text(
                                            val == null ? "- - " : val.dialCode)
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Expanded(
                          child: CustomTextFildWidget(
                            controller: phoneNumberController,
                            onChanged: (_) {
                              errorStatus.notifyListeners();
                            },
                            focusNode: focusNode,
                            hintText: "Enter your Mobile Number",
                            type: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    ValueListenableBuilder(
                        valueListenable: errorStatus,
                        builder: (context, value, child) {
                          if (value == null) {
                            return const SizedBox();
                          }

                          return Text(
                            value,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: AppFontSize.bodySmall,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          );
                        }),
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

class AuthenticationButtonWidget extends StatelessWidget {
  const AuthenticationButtonWidget({
    super.key,
    required this.countryCodeNotifier,
    required this.phoneNumberController,
    required this.errorStatus,
  });

  final ValueNotifier<CountryCode?> countryCodeNotifier;
  final ValueNotifier<String?> errorStatus;
  final TextEditingController phoneNumberController;

  void onTapAuthenticate(BuildContext context) {
    if (_validatePhoneNumber()) {
      final phoneNumber = phoneNumberController.text.trim();
      final countryCode = countryCodeNotifier.value!;

      context.read<AuthBloc>().add(CreateUser(
          phoneNumber: countryCode.dialCode + phoneNumber,
          countryCode: countryCode));
    }
  }

  bool _validatePhoneNumber() {
    final numberText = phoneNumberController.value.text.trim();

    List<String> errorTexts = [];

    if (numberText.isNotEmpty &&
        numberText.isPhoneNumber() &&
        numberText.length == 10 &&
        countryCodeNotifier.value != null) {
      return true;
    } else {
      if (countryCodeNotifier.value == null) {
        errorTexts.add("Country code can't be empty");
      }
      if (numberText.isEmpty) {
        errorTexts.add("Phone number can't be empty");
      }

      if (!numberText.isPhoneNumber() || numberText.length != 10) {
        errorTexts.add("Enter a valid phone number with 10 digits");
      }

      errorStatus.value = errorTexts.join(", ");
      errorStatus.notifyListeners();

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => FloatingActionButton(
        onPressed: () => onTapAuthenticate(context),
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
    );
  }
}
