import 'package:flutter/cupertino.dart';
import 'package:soulpot/global/utilities/theme.dart';

import 'custom_snackbar.dart';

class FieldsManager {

  static bool checkSignupFields(BuildContext context, String email, String password, String passwordConfirmation) {
    if (email.isEmpty || password.isEmpty || passwordConfirmation.isEmpty) {
      snackBarCreator(context, "Certains champs sont vides", SoulPotTheme.spPaleRed);
      return false;
    }
    if (password.trim() != passwordConfirmation.trim()) {
      snackBarCreator(context, "Les mots de passe ne correspondent pas", SoulPotTheme.spPaleRed);
      return false;
    }
    return true;
  }


}