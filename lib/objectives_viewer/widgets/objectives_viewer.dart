import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/global/utilities/theme.dart';

import '../../models/objective.dart';
import 'objective_card.dart';

class ObjectivesViewer extends StatefulWidget {
  const ObjectivesViewer({Key? key, required this.objectives})
      : super(key: key);

  final List<Objective> objectives;

  @override
  State<ObjectivesViewer> createState() => _ObjectivesViewerState();
}

class _ObjectivesViewerState extends State<ObjectivesViewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: SoulPotTheme.spPalePurple,
      ),
      child: widget.objectives.isEmpty
          ? Center(
              child: Text(
                "Vous n'avez compléter aucun objectif pour le moment",
                style: TextStyle(
                    fontFamily: "Greenhouse",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
              ),
              itemCount: widget.objectives.length,
              itemBuilder: (context, position) {
                return ObjectiveCard(
                  objective: widget.objectives[position],
                );
              },
            ),
    );
  }
}
