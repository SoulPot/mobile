import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class AnalyzerCountPrinter extends StatelessWidget {
  AnalyzerCountPrinter({Key? key, required this.analyzerCount})
      : super(key: key);

  final int analyzerCount;
  final List<Widget> analyzerVisualizer = <Widget>[];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < analyzerCount; i++) {
      analyzerVisualizer.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Image.asset(
            "assets/images/SoulPotLogoFlowerTransparentBG.png",
            height: 15.h,
            width: 16.w,
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: analyzerVisualizer,
    );
  }
}
