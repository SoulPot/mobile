import 'package:flutter/cupertino.dart';

import '../single/fb_sign_in_button.dart';
import '../single/google_sign_in_button.dart';

class SocialAuthentication extends StatelessWidget {
  const SocialAuthentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: GoogleSignInButton(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: FacebookSignInButton(),
        ),
      ],
    );
  }
}
