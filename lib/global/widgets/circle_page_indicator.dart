
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:sizer/sizer.dart';

import '../utilities/theme.dart';

class PageIndicator extends StatefulWidget {
  const PageIndicator({Key? key, required this.pageNotifier, required this.itemCount}) : super(key: key);

  final ValueNotifier<int> pageNotifier;
  final int itemCount;

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: CirclePageIndicator(
        currentPageNotifier: widget.pageNotifier,
        itemCount: widget.itemCount,
        size: 10,
        selectedSize: 12,
        selectedDotColor: SoulPotTheme.spGreen,
        dotColor: Colors.grey,
      )
    );
  }
}

// return CirclePageIndicator(
//       currentPageNotifier: widget.pageNotifier,
//       itemCount: snapshot.data!.docs.length,
//       size: 10,
//       selectedSize: 12,
//       selectedDotColor: SoulPotTheme.spGreen,
//       dotColor: Colors.grey,
//     );