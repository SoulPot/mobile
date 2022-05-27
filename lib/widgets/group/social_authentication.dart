import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import '../single/fb_sign_in_button.dart';
import '../single/google_sign_in_button.dart';

class SocialAuthentication extends StatelessWidget {
  const SocialAuthentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: GoogleSignInButton(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: FacebookSignInButton(),
        ),
      ],
    );
  }
}
