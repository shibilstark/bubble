import 'package:bubble/config/assets/svgs.dart';
import 'package:bubble/config/themes/dimensions.dart';
import 'package:bubble/config/themes/palette.dart';
import 'package:bubble/presentation/widgets/asset_image.dart';
import 'package:bubble/presentation/widgets/cutom_textfield.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final ValueNotifier<CountryCode?> countryCodeNotifier;

  @override
  void initState() {
    countryCodeNotifier = ValueNotifier(null);
    super.initState();
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Palette.blue,
        child: const Icon(
          Icons.keyboard_arrow_right_rounded,
          color: Palette.white,
        ),
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
                          final code = await countryPickerWithParams.showPicker(
                              context: context);

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
                                      Text(val == null ? "- -" : val.dialCode)
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                      Expanded(
                        child: CustomTextFildWidget(
                          controller: TextEditingController(),
                          focusNode: FocusNode(),
                          hintText: "Enter your Mobile Number",
                          type: TextInputType.phone,
                        ),
                      ),
                    ],
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
