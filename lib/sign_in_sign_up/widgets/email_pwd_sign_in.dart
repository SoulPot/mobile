import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/sign_in_sign_up/views/sign_up_view.dart';
import 'package:sizer/sizer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../global/models/objective.dart';
import '../../global/models/plant.dart';
import '../../global/utilities/firebase_management/authentication.dart';
import '../../global/utilities/firebase_management/firestore.dart';
import '../../home_view.dart';

class EmailPwdSignIn extends StatefulWidget {
  const EmailPwdSignIn({Key? key}) : super(key: key);

  @override
  State<EmailPwdSignIn> createState() => _EmailPwdSignInState();
}

class _EmailPwdSignInState extends State<EmailPwdSignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool isLoading;

  @override
  initState() {
    isLoading = false;
    super.initState();
  }

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
                        const BorderSide(color: SoulPotTheme.spGreen),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                      color: Colors.grey[800], fontFamily: 'Greenhouse'),
                  hintText: "Email",
                  fillColor: SoulPotTheme.spBackgroundWhite),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: TextField(
              controller: _passwordController,
              textAlign: TextAlign.center,
              obscureText: true,
              textInputAction: TextInputAction.unspecified,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: SoulPotTheme.spGreen),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Mot de passe",
                  fillColor: SoulPotTheme.spBackgroundWhite),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: isLoading ? LoadingAnimationWidget.discreteCircle(color: SoulPotTheme.spGreen, size: 5.h) : ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                bool connected = await AuthenticationManager.signInWithPwd(
                    context, _emailController.text, _passwordController.text);
                if (connected) {
                  List<Plant> codex = await FirestoreManager.getCodex();
                  List<Objective> objectives =
                      await FirestoreManager.getStaticObjectives();
                  codex.sort((a, b) => a.alias.compareTo(b.alias));
                  setState(() {
                    isLoading = false;
                  });
                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                        alignment: Alignment.bottomCenter,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 600),
                        reverseDuration: const Duration(milliseconds: 600),
                        type: PageTransitionType.fade,
                        child: HomeView(codex: codex, objectives: objectives),
                        childCurrent: context.widget),
                  );
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                primary: SoulPotTheme.spGreen,
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
                textStyle: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text(
                "Connexion",
                style: TextStyle(fontFamily: "Greenhouse", fontSize: 12.sp),
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
                  style: TextButton.styleFrom(primary: SoulPotTheme.spBlack),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          alignment: Alignment.bottomCenter,
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 300),
                          reverseDuration: const Duration(milliseconds: 300),
                          type: PageTransitionType.rightToLeftWithFade,
                          child: const SignUpView(),
                          childCurrent: context.widget),
                    );
                  },
                  child: Text(
                    "S'inscrire",
                    style: TextStyle(
                        color: SoulPotTheme.spGreen,
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
