import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soulpot/theme.dart';
import 'package:soulpot/utilities/error_thrower.dart';
import 'package:soulpot/utilities/fields_management.dart';
import 'package:soulpot/views/authentication/sign_in_view.dart';

import '../../utilities/authentication.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            color: SoulPotTheme.SPBackgroundWhite,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset('assets/images/LogoSoulPot.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
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
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                    child: TextField(
                      controller: _pwdController,
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
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                    child: TextField(
                      controller: _confirmPwdController,
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
                          hintText: "Validation mot de passe",
                          fillColor: SoulPotTheme.SPBackgroundWhite),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Vous possédez déjà un compte ? ", style: TextStyle(fontFamily: 'Greenhouse', fontSize: 18),),
                        TextButton(
                          style:
                          TextButton.styleFrom(primary: SoulPotTheme.SPBlack),
                          onPressed: () {
                            Navigator.pop(
                              context,
                              PageTransition(
                                  alignment: Alignment.bottomCenter,
                                  curve: Curves.easeInOut,
                                  duration: Duration(milliseconds: 300),
                                  reverseDuration: Duration(milliseconds: 300),
                                  type: PageTransitionType.leftToRight,
                                  child: SignInView(),
                                  childCurrent: context.widget),
                            );
                          },
                          child: Text(
                            "Se connecter",
                            style: TextStyle(color: SoulPotTheme.SPGreen, fontFamily: 'Greenhouse', fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (FieldsManager.checkSignupFields(context, _emailController.text, _pwdController.text, _confirmPwdController.text)) {
                          Authentication.signUp(context, _emailController.text.trim(), _pwdController.text.trim());
                        }
                      },
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          primary: SoulPotTheme.SPGreen,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
