import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/global/widgets/cached_image.dart';

import '../../../global/models/plant.dart';
import '../../../global/utilities/theme.dart';

class PictureGifCarousel extends StatefulWidget {
  const PictureGifCarousel({Key? key, required this.pageNotifier, required this.plant}) : super(key: key);

  final ValueNotifier<int> pageNotifier;
  final Plant plant;
  @override
  State<PictureGifCarousel> createState() => _PictureGifCarouselState();
}

class _PictureGifCarouselState extends State<PictureGifCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 40.h,
        enableInfiniteScroll: false,
        pageSnapping: true,
        viewportFraction: 1,
        onPageChanged: (index, _) {
          widget.pageNotifier.value = index;
        },
      ),
      items: [widget.plant.gifURL, widget.plant.pictureURL!].map((url) {
        return Builder(
          builder: (BuildContext context) {
            return CachedImage(imageUrl: url, height: 40.h);
          },
        );
      }).toList(),
    );
  }
}
