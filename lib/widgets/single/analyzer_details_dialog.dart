import 'dart:io';

import 'package:battery_indicator/battery_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:soulpot/utilities/bluetooth_manager.dart';
import 'package:soulpot/utilities/wifi_manager.dart';
import 'package:soulpot/widgets/single/dropdown_wifi_picker.dart';
import 'package:sizer/sizer.dart';

import '../../models/Analyzer.dart';
import '../../theme.dart';

class AnalyzerDetailsDialog extends StatefulWidget {
  const AnalyzerDetailsDialog({Key? key, required Analyzer analyzer})
      : analyzer = analyzer,
        super(key: key);

  final Analyzer analyzer;

  @override
  State<AnalyzerDetailsDialog> createState() => _AnalyzerDetailsDialogState();
}

class _AnalyzerDetailsDialogState extends State<AnalyzerDetailsDialog> {
  initState() {}

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 50.h,
        width: 90.w,
        child: Padding(
          padding: EdgeInsets.all(1.h),
          child: Column(
            children: [
              Text(
                widget.analyzer.name,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Greenhouse",
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: BatteryIndicator(
                      batteryFromPhone: false,
                      batteryLevel: widget.analyzer.battery!,
                      style: BatteryIndicatorStyle.skeumorphism,
                      showPercentNum: true,
                      size: 2.2.w,
                      colorful: true,
                    ),
                  ),
                  Text("Charge de la batterie : ${widget.analyzer.battery}%"),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
