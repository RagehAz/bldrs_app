import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/aa_user_banner.dart';
import 'package:bldrs/b_views/z_components/auth/password_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/a_flyer_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class Dialogs {
  // -----------------------------------------------------------------------------

  const Dialogs();

  // -----------------------------------------------------------------------------

  /// CLOSE

  // --------------------
  static Future<void> closDialog(BuildContext context) async {
    await Nav.goBack(context: context, invoker: 'closeDialog');
  }
  // -----------------------------------------------------------------------------

  /// SUCCESS

  // --------------------
  static Future<void> showSuccessDialog({
    @required BuildContext context,
    Verse firstLine,
    Verse secondLine,
  }) async {

    await TopDialog.showTopDialog(
      context: context,
      firstVerse: firstLine ?? const Verse(
        text: 'phid_success',
        translate: true,
      ),
      secondVerse: secondLine,
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }


  // -----------------------------------------------------------------------------

  /// NOTICE

  // --------------------
  static Future<void> topNotice({
    @required BuildContext context,
    @required Verse verse,
  }) async {

    await TopDialog.showTopDialog(
      context: context,
      firstVerse: verse,
      // color: Colorz.yellow255,
    );

  }
  // --------------------
  static Future<void> weWillLookIntoItNotice(BuildContext context) async {
    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse:  const Verse(
        text: 'phid_thanks_million',
        translate: true,
      ),
      bodyVerse: const Verse(
        pseudo: 'We will look into this matter and take the necessary '
            'action as soon as possible\n Thank you for helping out',
        text: 'phid_we_will_look_into_it',
        translate: true,
      ),
      confirmButtonVerse: const Verse(
        text: 'phid_most_welcome',
        translate: true,
      ),
    );
  }
  // --------------------
  static Future<void> youNeedToBeSignedInDialog(BuildContext context) async {

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_you_need_to_sign_in',
        translate: true,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// CONFIRMATION DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> confirmProceed({
    @required BuildContext context,
    Verse titleVerse,
    Verse bodyVerse,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: titleVerse ?? const Verse(
        text: 'phid_proceed_?',
        translate: true,
      ),
      bodyVerse: bodyVerse,
      boolDialog: true,
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> goBackDialog({
    @required BuildContext context,
    Verse titleVerse,
    Verse bodyVerse,
    Verse confirmButtonVerse,
    bool goBackOnConfirm = false,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: titleVerse ?? const Verse(
        text: 'phid_go_back_?',
        translate: true,
      ),
      bodyVerse: bodyVerse,
      boolDialog: true,
      confirmButtonVerse: confirmButtonVerse ?? const Verse(
        text:'phid_go_back',
        translate: true,
      ),
    );

    if (goBackOnConfirm == true && _result == true){
      await Nav.goBack(
        context: context,
        invoker: 'goBackDialog : $titleVerse',
      );
    }

    return _result;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> discardChangesGoBackDialog(BuildContext context) async {

    final bool result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_discard_changes_?',
        translate: true,
      ),
      bodyVerse: const Verse(
        text: 'phid_discard_changed_warning',
        translate: true,
      ),
      confirmButtonVerse: const Verse(
        text: 'phid_yes_discard',
        translate: true,
      ),
      boolDialog: true,
    );

    return result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> bottomBoolDialog({
    @required BuildContext context,
    @required Verse titleVerse,
}) async {

    bool _result = false;

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: false,
      height: BottomDialog.calculateDialogHeight(
        draggable: false,
        titleIsOn: true,
        childHeight: 70,
      ),
      titleVerse: titleVerse,
      child: SizedBox(
        width: BottomDialog.clearWidth(context),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            /// NO
            DreamBox(
              height: 50,
              width: Scale.getUniformRowItemWidth(
                context: context,
                numberOfItems: 2,
                boxWidth: BottomDialog.clearWidth(context),
              ),
              // color: Colorz.bloodTest,
              verse: const Verse(
                text: 'phid_no',
                casing: Casing.upperCase,
                translate: true,
              ),
              verseItalic: true,
              onTap: () async {
                await Nav.goBack(context: context, invoker: 'bottomBoolDialog');
              },
            ),

            /// YES
            DreamBox(
              height: 50,
              width: Scale.getUniformRowItemWidth(
                context: context,
                numberOfItems: 2,
                boxWidth: BottomDialog.clearWidth(context),
              ),
              color: Colorz.green125,
              verse: const Verse(
                text: 'phid_yes',
                casing: Casing.upperCase,
                translate: true,
              ),
              verseItalic: true,
              onTap: () async {
                _result = true;
                await Nav.goBack(context: context, invoker: 'bottomBoolDialog');
              },
            ),

          ],
        ),
      ),
    );

    return _result;
  }
  // -----------------------------------------------------------------------------

  /// ERRORS DIALOGS

  // --------------------
  /// TASK : NEED TO CHECK LIST OF ERRORS FROM FIREBASE WEBSITE
  static Future<void> authErrorDialog({BuildContext context, dynamic result}) async {

    // final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);

    final List<Map<String, dynamic>> _errors = <Map<String, dynamic>>[
      /// SIGN IN ERROR
      <String, dynamic>{
        'error': '[firebase_auth/user-not-found]', // There is no user record corresponding to this identifier. The user may have been deleted.',
        'reply': 'phid_emailNotFound',
      },
      <String, dynamic>{
        'error': '[firebase_auth/network-request-failed]', // A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
        'reply': 'phid_no_internet_connection',
      },
      <String, dynamic>{
        'error':
        '[firebase_auth/invalid-email]', // The email address is badly formatted.',
        'reply': 'phid_emailWrong',
      },
      <String, dynamic>{
        'error': '[firebase_auth/wrong-password]', // The password is invalid or the user does not have a password.',
        'reply': 'phid_wrongPassword',

        /// TASK : should link accounts authentication
      },
      <String, dynamic>{
        'error': '[firebase_auth/too-many-requests]', // We have blocked all requests from this device due to unusual activity. Try again later.',
        'reply': 'phid_too_many_fails_error',

        /// TASK : should link accounts authentication and delete this dialog
      },
      <String, dynamic>{
        'error': 'PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null, null)',
        'reply': 'phid_could_not_sign_by_google',
      },

      /// REGISTER ERRORS
      <String, dynamic>{
        'error': '[firebase_auth/email-already-in-use]', // The email address is already in use by another account.',
        'reply': 'phid_emailAlreadyRegistered',
      },
      <String, dynamic>{
        'error': '[firebase_auth/invalid-email]', // The email address is badly formatted.',
        'reply': 'phid_emailWrong',
      },

      /// NETWORK ERRORS
      <String, dynamic>{
        'error': '[cloud_firestore/unavailable]', // The service is currently unavailable. This is a most likely a transient condition and may be corrected by retrying with a backoff.
        'reply': '##Network is unresponsive, please try again',
      },

      /// SHARED ERRORS
      <String, dynamic>{
        'error': null,
        'reply': 'phid_somethingIsWrong',
      },
    ];

    // blog('authErrorDialog result : $result');

    Verse _errorReplyVerse;

    for (final Map<String, dynamic> map in _errors) {

      final bool _mapContainsTheError = TextCheck.stringContainsSubString(
        string: result,
        subString: map['error'],
      );

      if (_mapContainsTheError == true) {
        _errorReplyVerse = Verse(
          text: map['reply'],
          translate: true,
        );
        break;
      }

      else {
        _errorReplyVerse = const Verse(
          text: 'phid_somethingIsWrong',
          translate: true,
        );
      }

    }

    // [firebase_auth/user-not-found]
    // [firebase_auth/user-not-found]

    blog('_errorReplyVerse : $_errorReplyVerse');

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_a_could_not_continue_title',
        translate: true,
      ),
      bodyVerse: _errorReplyVerse,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> tryAgainDialog(BuildContext context) async {

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_somethingIsWrong!',
        translate: true,
      ),
      bodyVerse: const Verse(
        text: 'phid_please_try_again',
        translate: true,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> errorDialog({
    @required BuildContext context,
    Verse titleVerse,
    Verse bodyVerse,
  }) async {

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: titleVerse ?? const Verse(
        text: 'phid_somethingIsWrong',
        translate: true,
      ),
      bodyVerse: bodyVerse,
      color: Colorz.red255,
    );

  }
  // -----------------------------------------------------------------------------

  /// TEXT FIELD DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> showPasswordDialog(BuildContext context) async {

    final TextEditingController _password = TextEditingController();

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_enter_your_password',
        translate: true,
      ),
      height: Scale.superScreenHeight(context) * 0.6,
      onOk: () async {

        await CenterDialog.closeCenterDialog(context);
        Keyboard.closeKeyboard(context);

      },
      child: PasswordBubbles(
        appBarType: AppBarType.non,
        boxWidth: CenterDialog.clearWidth(context) - 20,
        passwordController: _password,
        showPasswordOnly: true,
        passwordValidator: (String text) => Formers.passwordValidator(
          password: _password.text,
          canValidate: true,
        ),
        passwordConfirmationController: null,
        passwordConfirmationValidator: null,
        onSubmitted: (String text) => CenterDialog.closeCenterDialog(context),
        // isTheSuperKeyboardField: false,
      ),
    );

    return _password.text;
  }
  // --------------------
  static Future<String> keyboardDialog({
    @required BuildContext context,
    KeyboardModel keyboardModel,
    bool confirmButtonIsOn = true,
  }) async {

    final KeyboardModel _keyboardModel = keyboardModel ?? KeyboardModel.standardModel();
    Future<void> _onSubmit (String text) async {

      Keyboard.closeKeyboard(context);
      await Nav.goBack(
        context: context,
        invoker: 'keyboardDialog',
      );
      if (_keyboardModel.onSubmitted != null){
        if (_keyboardModel.validator == null || _keyboardModel.validator(text) == null){
          _keyboardModel.onSubmitted(text);
        }
      }

    }

    const double _ratioOfScreenHeight = 0.8;
    final double _overridingDialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: _ratioOfScreenHeight);
    final double _clearWidth = BottomDialog.clearWidth(context);
    final double _clearHeight = BottomDialog.clearHeight(
        context: context,
        overridingDialogHeight: _overridingDialogHeight,
        draggable: true,
        titleIsOn: false
    );

    bool _buttonDeactivated;
    String _text = _keyboardModel.initialText;

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: _overridingDialogHeight,
      child: SizedBox(
        width: _clearWidth,
        height: _clearHeight,
        child: StatefulBuilder(
          builder: (BuildContext ctx,  setState){


            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                TextFieldBubble(
                  globalKey: _keyboardModel.globalKey,
                  appBarType: AppBarType.non,
                  isFloatingField: _keyboardModel.isFloatingField,
                  titleVerse: _keyboardModel.titleVerse,
                  initialText: _keyboardModel.initialText,
                  maxLines: _keyboardModel.maxLines,
                  minLines: _keyboardModel.minLines,
                  maxLength: _keyboardModel.maxLength,
                  bubbleWidth: _clearWidth,
                  hintVerse: _keyboardModel.hintVerse,
                  counterIsOn: _keyboardModel.counterIsOn,
                  canObscure: _keyboardModel.canObscure,
                  keyboardTextInputType: _keyboardModel.textInputType,
                  keyboardTextInputAction: _keyboardModel.textInputAction,
                  autoFocus: true,
                  isFormField: _keyboardModel.isFormField,
                  onSubmitted: _onSubmit,
                  // autoValidate: true,
                  validator: (String text){
                    if (_keyboardModel.validator != null){
                      return _keyboardModel?.validator(_text);
                    }
                    else {
                      return null;
                    }
                  },
                  textOnChanged: (String text){

                    setState((){
                      _text = text;
                    });

                    if (_keyboardModel.onChanged != null){
                      _keyboardModel.onChanged(text);
                    }

                    if (_keyboardModel.validator != null){

                      setState((){
                        if (_keyboardModel.validator(_text) == null){
                          _buttonDeactivated = false;
                        }
                        else {
                          _buttonDeactivated = true;
                        }
                      });

                    }
                  },

                ),

                if (confirmButtonIsOn == true)
                  DreamBox(
                    isDeactivated: _buttonDeactivated,
                    height: 40,
                    verseScaleFactor: 0.6,
                    margins: const EdgeInsets.symmetric(horizontal: 10),
                    verse: const Verse(
                      text: 'phid_confirm',
                      translate: true,
                      casing: Casing.upperCase,
                    ),
                    onTap: () => _onSubmit(_text),
                  ),

              ],
            );

          },
        ),
      ),
    );

    return null;
  }
  // -----------------------------------------------------------------------------

  /// ZONE DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel> confirmCityDialog({
    @required BuildContext context,
    @required List<CityModel> cities,
  }) async {
    CityModel _city;

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        buttonHeight: 50,
        numberOfWidgets: cities.length + 1,
        builder: (BuildContext context, PhraseProvider _phraseProvider){

          return <Widget>[

            const SuperVerse(
              verse: Verse(
                text: 'phid_confirm_your_city',
                translate: true,
                casing: Casing.capitalizeFirstChar,
                pseudo: 'Please confirm your city',
              ),
            ),

            ...List<Widget>.generate(cities.length, (int index) {

              final CityModel _foundCity = cities[index];
              final String _foundCityName = CityModel.getTranslatedCityNameFromCity(
                context: context,
                city: _foundCity,
              );

              return BottomDialog.wideButton(
                  context: context,
                  verse: Verse(
                    text: _foundCityName,
                    translate: false,
                  ),
                  icon: Flag.getFlagIcon(_foundCity.countryID),
                  onTap: () async {

                    _city = _foundCity;

                    await Nav.goBack(
                      context: context,
                      invoker: 'confirmCityDialog : city selected aho $_foundCityName',
                    );

                  });

            }),

          ];

        }
    );

    return _city;
  }
  // -----------------------------------------------------------------------------

  /// USERS DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> userDialog({
    @required BuildContext context,
    @required UserModel userModel,
    @required Verse titleVerse,
    @required Verse bodyVerse,
    Verse confirmButtonVerse,
    bool boolDialog = true,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonVerse,
      height: Scale.superScreenHeight(context) * 0.85,
      child: UserBanner(
        userModel: userModel,
      ),
    );

    return _result;
  }
  // -----------------------------------------------------------------------------

  /// BZZ DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> bzBannerDialog({
    @required BuildContext context,
    @required BzModel bzModel,
    @required Verse titleVerse,
    @required Verse bodyVerse,
    Verse confirmButtonVerse,
    bool boolDialog = true,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      confirmButtonVerse: confirmButtonVerse,
      boolDialog: boolDialog,
      height: Scale.superScreenHeight(context) * 0.85,
      child: BzBanner(
        boxWidth: CenterDialog.clearWidth(context),
        boxHeight: CenterDialog.clearWidth(context),
        bzModel: bzModel,
        bigName: false,
      ),
    );

    return _result;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> bzzBannersDialog({
    @required BuildContext context,
    @required List<BzModel> bzzModels,
    @required Verse titleVerse,
    @required Verse bodyVerse,
    Verse confirmButtonVerse,
    bool boolDialog = true,
  }) async {

    final double _gridHeight = Scale.superScreenHeight(context) * 0.5;

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      confirmButtonVerse: confirmButtonVerse,
      boolDialog: boolDialog,
      height: Scale.superScreenHeight(context) * 0.85,
      child: Container(
        width: CenterDialog.getWidth(context),
        height: _gridHeight,
        color: Colorz.white10,
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: bzzModels?.length ?? 0,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemBuilder: (_, int index){

            return BzBanner(
              bzModel: bzzModels[index],
              boxWidth: CenterDialog.clearWidth(context) * 0.8,
              boxHeight: CenterDialog.clearWidth(context),
              bigName: false,
            );

          },
        ),
      ),
    );

    return _result;


  }
  // -----------------------------------------------------------------------------

  /// AUTHORS DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> bzContactsDialog({
    @required BuildContext context,
    @required BzModel bzModel,
    @required Verse titleVerse,
    @required Verse bodyVerse,
    Verse confirmButtonVerse,
    ValueChanged<ContactModel> onContact,
  }) async {

    final double _gridHeight = Scale.superScreenHeight(context) * 0.5;

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      confirmButtonVerse: confirmButtonVerse ?? const Verse(
        text: 'phid_cancel',
        translate: true,
      ),
      height: Scale.superScreenHeight(context) * 0.85,
      child: Container(
        width: CenterDialog.getWidth(context),
        height: _gridHeight,
        color: Colorz.white10,
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: bzModel?.authors?.length ?? 0,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemBuilder: (_, int index){

            return AuthorCard(
              author: bzModel.authors[index],
              bzModel: bzModel,
              onContactTap: onContact,
              bubbleWidth: CenterDialog.getWidth(context),
              moreButtonIsOn: false,
            );

          },
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// FLYERS DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> flyersDialog({
    @required BuildContext context,
    @required List<String> flyersIDs,
    @required Verse titleVerse,
    @required Verse bodyVerse,
    Verse confirmButtonVerse,
    bool boolDialog = true,
  }) async {

    final double _gridHeight = Scale.superScreenHeight(context) * 0.5;

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonVerse,
      height: Scale.superScreenHeight(context) * 0.85,
      child: Container(
        width: CenterDialog.getWidth(context),
        height: _gridHeight,
        color: Colorz.white10,
        alignment: Alignment.center,
        child: FlyersGrid(
          scrollController: ScrollController(),
          paginationFlyersIDs: flyersIDs,
          scrollDirection: Axis.horizontal,
          gridWidth: CenterDialog.getWidth(context) - 10,
          gridHeight: _gridHeight,
          topPadding: 0,
          numberOfColumnsOrRows: 1,
          heroTag: 'flyersDialogGrid',
        ),
      ),

    );

    return _result;


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> flyerDialog({
    @required BuildContext context,
    @required FlyerModel flyer,
    @required Verse titleVerse,
    @required Verse bodyVerse,
    Verse confirmButtonVerse,
    bool boolDialog = true,
  }) async {

    final double _screenHeight = Scale.superScreenHeight(context);
    final double _dialogHeight = _screenHeight * 0.7;
    final double _flyerBoxHeight = _dialogHeight * 0.5;

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonVerse,
      height: _dialogHeight,
      child: SizedBox(
        height: _flyerBoxHeight,
        child: AbsorbPointer(
          child: FlyerStarter(
            flyerModel: flyer,
            minWidthFactor: FlyerBox.sizeFactorByHeight(context, _flyerBoxHeight),
            heroTag: 'flyerDialogGrid',
          ),
        ),
      ),
    );

    return _result;

  }
  // -----------------------------------------------------------------------------
}
