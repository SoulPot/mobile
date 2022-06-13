import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:soulpot/views/analyzer_configuration/analyzer_count_picker_view.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/views/authentication/sign_in_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          home: AnalyzerCountPickerView(),
        );
      },
    );
  }
}


