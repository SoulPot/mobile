import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPlantPage extends StatefulWidget {
  const MyPlantPage({Key? key}) : super(key: key);

  @override
  State<MyPlantPage> createState() => _MyPlantPageState();
}

class _MyPlantPageState extends State<MyPlantPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/plant1.gif",
          height: 500.0,
          width: 500.0,
        )
      )

    );
  }

}