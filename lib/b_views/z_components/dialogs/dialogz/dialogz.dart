import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/auth/password_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/a_flyer_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_banner.dart';
import 'package:bldrs/b_views/b_auth/x_auth_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
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

// ---------------------------------
  static void closDialog(BuildContext context){
    Nav.goBack(context: context, invoker: 'closeDialog');
  }
// -----------------------------------------------------------------------------

  /// ERRORS DIALOGS

// ---------------------------------
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

    String _errorReply;

    for (final Map<String, dynamic> map in _errors) {
      final bool _mapContainsTheError = TextChecker.stringContainsSubString(
        string: result,
        subString: map['error'],
      );

      if (_mapContainsTheError == true) {
        _errorReply = map['reply'];
        break;
      } else {
        _errorReply = 'phid_something_went_wrong_error';
      }
    }

    // [firebase_auth/user-not-found]
    // [firebase_auth/user-not-found]

    blog('_errorReply : $_errorReply');

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: 'phid_a_could_not_continue_title',
      bodyVerse: _errorReply,
    );
  }
// ---------------------------------
  static Future<void> tryAgainDialog(BuildContext context) async {

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: 'Something went wrong!',
      bodyVerse: 'Please try Again.',
    );

  }
// -----------------------------------------------------------------------------

  /// ZONE DIALOGS

// ---------------------------------
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
              verse: '##Please confirm your city',
            ),

            ...List<Widget>.generate(cities.length, (int index) {

              final CityModel _foundCity = cities[index];
              final String _foundCityName = _foundCity.cityID;

              return BottomDialog.wideButton(
                  context: context,
                  verse: _foundCityName,
                  icon: Flag.getFlagIcon(_foundCity.countryID),
                  onTap: () {

                    _city = _foundCity;

                    Nav.goBack(
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

  /// TEXT FIELD DIALOGS

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> showPasswordDialog(BuildContext context) async {

    final TextEditingController _password = TextEditingController();

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: '##Enter Your password',
      height: Scale.superScreenHeight(context) * 0.6,
      onOk: () async {

        CenterDialog.closeCenterDialog(context);
        Keyboard.closeKeyboard(context);

      },
      child: PasswordBubbles(
        appBarType: AppBarType.non,
        boxWidth: CenterDialog.clearWidth(context) - 20,
        passwordController: _password,
        showPasswordOnly: true,
        passwordValidator: () => passwordValidation(
          password: _password.text,
        ),
        passwordConfirmationController: null,
        passwordConfirmationValidator: null,
        onSubmitted: (String text) => CenterDialog.closeCenterDialog(context),
        // isTheSuperKeyboardField: false,
      ),
    );

    return _password.text;
  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> keyboardDialog({
    @required BuildContext context,
    KeyboardModel keyboardModel,
    bool confirmButtonIsOn = true,
  }) async {

    final KeyboardModel _keyboardModel = keyboardModel ?? KeyboardModel.standardModel();

    const double _ratioOfScreenHeight = 0.75;
    final double _overridingDialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: _ratioOfScreenHeight);
    final double _clearWidth = BottomDialog.clearWidth(context);
    final double _clearHeight = BottomDialog.clearHeight(
        context: context,
        overridingDialogHeight: _overridingDialogHeight,
        draggable: true,
        titleIsOn: false
    );

    void _onConfirmTap (String text){

        Keyboard.closeKeyboard(context);
        Nav.goBack(
          context: context,
          invoker: 'keyboardDialog',
        );
      if (_keyboardModel.onSubmitted != null){
        _keyboardModel.onSubmitted(_keyboardModel.controller.text);
      }

    }

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: _overridingDialogHeight,
      child: SizedBox(
        width: _clearWidth,
        height: _clearHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[

            TextFieldBubble(
              appBarType: AppBarType.non,
              isFloatingField: _keyboardModel.isFloatingField,
              titleVerse: _keyboardModel.titleVerse,
              textController: _keyboardModel.controller,
              maxLines: _keyboardModel.maxLines,
              minLines: _keyboardModel.minLines,
              maxLength: _keyboardModel.maxLength,
              bubbleWidth: _clearWidth,
              hintText: _keyboardModel.hintVerse,
              counterIsOn: _keyboardModel.counterIsOn,
              canObscure: _keyboardModel.canObscure,
              keyboardTextInputType: _keyboardModel.textInputType,
              keyboardTextInputAction: _keyboardModel.textInputAction,
              autoFocus: true,
              onSubmitted: _onConfirmTap,

            ),

            if (confirmButtonIsOn == true)
              DreamBox(
                height: 40,
                verseScaleFactor: 0.6,
                margins: const EdgeInsets.symmetric(horizontal: 10),
                verse:'Confirm',

                onTap: () => _onConfirmTap(_keyboardModel.controller.text),
              ),

          ],
        ),
      ),
    );

    return _keyboardModel.controller.text;
  }
// -----------------------------------------------------------------------------

  /// CONFIRMATION DIALOGS

// ---------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> confirmProceed({
    @required BuildContext context,
    String titleVerse,
    String bodyVerse,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: titleVerse ?? '##Proceed ?',
      bodyVerse: bodyVerse,
      boolDialog: true,
    );

    return _result;
  }
// ---------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> goBackDialog({
    @required BuildContext context,
    String titleVerse,
    String bodyVerse,
    String confirmButtonText,
    bool goBackOnConfirm = false,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: titleVerse ?? 'Go Back ?',
      bodyVerse: bodyVerse,
      boolDialog: true,
      confirmButtonVerse: confirmButtonText ?? 'Go Back',
    );

    if (goBackOnConfirm == true && _result == true){
      Nav.goBack(
        context: context,
        invoker: 'goBackDialog : $titleVerse',
      );
    }

    return _result;

  }


// -----------------------------------------------------------------------------

  /// USERS DIALOGS

// ---------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> userDialog({
    @required BuildContext context,
    @required UserModel userModel,
    @required String titleVerse,
    @required String bodyVerse,
    String confirmButtonText,
    bool boolDialog = true,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonText,
      height: Scale.superScreenHeight(context) * 0.85,
      child: UserBanner(
        userModel: userModel,
      ),
    );

    return _result;
  }
// -----------------------------------------------------------------------------

  /// BZZ DIALOGS

// ---------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> bzBannerDialog({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String title,
    @required String body,
    String confirmButtonText,
    bool boolDialog = true,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: title,
      bodyVerse: body,
      confirmButtonVerse: confirmButtonText,
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
// ---------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> bzzBannersDialog({
    @required BuildContext context,
    @required List<BzModel> bzzModels,
    @required String title,
    @required String body,
    String confirmButtonText,
    bool boolDialog = true,
  }) async {

    final double _gridHeight = Scale.superScreenHeight(context) * 0.5;

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: title,
      bodyVerse: body,
      confirmButtonVerse: confirmButtonText,
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

// ---------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> bzContactsDialog({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String title,
    @required String body,
    String confirmButtonText,
    ValueChanged<ContactModel> onContact,
  }) async {

    final double _gridHeight = Scale.superScreenHeight(context) * 0.5;

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: title,
      bodyVerse: body,
      confirmButtonVerse: '##Cancel',
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

// ---------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> flyersDialog({
    @required BuildContext context,
    @required List<String> flyersIDs,
    @required String title,
    @required String body,
    String confirmButtonText,
    bool boolDialog = true,
  }) async {

    final double _gridHeight = Scale.superScreenHeight(context) * 0.5;

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: title,
      bodyVerse: body,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonText,
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
        ),
      ),

    );

    return _result;


  }
// ---------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> flyerDialog({
    @required BuildContext context,
    @required FlyerModel flyer,
    @required String title,
    @required String body,
    String confirmButtonText,
    bool boolDialog = true,
  }) async {

    final double _screenHeight = Scale.superScreenHeight(context);
    final double _dialogHeight = _screenHeight * 0.7;
    final double _flyerBoxHeight = _dialogHeight * 0.5;

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: title,
      bodyVerse: body,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonText,
      height: _dialogHeight,
      child: SizedBox(
        height: _flyerBoxHeight,
        child: AbsorbPointer(
          child: FlyerStarter(
            flyerModel: flyer,
            minWidthFactor: FlyerBox.sizeFactorByHeight(context, _flyerBoxHeight),
          ),
        ),
      ),
    );

    return _result;

  }
// -----------------------------------------------------------------------------

}
