import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soulpot/theme.dart';
import 'package:soulpot/utilities/authentication.dart';
import 'package:soulpot/views/authentication/sign_up_view.dart';
import 'package:sizer/sizer.dart';

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
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: TextField(
              controller: _emailController,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: SoulPotTheme.SPGreen, width: 1.h),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                      color: Colors.grey[800], fontFamily: 'Greenhouse'),
                  hintText: "Email",
                  fillColor: SoulPotTheme.SPBackgroundWhite),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: TextField(
              controller: _passwordController,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.unspecified,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: SoulPotTheme.SPGreen, width: 1.h),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Mot de passe",
                  fillColor: SoulPotTheme.SPBackgroundWhite),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: ElevatedButton(
              onPressed: () {
                Authentication.signInWithPwd(
                    context, _emailController.text, _passwordController.text);
              },
              child: Text(
                "Connexion",
                style: TextStyle(fontFamily: "Greenhouse", fontSize: 12.sp),
              ),
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                primary: SoulPotTheme.SPGreen,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
                textStyle: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pas encore de compte ?",
                  style: TextStyle(fontFamily: "Greenhouse", fontSize: 12.sp),
                ),
                TextButton(
                  style: TextButton.styleFrom(primary: SoulPotTheme.SPBlack),
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
                    style: TextStyle(
                        color: SoulPotTheme.SPGreen,
                        fontSize: 12.sp,
                        fontFamily: "Greenhouse"),
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
