

import 'package:flutter/material.dart';

class Formers {
// -----------------------------------------------------------------------------

  const Formers();

// -----------------------------------------------------------------------------

/// FORM VALIDATION

// -------------------------------
  static bool validateForm(GlobalKey<FormState> formKey) {
    bool _inputsAreValid = true;

    if (formKey != null){
      _inputsAreValid = formKey.currentState?.validate();
    }

    return _inputsAreValid;
  }
// -----------------------------------------------------------------------------
  static void focusOnNode(FocusNode node){

    if (node != null){
      if (node.hasFocus == false){
        node.requestFocus();
      }
    }

  }
// -----------------------------------------------------------------------------
}
