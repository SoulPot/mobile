import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:soulpot/global/utilities/bluetooth_manager.dart';
import 'package:soulpot/global/utilities/wifi_manager.dart';
import 'package:soulpot/global/utilities/custom_snackbar.dart';
import 'package:soulpot/global/widgets/dropdown_wifi_picker.dart';
import 'package:sizer/sizer.dart';

import '../../models/analyzer.dart';
import '../../global/utilities/theme.dart';

class AnalyzerPairingDialog extends StatefulWidget {
  const AnalyzerPairingDialog({Key? key, required this.analyzer})
      : super(key: key);

  final Analyzer analyzer;

  @override
  State<AnalyzerPairingDialog> createState() => _AnalyzerPairingDialogState();
}

class _AnalyzerPairingDialogState extends State<AnalyzerPairingDialog> {
  //BLE
  BluetoothDevice? analyzer;
  BluetoothCharacteristic? wifiCharacteristic;
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  bool? deviceFound;
  bool showLoading = true;

  // WIFI
  List<String> wifiCredentials = ["SSID", "PASSWORD"];
  late List<String> ssids;
  late String selectedSSID = "";
  final TextEditingController _wifiPassController = TextEditingController();
  final TextEditingController _ssidController = TextEditingController();

  @override
  initState() {
    getBluetooth().then((_) => {
          getWifi().then((_) => setState(() {
                ssids.removeWhere(
                    (element) => ["", null, false, 0].contains(element));
                if (Platform.isAndroid) {
                  selectedSSID = ssids[0];
                }
              }))
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        height: 33.h,
        width: 90.w,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 0),
              child: deviceFound != null
                  ? Text(
                          "Analyzer trouvé",
                          style: TextStyle(
                              color: SoulPotTheme.spGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              fontFamily: 'Greenhouse'),
                        )
                  : Text(
                      'Scan en cours veuillez patienter...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: SoulPotTheme.spBlack,
                          fontSize: 15.sp,
                          fontFamily: 'Greenhouse',
                          fontWeight: FontWeight.bold),
                    ),
            ),
            const Spacer(),
            showLoading
                ? LoadingAnimationWidget.discreteCircle(
                    color: SoulPotTheme.spBT, size: 20.w)
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        Text(
                          "A quel réseau Wifi souhaitez-vous connecter ${widget.analyzer.name} ?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: SoulPotTheme.spBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                              fontFamily: 'Greenhouse'),
                        ),
                        Platform.isAndroid
                            ? Column(
                                children: [
                                  DropdownWidget(
                                      items: ssids,
                                      itemCallBack: _handleSelectedSSIDChanged,
                                      currentItem: selectedSSID),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    child: SizedBox(
                                      height: 5.h,
                                      width: 80.w,
                                      child: TextField(
                                        onChanged: (_) {
                                          setState(() {});
                                        },
                                        obscureText: true,
                                        controller: _wifiPassController,
                                        decoration: InputDecoration(
                                          hintText: 'Mot de passe',
                                          hintStyle: TextStyle(
                                              fontFamily: "Greenhouse",
                                              fontSize: 11.sp),
                                          border: const OutlineInputBorder(),
                                        ),
                                        style: TextStyle(
                                          color: SoulPotTheme.spBlack,
                                          fontSize: 12.sp,
                                          fontFamily: 'Greenhouse',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.w, vertical: 1.h),
                                    child: SizedBox(
                                      height: 5.h,
                                      width: 80.w,
                                      child: TextField(
                                        onChanged: (_) {
                                          setState(() {});
                                        },
                                        controller: _ssidController,
                                        decoration: const InputDecoration(
                                          labelText: 'SSID',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.w, vertical: 1.h),
                                    child: SizedBox(
                                      height: 5.h,
                                      width: 80.w,
                                      child: TextField(
                                        onChanged: (_) {
                                          setState(() {});
                                        },
                                        obscureText: true,
                                        controller: _wifiPassController,
                                        decoration: const InputDecoration(
                                          labelText: 'Mot de passe',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: showLoading
                  ? SizedBox(
                      height: 0.h,
                      width: 0.w,
                    )
                  : Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            if(analyzer != null) {
                              analyzer!.disconnect();
                            }
                            dispose();
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            primary: SoulPotTheme.spPaleRed,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.h),
                            textStyle: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text(
                            "Annuler",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: SoulPotTheme.spBlack),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: ElevatedButton(
                            onPressed: () async {
                              wifiCredentials[0] = Platform.isAndroid
                                  ? selectedSSID
                                  : _ssidController.text;
                              wifiCredentials[1] = _wifiPassController.text;
                              BluetoothManager.sendData(
                                  context,
                                  analyzer,
                                  wifiCharacteristic,
                                  "${wifiCredentials[0]},${wifiCredentials[1]}");
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              primary: SoulPotTheme.spPaleGreen,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 1.h),
                              textStyle: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Text(
                              "Valider",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: SoulPotTheme.spBlack),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSelectedSSIDChanged(String newValue) {
    setState(() {
      selectedSSID = newValue;
    });
  }

  Future<void> getBluetooth() async {
    if (Platform.isIOS) {
      flutterBlue.scan();
      await flutterBlue.stopScan();
    }
    var results = await flutterBlue.startScan(timeout: const Duration(seconds: 4));
    for (ScanResult r in results) {
      if (r.advertisementData.localName.contains("SOULPOT_ESP32_")) {
        analyzer = r.device;
      }
      r.device.disconnect();
    }
    flutterBlue.stopScan();

    if (analyzer == null) {
      cancelBluetoothScan();
    } else {
      await analyzer!.connect();
      var services = await analyzer!.discoverServices();
      for (BluetoothService s in services) {
        var characteristics = s.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.uuid.toString() == "96c44fd5-c309-4553-a11e-b8457810b94c") {
            wifiCharacteristic = c;
            showLoading = false;
            deviceFound = true;
          } else {
          }
        }
      }
    }
  }

  void cancelBluetoothScan() {
    snackBarCreator(context, "Aucun analyzer trouvé", SoulPotTheme.spPaleRed);
    Navigator.of(context).pop();
  }

  Future<void> getWifi() async {
    List<String> tmpSSIDs = [];
    if (Platform.isAndroid) {
      tmpSSIDs = await WifiManager.scanForWifi(context);
    }
    setState(() {
      ssids = tmpSSIDs.toSet().toList();
    });
  }
}
