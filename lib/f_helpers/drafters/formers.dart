import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:flutter/material.dart';

class Formers {
// -----------------------------------------------------------------------------

  const Formers();

// -----------------------------------------------------------------------------

/// FORM VALIDATION

// -------------------------------
  /// TESTED : WORKS PERFECT
  static bool validateForm(GlobalKey<FormState> formKey) {
    bool _inputsAreValid = true;

    if (formKey != null){
      _inputsAreValid = formKey.currentState?.validate();
    }

    return _inputsAreValid;
  }
// -------------------------------
  /// TESTED : WORKS PERFECT
  static void focusOnNode(FocusNode node){

    if (node != null){
      if (node.hasFocus == false){
        node.requestFocus();
      }
    }

  }
// -----------------------------------------------------------------------------

/// GENERAL VALIDATORS

// -------------------------------
  static String validatePhone(String phone){


    if (TextCheck.isEmpty(phone) == true){
      return '##Phone number should not be empty';
    }
    else {
      return null;
    }

  }
// -------------------------------
  static String validateEmail(String email){

    if (TextCheck.isEmpty(email) == true){
      return '##Add Email Address';
    }
    else {
      return null;
    }

  }
// -------------------------------
}
