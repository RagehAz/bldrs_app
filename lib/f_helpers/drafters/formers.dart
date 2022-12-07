import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/c_protocols/zone_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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
    @required BuildContext context,
    @required String email,
    @required bool canValidate,
  }) {
    String _output;

    if (canValidate == true){

      if (TextCheck.isEmpty(email) == true) {
        _output = Verse.transBake(context, 'phid_enterEmail');
      }

      else {

        if (EmailValidator.validate(email) == false){
          _output = Verse.transBake(context, 'phid_emailInvalid');
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String passwordValidator({
    @required BuildContext context,
    @required String password,
    @required bool canValidate,
  }){
    String _output;

    if (canValidate == true){

      if (password.isEmpty == true){
        _output = Verse.transBake(context, 'phid_enterPassword');
      }

      else if (password.length < 6){
        _output = Verse.transBake(context, 'phid_min6CharError');
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
        _output = Verse.transBake(context, 'phid_confirmPassword');
      }

      else if (passwordConfirmation != password){
        _output = Verse.transBake(context, 'phid_passwordMismatch');
      }

      else if (password.length < 6){
        _output = Verse.transBake(context, 'phid_min6CharError');
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GENERAL FIELDS VALIDATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String picValidator({
    @required BuildContext context,
    @required dynamic pic,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){
      if (PicMaker.checkPicIsEmpty(pic) == true){
        _message = Verse.transBake(context, 'phid_add_an_image');
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String personNameValidator({
    @required BuildContext context,
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
        _message =  '${Verse.transBake(context, 'phid_name_should_be_longer_than')}'
                    '${Standards.minUserNameLength} '
                    '${Verse.transBake(context, 'phid_characters')}';
      }
      /// BAD LANG
      else if (_containsBadLang == true){
        _message = Verse.transBake(context, 'phid_name_cannot_contain_bad_words');
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
    @required BuildContext context,
    @required String companyName,
    @required bool canValidate,
    FocusNode focusNode,
  }){
    String _message;

    if (canValidate == true){

      if (TextCheck.isEmpty(companyName) == true){
        _message = Verse.transBake(context, 'phid_enter_business_name');
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

          _message =  '${Verse.transBake(context, 'phid_name_should_be_longer_than')}'
                      '${Standards.minCompanyNameLength} '
                      '${Verse.transBake(context, 'phid_characters')}';

        }
        /// BAD LANG
        else if (_containsBadLang == true){
          _message = Verse.transBake(context, 'phid_name_cannot_contain_bad_words');
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
    @required BuildContext context,
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
        _message =  '${Verse.transBake(context, 'phid_name_should_be_longer_than')}'
                    '${Standards.minJobTitleLength} '
                    '${Verse.transBake(context, 'phid_characters')}';

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
    @required BuildContext context,
    @required ZoneModel zoneModel,
    @required bool selectCountryAndCityOnly,
    @required bool selectCountryIDOnly,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){

      if (zoneModel == null){
        _message = Verse.transBake(context, 'phid_select_a_zone');
      }

      else {

        final String _countryID = zoneModel.countryID;
        final String _cityID = zoneModel.cityID;
        final String _districtID = zoneModel.districtID;

        /// ONLY SELECTING COUNTRY ID
        if (selectCountryIDOnly == true){
          if (_countryID == null){
            _message = Verse.transBake(context, 'phid_select_your_country');
          }
        }

        /// ONLY SELECTING COUNTRY ID + CITY ID
        else if (selectCountryAndCityOnly == true){
          if (_countryID == null || _cityID == null){
            _message = Verse.transBake(context, 'phid_select_country_and_city');
          }
        }

        /// SELECTING ALL IDS (COUNTRY ID + CITY ID + DISTRICT ID)
        else {
          if (_countryID == null || _cityID == null || _districtID == null){
            _message = Verse.transBake(context, 'phid_select_country_city_and_district');
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
    @required BuildContext context,
    @required List<ContactModel> contacts,
    @required ZoneModel zoneModel,
    @required bool canValidate,
    @required bool isRequired,
    FocusNode focusNode,
  }){
    String _message;

    if (canValidate == true){

      final String _phone = ContactModel.getValueFromContacts(
        contacts: contacts,
        contactType: ContactType.phone,
      );

      /// EMPTY
      if (TextCheck.isEmpty(_phone) == true && isRequired == true){
        _message = Verse.transBake(context, 'phid_phone_number_should_not_be_empty');
      }

      if (TextCheck.isEmpty(_phone) == false){

        /// COUNTRY CODE
        if (zoneModel != null && zoneModel.countryID != null){

          final String _code = Flag.getCountryPhoneCode(zoneModel.countryID);
          final bool _startsWithCode = TextCheck.stringStartsExactlyWith(
            text: _phone,
            startsWith: _code,
          );

          if (_startsWithCode == false){
            _message ??=  '${Verse.transBake(context, 'phid_phone_number_in')} '
                          '${zoneModel.countryName} '
                          '${Verse.transBake(context, 'phid_should_start_with')}'
                          '\n( $_code )';
          }

        }

        /// NUMBER FORMAT
        _message ??= numbersOnlyValidator(
          context: context,
          text: TextMod.replaceVarTag(
            input: _phone,
            customTag: '+',
            customValue: '',
          ),
        );

        _message ??= _maxDigitsExceededValidator(
            context: context,
            maxDigits: 0,
            text: _phone,
          );

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
    @required BuildContext context,
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
        context: context,
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
    @required BuildContext context,
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

      _message = webSiteValidator(
        context: context,
        website: _website,
      );

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }

    }

    return _message;
  }
  // --------------------
  /// TASK : TEST ME
  static String paragraphValidator({
    @required BuildContext context,
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
        _message = Verse.transBake(context, 'phid_bad_language_is_not_allowed');
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
    @required BuildContext context,
    @required BzSection selectedSection,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){
      if (selectedSection == null){
        _message = Verse.transBake(context, 'phid_select_the_main_field_of_business');
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String bzTypeValidator({
    @required BuildContext context,
    @required List<BzType> selectedTypes,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){
      if (Mapper.checkCanLoopList(selectedTypes) == false){
        _message = Verse.transBake(context, 'phid_select_at_least_one_bz_type');
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String bzFormValidator({
    @required BuildContext context,
    @required BzForm bzForm,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){
      if (bzForm == null){
        _message = Verse.transBake(context, 'phid_select_company_or_pro');
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String bzAboutValidator({
    @required BuildContext context,
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
        _message = Verse.transBake(context, 'phid_bad_language_is_not_allowed');
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
    @required BuildContext context,
    @required String headline,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){

      final bool _isEmpty = headline.trim() == '';
      final bool _isShort = headline.trim().length < Standards.flyerHeadlineMinLength;

      if (_isEmpty == true){
        _message = Verse.transBake(context, 'phid_flyer_should_have_headline');
      }

      else if (_isShort == true){
        _message = Verse.transBake(context, 'phid_flyer_headline_should_be_more_than_10_chars');
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String slidesValidator({
    @required BuildContext context,
    @required DraftFlyer draftFlyer,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){

      final bool _hasSlides = Mapper.checkCanLoopList(draftFlyer?.draftSlides);

      if (_hasSlides == false){
        _message = Verse.transBake(context, 'phid_flyer_should_have_atleast_one_slide');
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String flyerTypeValidator({
    @required BuildContext context,
    @required DraftFlyer draft,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){

      if (draft?.flyerType == null){
        /// '##Select The flyer type to help people find it'
        _message = Verse.transBake(context, 'phid_select_flyer_type_to_help_classification');
      }

    }

    return _message;
  }
  // --------------------
  /// TASK : TEST ME
  static String pdfValidator({
    @required BuildContext context,
    @required PDFModel pdfModel,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){

      if (pdfModel != null){

        final bool _sizeLimitReached = pdfModel?.checkSizeLimitReached() == true;
        final bool _nameHasBadWord = TextCheck.containsBadWords(text: pdfModel.name);

        if (_sizeLimitReached == true){
          _message =  '${Verse.transBake(context, 'phid_file_size_should_be_less_than')} '
                      '${Standards.maxFileSizeLimit} '
                      '${Verse.transBake(context, 'phid_mb')}';
        }
        else if (_nameHasBadWord == true){
          _message = Verse.transBake(context, 'phid_bad_language_is_not_allowed');
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
    @required BuildContext context,
    @required Gender gender,
    @required bool canValidate,
  }){
    String _message;

    if (canValidate == true){
      if (gender == null){
        _message = Verse.transBake(context, 'phid_select_a_gender');
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

    final String _missingFieldsString = _generateUserMissingFieldsString(
      context: context,
      userModel: userModel,
    );

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(text: 'phid_complete_your_profile', translate: true),
      bodyVerse: Verse(
        text: '${Verse.transBake(context, 'phid_required_fields')}'
              '\n$_missingFieldsString',
        translate: true,
        variables: _missingFieldsString,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUserHasMissingFields({
    @required BuildContext context,
    @required UserModel userModel,
  }){
    bool _thereAreMissingFields;

    final List<String> _missingFields = _generateUserMissingFieldsHeadlines(
      context: context,
      userModel: userModel,
    );

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
  static List<String> _generateUserMissingFieldsHeadlines({
    @required UserModel userModel,
    @required BuildContext context,
  }) {
    final List<String> _missingFields = <String>[];

    /*
    -> NOT required : needs,
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

    if (
    Formers.picValidator(context: context, pic: userModel?.picPath, canValidate: true) != null) {
      _missingFields.add(Verse.transBake(context, 'phid_picture'));
    }

    if (Formers.genderValidator(context: context, gender: userModel?.gender, canValidate: true) != null) {
      _missingFields.add(Verse.transBake(context, 'phid_gender'));
    }

    if (Formers.personNameValidator(context: context, name: userModel?.name, canValidate: true) != null) {
      _missingFields.add(Verse.transBake(context, 'phid_name'));
    }

    if (Formers.jobTitleValidator(context: context, jobTitle: userModel?.title, canValidate: true) != null) {
      _missingFields.add(Verse.transBake(context, 'phid_job_title'));
    }

    if (Formers.companyNameValidator(context: context, companyName: userModel?.company, canValidate: true) != null) {
      _missingFields.add(Verse.transBake(context, 'phid_business_name'));
    }

    if (Formers.zoneValidator(
      context: context,
      zoneModel: userModel?.zone,
      selectCountryAndCityOnly: true,
      selectCountryIDOnly: false,
      canValidate: true,
    ) != null) {
      _missingFields.add(Verse.transBake(context, 'phid_zone'));
    }

    return _missingFields;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _generateUserMissingFieldsString({
    @required BuildContext context,
    @required UserModel userModel,
  }){
    String _output;

    final List<String> _missingFields = _generateUserMissingFieldsHeadlines(
      userModel: userModel,
      context: context,
    );

    if (Mapper.checkCanLoopList(_missingFields) == true){
      _output = Stringer.generateStringFromStrings(
        strings: _missingFields,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// VALIDATION COLORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Color validatorBubbleColor({
    @required String Function() validator,
    Color defaultColor = Colorz.white10,
    bool canErrorize = true,
  }){

    bool _errorIsOn = false;
    Color _errorColor;
    if (validator != null){
      // ------
      /// MESSAGE
      final String _validationMessage = validator();
      // ------
      /// ERROR IS ON
      _errorIsOn = _validationMessage != null;
      // ------
      /// BUBBLE COLOR OVERRIDE
      final bool _colorAssigned = TextCheck.stringContainsSubString(string: _validationMessage, subString: 'Δ');
      if (_colorAssigned == true){
        final String _colorCode = TextMod.removeTextAfterFirstSpecialCharacter(_validationMessage, 'Δ');
        _errorColor = Colorizer.decipherColor(_colorCode);
      }
      // ------
    }

    if (_errorIsOn == true && canErrorize == true){
      return _errorColor ?? Colorz.errorColor;
    }
    else {
      return defaultColor;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Color validatorTextColor({
    @required String message,
  }){
    Color _color;

    if (message != null){

      final bool _colorAssigned = TextCheck.stringContainsSubString(string: message, subString: 'Δ');

      // blog('getValidatorTextColor : _colorAssigned : $_colorAssigned');

      /// SO WHEN ERROR IS ON + BUBBLE HAS COLOR OVERRIDE
      if (_colorAssigned == true){
        _color = Colorz.yellow255;
      }


    }

    return _color;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String colorizeValidatorMessage({
    @required String message,
    @required Color color,
  }){
    final String _errorColor = Colorizer.cipherColor(color);
    return '$_errorColorΔ$message';
  }
  // -----------------------------------------------------------------------------

  /// NUMBERS VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String numberDataCreatorFieldValidator({
    @required BuildContext context,
    @required String text,
    @required PickerModel picker,
    @required DataCreator dataCreatorType,
    @required String selectedUnitID,
  }) {
    String _message;

    /// ONLY NUMBERS VALIDATION
    if (TextCheck.isEmpty(text) == false){
      _message = numbersOnlyValidator(
        context: context,
        text: text,
      );
    }

    /// IF REQUIRED AND EMPTY
    if (picker.isRequired == true){
      if (TextCheck.isEmpty(text) == true){
        _message = Verse.transBake(context, 'phid_this_field_can_not_be_empty');
      }
    }

    /// IF SHOULD HAVE UNIT BUT NOT YET SELECTED
    if (picker.unitChainID != null && selectedUnitID == null){
      _message = Verse.transBake(context, 'phid_should_select_a_measurement_unit');
    }

    /// INT VALIDATION
    final bool _isInt = DataCreation.checkIsIntDataCreator(dataCreatorType);
    if (_isInt == true){

      /// SHOULD NOT INCLUDE FRACTIONS
      final bool _includeDot = TextCheck.stringContainsSubString(string: text, subString: '.');
      if (_includeDot == true){
        _message = Verse.transBake(context, 'phid_num_cant_include_fractions');
      }

    }

    /// DOUBLE VALIDATION
    final bool _isDouble = DataCreation.checkIsDoubleDataCreator(dataCreatorType);
    if (_isDouble){
      // nothing in my mind for you at this point
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String currencyFieldValidator({
    @required BuildContext context,
    @required ValueNotifier<String> selectedCurrencyID, // IS UNIT SPEC VALUE
    @required String text, // IS THE VALUE SPEC VALUE
    @required PickerModel picker,
  }) {
    String _message;

    /// ONLY NUMBERS VALIDATION
    if (TextCheck.isEmpty(text) == false){
      _message = numbersOnlyValidator(
          context: context,
          text: text,
      );
    }

    /// IF REQUIRED AND EMPTY
    if (picker.isRequired == true){
      if (TextCheck.isEmpty(text) == true){
        _message = Verse.transBake(context, 'phid_this_field_can_not_be_empty');
      }
    }

    /// IF CURRENCY NOT YET SELECTED
    if (selectedCurrencyID == null){
      _message = Verse.transBake(context, 'phid_should_select_currency');
    }

    /// IF CURRENCY IS SELECTED
    else {

      final CurrencyModel selectedCurrency = ZoneProvider.proGetCurrencyByCurrencyID(
          context: context,
          currencyID: selectedCurrencyID.value,
          listen: false
      );

      /// IF EXCEEDED CURRENCY DIGITS
      if (selectedCurrency != null){

        final bool _invalidDigits = Numeric.checkNumberAsStringHasInvalidDigits(
          numberAsText: text,
          maxDigits: selectedCurrency.digits,
        );

        if (_invalidDigits == true) {
          _message = Formers._maxDigitsExceededValidator(
            context: context,
            text: text,
            maxDigits: selectedCurrency.digits,
          );
        }

      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _maxDigitsExceededValidator({
    @required BuildContext context,
    @required int maxDigits,
    @required String text,
  }){
    String _message;

    if (TextCheck.isEmpty(text) == false){

      if (maxDigits == 0){

        final bool _hasDigits = TextCheck.stringContainsSubString(
          string: text,
          subString: '.',
        );

        if (_hasDigits == true){
          _message ??= Verse.transBake(context, 'phid_number_cant_have_fractions');
        }

      }

      else {

        final bool _invalidDigits = Numeric.checkNumberAsStringHasInvalidDigits(
          numberAsText: text,
          maxDigits: maxDigits,
        );

        if (_invalidDigits == true){

          _message ??=  '${Verse.transBake(context, 'phid_number_fractions_cant_exceed')} '
                        '$maxDigits '
                        '${Verse.transBake(context, 'phid_fraction_digits')}';

        }

      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String numbersOnlyValidator({
    @required BuildContext context,
    @required String text,
  }){
    String _message;

    if (TextCheck.isEmpty(text) == false){

      /// PARSING VALIDATION
      final double _double = Numeric.transformStringToDouble(text);
      final int _int = Numeric.transformStringToInt(text);
      if (_double == null && _int == null){
        _message = Verse.transBake(context, 'phid_only_numbers_is_to_be_added');
      }

      /// EMPTY SPACES CHECK
      final String _withoutSpaces = TextMod.removeSpacesFromAString(text);
      if (text != _withoutSpaces){
        _message = Verse.transBake(context, 'phid_cant_add_empty_spaces');
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String webSiteValidator({
    @required BuildContext context,
    @required String website,
  }){
    String _message;

    /// WEBSITE HAS VALUE
    if (TextCheck.isEmpty(website) == false){

      if (website != 'https://'){
        final bool _isURLFormat = ObjectCheck.isURLFormat(website) == true;
        if (_isURLFormat == false){
          _message = Verse.transBake(context, 'phid_url_format_is_incorrect');
        }
      }

    }

    /// WEBSITE IS EMPTY
    else {
      _message = Verse.transBake(context, 'phid_this_field_can_not_be_empty');
    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// GEO POINT VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String positionValidator({
    @required BuildContext context,
    @required String latOrLng,
  }){
    String _message;

    if (TextCheck.isEmpty(latOrLng) == false){

      _message = numbersOnlyValidator(
        context: context,
        text: latOrLng,
      );

      if (_message == null){

        final double _double = Numeric.transformStringToDouble(latOrLng);

        if (_double == null){
          _message = Verse.transBake(context, 'phid_only_numbers_is_to_be_added');
        }
        else {

          if (Atlas.checkCoordinateIsGood(_double) == true){
            // nothing in my mind for you at this point
          }
          else {
            _message = Verse.transBake(context, 'phid_coordinate_must_be_between_minus_90_and_90');
          }

        }

      }

    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// BAKING

  // --------------------
  /// TESTED : WORKS PERFECT
  static String bakeValidator({
    @required String Function(String text) validator,
    @required String text,
    bool keepEmbeddedBubbleColor = false,
  }){

    if (validator == null){
      return null;
    }

    else {

      if (keepEmbeddedBubbleColor == true){
        return validator(text);
      }

      else {
        return Formers._bakeValidatorMessage(validator(text));
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _bakeValidatorMessage(String message){
    String _output;

    if (message != null){
      _output = TextMod.removeTextBeforeFirstSpecialCharacter(message, 'Δ');
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
