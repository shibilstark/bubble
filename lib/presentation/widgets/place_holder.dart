import 'package:flutter/cupertino.dart';

class CommonPlaceHolder extends StatelessWidget {
  const CommonPlaceHolder({
    Key? key,
    required this.height,
    required this.width,
    this.radius = 10,
  }) : super(key: key);
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
