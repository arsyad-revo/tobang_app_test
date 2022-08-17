import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tobang_app_test/utils/widget_util.dart';

class CachedImage extends StatelessWidget {
  final String? imgUrl;
  final double? radius;
  const CachedImage({Key? key, this.imgUrl, this.radius = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imgUrl!,
        imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius!),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        placeholder: (context, url) => Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: customLoading(),
              ),
            ),
        errorWidget: (context, url, error) => const Icon(Icons.error));
  }
}
