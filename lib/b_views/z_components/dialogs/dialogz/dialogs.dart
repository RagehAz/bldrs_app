import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/x_ui/keyboard_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/d_settings_page/password_screen.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/aa_user_banner.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/a_heroic_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';
import 'package:stringer/stringer.dart';

class Dialogs {
  // -----------------------------------------------------------------------------

  const Dialogs();

  // -----------------------------------------------------------------------------

  /// CLOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closDialog() async {
    await Nav.goBack(
      context: getMainContext(),
      invoker: 'closeDialog',
      addPostFrameCallback: true,
    );
  }
  // -----------------------------------------------------------------------------

  /// SUCCESS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showSuccessDialog({
    Verse firstLine,
    Verse secondLine,
  }) async {

    await TopDialog.showTopDialog(
      firstVerse: firstLine ?? const Verse(
        id: 'phid_success',
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
  /// TESTED : WORKS PERFECT
  static Future<void> topNotice({
    @required Verse verse,
    Color color = Colorz.yellow255,
  }) async {

    await TopDialog.showTopDialog(
      firstVerse: verse,
      color: color,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> centerNotice({
    @required Verse verse,
    Verse body,
    Color color,
  }) async {

    await CenterDialog.showCenterDialog(
      titleVerse: verse,
      color: color,
      bodyVerse: body,
      // boolDialog: false,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> weWillLookIntoItNotice() async {
    await CenterDialog.showCenterDialog(
      titleVerse:  const Verse(
        id: 'phid_thanks_million',
        translate: true,
      ),
      bodyVerse: const Verse(
        pseudo: 'We will look into this matter and take the necessary '
            'action as soon as possible\n Thank you for helping out',
        id: 'phid_we_will_look_into_it',
        translate: true,
      ),
      confirmButtonVerse: const Verse(
        id: 'phid_most_welcome',
        translate: true,
      ),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> youNeedToBeSignedUpDialog({
    @required String afterHomeRouteName,
    @required String afterHomeRouteArgument,
  }) async {

    final bool _go = await CenterDialog.showCenterDialog(
      titleVerse: const Verse(
        id: 'phid_you_need_to_sign_in',
        translate: true,
      ),
      boolDialog: true,
    );

    if (_go == true){

      UiProvider.proSetAfterHomeRoute(
          routeName: afterHomeRouteName,
          arguments: afterHomeRouteArgument,
          notify: true,
      );

      await BldrsNav.jumpToAuthScreen();

    }

  }
  // -----------------------------------------------------------------------------

  /// CONFIRMATION DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> confirmProceed({
    Verse titleVerse,
    Verse bodyVerse,
    bool invertButtons = false,
    Verse noVerse,
    Verse yesVerse,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      titleVerse: titleVerse ?? const Verse(
        id: 'phid_proceed_?',
        translate: true,
      ),
      bodyVerse: bodyVerse,
      boolDialog: true,
      invertButtons: invertButtons,
      noVerse: noVerse,
      confirmButtonVerse: yesVerse,
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> goBackDialog({
    Verse titleVerse,
    Verse bodyVerse,
    Verse confirmButtonVerse,
    bool goBackOnConfirm = false,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      invertButtons: true,
      titleVerse: titleVerse ?? const Verse(
        id: 'phid_go_back_?',
        translate: true,
      ),
      bodyVerse: bodyVerse,
      boolDialog: true,
      confirmButtonVerse: confirmButtonVerse ?? const Verse(
        id:'phid_go_back',
        translate: true,
      ),
    );

    if (goBackOnConfirm == true && _result == true){
      await Nav.goBack(
        context: getMainContext(),
        invoker: 'goBackDialog : $titleVerse',
      );
    }

    return _result;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> discardChangesGoBackDialog() async {

    final bool result = await CenterDialog.showCenterDialog(
      titleVerse: const Verse(
        id: 'phid_discard_changes_?',
        translate: true,
      ),
      bodyVerse: const Verse(
        id: 'phid_discard_changed_warning',
        translate: true,
      ),
      confirmButtonVerse: const Verse(
        id: 'phid_yes_discard',
        translate: true,
      ),
      boolDialog: true,
    );

    return result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> bottomBoolDialog({
    @required Verse titleVerse,
  }) async {

    bool _result = false;

    final BuildContext context = getMainContext();

    await BottomDialog.showBottomDialog(
      height: BottomDialog.calculateDialogHeight(
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
            BldrsBox(
              height: 50,
              width: Scale.getUniformRowItemWidth(
                context: context,
                numberOfItems: 2,
                boxWidth: BottomDialog.clearWidth(context),
              ),
              // color: Colorz.bloodTest,
              verse: const Verse(
                id: 'phid_no',
                casing: Casing.upperCase,
                translate: true,
              ),
              verseItalic: true,
              onTap: () async {
                await Nav.goBack(context: context, invoker: 'bottomBoolDialog');
              },
            ),

            /// YES
            BldrsBox(
              height: 50,
              width: Scale.getUniformRowItemWidth(
                context: context,
                numberOfItems: 2,
                boxWidth: BottomDialog.clearWidth(context),
              ),
              color: Colorz.green125,
              verse: const Verse(
                id: 'phid_yes',
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
  static Future<void> authErrorDialog({
    @required dynamic result,
  }) async {

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
        'reply': 'phid_network_is_unresponsive',
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
          id: map['reply'],
          translate: true,
        );
        break;
      }

      else {
        _errorReplyVerse = const Verse(
          id: 'phid_somethingIsWrong',
          translate: true,
        );
      }

    }

    // [firebase_auth/user-not-found]
    // [firebase_auth/user-not-found]

    blog('_errorReplyVerse : ${_errorReplyVerse.id}');

    await CenterDialog.showCenterDialog(
      titleVerse: const Verse(
        id: 'phid_could_not_continue_title',
        translate: true,
      ),
      bodyVerse: _errorReplyVerse,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> tryAgainDialog() async {

    await CenterDialog.showCenterDialog(
      titleVerse: const Verse(
        id: 'phid_somethingIsWrong!',
        translate: true,
      ),
      bodyVerse: const Verse(
        id: 'phid_please_try_again',
        translate: true,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> errorDialog({
    Verse titleVerse,
    Verse bodyVerse,
  }) async {

    await CenterDialog.showCenterDialog(
      titleVerse: titleVerse ?? const Verse(
        id: 'phid_somethingIsWrong',
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
  static Future<String> showPasswordDialog() async {

    final String _password = await Nav.goToNewScreen(
        context: getMainContext(),
        screen: const PasswordScreen(),
    );

    return _password;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> keyboardDialog({
    KeyboardModel keyboardModel,
    bool confirmButtonIsOn = true,
  }) async {

    final KeyboardModel _keyboardModel = keyboardModel ?? KeyboardModel.standardModel();
    Future<void> _onSubmit (String text) async {

      Keyboard.closeKeyboard();
      await Nav.goBack(
        context: getMainContext(),
        invoker: 'keyboardDialog',
      );
      if (_keyboardModel.onSubmitted != null){
        if (_keyboardModel.validator == null || _keyboardModel.validator(text) == null){
          _keyboardModel.onSubmitted(text);
        }
      }

    }

    const double _ratioOfScreenHeight = 0.8;
    final double _overridingDialogHeight = BottomDialog.dialogHeight(getMainContext(), ratioOfScreenHeight: _ratioOfScreenHeight);
    final double _clearWidth = BottomDialog.clearWidth(getMainContext());
    final double _clearHeight = BottomDialog.clearHeight(
        context: getMainContext(),
        overridingDialogHeight: _overridingDialogHeight,
        titleIsOn: false
    );

    bool _buttonDeactivated;
    String _text = _keyboardModel.initialText;

    await BottomDialog.showBottomDialog(
      height: _overridingDialogHeight,
      child: SizedBox(
        width: _clearWidth,
        height: _clearHeight,
        child: StatefulBuilder(
          builder: (BuildContext ctx,  setState){


            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                BldrsTextFieldBubble(
                  formKey: _keyboardModel.globalKey,
                  bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                    context: getMainContext(),
                    headlineVerse: _keyboardModel.titleVerse,
                  ),
                  appBarType: AppBarType.non,
                  isFloatingField: _keyboardModel.isFloatingField,
                  initialText: _keyboardModel.initialText,
                  maxLines: _keyboardModel.maxLines,
                  minLines: _keyboardModel.minLines,
                  maxLength: _keyboardModel.maxLength,
                  bubbleWidth: _clearWidth,
                  hintVerse: _keyboardModel.hintVerse,
                  counterIsOn: _keyboardModel.counterIsOn,
                  isObscured: _keyboardModel.isObscured,
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
                  onTextChanged: (String text){

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
                  BldrsBox(
                    isDisabled: _buttonDeactivated,
                    height: 40,
                    verseScaleFactor: 0.6,
                    margins: const EdgeInsets.symmetric(horizontal: 10),
                    verse: const Verse(
                      id: 'phid_confirm',
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

    if (keyboardModel != null){
      keyboardModel.isObscured?.dispose();
    }

    return _text;
  }
  // -----------------------------------------------------------------------------

  /// TEXT FIELD DIALOGS

  // --------------------
  ///
  static Future<void> missingFieldsDialog() async {



  }
  // -----------------------------------------------------------------------------

  /// ZONE DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel> confirmCityDialog({
    @required List<CityModel> cities,
  }) async {
    CityModel _city;

    await BottomDialog.showButtonsBottomDialog(
        buttonHeight: 50,
        numberOfWidgets: cities.length + 1,
        builder: (_){

          return <Widget>[

            const BldrsText(
              verse: Verse(
                id: 'phid_confirm_your_city',
                translate: true,
                casing: Casing.capitalizeFirstChar,
                pseudo: 'Please confirm your city',
              ),
            ),

            ...List<Widget>.generate(cities.length, (int index) {

              final CityModel _foundCity = cities[index];
              final String _foundCityName = CityModel.translateCity(
                city: _foundCity,
              );

              return BottomDialog.wideButton(
                  context: getMainContext(),
                  verse: Verse(
                    id: _foundCityName,
                    translate: false,
                  ),
                  icon: Flag.getCountryIcon(_foundCity.oldGetCountryID()),
                  onTap: () async {

                    _city = _foundCity;

                    await Nav.goBack(
                      context: getMainContext(),
                      invoker: 'confirmCityDialog : city selected aho $_foundCityName',
                    );

                  });

            }),

          ];

        }
    );

    return _city;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> zoneIsNotAvailable() async {

    await CenterDialog.showCenterDialog(
      titleVerse: const Verse(
        id: 'phid_zone_is_not_available',
        translate: true,
      ),
      bodyVerse: const Verse(
        id: 'phid_zone_is_not_available_body',
        translate: true,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// USERS DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> userDialog({
    @required UserModel userModel,
    @required Verse titleVerse,
    @required Verse bodyVerse,
    Verse confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonVerse,
      invertButtons: invertButtons,
      height: Scale.screenHeight(getMainContext()) * 0.7,
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
    @required BzModel bzModel,
    @required Verse titleVerse,
    @required Verse bodyVerse,
    Verse confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      confirmButtonVerse: confirmButtonVerse,
      boolDialog: boolDialog,
      height: Scale.screenHeight(getMainContext()) * 0.8,
      invertButtons: invertButtons,
      child: BzBanner(
        boxWidth: CenterDialog.clearWidth(getMainContext()),
        boxHeight: CenterDialog.clearWidth(getMainContext()),
        bzModel: bzModel,
        bigName: false,
      ),
    );

    return _result;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> bzzBannersDialog({
    @required List<BzModel> bzzModels,
    @required Verse titleVerse,
    @required Verse bodyVerse,
    Verse confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
  }) async {

    final double _gridHeight = Scale.screenHeight(getMainContext()) * 0.5;

    final bool _result = await CenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      confirmButtonVerse: confirmButtonVerse,
      boolDialog: boolDialog,
      invertButtons: invertButtons,
      height: Scale.screenHeight(getMainContext()) * 0.7,
      child: Container(
        width: CenterDialog.getWidth(getMainContext()),
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
              boxWidth: CenterDialog.clearWidth(getMainContext()) * 0.8,
              boxHeight: CenterDialog.clearWidth(getMainContext()),
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
    @required BzModel bzModel,
    @required Verse titleVerse,
    @required Verse bodyVerse,
    Verse confirmButtonVerse,
    ValueChanged<ContactModel> onContact,
  }) async {

    final BuildContext context = getMainContext();
    final double _gridHeight = Scale.screenHeight(context) * 0.5;

    await CenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      confirmButtonVerse: confirmButtonVerse ?? const Verse(
        id: 'phid_cancel',
        translate: true,
      ),
      height: Scale.screenHeight(context) * 0.7,
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
    @required List<String> flyersIDs,
    @required Verse titleVerse,
    @required Verse bodyVerse,
    Verse confirmButtonVerse,
    bool boolDialog = true,
  }) async {

    final BuildContext context = getMainContext();
    final double _gridHeight = Scale.screenHeight(context) * 0.4;

    final bool _result = await CenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonVerse,
      height: Scale.screenHeight(context) * 0.7,
      child: Container(
        width: CenterDialog.getWidth(context),
        height: _gridHeight,
        color: Colorz.white10,
        alignment: Alignment.center,
        child: FlyersGrid(
          scrollController: ScrollController(),
          flyersIDs: flyersIDs,
          scrollDirection: Axis.horizontal,
          gridWidth: CenterDialog.getWidth(context) - 10,
          gridHeight: _gridHeight,
          topPadding: 0,
          numberOfColumnsOrRows: 1,
          screenName: 'flyersDialogGrid',
          isHeroicGrid: true,
        ),
      ),

    );

    return _result;


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> flyerDialog({
    @required FlyerModel flyer,
    @required Verse titleVerse,
    @required Verse bodyVerse,
    Verse confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
  }) async {

    final double _screenHeight = Scale.screenHeight(getMainContext());
    final double _dialogHeight = _screenHeight * 0.7;
    final double _flyerBoxHeight = _dialogHeight * 0.5;

    final bool _result = await CenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonVerse,
      height: _dialogHeight,
      invertButtons: invertButtons,
      child: SizedBox(
        height: _flyerBoxHeight,
        child: AbsorbPointer(
          child: HeroicFlyer(
            flyerModel: flyer,
            flyerBoxWidth: FlyerDim.flyerWidthByFlyerHeight(
              flyerBoxHeight: _flyerBoxHeight,
            ),
            screenName: 'flyerDialogGrid',
          ),
        ),
      ),
    );

    return _result;

  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> slideDialog({
    @required SlideModel slideModel,
    @required Verse titleVerse,
    Verse bodyVerse,
    Verse confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
  }) async {

    final BuildContext context = getMainContext();
    final double _screenHeight = Scale.screenHeight(context);
    final double _dialogHeight = _screenHeight * 0.7;
    final double _flyerBoxHeight = _dialogHeight * 0.5;

    final bool _result = await CenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonVerse,
      height: _dialogHeight,
      invertButtons: invertButtons,
      copyOnTap: false,
      child: Container(
        width: CenterDialog.getWidth(context),
        alignment: Alignment.center,
        child: SingleSlide(
          flyerBoxWidth: FlyerDim.flyerWidthByFlyerHeight(
            flyerBoxHeight: _flyerBoxHeight,
          ),
          flyerBoxHeight: _flyerBoxHeight,
          slideModel: slideModel,
          tinyMode: true,
          slideShadowIsOn: true,
          onDoubleTap: null,
          onSlideBackTap: null,
          onSlideNextTap: null,
          blurLayerIsOn: true,
          canTapSlide: false,
          canPinch: false,
          // canAnimateMatrix: true,
          canUseFilter: false,
        ),
      ),
    );

    return _result;

  }
// -----------------------------------------------------------------------------
}
