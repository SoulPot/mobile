import 'dart:convert';
import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:soulpot/global/utilities/config.dart';

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
      if (r.advertisementData.localName.contains(espDeviceName)) {
        await r.device.disconnect();
        await r.device.connect();
        List<BluetoothService> analyzerServices =
            await r.device.discoverServices();
        for (BluetoothService s in analyzerServices) {
          var characteristics = s.characteristics;
          for (BluetoothCharacteristic c in characteristics) {
            if (c.uuid.toString() == espAnalyzerCharacteristic) {
              await c.read().then((value) async {
                if (value.first == 1) {
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
        await r.device.connect();
        List<BluetoothService> analyzerServices =
            await r.device.discoverServices();
        for (BluetoothService s in analyzerServices) {
          var characteristics = s.characteristics;
          for (BluetoothCharacteristic c in characteristics) {
            if (c.uuid.toString() == espAnalyzerCharacteristic) {
              analyzerDevice = r.device;
            }
          }
        }
      }
      await r.device.disconnect();
    }
    return analyzerDevice;
  }

  static Future<BluetoothCharacteristic?> getAnalyzerCharacteristic(
      BluetoothDevice? analyzerDevice) async {
    BluetoothCharacteristic? characteristic;

    if (analyzerDevice == null) {
      return null;
    }
    await analyzerDevice.connect();
    List<BluetoothService> analyzerServices =
        await analyzerDevice.discoverServices();
    for (BluetoothService s in analyzerServices) {
      var characteristics = s.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        if(c.uuid.toString() == espAnalyzerCharacteristic) {
          characteristic = c;
        }
      }
    }
    return characteristic;
  }

  static Future<int> readCharacteristic(
      BluetoothCharacteristic characteristic, BluetoothDevice device) async {
    var data = await characteristic.read();
    return data[0];
  }

  static Future<bool> writeBLE(
      {required String payload,
        required BluetoothCharacteristic characteristic,
        required BluetoothDevice device}) async {
    try {
      Platform.isAndroid
          ? await characteristic.write(utf8.encode(payload),
          withoutResponse: false)
          : await characteristic.write(utf8.encode(payload),
          withoutResponse: true);
    } catch (error) {
      return false;
    }
    return true;
  }

}
