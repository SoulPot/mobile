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

  static Future<BluetoothDevice?> getFirstAnalyzerDeviceFound() async {
    BluetoothDevice? analyzerDevice;

    if (Platform.isIOS) {
      flutterBlue.scan();
      await flutterBlue.stopScan();
    }

    var results =
        await flutterBlue.startScan(timeout: const Duration(seconds: 4));
    for (ScanResult r in results) {
      if (analyzerDevice != null) break;
      if (r.advertisementData.localName.contains(ESP_DEVICE_NAME)) {
        await r.device.connect();
        print(
            "SUPPOSED $ESP_DEVICE_NAME => FOUND ${r.advertisementData.localName} => REAL NAME ${r.device.name}");
        List<BluetoothService> analyzerServices =
            await r.device.discoverServices();
        for (BluetoothService s in analyzerServices) {
          var characteristics = s.characteristics;
          for (BluetoothCharacteristic c in characteristics) {
            if (c.uuid.toString() == ESP_ANALYZER_CHARACTERISTIC) {
              await c.read().then((value) async {
                if (value.first == 1) {
                  print("FOUND CHARACTERISTIC");
                  analyzerDevice = r.device;
                }
              });
            }
          }
        }
      }
      await r.device.disconnect();
    }
    return analyzerDevice;
  }

  static Future<BluetoothDevice?> getAnalyzerDeviceByDeviceID(
      {required String analyzerID}) async {
    BluetoothDevice? analyzerDevice;

    if (Platform.isIOS) {
      flutterBlue.scan();
    }

    var results =
        await flutterBlue.startScan(timeout: const Duration(seconds: 4));
    for (ScanResult r in results) {
      if (analyzerDevice != null) break;
      if (r.advertisementData.localName == analyzerID) {
        print(
            "SUPPOSED $analyzerID => FOUND ${r.advertisementData.localName} => REAL NAME ${r.device.name}");
        await r.device.connect();
        List<BluetoothService> analyzerServices =
            await r.device.discoverServices();
        for (BluetoothService s in analyzerServices) {
          var characteristics = s.characteristics;
          for (BluetoothCharacteristic c in characteristics) {
            if (c.uuid.toString() == ESP_ANALYZER_CHARACTERISTIC) {
              print("FOUND CHARACTERISTIC");
              analyzerDevice = r.device;
            }
          }
        }
      }
      await r.device.disconnect();
    }
    print("END OF DEVICE SCAN");
    return analyzerDevice;
  }

  static Future<BluetoothCharacteristic?> getAnalyzerCharacteristic(
      BluetoothDevice? analyzerDevice) async {
    BluetoothCharacteristic? characteristic;

    if (analyzerDevice == null) {
      return null;
    }
    print("[SCAN CHARACTERISTIC] BEFORE CONNECT");
    await analyzerDevice.connect();
    print("[SCAN CHARACTERISTIC] BEFORE DISCOVER SERVICE");
    List<BluetoothService> analyzerServices =
        await analyzerDevice.discoverServices();
    print("[SCAN CHARACTERISTIC] BEFORE FOR CHARACTERISTICS");
    for (BluetoothService s in analyzerServices) {
      var characteristics = s.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        characteristic = c;
      }
    }
    print("END OF CHARACTERISTIC SCAN");
    return characteristic;
  }

  static Future<bool> sendCredentials(
      {required String credentials,
      required BluetoothCharacteristic characteristic,
      required BluetoothDevice device}) async {
    print("BEFORE WRITE IN FUNCTION");
    try {
      await characteristic.write(utf8.encode(credentials), withoutResponse: false);
    } catch (error) {
      print(error);
    }
    print("AFTER WRITE IN FUNCTION");
    return true;
  }

  static Future<int> readCharacteristic(
      BluetoothCharacteristic characteristic, BluetoothDevice device) async {
    print("BEFORE READ IN FUNCTION");
    var data = await characteristic.read();
    print("AFTER READ IN FUNCTION");
    return data[0];
  }
}
