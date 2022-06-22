import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:soulpot/global/utilities/theme.dart';

import 'custom_snackbar.dart';

class ErrorThrower {

  static void firebaseErrorThrower(FirebaseException e, BuildContext context) {
    switch (e.code) {case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
      {
        snackBarCreator(context, "Email déjà utilisé", SoulPotTheme.SPPaleRed);
        break;
      }
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
      {
        snackBarCreator(context, "Adresse email ou mot de passe incorrect", SoulPotTheme.SPPaleRed);
        break;
      }
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
      {
        snackBarCreator(context, "Aucun utilisateur trouvé pour cette adresse email.", SoulPotTheme.SPPaleRed);
        break;
      }
      case "ERROR_USER_DISABLED":
      case "user-disabled":
      {
        snackBarCreator(context, "Utilisateur désactivé", SoulPotTheme.SPPaleRed);
        break;
      }
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
      {
        snackBarCreator(context, "Trop de requêtes. Réessayez plus tard.", SoulPotTheme.SPPaleRed);
        break;
      }
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
      {
        snackBarCreator(context, "Erreur serveur, veuillez réessayer plus tard.", SoulPotTheme.SPPaleRed);
        break;
      }
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
      {
        snackBarCreator(context, "Adresse email invalide.", SoulPotTheme.SPPaleRed);
        break;
      }
      default:
        {
          snackBarCreator(context, "Opération interrompue. Veuillez réessayer plus tard.", SoulPotTheme.SPPaleRed);
          break;
        }
    }
  }
}

