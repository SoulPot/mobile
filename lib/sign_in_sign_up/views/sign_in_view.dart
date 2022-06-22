import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/sign_in_sign_up/widgets/email_pwd_sign_in.dart';
import 'package:soulpot/sign_in_sign_up/widgets/social_authentication_group.dart';
import 'package:sizer/sizer.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
            height: 100.h,
            width: 100.w,
            color: SoulPotTheme.SPBackgroundWhite,
            child: SafeArea(
              child: Column(
                children: [
                  Spacer(),
                  Image.asset(
                    'assets/images/LogoSoulPot.png',
                    height: 30.h,
                  ),
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
                        padding: EdgeInsets.only(left: 1.w, right: 1.w),
                        child: Text(
                          "OU",
                          style:
                              TextStyle(fontSize: 12.sp, fontFamily: "Greenhouse"),
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
