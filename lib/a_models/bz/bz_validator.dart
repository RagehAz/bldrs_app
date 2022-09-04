

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

class BzValidator {
// -----------------------------------------------------------------------------

  const BzValidator();

// -----------------------------------------------------------------------------

/// VALIDATORS

// -------------------------------
  /// TESTED : WORKS PERFECT
  static String nameValidator({
    @required BzModel bzModel,
    FocusNode focusNode,
  }){

    final bool _companyNameIsShort = TextCheck.isShorterThan(
      text: bzModel.name,
      length: Standards.minCompanyNameLength,
    );

    if (_companyNameIsShort == true){
      Formers.focusOnNode(focusNode);
      return '##Company Name should not be less than ${Standards.minCompanyNameLength} characters';
    }
    else {
      return null;
    }

  }
// -------------------------------
  static String aboutValidator({
    @required BzModel bzModel,
    FocusNode focusNode,
  }){

    final bool _hasBadWords = TextCheck.containsBadWords(
      text: bzModel.about,
    );

    if (_hasBadWords == true){
      Formers.focusOnNode(focusNode);
      return '##Company About section should not include bad words';
    }
    else {
      return null;
    }

  }
// -------------------------------
  static String phoneValidator({
    @required BzModel bzModel,
    FocusNode focusNode,
}){

    final String phone = ContactModel.getValueFromContacts(
      contacts: bzModel.contacts,
      contactType: ContactType.phone,
    );

    return Formers.validatePhone(phone);
  }
// ---------------------------------------
  static String emailValidator({
    @required BzModel bzModel,
    FocusNode focusNode,
  }){
    final String email = ContactModel.getValueFromContacts(
      contacts: bzModel.contacts,
      contactType: ContactType.email,
    );

    return Formers.validateEmail(email);
  }
// ---------------------------------------
  static String websiteValidator({
    @required BzModel bzModel,
    FocusNode focusNode,
  }){
    return null; /// TASK : VALIDATE WEBSITE FORMAT
  }
// ---------------------------------------
}
