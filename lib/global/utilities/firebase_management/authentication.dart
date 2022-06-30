import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/global/utilities/firebase_management/analytics.dart';
import 'package:soulpot/global/utilities/firebase_management/firestore.dart';

import '../custom_snackbar.dart';
import '../error_thrower.dart';

class AuthenticationManager {
  static final FirebaseAuth auth =
      FirebaseAuth.instanceFor(app: Firebase.apps.first);

  static Future<bool> signInWithPwd(
      BuildContext context, String email, String password) async {
    try {
      await AuthenticationManager.auth
          .signInWithEmailAndPassword(email: email, password: password);
      await FirebaseMessaging.instance.subscribeToTopic(auth.currentUser!.uid);
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
      var userCredentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirestoreManager.addUser(userCredentials.user!.uid);
      await FirestoreManager.assignAnalyzers(userCredentials.user!.uid);
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
    try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      var userCredentials = await auth.signInWithCredential(credential);
      await FirebaseMessaging.instance.subscribeToTopic(auth.currentUser!.uid);
      if (userCredentials.additionalUserInfo!.isNewUser) {
        await FirestoreManager.addUser(userCredentials.user!.uid);
        await FirestoreManager.assignAnalyzers(userCredentials.user!.uid);
      }
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);
      var userCredentials =
      await auth.signInWithCredential(facebookAuthCredential);
      await FirebaseMessaging.instance.subscribeToTopic(auth.currentUser!.uid);
      if (userCredentials.additionalUserInfo!.isNewUser) {
        await FirestoreManager.addUser(userCredentials.user!.uid);
        await FirestoreManager.assignAnalyzers(userCredentials.user!.uid);
      }
      return true;
    } catch(error) {
      return false;
    }
  }

  static Future<void> signOut() async {
    await FirebaseMessaging.instance
        .unsubscribeFromTopic(auth.currentUser!.uid);
    await auth.signOut();

    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }
}
