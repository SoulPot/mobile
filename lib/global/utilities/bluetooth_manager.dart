import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'custom_snackbar.dart';
import 'theme.dart';

class BluetoothManager {
  static FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  static Future<BluetoothDevice?> scanForAnalyzer() async {
    BluetoothDevice? analyzer;
    var results =
        await flutterBlue.startScan(timeout: const Duration(seconds: 4));
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
  static Future<void> writeToCharacteristic(
      BluetoothCharacteristic? characteristic, String data) async {
    if (characteristic == null) {
      return;
    }
    await characteristic.write(const Utf8Encoder().convert(data),
        withoutResponse: true);
  }

  static Future<bool> sendCredentials(String credentials) async {
    BluetoothCharacteristic? characteristic = await scanForAnalyzerCharacteristic(
        await scanForAnalyzer(), "SOULPOT_ESP32_Credentials");
    if (characteristic == null) {
      return false;
    }
    if(await sendData(characteristic, credentials)) {
      return true;
    }
    return false;
  }

  static Future<int> readAnalyzerCharacteristic(
      BluetoothCharacteristic? analyzerCharacteristic) async {
    var data = await analyzerCharacteristic!.read();
    return data[0];
  }

  static Future<bool> sendData(BluetoothCharacteristic? analyzerCharacteristic, String data) async {
    try {
      await analyzerCharacteristic?.write(utf8.encode(data));
      return true;
    } catch (error) {
      return false;
    }
  }
}
