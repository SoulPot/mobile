import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:soulpot/global/utilities/theme.dart';

import 'global/utilities/config.dart';
import 'global/utilities/firebase_management/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FacebookAuth.instance.autoLogAppEventsEnabled(true);
  if(Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await DEVICE_INFOS.androidInfo;
    DEVICE_ID = androidInfo.androidId;
  } else if(Platform.isIOS) {
    IosDeviceInfo iosInfo = await DEVICE_INFOS.iosInfo;
    DEVICE_ID = iosInfo.identifierForVendor;
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

  print("Handling a background message: ${message.messageId}");
}

class SoulPotApp extends StatelessWidget {
  const SoulPotApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SoulPot',
          home: FutureBuilder(
            future: AuthenticationManager.initializeApp(context),
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
