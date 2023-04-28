import 'package:flutter/material.dart';

import '../../config/themes/themes.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.title,
    required this.ontap,
    this.borderRadius,
    this.backgroundColor = Palette.blue,
    this.textColor = Palette.white,
    this.textStyle,
  });
  final String title;
  final void Function() ontap;
  final BorderRadius? borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        backgroundColor: MaterialStateProperty.all(
          backgroundColor,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(5),
          ),
        ),
      ),
      child: Text(
        title,
        style: textStyle ??
            TextStyle(
              color: textColor,
              fontSize: AppFontSize.bodySmall,
              fontWeight: AppFontWeight.semiBold,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}

// class WidgetButton extends StatelessWidget {
//   const WidgetButton({
//     super.key,
//     required this.ontap,
//     required this.child,
//     this.borderRadius,
//     this.backgroundColor = Palette.purple,
//     this.textColor = Palette.textWhite,
//   });

//   final void Function() ontap;
//   final BorderRadius? borderRadius;
//   final Color backgroundColor;
//   final Color textColor;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: ontap,
//       style: ButtonStyle(
//         elevation: const MaterialStatePropertyAll(0),
//         backgroundColor: MaterialStateProperty.all(
//           backgroundColor,
//         ),
//         shape: MaterialStateProperty.all(
//           RoundedRectangleBorder(
//             borderRadius: borderRadius ?? BorderRadius.circular(5),
//           ),
//         ),
//       ),
//       child: child,
//     );
//   }
// }
