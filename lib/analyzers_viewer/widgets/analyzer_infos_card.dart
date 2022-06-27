import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/analyzers_viewer/widgets/analyzer_details_dialog.dart';

import '../../models/analyzer.dart';
import '../../global/utilities/theme.dart';

class CardInfoAnalyzer extends StatefulWidget {
  const CardInfoAnalyzer({Key? key, required this.analyzer}) : super(key: key);

  final Analyzer analyzer;

  @override
  State<CardInfoAnalyzer> createState() => _CardInfoAnalyzerState();
}

class _CardInfoAnalyzerState extends State<CardInfoAnalyzer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Center(
              child: Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Text(
                      widget.analyzer.name,
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Greenhouse"),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(2.w, 0, 1.w, 2.h),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, top: 1.h),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: SoulPotTheme.spBlack,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                " Identifiant : ${widget.analyzer.id!}",
                                style: TextStyle(fontSize: 12.sp),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, top: 1.h),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.wifi,
                              color: SoulPotTheme.spGreen,
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
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: IconButton(
                    icon: Icon(
                      Icons.settings_rounded,
                      size: 7.w,
                      color: SoulPotTheme.spPurple,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AnalyzerDetailsDialog(
                                analyzer: widget.analyzer,
                              ));
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
