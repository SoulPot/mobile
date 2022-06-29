import 'package:flutter/material.dart';
import 'package:soulpot/models/plant.dart';

import '../widget/plant_item_card.dart';

class CodexView extends StatefulWidget {
  const CodexView({Key? key, required this.codex}) : super(key: key);

  final List<Plant> codex;

  @override
  State<CodexView> createState() => _CodexViewState();
}

class _CodexViewState extends State<CodexView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView.builder(
              itemCount: widget.codex.length,
              itemBuilder: (context, position) {
                Plant plant = widget.codex[position];
                return PlantItemCard(plant: plant);
              },
            ),
        )
    );
  }
}
