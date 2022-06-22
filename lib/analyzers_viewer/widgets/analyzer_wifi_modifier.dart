import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../global/utilities/theme.dart';
import '../../global/widgets/dropdown_wifi_picker.dart';

class AnalyzerWifiModifier extends StatefulWidget {
  const AnalyzerWifiModifier({Key? key, required this.ssids}) : super(key: key);

  final List<String> ssids;

  @override
  State<AnalyzerWifiModifier> createState() => _AnalyzerWifiModifierState();
}

class _AnalyzerWifiModifierState extends State<AnalyzerWifiModifier> {
  List<String> wifiCredentials = ["SSID", "PASSWORD"];
  List<String> ssids = [];
  late String selectedSSID = "";
  bool errorVisible = false;
  final TextEditingController _wifiPassController = TextEditingController();
  final TextEditingController _ssidController = TextEditingController();

  @override
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
      child: SizedBox(
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
              const Spacer(),
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
                                child: SizedBox(
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
                                      setState(() {
                                        errorVisible = false;
                                      });
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
                                      setState(() {
                                        errorVisible = false;
                                      });
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
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          dispose();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          primary: SoulPotTheme.spPaleRed,
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.w, vertical: 2.h),
                          textStyle: TextStyle(
                            fontSize: 13.sp,
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
                        padding: EdgeInsets.only(left: 8.w),
                        child: ElevatedButton(
                          onPressed: () async {
                            if ((_ssidController.text != "" ||
                                    selectedSSID.isNotEmpty) &&
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
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            primary: SoulPotTheme.spPaleGreen,
                            padding: EdgeInsets.symmetric(
                                horizontal: 7.w, vertical: 2.h),
                            textStyle: TextStyle(
                              fontSize: 13.sp,
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
                ],
              ),
              const Spacer(),
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