import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:soulpot/utilities/bluetooth_manager.dart';
import 'package:soulpot/utilities/wifi_manager.dart';
import 'package:soulpot/widgets/single/dropdown_wifi_picker.dart';
import 'package:sizer/sizer.dart';

import '../../models/Analyzer.dart';
import '../../theme.dart';

class AnalyzerPairingDialog extends StatefulWidget {
  const AnalyzerPairingDialog({Key? key, required Analyzer analyzer})
      : analyzer = analyzer,
        super(key: key);

  final Analyzer analyzer;

  @override
  State<AnalyzerPairingDialog> createState() => _AnalyzerPairingDialogState();
}

class _AnalyzerPairingDialogState extends State<AnalyzerPairingDialog> {
  //BLE
  BluetoothDevice? analyzer;
  BluetoothCharacteristic? wifiCharacteristic;
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  bool deviceFound = false;
  bool showLoading = true;

  // WIFI
  List<String> wifiCredentials = ["SSID", "PASSWORD"];
  late List<String> ssids;
  late String selectedSSID = "";
  TextEditingController _wifiPassController = TextEditingController();
  TextEditingController _ssidController = TextEditingController();

  initState() {
    super.initState();
    getBluetooth().then((_) => {
          getWifi().then((_) => setState(() {
                ssids.removeWhere(
                    (element) => ["", null, false, 0].contains(element));
                if (Platform.isAndroid) {
                  selectedSSID = ssids[0];
                }
              }))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 33.h,
        width: 90.w,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 0),
              child: deviceFound
                  ? Text(
                      "Analyzer trouvé",
                      style: TextStyle(
                          color: SoulPotTheme.SPGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          fontFamily: 'Greenhouse'),
                    )
                  : Text(
                      'Scan en cours veuillez patienter...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: SoulPotTheme.SPBlack,
                          fontSize: 15.sp,
                          fontFamily: 'Greenhouse',
                          fontWeight: FontWeight.bold),
                    ),
            ),
            Spacer(),
            showLoading
                ? LoadingAnimationWidget.discreteCircle(
                    color: SoulPotTheme.SPBT, size: 20.w)
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        Text(
                          "A quel réseau Wifi souhaitez-vous connecter ${widget.analyzer.name} ?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: SoulPotTheme.SPBlack,
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
                                    child: TextField(
                                      onChanged: (_) {
                                        setState(() {});
                                      },
                                      controller: _wifiPassController,
                                      decoration: InputDecoration(
                                        hintText: 'Mot de passe',
                                        hintStyle: TextStyle(
                                            fontFamily: "Greenhouse",
                                            fontSize: 11.sp),
                                        border: OutlineInputBorder(),
                                      ),
                                      style: TextStyle(
                                        color: SoulPotTheme.SPBlack,
                                        fontSize: 12.sp,
                                        fontFamily: 'Greenhouse',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                                    child: TextField(
                                      controller: _ssidController,
                                      decoration: InputDecoration(
                                        labelText: 'SSID',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                                    child: TextField(
                                      controller: _wifiPassController,
                                      decoration: InputDecoration(
                                        labelText: 'Mot de passe',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      this.dispose();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Annuler",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: SoulPotTheme.SPBlack),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      primary: SoulPotTheme.SPPaleRed,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  (selectedSSID != "" && _wifiPassController.text != "")
                      ? Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: ElevatedButton(
                            onPressed: () async {
                              wifiCredentials[0] = Platform.isAndroid
                                  ? selectedSSID
                                  : _ssidController.text;
                              wifiCredentials[1] = _wifiPassController.text;
                              print(
                                  "Analyzer => $analyzer \n characteristic => $wifiCharacteristic \n credentials => ${wifiCredentials[0]},${wifiCredentials[1]}");
                              BluetoothManager.sendData(
                                  context,
                                  analyzer,
                                  wifiCharacteristic,
                                  "${wifiCredentials[0]},${wifiCredentials[1]}");
                            },
                            child: Text(
                              "Valider",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: SoulPotTheme.SPBlack),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              primary: SoulPotTheme.SPPaleGreen,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 1.h),
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  Spacer(),
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
    await BluetoothManager.scanForAnalyzer("SOULPOT_ESP32_").then(
      (value) => analyzer = value,
    );
    await BluetoothManager.scanForAnalyzerCharacteristic(
            analyzer, "96c44fd5-c309-4553-a11e-b8457810b94c")
        .then((value) => {
              wifiCharacteristic = value,
              showLoading = false,
              deviceFound = true,
            });
    return;
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
