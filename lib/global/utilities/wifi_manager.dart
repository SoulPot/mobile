import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/global/utilities/custom_snackbar.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WifiManager {

  static Future<List<String>> scanForWifi(BuildContext context) async {
    List<String> _scannedSSID = [];
    final result =
        await WiFiScan.instance.getScannedResults();
    if (result.hasError) {
      snackBarCreator(context, result.error.toString(), SoulPotTheme.SPPaleRed);
    } else {
      final accessPoints = result.value;
      accessPoints!.forEach((element) {
        _scannedSSID.add(element.ssid);
      });
    }
    return _scannedSSID;
  }
}