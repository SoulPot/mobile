import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ObjectivePage extends StatefulWidget {
  const ObjectivePage({Key? key}) : super(key: key);

  @override
  State<ObjectivePage> createState() => _ObjectivePageState();
}

class _ObjectivePageState extends State<ObjectivePage> {

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