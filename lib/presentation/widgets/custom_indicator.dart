import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    this.width = 30,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      color: Theme.of(context).colorScheme.primary,
      size: width,
      itemCount: 4,
      duration: const Duration(milliseconds: 800),
    );
  }
}
