import 'package:battery_indicator/battery_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/widgets/single/analyzer_details_dialog.dart';

import '../models/Analyzer.dart';
import '../theme.dart';

class CardInfoAnalyzer extends StatefulWidget {
  const CardInfoAnalyzer({Key? key, required this.analyzer}) : super(key: key);

  final Analyzer analyzer;

  @override
  State<CardInfoAnalyzer> createState() => _CardInfoAnalyzerState();
}

class _CardInfoAnalyzerState extends State<CardInfoAnalyzer> {
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.fromLTRB(2.w, 0, 1.w, 2.h),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: Center(
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            widget.analyzer.name,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Greenhouse"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Image.network(
                              widget.analyzer.imageURL!,
                              height: 6.h,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Row(
                      children: [
                        BatteryIndicator(
                          batteryFromPhone: false,
                          batteryLevel: widget.analyzer.battery!,
                          style: BatteryIndicatorStyle.skeumorphism,
                          showPercentNum: true,
                          size: 2.2.w,
                          colorful: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            " Charge batterie : ${widget.analyzer.battery}%",
                            style: TextStyle(fontSize: 12.sp),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.wifi,
                          color: SoulPotTheme.SPGreen,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            " Réseau Wifi : ${widget.analyzer.wifiName!}",
                            style: TextStyle(fontSize: 12.sp),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(right: 1.w),
              child: IconButton(
                icon: Icon(
                  Icons.settings_rounded,
                  color: SoulPotTheme.SPPurple,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AnalyzerDetailsDialog(
                            analyzer: widget.analyzer,
                          )).then((value) => setState(() {}));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
