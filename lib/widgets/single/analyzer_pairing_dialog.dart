import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:soulpot/utilities/bluetooth_manager.dart';
import 'package:soulpot/utilities/wifi_manager.dart';
import 'package:soulpot/widgets/single/dropdown_wifi_picker.dart';

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
  bool showLoading = true; //TODO: true if bluetooth enabled

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
                selectedSSID = ssids[0];
                print("$analyzer $wifiCharacteristic");
              }))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width / 1.1,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: deviceFound
                  ? Text(
                      "Analyzer trouvé : ${analyzer!.name}",
                      style: TextStyle(
                          color: SoulPotTheme.SPGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Greenhouse'),
                    )
                  : Text(
                      'Scan en cours veuillez patienter...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: SoulPotTheme.SPBlack,
                          fontSize: 20,
                          fontFamily: 'Greenhouse',
                          fontWeight: FontWeight.bold),
                    ),
            ),
            Spacer(),
            showLoading
                ? LoadingAnimationWidget.discreteCircle(
                    color: SoulPotTheme.SPBT,
                    size: MediaQuery.of(context).size.width / 5)
                : Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        Text(
                          "A quel réseau Wifi souhaitez-vous connecter ${widget.analyzer.name} ?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: SoulPotTheme.SPBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Greenhouse'),
                        ),
                        Platform.isAndroid
                            ? ssids.isEmpty
                                ? LoadingAnimationWidget.stretchedDots(
                                    color: SoulPotTheme.SPPalePurple,
                                    size: MediaQuery.of(context).size.width / 7)
                                : Column(
                                    children: [
                                      DropdownWidget(
                                          items: ssids,
                                          itemCallBack:
                                              _handleSelectedSSIDChanged,
                                          currentItem: selectedSSID),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, top: 10),
                                        child: TextField(
                                          controller: _wifiPassController,
                                          decoration: InputDecoration(
                                            labelText: 'Mot de passe',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                            : Column(
                                children: [
                                  TextField(
                                    controller: _ssidController,
                                    decoration: InputDecoration(
                                      labelText: 'SSID',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  TextField(
                                    controller: _wifiPassController,
                                    decoration: InputDecoration(
                                      labelText: 'Mot de passe',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  (selectedSSID != "" && _wifiPassController.text != "")
                      ? Spacer()
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  (selectedSSID != "" && _wifiPassController.text != "")
                      ? ElevatedButton(
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
                                horizontal: 15, vertical: 10),
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
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
        .then((value) => {wifiCharacteristic = value, showLoading = false});
    return; //TODO: uncomment if bluetooth is enabled
  }

  Future<void> getWifi() async {
    List<String> tmpSSIDs = [];
    if (Platform.isAndroid) {
      tmpSSIDs = await WifiManager.scanForWifi(context);
    } else if (Platform.isIOS) {
      tmpSSIDs[0] = (await WifiManager.getConnectedWifi(context))!;
    }
    setState(() {
      ssids = tmpSSIDs.toSet().toList();
    });
  }
}
