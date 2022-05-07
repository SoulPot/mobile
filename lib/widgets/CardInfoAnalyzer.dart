import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    var iconBattery = SoultPotTheme.battery_full;
    if (widget.batteryPercentage < 70) {
      iconBattery = SoultPotTheme.battery_half;
    } else if (widget.batteryPercentage < 30) {
      iconBattery = SoultPotTheme.battery_empty;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Center(
                child: Text(
                  widget.analyzerName,
                  style: TextStyle(fontSize: 20),
                ),
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
                            " Batterie : " + widget.batteryPercentage.toString() + "% ",
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
                        Icon(SoultPotTheme.bucket_solid),
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
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: ElevatedButton(
                onPressed: fillWater,
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  primary: SoultPotTheme.SPPaleGreen,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      SoultPotTheme.faucet_solid,
                      color: SoultPotTheme.SPGreen,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Réservoir Rempli",
                        style: TextStyle(
                            fontSize: 16, color: SoultPotTheme.SPGreen),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void fillWater() {
    print("Le réservoir est rempli");
  }
}
