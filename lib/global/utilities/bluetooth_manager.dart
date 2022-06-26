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

  static Future<BluetoothCharacteristic?> getAnalyzerCharacteristic({required bool isSetup, Analyzer? analyzer}) async {
    BluetoothDevice? analyzer;

    if (Platform.isIOS) {
      flutterBlue.scan();
      await flutterBlue.stopScan();
    }
    var results =
        await flutterBlue.startScan(timeout: const Duration(seconds: 4));
    for (ScanResult r in results) {
      if (r.advertisementData.localName.contains(isSetup ? ESP_DEVICE_NAME : analyzer!.id.toString())) {
        analyzer = r.device;
      }
      r.device.disconnect();
    }
    flutterBlue.stopScan();

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

  static Future<int> sendCredentials({required String credentials, required bool isSetup, BluetoothCharacteristic? characteristic, Analyzer? analyzer}) async {
    characteristic ??= await BluetoothManager.getAnalyzerCharacteristic(isSetup: isSetup, analyzer: analyzer);
    await writeData(characteristic, credentials);
    print("Sent credentials: $credentials");
    await Future.delayed(const Duration(seconds: 1));
    int tempResult = await readCharacteristic(characteristic);
    print("readed");
    print("tempResult: $tempResult");
    return await readCharacteristic(characteristic);
  }

  static Future<int> readCharacteristic(BluetoothCharacteristic? characteristic) async {
    if (characteristic == null) {
      return -1;
    }
    var data = await characteristic.read();
    return data[0];
  }

  static Future<bool> writeData(
      BluetoothCharacteristic? analyzerCharacteristic, String data) async {
    try {
      await analyzerCharacteristic?.write(utf8.encode(data));
      return true;
    } catch (error) {
      return false;
    }
  }
}
