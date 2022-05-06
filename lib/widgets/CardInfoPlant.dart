import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardInfoPlant extends StatefulWidget {
  const CardInfoPlant({Key? key, required this.cardType}) : super(key: key);
  final String cardType;

  @override
  State<CardInfoPlant> createState() => _CardInfoPlantState();
}

class _CardInfoPlantState extends State<CardInfoPlant> {
  var types = ["luminosity", "temperature", "humidity", "analyzer"];
  var colors = [
    Color(0xFFEFAD06),
    Color(0xFF46BFE3),
    Color(0xFF0707BB),
    Color(0xFF8D897C)
  ];
  var labels = ["Luminosité", "Température", "Humidité", "Analyzer"];
  var valuesMocked = ["80%", "10°", "70%", "Batterie à 50%"];

  Widget build(BuildContext context) {
    var type = 0;
    var fontColor = Colors.black;
    for (var i = 0; i < 4; i++) {
      if (widget.cardType == types[i]) {
        type = i;
      }
    }

    if (type == 2 || type == 3) {
      fontColor = Colors.white;
    }

    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 8,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(valuesMocked[type],
                  style: TextStyle(fontSize: 24, color: fontColor)),
              Text(labels[type],
                  style: TextStyle(fontSize: 24, color: fontColor)),
            ],
          ),
        ),
        color: colors[type],
      ),
    );
  }
}
