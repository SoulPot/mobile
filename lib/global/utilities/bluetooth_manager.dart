import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'custom_snackbar.dart';
import 'theme.dart';

class BluetoothManager {
  static FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  static Future<BluetoothDevice?> scanForAnalyzer() async {
    BluetoothDevice? analyzer;
    var results = await flutterBlue.startScan(timeout: const Duration(seconds: 4));
      for (ScanResult r in results) {
        if (r.advertisementData.localName.contains("SOULPOT_ESP32_")) {
          analyzer = r.device;
        }
      }
    return analyzer;
  }

  static Future<BluetoothCharacteristic?> scanForAnalyzerCharacteristic(
      BluetoothDevice? analyzer, String characteristicToFindUUID) async {
    BluetoothCharacteristic? analyzerCharacteristic;
    await analyzer!.connect();

    List<BluetoothService>? services = await analyzer.discoverServices();
    if (services.isEmpty) {
      return null;
    }
    for (var service in services) {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic char in characteristics) {
        if (char.uuid.toString() == characteristicToFindUUID) {
          analyzerCharacteristic = char;
        }
      }
    }
    return analyzerCharacteristic;
  }

  static Future<void> sendData(BuildContext context, BluetoothDevice? analyzer,
      BluetoothCharacteristic? analyzerCharacteristic, String data) async {
    try {
      await analyzerCharacteristic?.write(utf8.encode(data));
    } catch (error) {
      snackBarCreator(
          context, "Error while sending data : $error", SoulPotTheme.spPaleRed);
    }
  }
}
