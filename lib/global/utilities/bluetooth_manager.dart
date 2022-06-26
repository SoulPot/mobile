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
      print("SUPPOSED $ESP_DEVICE_NAME => FOUND ${r.advertisementData.localName} => REAL NAME ${r.device.name}");
      if (r.advertisementData.localName.contains(ESP_DEVICE_NAME)) {
        await r.device.connect();
        List<BluetoothService> analyzerServices =
        await r.device.discoverServices();
        for (BluetoothService s in analyzerServices) {
          var characteristics = s.characteristics;
          for (BluetoothCharacteristic c in characteristics) {
            if (c.uuid.toString() == ESP_ANALYZER_CHARACTERISTIC) {
              await c.read().then((value) {
                if (value.first == 1) {
                  analyzerDevice = r.device;
                }
              });
            }
          }
        }
      }
      r.device.disconnect();
    }
    return analyzerDevice;
  }

  static Future<BluetoothDevice?> getAnalyzerDeviceByDeviceID({required String analyzerID}) async {

    BluetoothDevice? analyzerDevice;

    if (Platform.isIOS) {
      flutterBlue.scan();
      await flutterBlue.stopScan();
    }

    var results =
    await flutterBlue.startScan(timeout: const Duration(seconds: 4));
    for (ScanResult r in results) {
      print("SUPPOSED $analyzerID => FOUND ${r.advertisementData.localName} => REAL NAME ${r.device.name}");
      if (r.advertisementData.localName == analyzerID) {
        await r.device.connect();
        List<BluetoothService> analyzerServices =
        await r.device.discoverServices();
        for (BluetoothService s in analyzerServices) {
          var characteristics = s.characteristics;
          for (BluetoothCharacteristic c in characteristics) {
            if (c.uuid.toString() == ESP_ANALYZER_CHARACTERISTIC) {
              analyzerDevice = r.device;
            }
          }
        }
      }
      r.device.disconnect();
    }
    return analyzerDevice;
  }


  static Future<BluetoothCharacteristic?> getAnalyzerCharacteristic(BluetoothDevice? analyzerDevice) async {
    BluetoothCharacteristic? characteristic;

    if(analyzerDevice == null) {
      return null;
    }
    await analyzerDevice.connect();
    List<BluetoothService> analyzerServices =
    await analyzerDevice.discoverServices();
    for (BluetoothService s in analyzerServices) {
      var characteristics = s.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        characteristic = c;
        }
      }
    return characteristic;
  }

  static Future<bool> sendCredentials(
      {required String credentials,
      required BluetoothCharacteristic characteristic, required BluetoothDevice device}) async {
    try {
      print("BEFORE WRITE IN FUNCTION");
      await characteristic.write(utf8.encode(credentials),
          withoutResponse: true);
      print("AFTER WRITE IN FUNCTION");
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<int> readCharacteristic(BluetoothCharacteristic characteristic) async {
    var data = await characteristic.read();
    return data[0];
  }
}
