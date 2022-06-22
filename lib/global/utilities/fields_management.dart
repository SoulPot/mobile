import 'package:flutter/cupertino.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/global/utilities/error_thrower.dart';

import 'custom_snackbar.dart';

class FieldsManager {

  static bool checkSignupFields(BuildContext context, String email, String password, String passwordConfirmation) {
    if (email.isEmpty || password.isEmpty || passwordConfirmation.isEmpty) {
      print('empty fields');
      snackBarCreator(context, "Certains champs sont vides", SoulPotTheme.SPPaleRed);
      return false;
    }
    if (password.trim() != passwordConfirmation.trim()) {
      print('password not matching');
      snackBarCreator(context, "Les mots de passe ne correspondent pas", SoulPotTheme.SPPaleRed);
      return false;
    }
    return true;
  }


}