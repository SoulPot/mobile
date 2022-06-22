import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/global/utilities/firebase_management/analytics.dart';
import 'package:soulpot/global/utilities/firebase_management/firestore.dart';
import 'package:soulpot/sign_in_sign_up/views/sign_in_view.dart';
import 'package:soulpot/home_view.dart';

import '../../../models/Objective.dart';
import '../../../models/Plant.dart';
import '../custom_snackbar.dart';
import '../error_thrower.dart';


class AuthenticationManager {

  static Future<Widget> initializeApp(BuildContext context) async{
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      List<Objective> objectives = await FirestoreManager.getStaticObjectives();
      List<Plant> codex = await FirestoreManager.getCodex();
      return HomeView(codex, objectives);
    }
    return SignInView();
  }

  static Future<User?> signInWithPwd( BuildContext context, String email, String password) async {
    User? user;
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user!;
      print(user.email);
      AnalyticsManager.logEmailPwdAuth();
      enterApp(context);
      return user;
    } on FirebaseAuthException catch (e) {
      ErrorThrower.firebaseErrorThrower(e, context);
      return null;
    }
  }

  static Future<void> signUp(BuildContext context, String email, String password) async {
    User user;
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user!;

      String delimiter = '@';
      int lastIndex = email.indexOf(delimiter);

      user.updateDisplayName(email.substring(0, lastIndex));
      snackBarCreator(context, "Utilisateur inscrit", SoulPotTheme.SPPaleGreen);
      Navigator.pushReplacement(
        context,
        PageTransition(
            alignment: Alignment.bottomCenter,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 600),
            reverseDuration: Duration(milliseconds: 600),
            type: PageTransitionType.fade,
            child: SignInView(),
            childCurrent: context.widget),
      );
    } on FirebaseAuthException catch (e) {
      ErrorThrower.firebaseErrorThrower(e, context);
    } catch (e) {
      snackBarCreator(context, e.toString(), SoulPotTheme.SPPaleRed);
    }
  }

  static Future<User?> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken,);
    var userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    enterApp(context);
    return userCredential.user;
  }

  static Future<User?> signInWithFacebook(BuildContext context) async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    final User? user = userCredential.user!;
    enterApp(context);
    return user;
  }

  static Future<void> enterApp(BuildContext context) async{
    List<Plant> codex = await FirestoreManager.getCodex();
    List<Objective> objectives = await FirestoreManager.getStaticObjectives();
    Navigator.pushReplacement(
      context,
      PageTransition(
          alignment: Alignment.bottomCenter,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 600),
          reverseDuration: Duration(milliseconds: 600),
          type: PageTransitionType.fade,
          child: HomeView(codex, objectives),
          childCurrent: context.widget),
    );
  }
}

