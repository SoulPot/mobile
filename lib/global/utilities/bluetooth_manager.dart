import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:soulpot/global/utilities/config.dart';
import 'package:soulpot/models/analyzer.dart';
import 'custom_snackbar.dart';
import 'theme.dart';

class BluetoothManager {

  static FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  static Future<BluetoothDevice?> getAnalyzerDevice({String? analyzerID}) async {
    BluetoothDevice? analyzer;
    String deviceNameToFind = analyzerID ?? ESP_DEVICE_NAME;
    print("Searching for $deviceNameToFind");
    if (Platform.isIOS) {
      flutterBlue.scan();
      await flutterBlue.stopScan();
    }
    var results =
    await flutterBlue.startScan(timeout: const Duration(seconds: 4));
    for (ScanResult r in results) {
      print("SUPPOSED ${deviceNameToFind}, FOUND ${r.advertisementData.localName.toString()}");
      if (r.advertisementData.localName.contains(deviceNameToFind)) {
        analyzer = r.device;
      }
      r.device.disconnect();
    }
    flutterBlue.stopScan();
    return analyzer;
  }

  static Future<BluetoothCharacteristic?> getAnalyzerCharacteristic(BluetoothDevice? analyzer) async {
    if (analyzer == null) {
      return null;
    } else {
      await analyzer.connect();
      var services = await analyzer.discoverServices();
      for (BluetoothService s in services) {
        var characteristics = s.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.uuid.toString() == ESP_ANALYZER_CHARACTERISTIC) {
            return c;
          }
        }
      }
    }
    return null;
  }

  static Future<bool> sendCredentials({required String credentials, required BluetoothCharacteristic? characteristic}) async {
    try {
      await characteristic?.write(utf8.encode(credentials), withoutResponse: true);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<int> readCharacteristic(BluetoothCharacteristic? characteristic) async {
    if (characteristic == null) {
      return -1;
    }
    var data = await characteristic.read();
    return data[0];
  }
}
