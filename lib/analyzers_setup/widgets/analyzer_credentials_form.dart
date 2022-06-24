import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/models/analyzer.dart';

import '../../global/utilities/bluetooth_manager.dart';
import '../../global/utilities/theme.dart';
import '../../global/widgets/dropdown_wifi_picker.dart';

class AnalyzerCredentialsForm extends StatefulWidget {
  const AnalyzerCredentialsForm(
      {required this.analyzer,
      Key? key,
      required this.scannedSSIDs,
      required this.wifiCharacteristic})
      : super(key: key);

  final Analyzer analyzer;
  final List<String> scannedSSIDs;
  final BluetoothCharacteristic wifiCharacteristic;

  @override
  State<AnalyzerCredentialsForm> createState() =>
      _AnalyzerCredentialsFormState();
}

class _AnalyzerCredentialsFormState extends State<AnalyzerCredentialsForm> {
  int? espState;
  late BluetoothDevice espDevice;

  List<String> wifiCredentials = ["SSID", "PASSWORD"];
  late String selectedSSID;
  final TextEditingController _wifiPassController = TextEditingController();
  final TextEditingController _ssidController = TextEditingController();

  bool showLoadingWifi = false;
  bool showErrorWifi = false;

  @override
  void initState() {
    espDevice = BluetoothDevice.fromId(widget.wifiCharacteristic.deviceId.id);
    selectedSSID = Platform.isAndroid ? widget.scannedSSIDs.first : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            showErrorWifi
                ? SizedBox(
                    width: 0.w,
                    height: 0.h,
                  )
                : showLoadingWifi
                    ? SizedBox(
                        width: 0.w,
                        height: 0.h,
                      )
                    : Text(
                        "Analyzer trouvé",
                        style: TextStyle(
                            color: SoulPotTheme.spGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            fontFamily: 'Greenhouse'),
                      ),
            showLoadingWifi
                ? Column(
                    children: [
                      Text(
                        "Connexion de l'ESP au réseau ${wifiCredentials[0]} en cours...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: SoulPotTheme.spBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp,
                            fontFamily: 'Greenhouse'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: LoadingAnimationWidget.discreteCircle(
                          color: SoulPotTheme.spGreen,
                          size: 20.w,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      showErrorWifi
                          ? Text(
                              "Connexion échouée, veuillez resaisir les informations nécessaires !",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: SoulPotTheme.spRed,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                  fontFamily: 'Greenhouse'),
                            )
                          : Text(
                              "A quel réseau Wifi souhaitez-vous connecter ${widget.analyzer.name} ?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: SoulPotTheme.spBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp,
                                  fontFamily: 'Greenhouse'),
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Platform.isAndroid
                            ? DropdownWidget(
                                items: widget.scannedSSIDs,
                                itemCallBack: _handleSelectedSSIDChanged,
                                currentItem: selectedSSID)
                            : Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: SizedBox(
                                  height: 5.h,
                                  width: 80.w,
                                  child: TextField(
                                    onChanged: (_) {
                                      setState(() {});
                                    },
                                    controller: _ssidController,
                                    decoration: InputDecoration(
                                      hintText: 'SSID',
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
                      ),
                      SizedBox(
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
                                fontFamily: "Greenhouse", fontSize: 11.sp),
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Row(
                          children: [
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () async {
                                espDevice.disconnect();
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
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  showLoadingWifi = true;
                                });

                                wifiCredentials[0] = Platform.isAndroid
                                    ? selectedSSID
                                    : _ssidController.text;

                                wifiCredentials[1] = _wifiPassController.text;

                                espState = await BluetoothManager.sendCredentials(
                                    credentials:
                                        "${wifiCredentials[0]},${wifiCredentials[1]}",
                                    isSetup: true,
                                    characteristic: widget.wifiCharacteristic);

                                if (espState == 2) {
                                  // CASE ERROR WIFI CONNECTION
                                  _ssidController.text = "";
                                  _wifiPassController.text = "";
                                  setState(() {
                                    showLoadingWifi = false;
                                    showErrorWifi = true;
                                  });
                                } else if (espState == 1) {
                                  widget.analyzer.id = espDevice.id.id;
                                  await FirebaseMessaging.instance
                                      .subscribeToTopic(widget.analyzer.id!);
                                  var prefs =
                                      await SharedPreferences.getInstance();

                                  //prefs.setBool("first_launch", false);
                                }
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
                            const Spacer(),
                          ],
                        ),
                      )
                    ],
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
}
