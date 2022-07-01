import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utilities/theme.dart';

class CachedImage extends StatefulWidget {
  const CachedImage(
      {Key? key,
      required this.imageUrl,
      required this.height})
      : super(key: key);

  final String imageUrl;
  final double height;

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl,
        height: widget.height,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
            color: SoulPotTheme.spGreen,
          ),
        ),
        errorWidget: (context, url, error) =>
            const Center(child: Icon(Icons.error)),
      ),
    );
  }
}
