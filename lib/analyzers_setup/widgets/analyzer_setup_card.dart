import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/global/utilities/theme.dart';

import '../../global/models/analyzer.dart';
import '../../global/models/plant.dart';
import '../../global/widgets/analyzer_configuration/analyzer_pairing_dialog.dart';
import '../../global/widgets/analyzer_configuration/plant_card.dart';
import '../../global/widgets/analyzer_configuration/plant_picker_dialog.dart';
import '../../global/widgets/analyzer_configuration/analyzer_rename_dialog.dart';

class AnalyzerSetupCard extends StatefulWidget {
  const AnalyzerSetupCard(
      {Key? key, required this.analyzer, required this.codex})
      : super(key: key);

  final Analyzer analyzer;
  final List<Plant> codex;

  @override
  State<AnalyzerSetupCard> createState() => _AnalyzerSetupCardState();
}

class _AnalyzerSetupCardState extends State<AnalyzerSetupCard> {
  Plant? selectedPlant;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: SoulPotTheme.spPalePurple,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Text(
              widget.analyzer.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: SoulPotTheme.spBlack,
                fontSize: 15.sp,
                fontFamily: 'Greenhouse',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => RenameDialog(
                        analyzer: widget.analyzer,
                      )).then((value) => setState(() {}));
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              primary: SoulPotTheme.spPaleGreen,
            ),
            child: Text(
              'Renommer',
              style: TextStyle(
                color: SoulPotTheme.spBlack,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Greenhouse',
              ),
            ),
          ),
          selectedPlant != null
              ? GestureDetector(
                  child: PlantCard(plant: selectedPlant!),
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) => PlantPickerDialog(
                              codex: widget.codex,
                            )).then((value) => setState(() {
                          selectedPlant = value;
                        }));
                  },
                )
              : ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) => PlantPickerDialog(
                              codex: widget.codex,
                            )).then((value) => setState(() {
                          selectedPlant = value;
                          widget.analyzer.plant = value;
                        }));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    primary: SoulPotTheme.spPurple,
                  ),
                  child: Text(
                    'Choisir plante',
                    style: TextStyle(
                      color: SoulPotTheme.spBackgroundWhite,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Greenhouse',
                    ),
                  ),
                ),
          widget.analyzer.paired!
              ? Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(
                    "Connecté",
                    style: TextStyle(
                      color: SoulPotTheme.spGreen,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Greenhouse',
                    ),
                  ),
                )
              : ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) =>
                            AnalyzerPairingDialog(
                              analyzer: widget.analyzer,
                            )).then((value) => setState(() {
                          if (value != null) {
                            widget.analyzer.paired = true;
                            widget.analyzer.wifiName = value;
                          }
                        }));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    primary: SoulPotTheme.spBT,
                  ),
                  child: Text(
                    'Appairer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Greenhouse',
                    ),
                  ),
                ),
          const Spacer(),
        ],
      ),
    );
  }
}
