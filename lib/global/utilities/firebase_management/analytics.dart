import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsManager {

  static final FirebaseAnalytics analytics = FirebaseAnalytics.instanceFor(app: Firebase.apps.first);

  static void logEmailPwdAuth() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm:ss').format(now);
    await analytics.logEvent(
      name: "authentication",
      parameters: {
        "date": formattedDate,
        "platform": Platform.isIOS ? "ios" : "android",
        "type": "email_pwd"
      },
    );
  }

  static void logFacebookAuth() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm:ss').format(now);
    await analytics.logEvent(
      name: "authentication",
      parameters: {
        "date": formattedDate,
        "platform": Platform.isIOS ? "ios" : "android",
        "type": "facebook"
      },
    );
  }

  static void logGoogleAuth() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm:ss').format(now);
    await analytics.logEvent(
      name: "authentication",
      parameters: {
        "date": formattedDate,
        "platform": Platform.isIOS ? "ios" : "android",
        "type": "google"
      },
    );
  }

  static void logSignUp() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm:ss').format(now);
    await analytics.logEvent(
      name: "new account",
      parameters: {
        "date": formattedDate,
        "platform": Platform.isIOS ? "ios" : "android",
      },
    );
  }

  static void logNewPlantAdded(String plantName) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm:ss').format(now);
    await analytics.logEvent(
      name: "new plant",
      parameters: {
        "date": formattedDate,
        "platform": Platform.isIOS ? "ios" : "android",
        "plant_type": plantName
      },
    );
  }

  static void logSprinkle() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm:ss').format(now);
    await analytics.logEvent(
      name: "new plant",
      parameters: {
        "date": formattedDate,
        "platform": Platform.isIOS ? "ios" : "android",
      },
    );
  }

  static void logDeletePlant() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm:ss').format(now);
    await analytics.logEvent(
      name: "delete plant",
      parameters: {
        "date": formattedDate,
        "platform": Platform.isIOS ? "ios" : "android",
      },
    );
  }
  
}