import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/themes/themes.dart';

class CustomTextFildWidget extends StatelessWidget {
  const CustomTextFildWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.isObcured = false,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixWiget,
    this.suffixWiget,
    this.validator,
    this.maxLines = 1,
    this.hintText = "",
    this.type = TextInputType.text,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Widget? suffixWiget;
  final Widget? suffixIcon;
  final Widget? prefixWiget;
  final Widget? prefixIcon;
  final bool isObcured;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final int maxLines;
  final String hintText;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        height: 50.h,
        child: TextField(
          keyboardType: type,
          obscureText: isObcured,
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          scrollPhysics: const BouncingScrollPhysics(),
          maxLines: maxLines,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Palette.grey,
              fontSize: AppFontSize.bodyMedium,
              fontWeight: AppFontWeight.medium,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.background,
            border: InputBorder.none,
            errorMaxLines: 3,
            suffixIcon: suffixIcon,
            suffix: suffixWiget,
            prefixIcon: prefixIcon,
            prefix: prefixWiget,
          ),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: AppFontWeight.medium,
              ),
        ),
      ),
    );
  }
}
