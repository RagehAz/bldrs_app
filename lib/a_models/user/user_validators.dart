import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

class UserValidators {
// -----------------------------------------------------------------------------

  const UserValidators();

// -----------------------------------------------------------------------------

  /// VALIDATORS

// ---------------------------------------
  static String picValidator(UserModel userModel){

    if (userModel?.pic == null){
      return '## You should add a picture for your self';
    }
    else {
      return null;
    }

  }
// ---------------------------------------
  static String genderValidator(UserModel userModel){
    if (userModel?.gender == null){
      return '## Select a gender';
    }
    else {
      return null;
    }
  }
// -------------------------------
  /// TESTED : WORKS PERFECT
  static String nameValidator({
    @required UserModel userModel,
    FocusNode focusNode,
  }){

    final bool _userNameIsShort = TextCheck.isShorterThan(
      text: userModel?.name?.trim(),
      length: Standards.minUserNameLength,
    );

    // final bool _containsBadLang = TextChecker.containsBadWords(
    //   text: tempUser.value.name,
    // );

    if (_userNameIsShort == true){
      Formers.focusOnNode(focusNode);
      return '##User name should be longer than ${Standards.minUserNameLength} characters';
    }
    // else if (_containsBadLang == true){
    //   return '## User name contains a bad word';
    // }
    else {
      return null;
    }
  }
// -------------------------------
  /// TESTED : WORKS PERFECT
  static String jobTitleValidator({
    @required UserModel userModel,
    FocusNode focusNode,
  }){

    final bool _titleIsShort = TextCheck.isShorterThan(
      text: userModel.title,
      length: Standards.minJobTitleLength,
    );

    if (_titleIsShort == true){
      Formers.focusOnNode(focusNode);
      return '##Job title should not be less than ${Standards.minJobTitleLength} characters';
    }
    else {
      return null;
    }
  }
// -------------------------------
  /// TESTED : WORKS PERFECT
  static String companyNameValidator({
    @required UserModel userModel,
    FocusNode focusNode,
  }){

    final bool _companyNameIsShort = TextCheck.isShorterThan(
      text: userModel.company,
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
// ---------------------------------------
  static String phoneValidator(UserModel userModel){

    final String phone = ContactModel.getValueFromContacts(
        contacts: userModel.contacts,
        contactType: ContactType.phone,
    );

    return Formers.validatePhone(phone);
  }
// ---------------------------------------
  static String emailValidator(UserModel userModel){

    final String email = ContactModel.getValueFromContacts(
      contacts: userModel.contacts,
      contactType: ContactType.email,
    );

    return Formers.validateEmail(email);
  }
// ---------------------------------------
  static String countryValidator(UserModel userModel){

    if (userModel?.zone?.countryID == null){
      return '##Select at which country you are';
    }
    else {
      return null;
    }

  }
// ---------------------------------------
  static String cityValidator(UserModel userModel){

    if (userModel?.zone?.cityID == null){
      return '##Select at which city you are';
    }
    else {
      return null;
    }

  }
// -----------------------------------------------------------------------------

  /// MISSING FIELDS DIALOG

// -------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showMissingFieldsDialog({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    final String _missingFieldsString = _generateMissingFieldsString(userModel);

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse:  'phid_complete_your_profile',
      bodyVerse:  '##Required fields :\n'
          '$_missingFieldsString',
    );

  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkModelHasMissingFields(UserModel userModel){
    bool _thereAreMissingFields;

    final List<String> _missingFields = _generateMissingFieldsHeadlines(userModel);

    if (Mapper.checkCanLoopList(_missingFields) == true){
      _thereAreMissingFields = true;
    }

    else {
      _thereAreMissingFields = false;
    }

    return _thereAreMissingFields;
  }
// -----------------------------------------------------------------------------

  /// GENERATORS

// -------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> _generateMissingFieldsHeadlines(UserModel userModel) {
    final List<String> _missingFields = <String>[];

    /*
    -> NOT required : status,
    -> NOT required : location,
    -> NOT required : contacts,
    -> NOT required : myBzzIDs,
    -> NOT required : savedFlyersIDs,
    -> NOT required : followedBzzIDs,
    ---------------------------------->
    -> generated : id,
    -> generated : authBy,
    -> generated : createdAt,
    -> generated : trigram,
    -> generated : language,
    -> generated : emailIsVerified,
    -> generated : isAdmin,
    -> generated : fcmToken,
    ---------------------------------->
    -> required : name,
    -> required : pic,
    -> required : title,
    -> required : company,
    -> required : gender,
    -> required : zone,
    ---------------------------------->
    */

    if (picValidator(userModel) != null) {
      _missingFields.add('Picture');
    }

    if (genderValidator(userModel) != null) {
      _missingFields.add('Gender');
    }

    if (nameValidator(userModel: userModel) != null) {
      _missingFields.add('phid_name');
    }

    if (jobTitleValidator(userModel: userModel) != null) {
      _missingFields.add('phid_job_title');
    }

    if (companyNameValidator(userModel: userModel) != null) {
      _missingFields.add('phid_company_name');
    }

    if (countryValidator(userModel) != null) {
      _missingFields.add('phid_country');
    }

    if (cityValidator(userModel) != null) {
      _missingFields.add('phid_city');
    }

    return _missingFields;
  }
// -------------------------------
  /// TESTED : WORKS PERFECT
  static String _generateMissingFieldsString(UserModel userModel){
    String _output;

    final List<String> _missingFields = _generateMissingFieldsHeadlines(userModel);

    if (Mapper.checkCanLoopList(_missingFields) == true){
      _output = Stringer.generateStringFromStrings(
        strings: _missingFields,
      );
    }

    return _output;
  }
// -----------------------------------------------------------------------------
}
