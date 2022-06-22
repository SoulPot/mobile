import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ObjectivesView extends StatefulWidget {
  const ObjectivesView({Key? key}) : super(key: key);

  @override
  State<ObjectivesView> createState() => _ObjectivesViewState();
}

class _ObjectivesViewState extends State<ObjectivesView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
                "Objectives and Quests"
            )
        )

    );
  }

}