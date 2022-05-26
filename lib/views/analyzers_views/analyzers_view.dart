import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';
import '../../widgets/CardInfoAnalyzer.dart';

class AnalyzersView extends StatefulWidget {
  const AnalyzersView({Key? key}) : super(key: key);

  @override
  State<AnalyzersView> createState() => _AnalyzersViewState();
}

class _AnalyzersViewState extends State<AnalyzersView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                        color: SoulPotTheme.SPGreen,
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
            CardInfoAnalyzer(analyzerName: "Analyzer Tomates", batteryPercentage:50, wifiName: "Box2022", waterLevel: "80%",),
            CardInfoAnalyzer(analyzerName: "Analyzer Tomates", batteryPercentage:50, wifiName: "Box2022", waterLevel: "80%",),
            Padding(
              padding: const EdgeInsets.only(left: 60.0, right: 60.0),
              child: ElevatedButton(
                onPressed: addNewAnalyzer,
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  primary: SoulPotTheme.SPPaleGreen,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: SoulPotTheme.SPGreen,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Ajouter un Analyzer",
                        style: TextStyle(
                            fontSize: 16, color: SoulPotTheme.SPGreen),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void parameters() {
    print("Vers les paramètres");
  }

  void addNewAnalyzer(){

  }
}
