import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  static final FirebaseAuth auth = FirebaseAuth.instanceFor(app: Firebase.apps.first);

  static Future<Widget> initializeApp(BuildContext context) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    User? user = auth.currentUser;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_launch');

    /*if(firstTime == null) {
      return const AnalyzerCountPickerView();
    } else if (firstTime == false){

    }*/
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
      await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String delimiter = '@';
      int lastIndex = email.indexOf(delimiter);

      auth.currentUser
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
    await auth.signInWithCredential(credential);
    await FirebaseMessaging.instance.subscribeToTopic(auth.currentUser!.uid);
    return true;
  }

  static Future<bool> signInWithFacebook(BuildContext context) async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    await auth.signInWithCredential(facebookAuthCredential);
    await FirebaseMessaging.instance.subscribeToTopic(auth.currentUser!.uid);
    return true;
  }

  static Future<void> signOut() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(auth.currentUser!.uid);
    print("Unsubscribed from topic: ${auth.currentUser!.uid}");
    await auth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }
}
