import 'dart:io';

import 'package:flutter/material.dart';
import 'package:soulpot/global/widgets/analyzer_configuration/analyzer_rename_dialog.dart';
import 'package:soulpot/global/utilities/firebase_management/firestore.dart';
import 'package:soulpot/global/utilities/wifi_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../global/models/analyzer.dart';
import '../../../global/utilities/theme.dart';
import '../../../global/widgets/analyzer_configuration/analyzer_pairing_dialog.dart';
import 'delete_analyzer_dialog.dart';


class AnalyzerDetailsDialog extends StatefulWidget {
  const AnalyzerDetailsDialog({Key? key, required this.analyzer})
      : super(key: key);

  final Analyzer analyzer;

  @override
  State<AnalyzerDetailsDialog> createState() => _AnalyzerDetailsDialogState();
}

class _AnalyzerDetailsDialogState extends State<AnalyzerDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: 40.h,
        width: 90.w,
        child: Padding(
          padding: EdgeInsets.all(1.h),
          child: Column(
            children: [
              Text(
                widget.analyzer.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Greenhouse",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) =>
                          RenameDialog(analyzer: widget.analyzer),
                    ).then((_) async {
                      await FirestoreManager.updateAnalyzerName(widget.analyzer.id!, widget.analyzer.name);
                      setState(() {});

                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    primary: SoulPotTheme.spGreen,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  ),
                  child: Text(
                    "Renommer",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontFamily: "Greenhouse",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: const Icon(
                        Icons.smart_toy,
                        color: SoulPotTheme.spGreen,
                      ),
                    ),
                    Text(
                      "ID de l'analyzer : ${widget.analyzer.id}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Greenhouse",
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: const Icon(
                          Icons.wifi,
                          color: SoulPotTheme.spGreen,
                        ),
                      ),
                      Text(
                        "Réseau wifi : ${widget.analyzer.wifiName}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Greenhouse",
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) =>
                              AnalyzerPairingDialog(analyzer: widget.analyzer,),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: SoulPotTheme.spPurple,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.h),
                      ),
                      child: Text(
                        "Changer le réseau wifi",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontFamily: "Greenhouse",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) =>
                                DeleteAnalyzerDialog(analyzer: widget.analyzer))
                        .then((value) async {
                      if (value) {
                        await FirestoreManager.deletedAnalyzer(
                            widget.analyzer.id!);
                        if (!mounted) return;
                        Navigator.pop(context);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    primary: SoulPotTheme.spRed,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  ),
                  child: Text(
                    "Supprimer ${widget.analyzer.name}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontFamily: "Greenhouse",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>> getWifi() async {
    List<String> tmpSSIDs = [""];
    if (Platform.isAndroid) {
      tmpSSIDs = await WifiManager.scanForWifi(context);
    }
    return tmpSSIDs;
  }
}
