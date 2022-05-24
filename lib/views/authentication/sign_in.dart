import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/theme.dart';
import 'package:soulpot/widgets/group/email_pwd_sign_in.dart';
import 'package:soulpot/widgets/group/social_authentication.dart';

class SoulPotSignIn extends StatefulWidget {
  const SoulPotSignIn({Key? key}) : super(key: key);

  @override
  State<SoulPotSignIn> createState() => _SoulPotSignInState();
}

class _SoulPotSignInState extends State<SoulPotSignIn> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoulPotTheme.SPBackgroundWhite,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: SoulPotTheme.SPBackgroundWhite,
            child: SafeArea(
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
                          style:
                              TextStyle(fontSize: 20, fontFamily: "Greenhouse"),
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
                  SocialAuthentication(),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
