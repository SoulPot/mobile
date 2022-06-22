import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';

import '../../global/utilities/firebase_management/authentication.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isLoading = false;

    AuthButtonType? buttonType;
    AuthIconType? iconType;

    return GoogleAuthButton(
      onPressed: () {
        AuthenticationManager.signInWithGoogle(context);
      },
      text: "Se connecter avec Google  ",
      darkMode: true,
      isLoading: isLoading,
      style: AuthButtonStyle(
        buttonType: buttonType,
        iconType: iconType,
      ),
    );
  }
}
