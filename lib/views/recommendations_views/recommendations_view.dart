import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommendationsView extends StatefulWidget {
  const RecommendationsView({Key? key}) : super(key: key);

  @override
  State<RecommendationsView> createState() => _RecommendationsViewState();
}

class _RecommendationsViewState extends State<RecommendationsView> {

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