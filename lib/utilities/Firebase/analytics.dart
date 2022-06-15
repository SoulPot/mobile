import 'dart:io';
import 'package:intl/intl.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsManager {
  static AnalyticsManager instance = AnalyticsManager.instance;

  static void logEmailPwdAuth() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm:ss').format(now);
    await FirebaseAnalytics.instance.logEvent(
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
    await FirebaseAnalytics.instance.logEvent(
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
    await FirebaseAnalytics.instance.logEvent(
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
    await FirebaseAnalytics.instance.logEvent(
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
    await FirebaseAnalytics.instance.logEvent(
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
    await FirebaseAnalytics.instance.logEvent(
      name: "new plant",
      parameters: {
        "date": formattedDate,
        "platform": Platform.isIOS ? "ios" : "android",
      },
    );
  }
  
}