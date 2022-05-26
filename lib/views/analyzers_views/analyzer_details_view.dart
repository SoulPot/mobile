import 'package:flutter/material.dart';
import 'package:soulpot/theme.dart';

class AnalyzerDetailsView extends StatefulWidget {
  const AnalyzerDetailsView(
      {Key? key,
      required this.nameWifi,
      required this.namePlant,
      required this.analyzerName})
      : super(key: key);
  final String nameWifi;
  final String namePlant;
  final String analyzerName;

  @override
  State<AnalyzerDetailsView> createState() => _AnalyzerDetailsViewState();
}

class _AnalyzerDetailsViewState extends State<AnalyzerDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SoulPotTheme.SPPaleGreen,
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
                  backgroundColor: SoulPotTheme.SPPurple,
                  child: IconButton(
                      onPressed: editParameters,
                      icon: Icon(
                        Icons.mode_edit,
                        color: SoulPotTheme.SPPalePurple,
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
