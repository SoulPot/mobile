import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soulpot/models/Analyzer.dart';
import 'package:soulpot/models/Objective.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soulpot/models/Plant.dart';
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

        Objective o = Objective(element.id, element["nom"], element["description"], backgroundColor, fontColor, element["objective_value"]);
        objectivesStatic.add(o);
      });
    });
    return objectivesStatic;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAnalyzersByUserID() {
    return firestore
        .collection("analyzers")
        .where("userID",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
        .snapshots();
  }

  static Future<List<Plant>> getCodex() async {
    List<Plant> result = [];
    var data = await firestore.collection("plants").get();
    for (var document in data.docs) {
      result.add(Plant(
        document.id,
        document["alias"],
        document["image_url"],
        Recommendations(
          [document["min_temp"], document["max_temp"]],
          [document["min_soil_moist"], document["max_soil_moist"]],
          [document["min_light_lux"], document["max_light_lux"]],
        )
      ));
    }
    return result;
  }
}
