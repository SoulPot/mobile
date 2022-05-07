import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/CardInfoAnalyzer.dart';

class AnalyzerPage extends StatefulWidget {
  const AnalyzerPage({Key? key}) : super(key: key);

  @override
  State<AnalyzerPage> createState() => _AnalyzerPageState();
}

class _AnalyzerPageState extends State<AnalyzerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                IconButton(
                    onPressed: parameters,
                    icon: Icon(
                      Icons.settings,
                      color: SoultPotTheme.SPGreen,
                    )),
                Text(
                  "Nom Plante",
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
          ),
          CardInfoAnalyzer(analyzerName: "Analyzer Acacia", batteryPercentage:80, wifiName: "Home Wifi", waterLevel: "50%",),
          CardInfoAnalyzer(analyzerName: "Analyzer Tomates", batteryPercentage:50, wifiName: "Box2022", waterLevel: "80%",),
        ],
      ),
    );
  }

  void parameters() {
    print("Vers les paramètres");
  }
}
