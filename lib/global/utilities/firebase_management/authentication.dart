import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/global/utilities/firebase_management/analytics.dart';
import 'package:soulpot/global/utilities/firebase_management/firestore.dart';
import 'package:soulpot/sign_in_sign_up/views/sign_in_view.dart';
import 'package:soulpot/home_view.dart';

import '../../../models/objective.dart';
import '../../../models/plant.dart';
import '../custom_snackbar.dart';
import '../error_thrower.dart';

class AuthenticationManager {
  static Future<Widget> initializeApp(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      List<Objective> objectives = await FirestoreManager.getStaticObjectives();
      List<Plant> codex = await FirestoreManager.getCodex();
      return HomeView(codex: codex, objectives: objectives);
    }
    return const SignInView();
  }

  static Future<bool> signInWithPwd(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      AnalyticsManager.logEmailPwdAuth();
      return true;
    } on FirebaseAuthException catch (e) {
      ErrorThrower.firebaseErrorThrower(e, context);
      return false;
    }
  }

  static Future<bool> signUp(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String delimiter = '@';
      int lastIndex = email.indexOf(delimiter);

      FirebaseAuth.instance.currentUser
          ?.updateDisplayName(email.substring(0, lastIndex));
      return true;
    } on FirebaseAuthException catch (e) {
      ErrorThrower.firebaseErrorThrower(e, context);
      return false;
    } catch (e) {
      snackBarCreator(context, e.toString(), SoulPotTheme.spPaleRed);
      return false;
    }
  }

  static Future<bool> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    return true;
  }

  static Future<bool> signInWithFacebook(BuildContext context) async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    return true;
  }
}
