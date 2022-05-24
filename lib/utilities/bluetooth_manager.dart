import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:soulpot/models/Analyzer.dart';

import '../widgets/single/custom_snackbar.dart';
import '../../theme.dart';

class BluetoothManager {
  static FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  static Future<BluetoothDevice?> scanForAnalyzer(String analyzerName) async {
    BluetoothDevice? analyzerDevice;
    var results = await flutterBlue.startScan(timeout: const Duration(seconds: 3));
    for (ScanResult result in results) {
      if (result.device.name.contains(analyzerName)) {
        analyzerDevice = result.device;
        break;
      }
    }
    return analyzerDevice;
  }

  static Future<BluetoothCharacteristic?> scanForAnalyzerCharacteristic(
      BluetoothDevice? analyzer, String characteristicToFindUUID) async {
    BluetoothCharacteristic? analyzerCharacteristic;
    print("DEBUT SCAN");
    await analyzer?.connect();
    List<BluetoothService>? services = await analyzer?.discoverServices();
    services?.forEach((service) {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic char in characteristics) {
        if (char.uuid.toString() == characteristicToFindUUID) {
          print("Characteristic found: ${char.uuid.toString()}");
          analyzerCharacteristic = char;
        }
      }
    });
    return analyzerCharacteristic;
  }

  static Future<void> sendData(BuildContext context, BluetoothDevice? analyzer,
      BluetoothCharacteristic? analyzerCharacteristic, String data) async {
    try {
      print("before write");
      await analyzerCharacteristic?.write(utf8.encode(data));
      print("after write");
    } catch (error) {
      snackBarCreator(
          context, "Error while sending data : $error", SoulPotTheme.SPPaleRed);
    }
  }
}
