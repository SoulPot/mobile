import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnalyzerPage extends StatefulWidget {
  const AnalyzerPage({Key? key}) : super(key: key);

  @override
  State<AnalyzerPage> createState() => _AnalyzerPageState();
}

class _AnalyzerPageState extends State<AnalyzerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
              "Analyzer parameters"
            )
        )

    );
  }

}