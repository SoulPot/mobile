import 'package:flutter/cupertino.dart';

class AnalyzerCountPrinter extends StatelessWidget {
  AnalyzerCountPrinter({Key? key, required this.AnalyzerCount})
      : super(key: key);

  final int AnalyzerCount;
  var analyzerVisualizer = <Widget>[];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < AnalyzerCount; i++) {
      analyzerVisualizer.add(
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset(
            "assets/images/SoulPotLogoFlower.png",
            height: 100,
            width: MediaQuery.of(context).size.width / 6,
          ),
        ),
      );
    }
    return Row(
      children: analyzerVisualizer,
    );
  }
}
