import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soulpot/models/Analyzer.dart';
import 'package:soulpot/models/Objective.dart';
import 'package:soulpot/models/Recommendations.dart';
import 'package:soulpot/theme.dart';

class FirestoreManager {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<List<Objective>> getStaticObjectives() async {
    List<Objective> objectivesStatic = [];
    await firestore.collection("objectives").get().then((objective){
      objective.docs.forEach((element) {

        Color backgroundColor, fontColor;
        if(element["type"] == "easy"){
          backgroundColor = SoulPotTheme.SPPaleGreen;
          fontColor = SoulPotTheme.SPBlack;
        } else if(element["type"] == "advanced"){
          backgroundColor = SoulPotTheme.SPPaleRed;
          fontColor = SoulPotTheme.SPBlack;
        } else {
          backgroundColor = SoulPotTheme.SPPalePurple;
          fontColor = SoulPotTheme.SPBlack;
        }

        Objective o = Objective(element["nom"], element["description"], backgroundColor, fontColor, element["objective_value"]);
        objectivesStatic.add(o);
      });
    });
    return objectivesStatic;
  }

}
