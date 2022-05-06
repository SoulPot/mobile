import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/widgets/CardInfoPlant.dart';

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
                margin: EdgeInsets.only(top:10.0),
                child: Text("Nom de la plante", style: TextStyle(fontSize: 30))
            ),
            Center(
              child: Image.asset("assets/images/plant1.gif",
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
            )),
            Row(
              children: [
                CardInfoPlant(cardType: "luminosity"),
                CardInfoPlant(cardType: "temperature"),
              ],
            ),
            Row(
              children: [
                CardInfoPlant(cardType: "humidity",),
                CardInfoPlant(cardType: "analyzer",),
              ],
            )
          ],
        ),
      ),
    );
  }
}