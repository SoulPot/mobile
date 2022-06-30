import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:soulpot/global/utilities/config.dart';

import '../../models/analyzer.dart';
import '../../models/objective.dart';
import '../../models/plant.dart';
import '../../models/recommendations.dart';
import '../theme.dart';
import 'authentication.dart';

class FirestoreManager {
  static final FirebaseFirestore firestore =
      FirebaseFirestore.instanceFor(app: Firebase.apps.first);

  static Future<List<Objective>> getStaticObjectives() async {
    List<Objective> objectivesStatic = [];
    await firestore.collection("objectives").get().then((objective) {
      for (var element in objective.docs) {
        Color backgroundColor, fontColor;
        if (element["type"] == "easy") {
          backgroundColor = SoulPotTheme.spPaleGreen;
          fontColor = SoulPotTheme.spBlack;
        } else if (element["type"] == "advanced") {
          backgroundColor = SoulPotTheme.spPaleRed;
          fontColor = SoulPotTheme.spBlack;
        } else {
          backgroundColor = SoulPotTheme.spPalePurple;
          fontColor = SoulPotTheme.spBlack;
        }

        Objective o = Objective(
            element.id,
            element["nom"],
            element["description"],
            backgroundColor,
            fontColor,
            element["objective_value"],
            element["type"]);
        objectivesStatic.add(o);
      }
    });
    return objectivesStatic;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAnalyzersByUserID() {
    return firestore
        .collection("analyzers")
        .where("userID",
            isEqualTo: AuthenticationManager.auth.currentUser!.uid.toString())
        .snapshots();
  }

  static Future<List<Plant>> getCodex() async {
    List<Plant> result = [];
    var data = await firestore.collection("plants").get();
    for (var document in data.docs) {
      var plantFamily =
          document.data().keys.contains("family") ? document["family"] : "";
      var recommendationsText = document.data().keys.contains("recommendations")
          ? document["recommendations"]
          : "";
      var shortDescription = document.data().keys.contains("short_description")
          ? document["short_description"]
          : "";
      var origin =
          document.data().keys.contains("origin") ? document["origin"] : "";
      var infos =
          document.data().keys.contains("infos") ? document["infos"] : "";
      var height =
          document.data().keys.contains("height") ? document["height"] : "";
      var flowerColors = document.data().keys.contains("flower_colors")
          ? document["flower_colors"]
          : "";
      var cutting =
          document.data().keys.contains("cutting") ? document["cutting"] : "";
      var sowing =
          document.data().keys.contains("sowing") ? document["sowing"] : "";
      var pictureURL = document.data().keys.contains("picture_url")
          ? document["picture_url"]
          : "";
      var plantType = document.data().keys.contains("plant_type")
          ? document["plant_type"]
          : "";
      var floweringSeason = document.data().keys.contains("flowering_season")
          ? document["flowering_season"]
          : "";
      var plantingSeason = document.data().keys.contains("planting_season")
          ? document["planting_season"]
          : "";

      result.add(
        Plant(
            document.id,
            document["alias"],
            document["display_pid"],
            document["image_url"],
            Recommendations(
              [document["min_temp"], document["max_temp"]],
              [document["min_soil_moist"], document["max_soil_moist"]],
              [document["min_light_lux"], document["max_light_lux"]],
            ),
            plantFamily,
            recommendationsText,
            shortDescription,
            origin,
            infos,
            height,
            flowerColors,
            cutting,
            sowing,
            floweringSeason,
            pictureURL,
            plantType,
            plantingSeason),
      );
    }
    return result;
  }

  static Future<void> addUser(String userID) async {
    await firestore.collection("users").doc(userID).set({
      "isAdmin": false,
    });
  }

  static Future<void> createAnalyzer(Analyzer analyzer) async {
    AuthenticationManager.auth.currentUser?.uid != null
        ? await firestore.collection("analyzers").doc(analyzer.id).set({
            "name": analyzer.name,
            "plantID": analyzer.plant!.plantID,
            "wifiName": analyzer.wifiName,
            "userID": AuthenticationManager.auth.currentUser?.uid.toString(),
          })
        : await firestore.collection("analyzers").doc(analyzer.id).set({
            "name": analyzer.name,
            "plantID": analyzer.plant!.plantID,
            "wifiName": analyzer.wifiName,
            "deviceID": deviceID,
          });
  }

  static Future<void> assignAnalyzers(String userID) async {
    var data = await firestore.collection("analyzers").get();
    for (var document in data.docs) {
      if (document.data()["deviceID"] == deviceID) {
        await firestore.collection("analyzers").doc(document.id).update({
          "userID": userID,
          "deviceID": FieldValue.delete(),
        });
      }
    }
  }

  static Future<void> updateAnalyzerName(String analyzerID, String name) async {
    await firestore.collection("analyzers").doc(analyzerID).update({
      "name": name,
    });
  }

  static Future<void> deletedAnalyzer(String analyzerID) async {
    await firestore.collection("analyzers").doc(analyzerID).delete();
  }
}
