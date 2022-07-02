import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import '../../global/models/objective.dart';
import '../../global/models/plant.dart';
import '../../global/utilities/firebase_management/authentication.dart';
import '../../global/utilities/firebase_management/firestore.dart';
import '../../home_view.dart';

class AppleSignInButton extends StatefulWidget {
  const AppleSignInButton({Key? key}) : super(key: key);

  @override
  State<AppleSignInButton> createState() => _AppleSignInButtonState();
}

class _AppleSignInButtonState extends State<AppleSignInButton> {

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    AuthButtonType? buttonType;
    AuthIconType? iconType;

    return AppleAuthButton(
      onPressed: () async {
        setState(() {
          _isLoading = true;
        });
        bool connected = await AuthenticationManager.signInWithApple(context);
        if (connected) {
          List<Plant> codex = await FirestoreManager.getCodex();
          List<Objective> objectives =
              await FirestoreManager.getStaticObjectives();
          codex.sort((a, b) => a.alias.compareTo(b.alias));
          setState(() {
            _isLoading = false;
          });
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            PageTransition(
                alignment: Alignment.bottomCenter,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 600),
                reverseDuration: const Duration(milliseconds: 600),
                type: PageTransitionType.fade,
                child: HomeView(codex: codex, objectives: objectives),
                childCurrent: context.widget),
          );
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      },
      text: _isLoading ? "Connexion avec Apple" : "Se connecter avec Apple  ",
      themeMode: ThemeMode.dark,
      isLoading: _isLoading,
      style: AuthButtonStyle(
        buttonType: buttonType,
        iconType: iconType,
        width: 75.w,
      ),
    );
  }
}
