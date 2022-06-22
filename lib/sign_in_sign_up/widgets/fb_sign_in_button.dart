import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';

import '../../global/utilities/firebase_management/authentication.dart';


class FacebookSignInButton extends StatelessWidget {
  const FacebookSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    AuthButtonType? buttonType;
    AuthIconType? iconType;

    return FacebookAuthButton(
      onPressed: () {
        AuthenticationManager.signInWithFacebook(context);
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
