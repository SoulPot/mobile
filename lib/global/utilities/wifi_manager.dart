import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:wifi_scan/wifi_scan.dart';

class WifiManager {

  static Future<List<String>> scanForWifi(BuildContext context) async {
    List<String> scannedSSID = [];
    await WiFiScan.instance.startScan(askPermissions: true);
    final result = await WiFiScan.instance.getScannedResults(askPermissions: true);
    if (result.hasError) {
      return [];
    } else {
      final accessPoints = result.value;
      for (var element in accessPoints!) {
        scannedSSID.add(element.ssid);
      }
    }
    return scannedSSID;
  }
}