import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../global/utilities/firebase_management/authentication.dart';
import '../../global/utilities/firebase_management/firestore.dart';
import '../../home_view.dart';
import '../../models/objective.dart';
import '../../models/plant.dart';


class FacebookSignInButton extends StatefulWidget {
  const FacebookSignInButton({Key? key}) : super(key: key);

  @override
  State<FacebookSignInButton> createState() => _FacebookSignInButtonState();
}

class _FacebookSignInButtonState extends State<FacebookSignInButton> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    AuthButtonType? buttonType;
    AuthIconType? iconType;

    return FacebookAuthButton(
      onPressed: () async {
        bool connected = await AuthenticationManager.signInWithFacebook(context);
        if (connected) {
          List<Plant> codex = await FirestoreManager.getCodex();
          List<Objective> objectives =
          await FirestoreManager.getStaticObjectives();
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
        }
      },
      text: "Se connecter avec Facebook",
      darkMode: true,
      isLoading: isLoading,
      style: AuthButtonStyle(
        buttonType: buttonType,
        iconType: iconType,
      ),
    );
  }
}
