import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/themes/themes.dart';

/// Return an animated [ShimmerWidget], in case of is rounded only pass radius.
class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget(
      {Key? key,
      this.isRound = false,
      this.height = 0,
      this.width = 0,
      this.radius = 10})
      : super(key: key);

  final bool isRound;
  final double radius;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        enabled: true,
        period: const Duration(seconds: 2),
        baseColor: AppColors.black.withOpacity(0.1),
        highlightColor: AppColors.white.withOpacity(0.5),
        child: isRound
            ? CircleAvatar(
                backgroundColor: AppColors.white,
                radius: radius,
              )
            : Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(radius)),
                height: height,
                width: width,
              ));
  }
}
