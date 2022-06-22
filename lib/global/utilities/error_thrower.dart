import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:soulpot/global/utilities/theme.dart';

import 'custom_snackbar.dart';

class ErrorThrower {
  static void firebaseErrorThrower(FirebaseException e, BuildContext context) {
    switch (e.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
        {
          snackBarCreator(
              context, "Email déjà utilisé", SoulPotTheme.spPaleRed);
          break;
        }
      case "ERROR_WRONG_PASSWORD":
        {
          snackBarCreator(context, "Adresse email ou mot de passe incorrect",
              SoulPotTheme.spPaleRed);
          break;
        }
      case "ERROR_USER_NOT_FOUND":
        {
          snackBarCreator(
              context,
              "Aucun utilisateur trouvé pour cette adresse email.",
              SoulPotTheme.spPaleRed);
          break;
        }
      case "ERROR_USER_DISABLED":
        {
          snackBarCreator(
              context, "Utilisateur désactivé", SoulPotTheme.spPaleRed);
          break;
        }
      case "ERROR_TOO_MANY_REQUESTS":
        {
          snackBarCreator(context, "Trop de requêtes. Réessayez plus tard.",
              SoulPotTheme.spPaleRed);
          break;
        }
      case "ERROR_OPERATION_NOT_ALLOWED":
        {
          snackBarCreator(
              context,
              "Erreur serveur, veuillez réessayer plus tard.",
              SoulPotTheme.spPaleRed);
          break;
        }
      case "ERROR_INVALID_EMAIL":
        {
          snackBarCreator(
              context, "Adresse email invalide.", SoulPotTheme.spPaleRed);
          break;
        }
      default:
        {
          snackBarCreator(
              context,
              "Opération interrompue. Veuillez réessayer plus tard.",
              SoulPotTheme.spPaleRed);
          break;
        }
    }
  }
}
