import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Formers {
  // -----------------------------------------------------------------------------

  const Formers();

  // -----------------------------------------------------------------------------

  /// FORM VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool validateForm(GlobalKey<FormState> formKey) {
    bool _inputsAreValid = true;

    if (formKey != null){
      _inputsAreValid = formKey.currentState?.validate();
    }

    return _inputsAreValid;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void focusOnNode(FocusNode node){

    if (node != null){
      if (node.hasFocus == false){
        node.requestFocus();
      }
    }

  }
  // -----------------------------------------------------------------------------

  /// AUTH VALIDATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String emailValidator({
    @required String email,
    @required bool canValidate,
  }) {
    String _output;

    if (canValidate == true){

      if (TextCheck.isEmpty(email) == true) {
        _output = 'phid_enterEmail';
      }

      else {

        if (EmailValidator.validate(email) == false){
          _output = 'phid_emailInvalid';
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String passwordValidator({
    @required String password,
    @required bool canValidate,
  }){
    String _output;

    if (canValidate == true){

      if (password.isEmpty == true){
        _output = 'phid_enterPassword';
      }

      else if (password.length < 6){
        _output = 'phid_min6CharError';
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String passwordConfirmationValidation({
    @required BuildContext context,
    @required String password,
    @required String passwordConfirmation,
    @required bool canValidate,
  }){
    String _output;

    if (canValidate == true){
      if (passwordConfirmation.isEmpty || password.isEmpty){
        _output = 'phid_confirmPassword';
      }

      else if (passwordConfirmation != password){
        _output = 'phid_passwordMismatch';
      }

      else if (password.length < 6){
        _output = 'phid_min6CharError';
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GENERAL FIELDS VALIDATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String picValidator({
    @required dynamic pic,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){
      if (Imagers.checkPicIsEmpty(pic) == true){
        _message = '##Add an Image';
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String personNameValidator({
    @required String name,
    @required bool canValidate,
    FocusNode focusNode,
  }){
    String _message;

    if (canValidate == true){
      final bool _userNameIsShort = TextCheck.isShorterThan(
        text: name?.trim(),
        length: Standards.minUserNameLength,
      );
      final bool _containsBadLang = TextCheck.containsBadWords(
        text: name,
      );

      /// SHORT NAME
      if (_userNameIsShort == true){
        _message = '##Name should be longer than ${Standards.minUserNameLength} characters';
      }
      /// BAD LANG
      else if (_containsBadLang == true){
        _message = '## Name can not contain bad words';
      }

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String companyNameValidator({
    @required String companyName,
    @required bool canValidate,
    FocusNode focusNode,
  }){
    String _message;

    if (canValidate == true){

      if (TextCheck.isEmpty(companyName) == true){
        _message = '##Add company name';
      }

      else {

        final bool _companyNameIsShort = TextCheck.isShorterThan(
          text: companyName,
          length: Standards.minCompanyNameLength,
        );
        final bool _containsBadLang = TextCheck.containsBadWords(
          text: companyName,
        );

        /// SHORT NAME
        if (_companyNameIsShort == true){
          _message = '##Company Name should not be less than ${Standards.minCompanyNameLength} characters';
        }
        /// BAD LANG
        else if (_containsBadLang == true){
          _message = '##Company name can not contain bad words';
        }

      }

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String jobTitleValidator({
    @required String jobTitle,
    @required bool canValidate,
    FocusNode focusNode,
  }){
    String _message;

    if (canValidate == true){

      final bool _titleIsShort = TextCheck.isShorterThan(
        text: jobTitle,
        length: Standards.minJobTitleLength,
      );

      if (_titleIsShort == true){
        _message = '##Job title should not be less than ${Standards.minJobTitleLength} characters';
      }

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }

    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// ZONE VALIDATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String zoneValidator({
    @required ZoneModel zoneModel,
    @required bool selectCountryAndCityOnly,
    @required bool selectCountryIDOnly,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){

      if (zoneModel == null){
        _message = 'phid_select_a_zone';
      }

      else {

        final String _countryID = zoneModel.countryID;
        final String _cityID = zoneModel.cityID;
        final String _districtID = zoneModel.districtID;

        /// ONLY SELECTING COUNTRY ID
        if (selectCountryIDOnly == true){
          if (_countryID == null){
            _message = '##Select at which country you are';
          }
        }

        /// ONLY SELECTING COUNTRY ID + CITY ID
        else if (selectCountryAndCityOnly == true){
          if (_countryID == null || _cityID == null){
            _message = 'phid_select_country_and_city';
          }
        }

        /// SELECTING ALL IDS (COUNTRY ID + CITY ID + DISTRICT ID)
        else {
          if (_countryID == null || _cityID == null || _districtID == null){
            _message = 'phid_select_country_city_and_district';
          }
        }

      }

    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// CONTACTS VALIDATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String contactsPhoneValidator({
    @required List<ContactModel> contacts,
    @required ZoneModel zoneModel,
    @required bool canValidate,
    FocusNode focusNode,
  }){
    String _message;

    if (canValidate == true){
      final String _phone = ContactModel.getValueFromContacts(
        contacts: contacts,
        contactType: ContactType.phone,
      );

      if (TextCheck.isEmpty(_phone) == true){
        _message = '##Phone number should not be empty';
      }
      else {

        if (zoneModel != null && zoneModel.countryID != null){

          final String _code = CountryModel.getCountryPhoneCode(zoneModel.countryID);
          final bool _startsWithCode = TextCheck.textStartsExactlyWith(
            text: _phone,
            startsWith: _code,
          );

          if (_startsWithCode == false){
            _message = '##Phone numbers in ${zoneModel.countryName} should start with\n( $_code )';
          }

        }

      }

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String contactsEmailValidator({
    @required List<ContactModel> contacts,
    @required bool canValidate,
    FocusNode focusNode,
  }){
    String _message;

    if (canValidate == true){

      final String _email = ContactModel.getValueFromContacts(
        contacts: contacts,
        contactType: ContactType.email,
      );

      _message = emailValidator(
        email: _email,
        canValidate: canValidate,
      );

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String contactsWebsiteValidator({
    @required List<ContactModel> contacts,
    @required bool canValidate,
    FocusNode focusNode,
  }){
    String _message;

    if (canValidate == true){

      final String _website = ContactModel.getValueFromContacts(
        contacts: contacts,
        contactType: ContactType.website,
      );

      if (TextCheck.isEmpty(_website) == false){

        if (_website != 'https://'){

          final bool _isURLFormat = ObjectCheck.isURLFormat(_website) == true;

          if (_isURLFormat == false){
            _message = 'phid_url_format_is_incorrect';
          }

        }

      }

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }

    }

    return _message;
  }
  // --------------------
  ///
  static String paragraphValidator({
    @required String text,
    @required bool canValidate,
    FocusNode focusNode,
  }){
    String _message;

    if (canValidate == true){

      final bool _containsBadLang = TextCheck.containsBadWords(
        text: text,
      );

      /// BAD LANG
      if (_containsBadLang == true){
        _message = '##A bad word has been detected';
      }

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }

    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// BZ VALIDATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String bzSectionValidator({
    @required BzSection selectedSection,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){
      if (selectedSection == null){
        _message = '#Select One Field of business';
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String bzTypeValidator({
    @required List<BzType> selectedTypes,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){
      if (Mapper.checkCanLoopList(selectedTypes) == false){
        _message = '#Select at least one Business type';
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String bzFormValidator({
    @required BzForm bzForm,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){
      if (bzForm == null){
        _message = '#Select either the business represents and individual profession or a whole company';
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String bzAboutValidator({
    @required String bzAbout,
    @required bool canValidate,
    FocusNode focusNode,
  }){
    String _message;

    if (canValidate == true){

      final bool _hasBadWords = TextCheck.containsBadWords(
        text: bzAbout,
      );

      if (_hasBadWords == true){
        _message = '##Company About section should not include bad words';
      }

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }

    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// FLYER VALIDATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String flyerHeadlineValidator({
    @required String headline,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){

      final bool _isEmpty = headline.trim() == '';
      final bool _isShort = headline.trim().length < Standards.flyerHeadlineMinLength;

      if (_isEmpty == true){
        _message = "Can not publish a flyer without a title as it's used in the search engine";
      }

      else if (_isShort == true){
        _message = 'Flyer title can not be less than 10 characters';
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String slidesValidator({
    @required DraftFlyerModel draft,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){

      final bool _hasSlides = Mapper.checkCanLoopList(draft?.mutableSlides);

      if (_hasSlides == false){
        _message = 'phid_flyer_should_have_atleast_one_slide';
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String flyerTypeValidator({
    @required DraftFlyerModel draft,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){

      if (draft?.flyerType == null){
        _message = '##Select The flyer type to help people find it';
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String pdfValidator({
    @required FileModel fileModel,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){

      if (fileModel != null){

        final bool _sizeLimitReached = fileModel?.checkSizeLimitReached() == true;
        final bool _nameHasBadWord = TextCheck.containsBadWords(text: fileModel.fileName);

        if (_sizeLimitReached == true){
          _message = '## PDF file size should be less than ${Standards.maxFileSizeLimit} Mb';
        }
        else if (_nameHasBadWord == true){
          _message = '## File name should not include a bad word';
        }

      }

    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// USER VALIDATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String genderValidator({
    @required UserModel userModel,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){
      if (userModel?.gender == null){
        _message = '## Select a gender';
      }
    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// USER MISSING FIELDS CHECK UPS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showUserMissingFieldsDialog({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    final String _missingFieldsString = _generateUserMissingFieldsString(userModel);

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse:  'phid_complete_your_profile',
      bodyVerse:  '##Required fields :\n'
          '$_missingFieldsString',
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUserHasMissingFields(UserModel userModel){
    bool _thereAreMissingFields;

    final List<String> _missingFields = _generateUserMissingFieldsHeadlines(userModel);

    if (Mapper.checkCanLoopList(_missingFields) == true){
      _thereAreMissingFields = true;
    }

    else {
      _thereAreMissingFields = false;
    }

    return _thereAreMissingFields;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> _generateUserMissingFieldsHeadlines(UserModel userModel) {
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

    if (Formers.picValidator(pic: userModel?.pic, canValidate: true) != null) {
      _missingFields.add('Picture');
    }

    if (Formers.genderValidator(userModel: userModel, canValidate: true) != null) {
      _missingFields.add('Gender');
    }

    if (Formers.personNameValidator(name: userModel?.name, canValidate: true) != null) {
      _missingFields.add('phid_name');
    }

    if (Formers.jobTitleValidator(jobTitle: userModel?.title, canValidate: true) != null) {
      _missingFields.add('phid_job_title');
    }

    if (Formers.companyNameValidator(companyName: userModel?.company, canValidate: true) != null) {
      _missingFields.add('phid_company_name');
    }

    if (Formers.zoneValidator(
      zoneModel: userModel?.zone,
      selectCountryAndCityOnly: true,
      selectCountryIDOnly: false,
      canValidate: true,
    ) != null) {
      _missingFields.add('phid_zone');
    }

    return _missingFields;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _generateUserMissingFieldsString(UserModel userModel){
    String _output;

    final List<String> _missingFields = _generateUserMissingFieldsHeadlines(userModel);

    if (Mapper.checkCanLoopList(_missingFields) == true){
      _output = Stringer.generateStringFromStrings(
        strings: _missingFields,
      );
    }

    return _output;
  }
// -----------------------------------------------------------------------------
}
