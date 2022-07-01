import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/sign_in_sign_up/views/sign_in_view.dart';

import 'analyzers_setup/views/analyzer_count_picker_view.dart';
import 'global/models/objective.dart';
import 'global/models/plant.dart';
import 'global/utilities/config.dart';
import 'global/utilities/firebase_management/authentication.dart';
import 'global/utilities/firebase_management/firestore.dart';
import 'home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FacebookAuth.instance.autoLogAppEventsEnabled(true);
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfos.androidInfo;
    deviceID = (androidInfo.device ?? "") +
        (androidInfo.fingerprint ?? "") +
        (androidInfo.hardware ?? "") +
        (androidInfo.manufacturer ?? "") +
        (androidInfo.model ?? "") +
        (androidInfo.product ?? "") +
        (androidInfo.id ?? "");
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfos.iosInfo;
    deviceID = iosInfo.identifierForVendor;
  }
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const SoulPotApp());
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

class SoulPotApp extends StatelessWidget {
  const SoulPotApp({Key? key}) : super(key: key);

  static Future<Widget> initializeApp(BuildContext context) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    User? user = AuthenticationManager.auth.currentUser;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_launch');
    //prefs.remove("first_launch"); // DECOMMENTER POUR ACCEDER AU SETUP

    if (firstTime == null) {
      List<Plant> codex = await FirestoreManager.getCodex();
      codex.sort((a, b) => a.alias.compareTo(b.alias));
      return AnalyzerCountPickerView(codex: codex);
    } else if (firstTime == false) {
      if (user != null) {
        List<Objective> objectives =
            await FirestoreManager.getStaticObjectives();
        List<Plant> codex = await FirestoreManager.getCodex();
        codex.sort((a, b) => a.alias.compareTo(b.alias));
        return HomeView(codex: codex, objectives: objectives);
      }
    }
    return const SignInView();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SoulPot',
          home: FutureBuilder(
            future: initializeApp(context),
            builder: (BuildContext context, AsyncSnapshot<Widget> widget) {
              if (!widget.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: SoulPotTheme.spGreen,
                  ),
                );
              }
              return widget.data!;
            },
          ),
        );
      },
    );
  }
}
