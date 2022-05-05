import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soulpot/views/authentication/sign_in.dart';
import 'package:soulpot/views/home_page.dart';

import 'firebase_error_thrower.dart';

class Authentication {
  static Future<void> initializeFirebase(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        PageTransition(
            alignment: Alignment.bottomCenter,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 600),
            reverseDuration: Duration(milliseconds: 600),
            type: PageTransitionType.fade,
            child: HomePage(),
            childCurrent: context.widget),
      );
    }
  }

  static Future<User?> signInWithPwd( BuildContext context, String email, String password) async {
    User? user;

    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user!;
      print(user.email);
      return user;
    } on FirebaseAuthException catch (e) {
      firebaseErrorThrower(e, context);
      return null;
    }
  }

  static Future<void> signUp(
      {required BuildContext context,
        required String email,
        required String password,
        required String name}) async {
    User user;
    try {
      UserCredential userCredential =
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user!;

      String delimiter = '@';
      int lastIndex = email.indexOf(delimiter);

      user.updateDisplayName(email.substring(0, lastIndex));
      Navigator.pushReplacement(
        context,
        PageTransition(
            alignment: Alignment.bottomCenter,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 600),
            reverseDuration: Duration(milliseconds: 600),
            type: PageTransitionType.fade,
            child: SoulPotSignIn(),
            childCurrent: context.widget),
      );
    } on FirebaseAuthException catch (e) {
      firebaseErrorThrower(e, context);
    } catch (e) {
      snackBarCreator(context, e.toString());
    }
  }

  static Future<User?> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    var userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.user;
  }


}

