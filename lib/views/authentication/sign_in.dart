import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/theme.dart';
import 'package:soulpot/widgets/email_pwd_sign_in.dart';
import '../../widgets/google_sign_in_button.dart';

class SoulPotSignIn extends StatefulWidget {
  const SoulPotSignIn({Key? key}) : super(key: key);

  @override
  State<SoulPotSignIn> createState() => _SoulPotSignInState();
}

class _SoulPotSignInState extends State<SoulPotSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoultPotTheme.SPBackgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Image.asset('assets/images/LogoSoulPot.png'),
            Spacer(),
            EmailPwdSignIn(),
            Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    "OU",
                    style: TextStyle(fontSize: 20, fontFamily: "Greenhouse"),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ],
            ),
            Spacer(),
            GoogleSignInButton(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
