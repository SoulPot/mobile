import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../global/models/objective.dart';
import '../../global/models/plant.dart';
import '../../global/utilities/firebase_management/authentication.dart';
import '../../global/utilities/firebase_management/firestore.dart';
import '../../home_view.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    AuthButtonType? buttonType;
    AuthIconType? iconType;

    return GoogleAuthButton(
      onPressed: () async {
        setState(() {
          _isLoading = true;
        });
        bool connected = await AuthenticationManager.signInWithGoogle(context);
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
      text: _isLoading ? "Connexion avec Google" : "Se connecter avec Google  ",
      themeMode: ThemeMode.dark,
      isLoading: _isLoading,
      style: AuthButtonStyle(
        buttonType: buttonType,
        iconType: iconType,
      ),
    );
  }
}
