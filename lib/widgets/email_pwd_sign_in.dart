import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/theme.dart';
import 'package:soulpot/utilities/authentication.dart';

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
              decoration: InputDecoration(
                hintText: 'Email',
              ),
              controller: _emailController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              controller: _passwordController,
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
                    MaterialStateProperty.all<Color>(SoultPotTheme.SPGreen),
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
              children: [
                Spacer(),
                Text(
                  "Pas encore de compte ?",
                  style: TextStyle(fontFamily: "Greenhouse", fontSize: 18),
                ),
                TextButton(
                  onPressed: () {
                    /* ... */
                  },
                  child: Text(
                    "Inscrivez-vous",
                    style: TextStyle(color: SoultPotTheme.SPGreen, fontSize: 18),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all<Color>(SoultPotTheme.SPPaleGreen),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ]),
      ],
    );
  }
}
