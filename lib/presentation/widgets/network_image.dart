import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'asset_image.dart';
import 'place_holder.dart';

class NetWorkImageWidget extends StatelessWidget {
  const NetWorkImageWidget(
      {Key? key,
      required this.image,
      this.height = 120,
      this.width = 80,
      this.placeholder,
      this.placeholderRadius = 5,
      this.fit = BoxFit.fill})
      : super(key: key);

  final double height;
  final double width;
  final String? image;
  final String? placeholder;
  final double placeholderRadius;

  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return image == null || image!.trim() == ''
        ? placeholder == null
            ? CommonPlaceHolder(
                height: height,
                width: width,
                radius: 5,
              )
            : AppAssetImageView(
                placeholder!,
                width: width,
                height: height,
                fit: BoxFit.cover,
              )
        : CachedNetworkImage(
            imageUrl: "$image",
            width: width,
            height: height,
            fit: fit,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit,
                ),
              ),
            ),
            placeholder: (context, url) => CommonPlaceHolder(
                height: height, width: width, radius: placeholderRadius),
            errorWidget: (context, url, error) => CommonPlaceHolder(
                height: height, width: width, radius: placeholderRadius),
          );
  }
}
