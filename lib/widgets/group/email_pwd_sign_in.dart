import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soulpot/theme.dart';
import 'package:soulpot/utilities/authentication.dart';
import 'package:soulpot/views/authentication/sign_up_view.dart';

class EmailPwdSignIn extends StatefulWidget {
  const EmailPwdSignIn({Key? key}) : super(key: key);

  @override
  State<EmailPwdSignIn> createState() => _EmailPwdSignInState();
}

class _EmailPwdSignInState extends State<EmailPwdSignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: TextField(
              controller: _emailController,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: SoulPotTheme.SPGreen, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800], fontFamily: 'Greenhouse'),
                  hintText: "Email",
                  fillColor: SoulPotTheme.SPBackgroundWhite),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: TextField(
              controller: _passwordController,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.unspecified,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: SoulPotTheme.SPGreen, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Mot de passe",
                  fillColor: SoulPotTheme.SPBackgroundWhite),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                Authentication.signInWithPwd(context, _emailController.text, _passwordController.text);
              },
              child: Text(
                "Connexion",
                style: TextStyle(fontFamily: "Greenhouse", fontSize: 18),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(SoulPotTheme.SPGreen),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pas encore de compte ?",
                  style: TextStyle(fontFamily: "Greenhouse", fontSize: 18),
                ),
                TextButton(
                  style:
                  TextButton.styleFrom(primary: SoulPotTheme.SPBlack),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          alignment: Alignment.bottomCenter,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 300),
                          reverseDuration: Duration(milliseconds: 300),
                          type: PageTransitionType.rightToLeftWithFade,
                          child: SignUpView(),
                          childCurrent: context.widget),
                    );
                  },
                  child: Text(
                    "S'inscrire",
                    style: TextStyle(color: SoulPotTheme.SPGreen, fontSize: 18, fontFamily: "Greenhouse"),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ],
    );
  }
}
