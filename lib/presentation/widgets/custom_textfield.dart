import 'package:flutter/material.dart';

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
    this.maxLines = 1,
    this.hintText = "",
    this.type = TextInputType.text,
    this.borderRadius,
  });

  final TextEditingController controller;
  final BorderRadius? borderRadius;
  final FocusNode focusNode;
  final Widget? suffixWiget;
  final Widget? suffixIcon;
  final Widget? prefixWiget;
  final Widget? prefixIcon;
  final bool isObcured;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final int maxLines;
  final String hintText;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(5),
      child: TextField(
        keyboardType: type,
        obscureText: isObcured,
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted ??
            (val) {
              focusNode.nextFocus();
            },
        scrollPhysics: const BouncingScrollPhysics(),
        maxLines: maxLines,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Palette.grey,
            fontSize: AppFontSize.bodySmall,
            fontWeight: AppFontWeight.regular,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          filled: true,
          fillColor: Palette.white,
          border: InputBorder.none,
          errorMaxLines: 3,
          suffixIcon: suffixIcon,
          suffix: suffixWiget,
          prefixIcon: prefixIcon,
          prefix: prefixWiget,
        ),
        style: TextStyle(
          fontSize: AppFontSize.bodySmall,
          fontWeight: AppFontWeight.regular,
          color: Palette.black,
        ),
      ),
    );
  }
}
