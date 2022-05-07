import 'package:flutter/material.dart';
import 'package:soulpot/theme.dart';

class AnalyzerDetails extends StatefulWidget {
  const AnalyzerDetails(
      {Key? key,
      required this.nameWifi,
      required this.namePlant,
      required this.analyzerName})
      : super(key: key);
  final String nameWifi;
  final String namePlant;
  final String analyzerName;

  @override
  State<AnalyzerDetails> createState() => _AnalyzerDetailsState();
}

class _AnalyzerDetailsState extends State<AnalyzerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SoultPotTheme.SPPaleGreen,
        title: Text("Détails " + widget.analyzerName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Nom du Wifi : " + widget.nameWifi,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Plante Analysée : " + widget.namePlant,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Nom Paramètre : Valeur paramètre",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: SoultPotTheme.SPPurple,
                  child: IconButton(
                      onPressed: editParameters,
                      icon: Icon(
                        Icons.mode_edit,
                        color: SoultPotTheme.SPPalePurple,
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void editParameters() {}
}
