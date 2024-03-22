import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/dialogs/center_dialog.dart';
import 'package:basics/components/drawing/dot_separator.dart';
import 'package:basics/components/drawing/spacing.dart';
import 'package:basics/components/drawing/super_positioned.dart';
import 'package:basics/components/super_image/super_image.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:basics/models/flag_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/x_ui/keyboard_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/e_my_settings_page/password_screen.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/future_model_builders/bz_poster_flyer_builder.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/g_flyer/z_components/a_heroic_flyer_structure/a_heroic_flyer.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/c_slides/a_single_slide.dart';
import 'package:bldrs/g_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/b_variants/bz_bubbles/bz_authors_bubble/bz_contacts_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/user_bubbles/aa_user_banner.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/buttons/keywords_buttons/f_phid_button.dart';
import 'package:bldrs/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/layouts/super_tool_tip.dart';
import 'package:bldrs/z_components/poster/structure/x_note_poster_box.dart';
import 'package:bldrs/z_components/poster/variants/aa_bz_poster.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

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
    Verse? firstLine,
    Verse? secondLine,
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
    required Verse verse,
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
    required Verse verse,
    Verse? body,
    Color? color,
    Widget? child,
    Verse? confirmVerse,
  }) async {

    await BldrsCenterDialog.showCenterDialog(
      titleVerse: verse,
      color: color,
      bodyVerse: body,
      // boolDialog: false,
      confirmButtonVerse: confirmVerse,
      child: child,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> weWillLookIntoItNotice() async {
    await BldrsCenterDialog.showCenterDialog(
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
    required String? afterHomeRouteName,
    required String? afterHomeRouteArgument,
  }) async {

    final bool _go = await BldrsCenterDialog.showCenterDialog(
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

      await Routing.goTo(route: TabName.bid_Auth);

    }

  }
  // -----------------------------------------------------------------------------

  /// CONFIRMATION DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> confirmProceed({
    Verse? titleVerse,
    Verse? bodyVerse,
    bool invertButtons = false,
    Verse? noVerse,
    Verse? yesVerse,
    Widget? child,
  }) async {

    final bool _result = await BldrsCenterDialog.showCenterDialog(
      titleVerse: titleVerse ?? const Verse(
        id: 'phid_proceed_?',
        translate: true,
      ),
      bodyVerse: bodyVerse,
      boolDialog: true,
      invertButtons: invertButtons,
      noVerse: noVerse,
      confirmButtonVerse: yesVerse,
      child: child,
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> goBackDialog({
    Verse? titleVerse,
    Verse? bodyVerse,
    Verse? confirmButtonVerse,
    bool goBackOnConfirm = false,
  }) async {

    final bool _result = await BldrsCenterDialog.showCenterDialog(
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

    final bool result = await BldrsCenterDialog.showCenterDialog(
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
    required Verse titleVerse,
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
        width: BottomDialog.clearWidth(),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            /// NO
            BldrsBox(
              height: 50,
              width: Scale.getUniformRowItemWidth(
                numberOfItems: 2,
                boxWidth: BottomDialog.clearWidth(),
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
                numberOfItems: 2,
                boxWidth: BottomDialog.clearWidth(),
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
    required dynamic result,
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

    Verse? _errorReplyVerse;

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

    blog('_errorReplyVerse : ${_errorReplyVerse?.id}');

    await BldrsCenterDialog.showCenterDialog(
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

    await BldrsCenterDialog.showCenterDialog(
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
    Verse? titleVerse,
    Verse? bodyVerse,
  }) async {

    await BldrsCenterDialog.showCenterDialog(
      titleVerse: titleVerse ?? const Verse(
        id: 'phid_somethingIsWrong',
        translate: true,
      ),
      bodyVerse: bodyVerse,
      color: Colorz.red255,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> somethingWentWrongAppWillRestart() async {

    await centerNotice(
      verse: getVerse('phid_somethingWentWrong')!,
      body: getVerse('phid_bldrsWillRestart'),
    );

  }
  // -----------------------------------------------------------------------------

  /// TEXT FIELD DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> showPasswordDialog() async {

    final String? _password = await BldrsNav.goToNewScreen(
        screen: const PasswordScreen(),
    );

    return _password;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> keyboardDialog({
    KeyboardModel? keyboardModel,
    bool confirmButtonIsOn = true,
  }) async {

    final KeyboardModel? _keyboardModel = keyboardModel ?? KeyboardModel.standardModel();
    Future<void> _onSubmit (String? text) async {

      await Keyboard.closeKeyboard();
      await Nav.goBack(
        context: getMainContext(),
        invoker: 'keyboardDialog',
      );
      if (_keyboardModel?.onSubmitted != null){
        if (_keyboardModel?.validator == null || _keyboardModel?.validator?.call(text) == null){
          _keyboardModel?.onSubmitted?.call(text);
        }
      }

    }

    const double _ratioOfScreenHeight = 0.8;
    final double _overridingDialogHeight = BottomDialog.dialogHeight(getMainContext(), ratioOfScreenHeight: _ratioOfScreenHeight);
    final double _clearWidth = BottomDialog.clearWidth();
    final double _clearHeight = BottomDialog.clearHeight(
        context: getMainContext(),
        overridingDialogHeight: _overridingDialogHeight,
        titleIsOn: false
    );

    bool? _buttonDeactivated;
    String? _text = _keyboardModel?.initialText;

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
                  formKey: _keyboardModel?.globalKey,
                  bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                    context: getMainContext(),
                    headlineVerse: _keyboardModel?.titleVerse,
                  ),
                  appBarType: AppBarType.non,
                  isFloatingField: _keyboardModel?.isFloatingField,
                  initialText: _keyboardModel?.initialText,
                  maxLines: _keyboardModel?.maxLines,
                  minLines: _keyboardModel?.minLines,
                  maxLength: _keyboardModel?.maxLength,
                  bubbleWidth: _clearWidth,
                  hintVerse: _keyboardModel?.hintVerse,
                  counterIsOn: _keyboardModel?.counterIsOn,
                  isObscured: _keyboardModel?.isObscured,
                  keyboardTextInputType: _keyboardModel?.textInputType,
                  keyboardTextInputAction: _keyboardModel?.textInputAction,
                  autoFocus: true,
                  isFormField: _keyboardModel?.isFormField,
                  autoCorrect: Mapper.boolIsTrue(_keyboardModel?.autoCorrect),
                  enableSuggestions: Mapper.boolIsTrue(_keyboardModel?.enableSuggestions),
                  onSubmitted: _onSubmit,
                  // autoValidate: true,
                  validator: (String? text){
                    if (_keyboardModel?.validator != null){
                      return _keyboardModel?.validator?.call(_text);
                    }
                    else {
                      return null;
                    }
                  },
                  onTextChanged: (String? text){

                    setState((){
                      _text = text;
                    });

                    if (_keyboardModel?.onChanged != null){
                      _keyboardModel?.onChanged?.call(text);
                    }

                    if (_keyboardModel?.validator != null){

                      setState((){
                        if (_keyboardModel?.validator?.call(_text) == null){
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

  /// MISSING FIELDS DIALOGS

  // --------------------
  ///
  static Future<void> missingFieldsDialog() async {



  }
  // -----------------------------------------------------------------------------

  /// ZONE DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel?> confirmCityDialog({
    required List<CityModel> cities,
  }) async {
    CityModel? _city;

    await BottomDialog.showButtonsBottomDialog(
        buttonHeight: 50,
        numberOfWidgets: cities.length + 1,
        builder: (_, __){

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
              final String? _foundCityName = CityModel.translateCity(
                langCode: Localizer.getCurrentLangCode(),
                city: _foundCity,
              );

              return BottomDialog.wideButton(
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

    await BldrsCenterDialog.showCenterDialog(
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
    required UserModel userModel,
    required Verse titleVerse,
    required Verse bodyVerse,
    Verse? confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
  }) async {

    final BuildContext _context = getMainContext();
    final bool _result = await BldrsCenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonVerse,
      invertButtons: invertButtons,
      height: Scale.screenHeight(_context) * 0.7,
      child: UserBanner(
        userModel: userModel,
        width: BldrsCenterDialog.clearWidth(_context),
      ),
    );

    return _result;
  }
  // -----------------------------------------------------------------------------

  /// BZZ DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> bzBannerDialog({
    required BzModel? bzModel,
    required Verse? titleVerse,
    required Verse? bodyVerse,
    Verse? confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
  }) async {

    final bool _result = await BldrsCenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      confirmButtonVerse: confirmButtonVerse,
      boolDialog: boolDialog,
      height: Scale.screenHeight(getMainContext()) * 0.8,
      invertButtons: invertButtons,
      child: BzBanner(
        boxWidth: BldrsCenterDialog.clearWidth(getMainContext()),
        boxHeight: BldrsCenterDialog.clearWidth(getMainContext()),
        bzModel: bzModel,
        bigName: false,
      ),
    );

    return _result;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> bzzBannersDialog({
    required List<BzModel>? bzzModels,
    required Verse titleVerse,
    required Verse bodyVerse,
    Verse? confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
  }) async {

    final double _gridHeight = Scale.screenHeight(getMainContext()) * 0.5;

    final bool _result = await BldrsCenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      confirmButtonVerse: confirmButtonVerse,
      boolDialog: boolDialog,
      invertButtons: invertButtons,
      height: Scale.screenHeight(getMainContext()) * 0.7,
      child: Container(
        width: BldrsCenterDialog.getWidth(getMainContext()),
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
              bzModel: bzzModels![index],
              boxWidth: BldrsCenterDialog.clearWidth(getMainContext()) * 0.8,
              boxHeight: BldrsCenterDialog.clearWidth(getMainContext()),
              bigName: false,
            );

          },
        ),
      ),
    );

    return _result;


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel?> selectBzBottomDialog({
    required List<BzModel>? bzzModels,
  }) async {
    BzModel? _output;

    if (Lister.checkCanLoop(bzzModels) == true){

      final BuildContext context = getMainContext();

      await BottomDialog.showButtonsBottomDialog(
        numberOfWidgets: bzzModels!.length,
        builder: (_, __){

          return <Widget>[

            ...List.generate(bzzModels.length, (index){

              final BzModel _bzModel = bzzModels[index];

              return BottomDialog.wideButton(
                verse: Verse.plain(_bzModel.name),
                icon: _bzModel.logoPath,
                bigIcon: true,
                onTap: () async {

                  _output = _bzModel;

                  await Nav.goBack(context: context);

                  },
              );

            }),

          ];

          },
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> bzOptionsDialog({
    required BzModel bzModel,
    required List<Widget> buttons,
    Verse? title,
  }) async {

    final double _posterWidth = BottomDialog.clearWidth();
    final double _posterHeight = NotePosterBox.getBoxHeight(_posterWidth);
    const double _spacing = 5;
    const double _dotHeight = 10;
    final double _iOffset = _posterHeight * 0.05;
    final double _iSize = _posterHeight * 0.15;
    final int _buttonsCounts = buttons.length;

    double _clearHeight =
            (_buttonsCounts * BottomDialog.wideButtonHeight)
            + _posterHeight
            + (_spacing * _buttonsCounts)
            + _dotHeight
            + BottomDialog.draggerZoneHeight()
            + DotSeparator.getTotalHeight();
    _clearHeight = _clearHeight.clamp(0, Scale.screenHeight(getMainContext()) * 0.8);

    await BottomDialog.showBottomDialog(
      titleVerse: title,
      height: _clearHeight,
      child: FloatingList(
        mainAxisAlignment: MainAxisAlignment.start,
        // padding: EdgeInsets.zero,
        height: _clearHeight,
        columnChildren: <Widget>[

          /// POSTER
          Stack(
            children: <Widget>[

              /// POSTER IMAGE
              BzPosterFlyerBuilder(
                bzID: bzModel.id,
                builder: (bool loading, FlyerModel? flyer) {

                  return ClipRRect(
                    borderRadius: Borderers.cornerAll(BottomDialog.dialogClearCornerValue()),
                    child: BzPoster(
                        width: _posterWidth,
                        bzModel: bzModel,
                        bzSlidesInOneFlyer: flyer,
                        screenName: 'Dialog',
                    ),
                  );

                }
              ),

              /// I ICON
              SuperPositioned(
                enAlignment: Alignment.topRight,
                appIsLTR: UiProvider.checkAppIsLeftToRight(),
                verticalOffset: _iOffset,
                horizontalOffset: _iOffset,
                child: SuperToolTip(
                  verse: const Verse(
                    id: 'phid_poster_for_url',
                    translate: true,
                  ),
                  triggerMode: TooltipTriggerMode.tap,
                  child: BldrsBox(
                    width: _iSize,
                    height: _iSize,
                    icon: Iconz.info,
                    corners: _iSize * 0.5,
                    color: Colorz.black255,
                    iconSizeFactor: 0.6,
                  ),
                ),
              ),

            ],
          ),

          /// SEPARATOR
          const Spacing(size: _spacing),

          /// BUTTONS
          ...List.generate(_buttonsCounts, (index){

            return Padding(
              padding: const EdgeInsets.only(bottom: _spacing),
              child: buttons[index],
            );

          }),

          /// SEPARATOR
          const DotSeparator(),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// AUTHORS DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> bzContactsDialog({
    required BzModel? bzModel,
    required Verse titleVerse,
    required Verse bodyVerse,
    Verse? confirmButtonVerse,
    Function(String authorID, ContactModel contact)? onContact,
  }) async {

    final BuildContext context = getMainContext();
    final double _dialogHeight = Scale.screenHeight(context) - 30;
    final double _gridHeight = _dialogHeight - BldrsCenterDialog.getButtonZoneHeight * 5;
    final int _authorsLength = bzModel?.authors?.length ?? 0;
    final double _bubbleWidth = BldrsCenterDialog.getWidth(context);

    await BldrsCenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      confirmButtonVerse: confirmButtonVerse ?? const Verse(
        id: 'phid_cancel',
        translate: true,
      ),
      height: _dialogHeight,
      child: Center(
        child: Container(
          width: BldrsCenterDialog.getWidth(context),
          height: _gridHeight,
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: _authorsLength + 1,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (_, int index){

              if (index == 0){

                return BzContactsBubble(
                  width: _bubbleWidth,
                  bzModel: bzModel,
                );

              }

              else {

                final int _authorIndex = index - 1;
                return AuthorCard(
                  author: bzModel!.authors![_authorIndex],
                  bzModel: bzModel,
                  onContactTap: onContact,
                  bubbleWidth: _bubbleWidth,
                  moreButtonIsOn: false,
                );

              }

            },
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// FLYERS DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> flyersDialog({
    required List<String>? flyersIDs,
    required Verse titleVerse,
    required Verse bodyVerse,
    Verse? confirmButtonVerse,
    bool boolDialog = true,
  }) async {

    final BuildContext context = getMainContext();
    final double _gridHeight = BldrsCenterDialog.getHeight(context: context) * 0.8;

    final bool _result = await BldrsCenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonVerse,
      height: Scale.screenHeight(context) * 0.7,
      child: Container(
        width: BldrsCenterDialog.getWidth(context),
        height: _gridHeight,
        color: Colorz.white10,
        alignment: Alignment.center,
        child: FlyersGrid(
          hasResponsiveSideMargin: false,
          scrollController: ScrollController(),
          flyersIDs: flyersIDs,
          scrollDirection: Axis.horizontal,
          gridWidth: BldrsCenterDialog.getWidth(context) - 10,
          gridHeight: _gridHeight,
          topPadding: 0,
          numberOfColumnsOrRows: 1,
          screenName: 'flyersDialogGrid',
          gridType: FlyerGridType.heroic,
        ),
      ),

    );

    return _result;


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> flyerDialog({
    required FlyerModel flyer,
    required Verse titleVerse,
    required Verse bodyVerse,
    Verse? confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
  }) async {

    final BuildContext context = getMainContext();
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    final double _dialogHeight = _screenHeight * 0.7;
    final double _flyerBoxHeight = _dialogHeight * 0.5;

    final bool _result = await BldrsCenterDialog.showCenterDialog(
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
            gridHeight: _screenHeight,
            gridWidth: _screenWidth,
          ),
        ),
      ),
    );

    return _result;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> slideDialog({
    required SlideModel? slideModel,
    required Verse titleVerse,
    Verse? bodyVerse,
    Verse? confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
  }) async {

    final BuildContext context = getMainContext();
    final double _screenHeight = Scale.screenHeight(context);
    final double _dialogHeight = _screenHeight * 0.7;
    final double _flyerBoxHeight = _dialogHeight * 0.5;

    final bool _result = await BldrsCenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonVerse,
      height: _dialogHeight,
      invertButtons: invertButtons,
      // copyOnTap: false,
      child: Container(
        width: BldrsCenterDialog.getWidth(context),
        alignment: Alignment.center,
        child: SingleSlide(
          flyerBoxWidth: FlyerDim.flyerWidthByFlyerHeight(
            flyerBoxHeight: _flyerBoxHeight,
          ),
          flyerBoxHeight: _flyerBoxHeight,
          slideModel: slideModel,
          slidePicType: SlidePicType.small,
          loading: false,
          tinyMode: true,
          slideShadowIsOn: true,
          onDoubleTap: null,
          onSlideBackTap: null,
          onSlideNextTap: null,
          canTapSlide: false,
          canPinch: false,
          // canAnimateMatrix: true,
        ),
      ),
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> flyerOptionsDialog({
    required FlyerModel flyer,
    required List<Widget> buttons,
    Verse? title,
  }) async {

  flyer.blogFlyer(invoker: 'onFlyerBzOptionsTap');

  final double _posterWidth = BottomDialog.clearWidth();
  final double _posterHeight = NotePosterBox.getBoxHeight(_posterWidth);
  const double _spacing = 5;
  const double _dotHeight = 10;
  final int _buttonsCounts = buttons.length;

  double _clearHeight =
          (_buttonsCounts * BottomDialog.wideButtonHeight)
          + _posterHeight
          + (_spacing * _buttonsCounts)
          + _dotHeight
          + BottomDialog.draggerZoneHeight()
          + DotSeparator.getTotalHeight();

  _clearHeight = _clearHeight.clamp(0, Scale.screenHeight(getMainContext()) * 0.8);

  final double _iOffset = _posterHeight * 0.05;
  final double _iSize = _posterHeight * 0.15;

  await BottomDialog.showBottomDialog(
    height: _clearHeight,
    titleVerse: title,
    child: Column(
      children: <Widget>[

        /// POSTER
        SizedBox(
          width: _posterWidth,
          height: _posterHeight,
          child: Stack(
            children: <Widget>[

              /// POSTER IMAGE
              BldrsImage(
                pic: StoragePath.flyers_flyerID_poster(flyer.id),
                height: _posterHeight,
                width: _posterWidth,
                corners: BldrsAppBar.corners,
              ),

              /// I ICON
              SuperPositioned(
                enAlignment: Alignment.topRight,
                appIsLTR: UiProvider.checkAppIsLeftToRight(),
                verticalOffset: _iOffset,
                horizontalOffset: _iOffset,
                child: SuperToolTip(
                  verse: const Verse(
                    id: 'phid_poster_for_url',
                    translate: true,
                  ),
                  triggerMode: TooltipTriggerMode.tap,
                  child: BldrsBox(
                    width: _iSize,
                    height: _iSize,
                    icon: Iconz.info,
                    corners: _iSize * 0.5,
                    color: Colorz.black255,
                    iconSizeFactor: 0.6,
                  ),
                ),
              ),

            ],
          ),
        ),

        /// BUTTONS
        SizedBox(
          width: _posterWidth,
          height: _clearHeight - _posterHeight - 80,
          child: FloatingList(
            width: _posterWidth,
            height: _clearHeight - _posterHeight - 80,
            boxAlignment: Alignment.topCenter,
            columnChildren: [

              ... List.generate(_buttonsCounts, (index){

                return Padding(
                  padding: const EdgeInsets.only(bottom: _spacing),
                  child: buttons[index],
                );

              }),

              const DotSeparator(),

            ],
          ),
        ),



      ],
    ),

  );

  }
  // -----------------------------------------------------------------------------

  /// LANG DIALOG

  // --------------------
  static Future<String?> languageDialog() async {
    String? _output;

    final BuildContext context = getMainContext();
    final double _screenHeight = Scale.screenHeight(context);
    final double _dialogHeight = _screenHeight * 0.8;
    final double _buttonWidth = BldrsCenterDialog.getWidth(context);

    await BldrsCenterDialog.showCenterDialog(
      // titleVerse: Verse.plain('Language . اللغة . Idioma . Lingua . Sprache . Langue . 语言'),
      bodyVerse: Verse.plain('Language . اللغة . Idioma . Lingua . Sprache . Langue . 语言'),
      height: _dialogHeight,
      boolDialog: null,
      // copyOnTap: false,
      child: FloatingList(
        width: _buttonWidth,
        height: _dialogHeight * 0.7,
        // boxAlignment: Alignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        columnChildren: <Widget>[

          ...List.generate(Localizer.supportedLangCodes.length, (index){

            final String _langCode = Localizer.supportedLangCodes[index];
            final String _langName = Localizer.getLangNameByCode(_langCode);

            return BldrsBox(
              height: 40,
              width: _buttonWidth * 0.5,
              verseScaleFactor: 0.8,
              verseWeight: VerseWeight.thin,
              verse: Verse.plain(_langName),
              margins: const EdgeInsets.only(bottom: 5),
              color: Colorz.white10,
              onTap: () async {
                _output = _langCode;
                await Nav.goBack(context: context);
              },
            );

          }),

          ],
      ),
    );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PIC DIALOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> picsDialog({
    required List<MediaModel> pics,
    Verse? titleVerse,
    Verse? bodyVerse,
    Verse? confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
    double? picsHeights,
  }) async {

    final BuildContext context = getMainContext();
    final double _screenHeight = Scale.screenHeight(context);
    final double _dialogHeight = _screenHeight * 0.75;
    final double _dialogWidth = BldrsCenterDialog.getWidth(context);
    final double _flyerBoxHeight = picsHeights ?? (_dialogHeight * 0.5);

    final bool _result = await BldrsCenterDialog.showCenterDialog(
      titleVerse: titleVerse,
      bodyVerse: bodyVerse,
      boolDialog: boolDialog,
      confirmButtonVerse: confirmButtonVerse,
      height: _dialogHeight,
      invertButtons: invertButtons,
      // copyOnTap: false,
      child: FloatingList(
        scrollDirection: Axis.horizontal,
        height: _flyerBoxHeight,
        width: _dialogWidth,
        columnChildren: <Widget>[

          ...List.generate(pics.length, (index){

            final MediaModel _pic = pics[index];
            final Dimensions _dims = Dimensions(width: _pic.meta?.width, height: _pic.meta?.height);
            final double aspectRatio = _dims.getAspectRatio();
            final double _height = _flyerBoxHeight;
            final double _width = aspectRatio * _height;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.5),
              child: SuperImage(
                width: _width,
                height: _height,
                pic: _pic.file,
                loading: false,
                corners: _height * 0.1,
              ),
            );

          }),

        ],
      ),
    );

    return _result;

  }
  // --------------------
  static Future<bool> picDialogByXFile({
    required XFile? xFile,
    Verse? titleVerse,
    Verse? bodyVerse,
    Verse? confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
    double? picsHeights,
  }) async {
    bool _output = false;

    final MediaModel? _pic = await MediaModelCreator.fromXFile(
        file: xFile,
        mediaOrigin: MediaOrigin.generated,
        uploadPath: null,
        ownersIDs: [],
        renameFile: null,
    );

    if (_pic != null){

      _output = await picsDialog(
        titleVerse: titleVerse,
        pics: [_pic],
        bodyVerse: bodyVerse,
        boolDialog: boolDialog,
        confirmButtonVerse: confirmButtonVerse,
        invertButtons: invertButtons,
        picsHeights: picsHeights,
      );

    }

    return _output;
  }
  // --------------------
  static Future<bool> picDialogBySuperFile({
    required SuperFile? file,
    Verse? titleVerse,
    Verse? bodyVerse,
    Verse? confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
    double? picsHeights,
  }) async {
    bool _output = false;

    final MediaModel? _pic = await MediaModelCreator.fromSuperFile(
      file: file,
      mediaOrigin: MediaOrigin.generated,
      // uploadPath: null,
      ownersIDs: [],
      // rename: null,
    );

    if (_pic != null){

      _output = await picsDialog(
        titleVerse: titleVerse,
        pics: [_pic],
        bodyVerse: bodyVerse,
        boolDialog: boolDialog,
        confirmButtonVerse: confirmButtonVerse,
        invertButtons: invertButtons,
        picsHeights: picsHeights,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> postersDialogs({
    required List<String> flyersIDs,
    required Verse titleVerse,
    Verse? bodyVerse,
    Verse? confirmButtonVerse,
    bool boolDialog = true,
    bool invertButtons = false,
    double? picsHeights,
  }) async {
    bool _continue = false;

    final List<MediaModel> _posters = await PicProtocols.fetchFlyersPosters(
      flyersIDs: flyersIDs,
    );

    if (Lister.checkCanLoop(_posters) == true){

      _continue = await picsDialog(
        pics: _posters,
        titleVerse: titleVerse,
        bodyVerse: bodyVerse,
        boolDialog: boolDialog,
        confirmButtonVerse: confirmButtonVerse,
        invertButtons: invertButtons,
        picsHeights: picsHeights,
      );

    }

    return _continue;
  }
  // -----------------------------------------------------------------------------

  /// EMAIL DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> emailSentSuccessfullyDialogs({
    required String email,
  }) async {

    await Dialogs.centerNotice(
      verse: const Verse(
        id: 'phid_email_sent_successfully',
        translate: true,
      ),
    );

    await Dialogs.picsDialog(
      titleVerse: const Verse(
        id: 'phid_check_spam_folder',
        translate: true,
      ),
      bodyVerse: const Verse(
        id: 'phid_email_sent_successfully',
        translate: true,
      ),
      boolDialog: false,
      picsHeights: 120,
      pics: await MediaModelCreator.fromLocalAssets(
        localAssets: <String>[
          Iconz.mailJunkScreenshot,
          Iconz.mailSpamScreenshot,
        ],
      ),
      confirmButtonVerse: const Verse(
        id: 'phid_ok_i_will_check_spam',
        translate: true,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// PARAGRAPH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> paragraphDialog({
    required Verse paragraph,
    bool paragraphCentered = true,
    Verse? title,
    Verse? body,
    bool invertButtons = false,
    bool boolDialog = true,
    Verse? confirmButtonVerse,
    Verse? noVerse,
  }) async {

    final BuildContext context = getMainContext();
    final double _dialogWidth = BldrsCenterDialog.clearWidth(context);
    const double _margin = 10;
    final double _paragraphWidth = _dialogWidth - (_margin * 2);

    await BldrsCenterDialog.showCenterDialog(
      titleVerse: title,
      bodyVerse: body,
      confirmButtonVerse: confirmButtonVerse,
      invertButtons: invertButtons,
      boolDialog: boolDialog,
      noVerse: noVerse,
      // bodyCentered: true,
      height: Scale.screenHeight(context) * 0.8,
        child: BldrsText(
          width: _paragraphWidth,
          verse: paragraph,
          maxLines: 1000,
          // appIsLTR: UiProvider.checkAppIsLeftToRight(),
          // textDirection: UiProvider.getAppTextDir(),
          centered: paragraphCentered,
        )
    );

  }
  // -----------------------------------------------------------------------------

  /// PHIDS DIALOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> phidsDialogs({
    required Verse? headline,
    required List<String> phids,
  }) async {
    String? _output;

    final BuildContext context = getMainContext();
    final double _dialogWidth = Bubble.bubbleWidth(context: context) * 0.8;
    final double _buttonWidth = Bubble.clearWidth(context: context, bubbleWidthOverride: _dialogWidth);
    final double _contentHeight = Scale.screenHeight(context) * 0.6;

    await CenterDialog.showCenterDialog(
      context: context,
      backgroundColor: Colorz.nothing,
      bubble: Bubble(
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          headlineVerse: headline,
        ),
        width: _dialogWidth,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        bubbleColor: Colorz.black200,
        child: ClipRRect(
          borderRadius: Bubble.clearBorders(),
          child: SizedBox(
            height: _contentHeight,
            child: FloatingList(
              width: _dialogWidth,
              height: _contentHeight,
              boxCorners: Bubble.clearBorders(),
              columnChildren: <Widget>[

                ...List.generate(phids.length, (index){

                  final String _phid = phids[index];

                  return PhidButton(
                    phid: _phid,
                    width: _buttonWidth,
                    height: 50,
                    margins: const EdgeInsets.only(bottom: 5),
                    onPhidTap: () async {

                      _output = _phid;

                      await Nav.goBack(context: context);

                    },
                  );

                }),

              ],
            ),
          ),
        ),
      ),
    );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// STRINGS DIALOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> stringsDialogs({
    required Verse? headline,
    required List<String> strings,
  }) async {
    String? _output;

    await BottomDialog.showButtonsBottomDialog(
      // buttonHeight: 40,
      numberOfWidgets: strings.length + 1,
      titleVerse: headline,
      builder: (_, __){

        return [

          ...List.generate(strings.length, (index){

            final String _text = strings[index];

            return BldrsText(
              maxLines: 100,
              width: BottomDialog.clearWidth(),
              verse: Verse.plain(_text),
              size: 1,
              centered: false,
              labelColor: Colorz.black150,
              // margin: const EdgeInsets.symmetric(vertical: 1),
              weight: VerseWeight.regular,
              leadingDot: true,
              onTap: () async {

                // _output = _text;
                // await Nav.goBack(context: context);

                await Keyboard.copyToClipboardAndNotify(copy: _text);

                },
            );

          }),

        ];

        },

    );

    return _output;
  }
// -----------------------------------------------------------------------------
}
