import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/global/utilities/firebase_management/analytics.dart';
import 'package:soulpot/global/utilities/firebase_management/firestore.dart';
import 'package:soulpot/global/widgets/analyzer_configuration/plant_card.dart';
import 'package:soulpot/global/widgets/analyzer_configuration/plant_picker_dialog.dart';

import '../../../global/models/analyzer.dart';
import '../../../global/models/plant.dart';
import '../../../global/utilities/mqtt_manager.dart';
import '../../../global/utilities/theme.dart';
import '../../../global/widgets/analyzer_configuration/analyzer_pairing_dialog.dart';

class AddAnalyzerDialog extends StatefulWidget {
  const AddAnalyzerDialog({required this.codex, Key? key}) : super(key: key);

  final List<Plant> codex;

  @override
  State<AddAnalyzerDialog> createState() => _AddAnalyzerDialogState();
}

class _AddAnalyzerDialogState extends State<AddAnalyzerDialog> {
  final TextEditingController _plantNameController = TextEditingController();
  final MQTTManager _mqttManager = MQTTManager();

  Plant? _selectedPlant;
  String? _ssid;
  bool _paired = false;
  bool _showError = false;

  late Analyzer analyzerToCreate;

  @override
  void initState() {
    _mqttManager.connect();
    analyzerToCreate = Analyzer(
      _plantNameController.text,
      false,
    );
    super.initState();
  }

  Future<void> previous() async {
    const String payload = "{\"reset\":\"true\"}";
    if (analyzerToCreate.id != null) {
      _mqttManager.publishMsg(payload, analyzerToCreate.id!, "");
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
          height: _showError ? 55.h : 50.h,
          width: 90.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: Column(children: [
              Text(
                "Donnez un nom à votre analyzer",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Greenhouse",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                child: SizedBox(
                  height: 7.h,
                  width: 80.w,
                  child: TextField(
                    onChanged: (_) {
                      setState(() {});
                    },
                    maxLength: 40,
                    controller: _plantNameController,
                    cursorColor: SoulPotTheme.spPurple,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: SoulPotTheme.spGreen),
                      ),
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
              Text(
                "Quelle est la plante associée à votre analyzer ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Greenhouse",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 1.h,
                    horizontal: _selectedPlant != null ? 1.w : 15.w),
                child: _selectedPlant != null
                    ? GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  PlantPickerDialog(
                                    codex: widget.codex,
                                  )).then(
                            (value) => setState(() {
                              _selectedPlant = value;
                            }),
                          );
                        },
                        child: PlantCard(plant: _selectedPlant!))
                    : ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  PlantPickerDialog(
                                    codex: widget.codex,
                                  )).then(
                            (value) => setState(() {
                              _selectedPlant = value;
                            }),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          primary: SoulPotTheme.spPurple,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 3.w),
                          child: Text(
                            "Choisir dans le codex",
                            style: TextStyle(
                              fontSize: 9.sp,
                              color: SoulPotTheme.spBackgroundWhite,
                            ),
                          ),
                        ),
                      ),
              ),
              const Spacer(),
              _paired
                  ? Text(
                      "Analyzer connecté au réseau $_ssid",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Greenhouse",
                        color: SoulPotTheme.spGreen,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) =>
                                AnalyzerPairingDialog(
                                  analyzer: analyzerToCreate,
                                )).then(
                          (value) => setState(() {
                            _ssid = value;
                            _paired = value != null;
                          }),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: SoulPotTheme.spBT,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 10.w),
                        child: Text(
                          "Appairer",
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: SoulPotTheme.spBackgroundWhite,
                          ),
                        ),
                      ),
                    ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Column(
                  children: [
                    _showError
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Text(
                              "Votre analyzer doit être totalement configuré !",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Greenhouse",
                                color: SoulPotTheme.spRed,
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
                          onPressed: previous,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            primary: SoulPotTheme.spPaleRed,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 3.w),
                            child: Text(
                              "Annuler",
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: SoulPotTheme.spBackgroundWhite,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            if (_plantNameController.text != "" &&
                                _selectedPlant != null &&
                                _paired) {
                              analyzerToCreate.name = _plantNameController.text;
                              analyzerToCreate.paired = true;
                              analyzerToCreate.plant = _selectedPlant;
                              analyzerToCreate.wifiName = _ssid;
                              FirestoreManager.createAnalyzer(analyzerToCreate);
                              AnalyticsManager.logNewPlantAdded(analyzerToCreate.plant!.alias);
                              Navigator.pop(context);
                            } else {
                              setState(() {
                                _showError = true;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            primary: SoulPotTheme.spGreen,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 3.w),
                            child: Text(
                              "Valider",
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: SoulPotTheme.spBackgroundWhite,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          )),
    );
  }
}
