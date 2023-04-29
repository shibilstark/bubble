import 'package:bubble/config/themes/palette.dart';
import 'package:flutter/material.dart';

class CircularIndicatorWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color indicatorColor;
  const CircularIndicatorWidget({
    super.key,
    this.height = 20,
    this.width = 20,
    this.indicatorColor = Palette.blue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator(
        color: indicatorColor,
        strokeWidth: 2.5,
      ),
    );
  }
}
