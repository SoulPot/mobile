import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'global/utilities/firebase_management/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FacebookAuth.instance.autoLogAppEventsEnabled(true);

  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(SoulPotApp());
  });
}

class SoulPotApp extends StatelessWidget {
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
                return Center(
                  child: CircularProgressIndicator(),
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


