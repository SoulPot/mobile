import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/sign_in_sign_up/widgets/apple_sign_in_button.dart';

import 'fb_sign_in_button.dart';
import 'google_sign_in_button.dart';

class SocialAuthentication extends StatelessWidget {
  const SocialAuthentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: const GoogleSignInButton(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: const FacebookSignInButton(),
        ),
        Platform.isAndroid
            ? const SizedBox(
                height: 0,
                width: 0,
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: const AppleSignInButton(),
              ),
      ],
    );
  }
}
