import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/global/utilities/fields_management.dart';
import 'package:soulpot/sign_in_sign_up/views/sign_in_view.dart';
import 'package:sizer/sizer.dart';

import '../../global/utilities/firebase_management/authentication.dart';


class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoulPotTheme.spBackgroundWhite,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset('assets/images/LogoSoulPot.png',
                          height: 30.h,),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: TextField(
                      controller: _emailController,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: SoulPotTheme.spGreen),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800], fontFamily: 'Greenhouse'),
                          hintText: "Email",
                          fillColor: SoulPotTheme.spBackgroundWhite),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: TextField(
                      controller: _pwdController,
                      textAlign: TextAlign.center,
                      obscureText: true,
                      textInputAction: TextInputAction.unspecified,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: SoulPotTheme.spGreen),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Mot de passe",
                          fillColor: SoulPotTheme.spBackgroundWhite),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: TextField(
                      controller: _confirmPwdController,
                      textAlign: TextAlign.center,
                      obscureText: true,
                      textInputAction: TextInputAction.unspecified,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: SoulPotTheme.spGreen),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Validation mot de passe",
                          fillColor: SoulPotTheme.spBackgroundWhite),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Vous possédez déjà un compte ? ", style: TextStyle(fontFamily: 'Greenhouse', fontSize: 12.sp),),
                        TextButton(
                          style:
                          TextButton.styleFrom(primary: SoulPotTheme.spBlack),
                          onPressed: () {
                            Navigator.pop(
                              context,
                              PageTransition(
                                  alignment: Alignment.bottomCenter,
                                  curve: Curves.easeInOut,
                                  duration: const Duration(milliseconds: 300),
                                  reverseDuration: const Duration(milliseconds: 300),
                                  type: PageTransitionType.leftToRight,
                                  child: const SignInView(),
                                  childCurrent: context.widget),
                            );
                          },
                          child: Text(
                            "Se connecter",
                            style: TextStyle(color: SoulPotTheme.spGreen, fontFamily: 'Greenhouse', fontSize: 12.sp),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (FieldsManager.checkSignupFields(context, _emailController.text, _pwdController.text, _confirmPwdController.text)) {
                          bool registered = await AuthenticationManager.signUp(context, _emailController.text.trim(), _pwdController.text.trim());
                          if (registered) {
                            await AuthenticationManager.auth.signOut();
                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  alignment: Alignment.bottomCenter,
                                  curve: Curves.easeInOut,
                                  duration: const Duration(milliseconds: 600),
                                  reverseDuration: const Duration(milliseconds: 600),
                                  type: PageTransitionType.fade,
                                  child: const SignInView(),
                                  childCurrent: context.widget),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          primary: SoulPotTheme.spGreen,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 2.h),
                          textStyle: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          )),
                      child: const Text(
                        "S'inscrire",
                        style: TextStyle(color: Colors.white),
                      ),
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
