import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/global/utilities/custom_snackbar.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WifiManager {

  static Future<List<String>> scanForWifi(BuildContext context) async {
    List<String> scannedSSID = [];
    final result =
        await WiFiScan.instance.getScannedResults();
    if (result.hasError) {
      snackBarCreator(context, result.error.toString(), SoulPotTheme.spPaleRed);
    } else {
      final accessPoints = result.value;
      for (var element in accessPoints!) {
        scannedSSID.add(element.ssid);
      }
    }
    return scannedSSID;
  }
}