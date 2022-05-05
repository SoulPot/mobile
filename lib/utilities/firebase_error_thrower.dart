import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/custom_snackbar.dart';

late FirebaseApp firebaseApp;

FirebaseAuth auth = FirebaseAuth.instance;


void firebaseErrorThrower(FirebaseException e, BuildContext context) {
  switch (e.code) {
    case 'account-exists-with-different-credential':
      snackBarCreator(context, 'Ce compte existe déjà');
      break;
    case 'user-not-found':
      snackBarCreator(
          context, 'Aucun utilisateur trouvé pour cette adresse mail');
      break;
    case 'wrong-password':
      snackBarCreator(context, 'Mot de passe erroné');
      break;
    case 'permission-denied':
      snackBarCreator(context,
          'Vous n\'avez pas la permission nécessaire pour cette action');
      break;
    default:
      {
        snackBarCreator(context, e.toString());
      }
  }
}

void snackBarCreator(BuildContext context, String text) {
  CustomSnackBar(
    context,
    Text(
      text,
      textAlign: TextAlign.center,
    ),
  );
}
