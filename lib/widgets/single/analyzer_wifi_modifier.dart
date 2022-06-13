import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme.dart';
import 'dropdown_wifi_picker.dart';

class AnalyzerWifiModifier extends StatefulWidget {
  const AnalyzerWifiModifier({Key? key, required List<String> pSsids})
      : ssids = pSsids,
        super(key: key);

  final List<String> ssids;

  @override
  State<AnalyzerWifiModifier> createState() => _AnalyzerWifiModifierState();
}

class _AnalyzerWifiModifierState extends State<AnalyzerWifiModifier> {
  List<String> wifiCredentials = ["SSID", "PASSWORD"];
  List<String> ssids = [];
  late String selectedSSID = "";
  bool errorVisible = false;
  TextEditingController _wifiPassController = TextEditingController();
  TextEditingController _ssidController = TextEditingController();

  initState() {
    super.initState();
    ssids = widget.ssids.toSet().toList();
    ssids.removeWhere((element) => element == "");
    selectedSSID = ssids[0];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 50.h,
        width: 90.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
          child: Column(
            children: [
              Text(
                "Veuillez entrer le réseau wifi auquel vous souhaiter connecter votre analyzer : ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Greenhouse",
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 3.h),
                child: Column(
                  children: [
                    Platform.isAndroid
                        ? Column(
                            children: [
                              DropdownWidget(
                                  items: ssids,
                                  itemCallBack: _handleSelectedSSIDChanged,
                                  currentItem: selectedSSID),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 3.h),
                                child: Container(
                                  height: 5.h,
                                  width: 80.w,
                                  child: TextField(
                                    onChanged: (_) {
                                      setState(() {
                                        errorVisible = false;
                                      });
                                    },
                                    obscureText: true,
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
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1.w, vertical: 1.h),
                                child: Container(
                                  height: 5.h,
                                  width: 80.w,
                                  child: TextField(
                                    onChanged: (_) {
                                      setState(() {
                                        errorVisible = false;
                                      });
                                    },
                                    controller: _ssidController,
                                    decoration: InputDecoration(
                                      labelText: 'SSID',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1.w, vertical: 1.h),
                                child: Container(
                                  height: 5.h,
                                  width: 80.w,
                                  child: TextField(
                                    onChanged: (_) {
                                      setState(() {
                                        errorVisible = false;
                                      });
                                    },
                                    obscureText: true,
                                    controller: _wifiPassController,
                                    decoration: InputDecoration(
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
              Spacer(),
              Column(
                children: [
                  errorVisible
                      ? Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: Text(
                            "Veuillez remplir tous les champs",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                              fontFamily: "Greenhouse",
                              color: Colors.red,
                            ),
                          ),
                      )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  Row(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.w, vertical: 2.h),
                          textStyle: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: ElevatedButton(
                          onPressed: () async {
                            print("Selected SSID : " + selectedSSID);
                            if ((_ssidController.text != "" || selectedSSID.isNotEmpty) &&
                                _wifiPassController.text != "") {
                              wifiCredentials[0] = _ssidController.text;
                              wifiCredentials[1] = _wifiPassController.text;
                              //TODO: Push wifi credentials to ESP
                            } else {
                              setState(() {
                                errorVisible = true;
                              });
                            }
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
                                horizontal: 7.w, vertical: 2.h),
                            textStyle: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
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
