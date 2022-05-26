import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/widgets/CardInfoPlant.dart';

import '../../theme.dart';

class PlantsView extends StatefulWidget {
  const PlantsView({Key? key}) : super(key: key);

  @override
  State<PlantsView> createState() => _PlantsViewState();
}

class _PlantsViewState extends State<PlantsView> {

  // MOCKED DATAS
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
                      color: SoulPotTheme.SPGreen,
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
                    primary: SoulPotTheme.SPPaleGreen,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        SoulPotTheme.water,
                        color: SoulPotTheme.SPGreen,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: Text(
                          "M'arroser",
                          style: TextStyle(
                            fontSize: 16,
                            color: SoulPotTheme.SPGreen,
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
                  backgroundColor: SoulPotTheme.luminosityColors["Good"]!,
                  fontColor: Colors.black,
                ),
                CardInfoPlant(
                  label: "Température",
                  value: "10°",
                  backgroundColor: SoulPotTheme.temperatureColors["Good"]!,
                  fontColor: Colors.black,
                ),
              ],
            ),
            Row(
              children: [
                CardInfoPlant(
                  label: "Humidité",
                  value: "70%",
                  backgroundColor: SoulPotTheme.humidityColors["Good"]!,
                  fontColor: Colors.black,
                ),
                CardInfoPlant(
                  label: "Analyzer",
                  value: "Batterie à 50%",
                  backgroundColor: SoulPotTheme.batteryColors["Good"]!,
                  fontColor: Colors.black,
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
