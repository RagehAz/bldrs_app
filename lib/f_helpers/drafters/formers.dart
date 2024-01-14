// ignore_for_file: avoid_catches_without_on_clauses
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/colors/colorizer.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/space/atlas.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/models/flag_model.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class Formers {
  // -----------------------------------------------------------------------------

  const Formers();

  // -----------------------------------------------------------------------------

  /// FORM VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool validateForm(GlobalKey<FormState>? formKey) {
    bool _inputsAreValid = true;

    if (formKey != null){
      _inputsAreValid = formKey.currentState?.validate() ?? false;
    }

    return _inputsAreValid;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void focusOnNode(FocusNode? node){

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
  static String? emailValidator({
    required String? email,
    required bool? canValidate,
    String? enterEmailWord,
    String? emailInvalidWord,
  }) {
    String? _output;

    if (Mapper.boolIsTrue(canValidate) == true){

      if (TextCheck.isEmpty(email) == true) {
        _output = enterEmailWord?? getWord('phid_enterEmail');
      }

      else {

        if (EmailValidator.validate(email!) == false){
          _output = emailInvalidWord ?? getWord('phid_emailInvalid');
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? passwordValidator({
    required String password,
    required bool canValidate,
    String? enterPassword,
    String? min6Chars,
  }){
    String? _output;

    if (canValidate == true){

      if (password.isEmpty == true){
        _output = enterPassword ?? getWord('phid_enterPassword');
      }

      else if (password.length < 6){
        _output = min6Chars ?? getWord('phid_min6CharError');
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? passwordConfirmationValidation({
    required String password,
    required String passwordConfirmation,
    required bool canValidate,
  }){
    String? _output;

    if (canValidate == true){
      if (passwordConfirmation.isEmpty || password.isEmpty){
        _output = getWord('phid_confirmPassword');
      }

      else if (passwordConfirmation != password){
        _output = getWord('phid_passwordMismatch');
      }

      else if (password.length < 6){
        _output = getWord('phid_min6CharError');
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PIC VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? picValidator({
    required dynamic pic,
    required bool? canValidate,
  }){
    String? _message;

    if (Mapper.boolIsTrue(canValidate) == true){

      if (pic != null && pic is PicModel){

        final PicModel _picModel = pic;
        if (Mapper.boolIsTrue(_picModel.bytes?.isEmpty) == true && _picModel.path == null){
          _message = getWord('phid_add_an_image');
        }

      }

      else if (PicMaker.checkPicIsEmpty(pic) == true){
        _message = getWord('phid_add_an_image');
      }

    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// TEXT VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? personNameValidator({
    required String? name,
    required bool canValidate,
    FocusNode? focusNode,
  }){
    String? _message;

    if (canValidate == true){
      final bool _userNameIsShort = TextCheck.isShorterThan(
        text: name?.trim(),
        length: Standards.minUserNameLength,
      );
      final bool _containsBadLang = TextCheck.containsBadWords(
        text: name,
        badWords: badWords,
      );

      /// SHORT NAME
      if (_userNameIsShort == true){
        _message =  '${getWord('phid_name_should_be_longer_than')}'
                    '${Standards.minUserNameLength} '
                    '${getWord('phid_characters')}';
      }
      /// BAD LANG
      else if (_containsBadLang == true){
        _message = getWord('phid_name_cannot_contain_bad_words');
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
  static String? companyNameValidator({
    required String? companyName,
    required bool? canValidate,
    FocusNode? focusNode,
  }){
    String? _message;

    if (Mapper.boolIsTrue(canValidate) == true){

      if (TextCheck.isEmpty(companyName) == true){
        _message = getWord('phid_enter_business_name');
      }

      else {

        final bool _companyNameIsShort = TextCheck.isShorterThan(
          text: companyName,
          length: Standards.minCompanyNameLength,
        );
        final bool _containsBadLang = TextCheck.containsBadWords(
          text: companyName,
          badWords: badWords,
        );

        /// SHORT NAME
        if (_companyNameIsShort == true){

          _message =  '${getWord('phid_name_should_be_longer_than')} '
                      '${Standards.minCompanyNameLength} '
                      '${getWord('phid_characters')}';

        }
        /// BAD LANG
        else if (_containsBadLang == true){
          _message = getWord('phid_name_cannot_contain_bad_words');
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
  static String? jobTitleValidator({
    required String? jobTitle,
    required bool canValidate,
    FocusNode? focusNode,
  }){
    String? _message;

    if (canValidate == true){

      final bool _titleIsShort = TextCheck.isShorterThan(
        text: jobTitle,
        length: Standards.minJobTitleLength,
      );

      if (_titleIsShort == true){
        _message =  '${getWord('phid_name_should_be_longer_than')} '
                    '${Standards.minJobTitleLength} '
                    '${getWord('phid_characters')}';

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
  static String? paragraphValidator({
    required String? text,
    required bool canValidate,
    FocusNode? focusNode,
  }){
    String? _message;

    if (canValidate == true){

      final bool _containsBadLang = TextCheck.containsBadWords(
        text: text,
        badWords: badWords,
      );

      /// BAD LANG
      if (_containsBadLang == true){
        _message = getWord('phid_bad_language_is_not_allowed');
      }

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }

    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// GENDER VALIDATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? genderValidator({
    required Gender? gender,
    required bool canValidate,
  }){
    String? _message;

    if (canValidate == true){
      if (gender == null){
        _message = getWord('phid_select_a_gender');
      }
    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// ZONE VALIDATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? zoneValidator({
    required ZoneModel? zoneModel,
    required bool selectCountryIDOnly,
    required bool? canValidate,
  }){
    String? _message;

    if (Mapper.boolIsTrue(canValidate) == true){

      if (zoneModel == null){
        _message = getWord('phid_select_a_zone');
      }

      else {

        final String? _countryID = zoneModel.countryID;
        final String? _cityID = zoneModel.cityID;

        /// ONLY SELECTING COUNTRY ID
        if (selectCountryIDOnly == true){
          if (_countryID == null){
            _message = getWord('phid_select_your_country');
          }
        }

        /// ONLY SELECTING COUNTRY ID + CITY ID
        else {
          if (_countryID == null || _cityID == null || _cityID == Flag.allCitiesID){
            _message = getWord('phid_select_country_and_city');
          }
        }

      }

    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// CONTACTS VALIDATORS

  // --------------------
  /// DEPRECATED
  /*
  static String? contactsPhoneValidator({
    required List<ContactModel>? contacts,
    required ZoneModel? zoneModel,
    required bool? canValidate,
    required bool isMandatory,
    FocusNode? focusNode,
  }){
    String? _message;

    if (Mapper.boolIsTrue(canValidate) == true){

      final String? _phone = ContactModel.getValueFromContacts(
        contacts: contacts,
        contactType: ContactType.phone,
      );

      _message = phoneValidator(
        phone: _phone,
        zoneModel: zoneModel,
        canValidate: canValidate,
        isMandatory: isMandatory,
      );

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }

    }

    return _message;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? phoneValidator({
    required String? phone,
    required ZoneModel? zoneModel,
    required bool? canValidate,
    required bool isMandatory,
  }){
    String? _message;

    /// EMPTY
    if (TextCheck.isEmpty(phone) == true && isMandatory == true){
      _message = getWord('phid_phone_number_should_not_be_empty');
    }

    if (TextCheck.isEmpty(phone) == false){

      /// COUNTRY CODE
      if (zoneModel != null){

        final String? _code = Flag.getCountryPhoneCode(zoneModel.countryID);
        final bool _startsWithCode = TextCheck.stringStartsExactlyWith(
          text: phone,
          startsWith: _code,
        );

        if (_startsWithCode == false){
          _message ??=  '${getWord('phid_phone_number_in')} '
              '${zoneModel.countryName} '
              '${getWord('phid_should_start_with')}'
              '\n( $_code )';
        }

      }

      /// NUMBER FORMAT
      _message ??= numbersOnlyValidator(
        text: TextMod.replaceVarTag(
          input: phone,
          customTag: '+',
          customValue: '',
        ),
      );

      _message ??= _maxDigitsExceededValidator(
        maxDigits: 0,
        text: phone,
      );

    }

    // blog('phoneValidator phone : _message : $_message');

    return _message;
  }
  // --------------------
  /// DEPRECATED
  /*
  static String? contactsEmailValidator({
    required List<ContactModel>? contacts,
    required bool? canValidate,
    FocusNode? focusNode,
  }){
    String? _message;

    if (Mapper.boolIsTrue(canValidate) == true){

      final String? _email = ContactModel.getValueFromContacts(
        contacts: contacts,
        contactType: ContactType.email,
      );

      _message = emailValidator(
        email: _email,
        canValidate: canValidate,
        invoker: 'contactsEmailValidator',
      );

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }

    }

    return _message;
  }
   */
  // --------------------
  /// DEPRECATED
  /*
  static String? contactsWebsiteValidator({
    required List<ContactModel>? contacts,
    required bool? canValidate,
    required bool isMandatory,
    FocusNode? focusNode,
  }){
    String? _message;

    if (Mapper.boolIsTrue(canValidate) == true){

      final String? _website = ContactModel.getValueFromContacts(
        contacts: contacts,
        contactType: ContactType.website,
      );

      _message = webSiteValidator(
        website: _website,
        isMandatory: isMandatory,
      );

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }

    }

    return _message;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? webSiteValidator({
    required String? website,
    required bool isMandatory,
    List<String>? excludedDomains,
  }){
    String? _message;

    /// WEBSITE HAS VALUE
    if (TextCheck.isEmpty(website) == false){

      if (website != 'https://'){
        final bool _isURLFormat = ObjectCheck.isURLFormat(website) == true;
        if (_isURLFormat == false){
          _message = getWord('phid_url_format_is_incorrect');
        }

        if (_message == null){

          final bool _domainExcluded = TextCheck.checkStringContainAnyOfSubStrings(
            subStrings: excludedDomains,
            string: website,
          );

          if (_domainExcluded == true){
          _message = getWord('phid_can_not_use_this_link_here');
          }

        }

      }

    }

    /// WEBSITE IS EMPTY
    else if (isMandatory == true){
      _message = getWord('phid_this_field_can_not_be_empty');
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? socialLinkValidator({
    required String? url,
    required ContactType? contactType,
    required bool isMandatory,
  }){

    String? _message = webSiteValidator(
      website: url,
      isMandatory: isMandatory,
    );

    if (
        _message == null
        &&
        TextCheck.isEmpty(url) == false
        &&
        url != 'https://'
    ){

      final bool _isValid = ContactModel.checkSocialLinkIsValid(
          url: url,
          type: contactType,
      );

      if (_isValid == false){

        final String? _phid = ContactModel.getSocialContactIsNotValidPhid(
          type: contactType,
        );

        if (_phid != null){
          _message = getWord(_phid);
        }

      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool contactsAreValid({
    required List<ContactModel>? contacts,
    required ZoneModel? zoneModel,
    required bool phoneIsMandatory,
    required bool websiteIsMandatory,
  }){
    bool _valid = true;

    if (Lister.checkCanLoop(contacts) == true){

      String? _message;
      for (final ContactModel _contact in contacts!){

        /// PHONE
        if (_contact.type == ContactType.phone){
          _message = phoneValidator(
            phone: _contact.value,
            zoneModel: zoneModel,
            canValidate: true,
            isMandatory: phoneIsMandatory,
          );
        }
        /// EMAIL
        else if (_contact.type == ContactType.email){
          _message = emailValidator(
            email: _contact.value,
            canValidate: true,
          );
        }
        /// WEBSITE
        else if (_contact.type == ContactType.website){
          _message = webSiteValidator(
            website: _contact.value,
            isMandatory: websiteIsMandatory,
          );
        }
        /// SOCIAL MEDIA
        else if (ContactModel.checkContactIsSocialMedia(_contact.type) == true){
          _message = socialLinkValidator(
            url: _contact.value,
            contactType: _contact.type,
            isMandatory: false,
          );
          // blog('socialLinkValidator _message : $_message');
        }

        if (_message != null){
          _valid = false;
          break;
        }

      }

    }

    return _valid;
  }
  // -----------------------------------------------------------------------------

  /// BZ VALIDATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? bzSectionValidator({
    required BzSection? selectedSection,
    required bool? canValidate,
  }){
    String? _message;

    if (Mapper.boolIsTrue(canValidate) == true){
      if (selectedSection == null){
        _message = getWord('phid_select_the_main_field_of_business');
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? bzTypeValidator({
    required List<BzType>? selectedTypes,
    required bool? canValidate,
  }){
    String? _message;

    if (Mapper.boolIsTrue(canValidate) == true){
      if (Lister.checkCanLoop(selectedTypes) == false){
        _message = getWord('phid_select_at_least_one_bz_type');
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? bzFormValidator({
    required BzForm? bzForm,
    required bool? canValidate,
  }){
    String? _message;

    if (Mapper.boolIsTrue(canValidate) == true){
      if (bzForm == null){
        _message = getWord('phid_select_company_or_pro');
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? bzAboutValidator({
    required String? bzAbout,
    required bool? canValidate,
    FocusNode? focusNode,
  }){
    String? _message;

    if (Mapper.boolIsTrue(canValidate) == true){

      final bool _hasBadWords = TextCheck.containsBadWords(
        text: bzAbout,
        badWords: badWords,
      );

      if (_hasBadWords == true){
        _message = getWord('phid_bad_language_is_not_allowed');
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
  static String? bzScopeValidator({
    required List<String> scope,
    required bool canValidate,
    FocusNode? focusNode,
  }){
    String? _message;

    if (canValidate == true){
      if (Lister.checkCanLoop(scope) == false){
        _message = getWord('phid_select_bz_scope_to_describe');
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
  static String? flyerHeadlineValidator({
    required String? headline,
    required bool canValidate,
  }){
    String? _message;

    if (canValidate == true){

      final bool _isEmpty = headline?.trim() == '';
      final bool _isShort = (headline?.trim().length ?? 0) < Standards.flyerHeadlineMinLength;

      if (_isEmpty == true){
        _message = getWord('phid_flyer_should_have_headline');
      }

      else if (_isShort == true){
        _message = getWord('phid_flyer_headline_should_be_more_than_5_chars');
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? slidesValidator({
    required DraftFlyer? draftFlyer,
    required bool canValidate,
  }){
    String? _message;

    if (canValidate == true){

      final bool _hasSlides = Lister.checkCanLoop(draftFlyer?.draftSlides);

      if (_hasSlides == false){
        _message = getWord('phid_flyer_should_have_atleast_one_slide');
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? flyerTypeValidator({
    required DraftFlyer? draft,
    required bool canValidate,
  }){
    String? _message;

    if (canValidate == true){

      if (draft?.flyerType == null){
        _message = getWord('phid_select_flyer_type_to_help_classification');
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? pdfValidator({
    required PDFModel? pdfModel,
    required bool canValidate,
  }){
    String? _message;

    if (canValidate == true){

      if (pdfModel != null){

        final bool _sizeLimitReached = Mapper.boolIsTrue(pdfModel.checkSizeLimitReached()) == true;

        if (_sizeLimitReached == true){

          // _message =  '${getWord('phid_file_size_should_be_less_than')} '
          //             '${Standards.maxFileSizeLimit} '
          //             '${getWord('phid_mb')}';

          _message = PDFModel.getSizeLine(
            size: pdfModel.sizeMB,
            maxSize: Standards.maxFileSizeLimit,
            sizeLimitReached: _sizeLimitReached,
          ).id;

        }

        else {
          _message = pdfNameValidator(
            canValidate: canValidate,
            pdfModel: pdfModel,
          );
        }

      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? pdfNameValidator({
    required PDFModel? pdfModel,
    required bool canValidate,
  }){
    String? _message;

    if (canValidate == true && pdfModel != null){

      final bool _hasExtension = TextCheck.stringContainsSubString(
        string: pdfModel.name,
        subString: '.pdf',
      );
      final bool _hasDot = TextCheck.stringContainsSubString(
        string: pdfModel.name,
        subString: '.',
      );
      final bool _nameHasBadWord = TextCheck.containsBadWords(
        text: pdfModel.name,
        badWords: badWords,
      );

      if (_hasExtension == true){
        _message =  '${getWord('phid_file_name_should_not_include_extension')}\n'
            '${getWord('phid_remove_dot_pdf')}';
      }

      else if (_hasDot == true) {
        _message =  getWord('phid_file_name_should_have_no_dots');
      }

      else if (_nameHasBadWord == true){
        _message = getWord('phid_bad_language_is_not_allowed');
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? flyerPhidsValidator({
    required bool canValidate,
    required FlyerType? flyerType,
    required List<String>? phids,
    FocusNode? focusNode,
  }){
    String? _message;

    if (canValidate == true){

      if (flyerType == null){
        _message = getWord('phid_select_flyer_type_first');
      }
      else if (Lister.checkCanLoop(phids) == false){
        _message = getWord('phid_select_flyer_phids_to_filter');
      }

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }

    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// USER MISSING FIELDS CHECK UPS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showUserMissingFieldsDialog({
    required UserModel userModel,
  }) async {

    final String? _missingFieldsString = _generateUserMissingFieldsString(
      userModel: userModel,
    );

    await BldrsCenterDialog.showCenterDialog(
      titleVerse: const Verse(id: 'phid_complete_your_profile', translate: true),
      bodyVerse: Verse(
        id: '${getWord('phid_required_fields')}'
              '\n$_missingFieldsString',
        translate: false,
        variables: _missingFieldsString,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUserHasMissingFields({
    required UserModel? userModel,
  }){
    bool _thereAreMissingFields;

    final List<String> _missingFields = _generateUserMissingFieldsHeadlines(
      userModel: userModel,
    );

    if (Lister.checkCanLoop(_missingFields) == true){
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
    required UserModel? userModel,
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
    Formers.picValidator(pic: userModel?.picPath, canValidate: true) != null) {
      _missingFields.add(getWord('phid_picture'));
    }

    if (Formers.genderValidator(gender: userModel?.gender, canValidate: true) != null) {
      _missingFields.add(getWord('phid_gender'));
    }

    if (Formers.personNameValidator(name: userModel?.name, canValidate: true) != null) {
      _missingFields.add(getWord('phid_name'));
    }

    if (Formers.jobTitleValidator(jobTitle: userModel?.title, canValidate: true) != null) {
      _missingFields.add(getWord('phid_job_title'));
    }

    if (Formers.companyNameValidator(companyName: userModel?.company, canValidate: true) != null) {
      _missingFields.add(getWord('phid_business_name'));
    }

    if (Formers.zoneValidator(
      zoneModel: userModel?.zone,
      selectCountryIDOnly: false,
      canValidate: true,
    ) != null) {
      _missingFields.add(getWord('phid_zone'));
    }

    return _missingFields;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? _generateUserMissingFieldsString({
    required UserModel? userModel,
  }){
    String? _output;

    final List<String> _missingFields = _generateUserMissingFieldsHeadlines(
      userModel: userModel,
    );

    if (Lister.checkCanLoop(_missingFields) == true){
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
    required String? Function()? validator,
    Color defaultColor = Colorz.white10,
    bool canErrorize = true,
  }){

    bool _errorIsOn = false;
    Color? _errorColor;
    if (validator != null){
      // ------
      /// MESSAGE
      final String? _validationMessage = validator();
      // ------
      /// ERROR IS ON
      _errorIsOn = _validationMessage != null;
      // ------
      /// BUBBLE COLOR OVERRIDE
      final bool _colorAssigned = TextCheck.stringContainsSubString(string: _validationMessage, subString: 'Δ');
      if (_colorAssigned == true){
        final String? _colorCode = TextMod.removeTextAfterFirstSpecialCharacter(
            text: _validationMessage,
            specialCharacter: 'Δ',
        );
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
  static Color? validatorTextColor({
    required String? message,
  }){
    Color? _color;

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
    required String message,
    required Color color,
  }){
    final String? _errorColor = Colorizer.cipherColor(color);
    return '$_errorColorΔ$message';
  }
  // -----------------------------------------------------------------------------

  /// NUMBERS VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? numberDataCreatorFieldValidator({
    required String? text,
    required PickerModel? picker,
    required DataCreator? dataCreatorType,
    required String? selectedUnitID,
  }) {
    String? _message;

    /// ONLY NUMBERS VALIDATION
    if (TextCheck.isEmpty(text) == false){
      _message = numbersOnlyValidator(
        text: text,
      );
    }

    /// IF REQUIRED AND EMPTY
    if (Mapper.boolIsTrue(picker?.isRequired) == true){
      if (TextCheck.isEmpty(text) == true){
        _message = getWord('phid_this_field_can_not_be_empty');
      }
    }

    /// IF SHOULD HAVE UNIT BUT NOT YET SELECTED
    if (picker?.unitChainID != null && selectedUnitID == null){
      _message = getWord('phid_should_select_a_measurement_unit');
    }

    /// INT VALIDATION
    final bool _isInt = DataCreation.checkIsIntDataCreator(dataCreatorType);
    if (_isInt == true){

      /// SHOULD NOT INCLUDE FRACTIONS
      final bool _includeDot = TextCheck.stringContainsSubString(string: text, subString: '.');
      if (_includeDot == true){
        _message = getWord('phid_num_cant_include_fractions');
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
  static String? currencyFieldValidator({
    required String? selectedCurrencyID, // IS UNIT SPEC VALUE
    required String? text, // IS THE VALUE SPEC VALUE
    required bool? isRequired,
  }) {
    String? _message;

    /// ONLY NUMBERS VALIDATION
    if (TextCheck.isEmpty(text) == false){
      _message = numbersOnlyValidator(
          text: text,
      );
    }

    /// IF REQUIRED AND EMPTY
    if (Mapper.boolIsTrue(isRequired) == true){
      if (TextCheck.isEmpty(text) == true){
        _message = getWord('phid_this_field_can_not_be_empty');
      }
    }

    /// IF CURRENCY NOT YET SELECTED
    if (selectedCurrencyID == null){
      _message = getWord('phid_should_select_currency');
    }

    /// IF CURRENCY IS SELECTED
    else {

      final CurrencyModel? selectedCurrency = ZoneProvider.proGetCurrencyByCurrencyID(
        context: getMainContext(),
        currencyID: selectedCurrencyID,
        listen: false,
      );

      /// IF EXCEEDED CURRENCY DIGITS
      if (selectedCurrency != null){

        final bool _invalidDigits = Numeric.checkNumberAsStringHasMoreThanMaxDigits(
          numberAsText: text,
          maxDigits: selectedCurrency.digits,
        );

        if (_invalidDigits == true) {
          _message = _maxDigitsExceededValidator(
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
  static String? _maxDigitsExceededValidator({
    required int? maxDigits,
    required String? text,
  }){
    String? _message;

    if (TextCheck.isEmpty(text) == false){

      if (maxDigits == 0){

        final bool _hasDigits = TextCheck.stringContainsSubString(
          string: text,
          subString: '.',
        );

        if (_hasDigits == true){
          _message ??= getWord('phid_number_cant_have_fractions');
        }

      }

      else {

        final bool _invalidDigits = Numeric.checkNumberAsStringHasMoreThanMaxDigits(
          numberAsText: text,
          maxDigits: maxDigits,
        );

        if (_invalidDigits == true) {

          _message ??=  '${getWord('phid_number_fractions_cant_exceed')} '
                        '$maxDigits '
                        '${getWord('phid_fraction_digits')}';

        }

      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? numbersOnlyValidator({
    required String? text,
  }){
    String? _message;

    if (TextCheck.isEmpty(text) == false){

      /// PARSING VALIDATION
      final double? _double = Numeric.transformStringToDouble(text);
      final int? _int = Numeric.transformStringToInt(text);
      if (_double == null && _int == null){
        _message = getWord('phid_only_numbers_is_to_be_added');
      }

      /// EMPTY SPACES CHECK
      final String? _withoutSpaces = TextMod.removeSpacesFromAString(text);
      if (text != _withoutSpaces){
        _message = getWord('phid_cant_add_empty_spaces');
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? intOnlyValidator({
    required String? text,
  }){
    String? _message;

    if (TextCheck.isEmpty(text) == false){

      /// PARSING VALIDATION
      final double? _double = Numeric.transformStringToDouble(text);
      final int? _int = Numeric.transformStringToInt(text);
      final bool _hasDot = TextCheck.stringContainsSubString(
          string: text,
          subString: '.',
      );
      if (_hasDot == true || _int == null || (_double != _int)){
        _message = getWord('phid_integers_is_to_be_added');
      }

      /// EMPTY SPACES CHECK
      final String? _withoutSpaces = TextMod.removeSpacesFromAString(text);
      if (text != _withoutSpaces){
        _message = getWord('phid_cant_add_empty_spaces');
      }

    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// STRING ONLY VALIDATION

  // --------------------
  ///
  static String? stringOnlyValidator({
    required String? text,
  }){
    String? _message;

    if (TextCheck.isEmpty(text) == false){

      try {
        Map<String, dynamic>? testMap = {text!: 'x'};
        testMap = Mapper.cloneMap(testMap);
      }

      catch (e) {
        // If an exception occurs, the key is not valid
        _message = 'fuck'; //getWord('phid_only_strings_is_to_be_added');
      }

    }

    return _message;
  }
  // -----------------------------------------------------------------------------

  /// GEO POINT VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? positionValidator({
    required String? latOrLng,
  }){
    String? _message;

    if (TextCheck.isEmpty(latOrLng) == false){

      _message = numbersOnlyValidator(
        text: latOrLng,
      );

      if (_message == null){

        final double? _double = Numeric.transformStringToDouble(latOrLng);

        if (_double == null){
          _message = getWord('phid_only_numbers_is_to_be_added');
        }
        else {

          if (Atlas.checkCoordinateIsGood(_double) == true){
            // nothing in my mind for you at this point
          }
          else {
            _message = getWord('phid_coordinate_must_be_between_minus_90_and_90');
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
  static String? bakeValidator({
    required String Function(String? text)? validator,
    required String text,
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
  static String? _bakeValidatorMessage(String? message){
    String? _output;

    if (message != null){
      _output = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: message,
          specialCharacter: 'Δ',
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
