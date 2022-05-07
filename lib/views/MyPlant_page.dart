import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/widgets/CardInfoPlant.dart';

import '../theme.dart';

class MyPlantPage extends StatefulWidget {
  const MyPlantPage({Key? key}) : super(key: key);

  @override
  State<MyPlantPage> createState() => _MyPlantPageState();
}

class _MyPlantPageState extends State<MyPlantPage> {
  var colors = [
    Color(0xFFEFAD06),
    Color(0xFF46BFE3),
    Color(0xFF0707BB),
    Color(0xFF8D897C)
  ];
  var labels = ["Luminosité", "Température", "Humidité", "Analyzer"];
  var valuesMocked = ["80%", "10°", "70%", "Batterie à 50%"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
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
                  textAlign: TextAlign.center,
                ),
              ],
            )),
            Center(
                child: Image.asset(
              "assets/images/plant1.gif",
              height: MediaQuery.of(context).size.height / 2.2,
              width: MediaQuery.of(context).size.width,
            )),
            Padding(
              padding: const EdgeInsets.only(left: 100.0, right: 100.0),
              child: ElevatedButton(
                  onPressed: water,
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
                        SoultPotTheme.water,
                        color: SoultPotTheme.SPGreen,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: Text(
                          "M'arroser",
                          style: TextStyle(
                            fontSize: 16,
                            color: SoultPotTheme.SPGreen,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Divider(
              thickness: 2,
            ),
            Row(
              children: [
                CardInfoPlant(
                  label: "Luminosité",
                  value: "80%",
                  backgroundColor: colors[0],
                  fontColor: Colors.black,
                ),
                CardInfoPlant(
                  label: "Température",
                  value: "10°",
                  backgroundColor: colors[1],
                  fontColor: Colors.black,
                ),
              ],
            ),
            Row(
              children: [
                CardInfoPlant(
                  label: "Humidité",
                  value: "70%",
                  backgroundColor: colors[2],
                  fontColor: Colors.white,
                ),
                CardInfoPlant(
                  label: "Analyzer",
                  value: "Batterie à 50%",
                  backgroundColor: colors[3],
                  fontColor: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void water() {
    print("J'arrose ma plonte");
  }

  void parameters() {
    print("Vers les paramètres");
  }
}
