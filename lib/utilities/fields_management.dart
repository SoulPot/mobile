import 'package:flutter/cupertino.dart';
import 'package:soulpot/theme.dart';
import 'package:soulpot/utilities/error_thrower.dart';

import '../widgets/single/custom_snackbar.dart';

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