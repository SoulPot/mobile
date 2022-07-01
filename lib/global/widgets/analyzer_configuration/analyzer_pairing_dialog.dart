import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:soulpot/global/widgets/analyzer_configuration/analyzer_credentials_form.dart';
import 'package:soulpot/global/utilities/bluetooth_manager.dart';
import 'package:soulpot/global/utilities/wifi_manager.dart';
import 'package:soulpot/global/utilities/custom_snackbar.dart';
import 'package:sizer/sizer.dart';

import '../../models/analyzer.dart';
import '../../utilities/theme.dart';


class AnalyzerPairingDialog extends StatefulWidget {
  const AnalyzerPairingDialog({Key? key, required this.analyzer})
      : super(key: key);

  final Analyzer analyzer;

  @override
  State<AnalyzerPairingDialog> createState() => _AnalyzerPairingDialogState();
}

class _AnalyzerPairingDialogState extends State<AnalyzerPairingDialog> {
  //BLE
  BluetoothCharacteristic? wifiCharacteristic;
  BluetoothDevice? espDevice;

  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  bool? deviceFound;

  bool showLoadingBluetooth = true;

  List<String> scannedSSIDs = [];

  @override
  initState() {
    getBluetooth().then((_) => {
          getWifi().then((_) => setState(() {
                scannedSSIDs.removeWhere(
                    (element) => ["", null, false, 0].contains(element));
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 0),
          child: deviceFound != null
              ? AnalyzerCredentialsForm(
                      analyzer: widget.analyzer,
                      scannedSSIDs: scannedSSIDs,
                      wifiCharacteristic: wifiCharacteristic!,
                      espDevice: espDevice!,
                    )
              : Column(
                  children: [
                    Text(
                      'Scan en cours veuillez patienter...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: SoulPotTheme.spBlack,
                          fontSize: 15.sp,
                          fontFamily: 'Greenhouse',
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    LoadingAnimationWidget.discreteCircle(
                        color: SoulPotTheme.spBT, size: 20.w),
                    const Spacer(),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> getBluetooth() async {
    if (widget.analyzer.id == null) {
      espDevice = await BluetoothManager.getFirstAnalyzerDeviceFound();
      wifiCharacteristic =
          await BluetoothManager.getAnalyzerCharacteristic(espDevice);
    } else {
      espDevice = await BluetoothManager.getAnalyzerDeviceByDeviceID(
          analyzerID: widget.analyzer.id!);
      wifiCharacteristic =
          await BluetoothManager.getAnalyzerCharacteristic(espDevice);
    }
    if (wifiCharacteristic == null) {
      cancelBluetoothScan();
      setState(() {
        showLoadingBluetooth = false;
      });
    } else {
      setState(() {
        deviceFound = true;
        showLoadingBluetooth = false;
      });
    }
  }

  void cancelBluetoothScan() {
    snackBarCreator(context, "Analyzer introuvable, êtes vous à portée ?",
        SoulPotTheme.spPaleRed);
    Navigator.of(context).pop();
  }

  Future<void> getWifi() async { List<String> tmpSSIDs = [];
  if (Platform.isAndroid) {
    tmpSSIDs = await WifiManager.scanForWifi(context);
    if (tmpSSIDs.isEmpty) {
      if (!mounted) return;
      snackBarCreator(
          context, "Une erreur est survenue !", SoulPotTheme.spPaleRed);
    }
  }
  setState(() {
    scannedSSIDs = tmpSSIDs.toSet().toList();
  });
  }
}
