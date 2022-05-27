import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AnalyzerWifiModifier extends StatefulWidget {
  const AnalyzerWifiModifier({Key? key}) : super(key: key);

  @override
  State<AnalyzerWifiModifier> createState() => _AnalyzerWifiModifierState();
}

class _AnalyzerWifiModifierState extends State<AnalyzerWifiModifier> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 50.h,
        width: 90.w,
        child: Text("Wifi"),
      ),
    );
  }
}
