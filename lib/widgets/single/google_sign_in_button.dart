import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:soulpot/utilities/authentication.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isLoading = false;
    bool darkMode = false;

    AuthButtonType? buttonType;
    AuthIconType? iconType;

    return GoogleAuthButton(
      onPressed: () {
        Authentication.signInWithGoogle(context);
      },
      text: "Se connecter avec Google  ",
      darkMode: darkMode,
      isLoading: isLoading,
      style: AuthButtonStyle(
        buttonType: buttonType,
        iconType: iconType,
      ),
    );
  }
}
