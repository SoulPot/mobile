import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/views/analyzers_views/analyzer_details_view.dart';

import '../theme.dart';

class CardInfoAnalyzer extends StatefulWidget {
  const CardInfoAnalyzer(
      {Key? key,
      required this.analyzerName,
      required this.batteryPercentage,
      required this.wifiName,
      required this.waterLevel})
      : super(key: key);
  final String analyzerName;
  final int batteryPercentage;
  final String wifiName;
  final String waterLevel;

  @override
  State<CardInfoAnalyzer> createState() => _CardInfoAnalyzerState();
}

class _CardInfoAnalyzerState extends State<CardInfoAnalyzer> {

  Widget build(BuildContext context) {
    var iconBattery = SoulPotTheme.battery_full;
    if (widget.batteryPercentage < 70) {
      iconBattery = SoulPotTheme.battery_half;
    } else if (widget.batteryPercentage < 30) {
      iconBattery = SoulPotTheme.battery_empty;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      widget.analyzerName,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  PopupMenuButton(
                      child: Icon(Icons.more_vert),
                      onSelected: popupMenuButton,
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  Text(" Modifier l'Analyzer"),
                                ],
                              ),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  Text(" Supprimer l'Analyzer"),
                                ],
                              ),
                              value: 2,
                            )
                          ]),
                ],
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(iconBattery),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            " Batterie : " +
                                widget.batteryPercentage.toString() +
                                "% ",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.wifi),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            " Réseau Wifi : " + widget.wifiName,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(SoulPotTheme.bucket_solid),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            " Eau restante : " + widget.waterLevel,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void fillWater() {
    print("Le réservoir est rempli");
  }

  void popupMenuButton(int value) {
    if(value == 1){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AnalyzerDetailsView(nameWifi: "HotSpot3",namePlant: "Orchidée", analyzerName: "Analyzer",)),
      );
    }
    print("Plus de détails");
  }

}
