import 'package:flutter/cupertino.dart';

import '../../models/objective.dart';
import 'objective_card.dart';

class ObjectivesViewer extends StatefulWidget {
  const ObjectivesViewer({Key? key, required this.objectives}) : super(key: key);

  final List<Objective> objectives;
  @override
  State<ObjectivesViewer> createState() => _ObjectivesViewerState();
}

class _ObjectivesViewerState extends State<ObjectivesViewer> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: widget.objectives.length,
      itemBuilder: (context, position) {
        return ObjectiveCard(
          objective: widget.objectives[position],
        );
      },
    );
  }
}
