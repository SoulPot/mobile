import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
                "Informations get by analyzer"
            )
        )

    );
  }

}