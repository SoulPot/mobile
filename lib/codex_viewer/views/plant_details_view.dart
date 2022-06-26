import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soulpot/codex_viewer/views/codex_view.dart';

import '../../models/plant.dart';

class PlantDetailsView extends StatelessWidget {
  const PlantDetailsView({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Column(
              children: [
                Text("Nom Commun :"),
                Text(plant.alias),
                Text("Nom Scientifique"),
                Text(plant.plantID)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
