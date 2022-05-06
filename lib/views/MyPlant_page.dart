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
                Center(
                  widthFactor: 1.3,
                    child: Text(
                  "plante",
                  style: TextStyle(fontSize: 28),
                  textAlign: TextAlign.center,
                )),
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
                CardInfoPlant(cardType: "luminosity"),
                CardInfoPlant(cardType: "temperature"),
              ],
            ),
            Row(
              children: [
                CardInfoPlant(
                  cardType: "humidity",
                ),
                CardInfoPlant(
                  cardType: "analyzer",
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
