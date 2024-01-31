import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_screens/b_user_screens/c_user_editor_screen/user_editor_screen.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// AUTHENTICATORS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> authByEmailSignIn({
  required String email,
  required String password,
  required GlobalKey<FormState> formKey,
  required bool mounted,
}) async {

  /// A - PREPARE FOR AUTH AND CHECK VALIDITY
  final bool _allFieldsAreValid = await _validateForm(
    formKey: formKey,
  );

  if (_allFieldsAreValid == true) {

    WaitDialog.showUnawaitedWaitDialog(
      verse: const Verse(
        id: 'phid_signing_in',
        translate: true,
      ),
    );

    final bool _success = await AuthProtocols.signInBldrsByEmail(
      email: email,
      password: password,
    );

    await WaitDialog.closeWaitDialog();

    await _navAfterAuth(
      firstTimer: false,
      mounted: mounted,
      authSucceeded: _success,
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> authByEmailRegister({
  required String email,
  required String password,
  required GlobalKey<FormState> formKey,
  required bool mounted,
}) async {

  final bool _allFieldsAreValid = await _validateForm(
    formKey: formKey,
  );

  if (_allFieldsAreValid == true) {

    WaitDialog.showUnawaitedWaitDialog(
      verse: const Verse(
        id: 'phid_creating_new_account',
        translate: true,
      ),
    );

    final bool _success = await AuthProtocols.registerUser(
        email: email,
        password: password,
    );

    await WaitDialog.closeWaitDialog();

    /// GO BACK TO EMAIL SIGN IN PAGE
    await _navAfterAuth(
      authSucceeded: _success,
      mounted: mounted,
      firstTimer: true,
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> authBySocialMedia({
  required AuthModel? authModel,
  required bool mounted,
}) async {

  if (authModel != null) {

    WaitDialog.showUnawaitedWaitDialog(
      verse: const Verse(
        id: 'phid_signing_in',
        translate: true,
      ),
    );

    final Map<String, bool> _result = await AuthProtocols.socialAuth(
      authModel: authModel,
    );

    final bool _success = _result['success']!;
    final bool _firstTimer = _result['firstTimer']!;

    await WaitDialog.closeWaitDialog();

    await _navAfterAuth(
      authSucceeded: _success,
      mounted: mounted,
      firstTimer: _firstTimer,
    );

  }

}

// -----------------------------------------------------------------------------

/// CONTROLLING AUTH RESULT

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _navAfterAuth({
  required bool firstTimer,
  required bool mounted,
  required bool authSucceeded,
}) async {

  if (mounted == true && authSucceeded == true){

    final UserModel? userModel = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    if (userModel != null){

      if (firstTimer == true){

        final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(
          userModel: userModel,
        );

        if (_thereAreMissingFields == true){
          await _goToUserEditorForFirstTime(
            userModel: userModel,
              mounted: mounted,
          );
        }
        else {
          await _goToLogoScreen(mounted: mounted);
        }

      }

      else {
        await _goToLogoScreen(mounted: mounted);
      }

    }

  }


}
// --------------------
/// DEPRECATED
/*
Future<void> setUserAndAuthModelsLocallyAndOnLDB({
  required BuildContext context,
  required AuthModel authModel,
}) async {

  final UserModel _userModel = authModel.userModel;

  /// B.3 - so sign in succeeded returning a userModel, then set it in provider
  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final CountryModel _userCountry = await _zoneProvider.fetchCountryByID(
      context: context,
      countryID: _userModel.zone.countryID
  );

  final CityModel _userCity = await _zoneProvider.fetchCityByID(
      context: context,
      cityID: _userModel.zone.cityID
  );

  _usersProvider.setMyUserModelAndCountryAndCity(
    userModel: _userModel,
    countryModel: _userCountry,
    cityModel: _userCity,
    notify: false,
  );

  // await LDBOps.insertMap(
  //     primaryKey: primaryKey,
  //     docName: LDBDoc.auth,
  //     input: authModel.toMap(),
  // );

  _usersProvider.setMyAuthModel(
    authModel: authModel,
    notify: true,
  );

}
// --------------------
Future<void> _controlMissingFieldsCase({
  required BuildContext context,
  required AuthModel authModel,
}) async {

  await showMissingFieldsDialog(
    context: context,
    userModel: authModel.userModel,
  );

  await Nav.goToNewScreen(
      context: context,
      screen: EditProfileScreen(
        userModel: authModel.userModel,
        onFinish: () async {

          await _goToLogoScreen(context);

          },
      )

  );

}
// --------------------
Future<void> showMissingFieldsDialog({
  required BuildContext context,
  required UserModel userModel,
}) async {

  final List<String> _missingFields = UserModel.missingFields(userModel);
  final String _missingFieldsString = TextGen.generateStringFromStrings(
      strings: _missingFields,
  );

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'Complete Your profile',
    body:
    'Required fields :\n'
        '$_missingFieldsString',
  );

}
*/
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _goToLogoScreen({
  required bool mounted,
}) async {

  await NotesProvider.proInitializeNoteStreams(mounted: mounted);

  await Routing.goTo(route: TabName.bid_My_Info);

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _goToUserEditorForFirstTime({
  required UserModel userModel,
  required bool mounted,
}) async {

  await BldrsNav.goToNewScreen(
      screen: UserEditorScreen(
        initialTab: UserEditorTab.pic,
        firstTimer: true,
        userModel: userModel,
        reAuthBeforeConfirm: false,
        canGoBack: false,
        validateOnStartup: false,
        checkLastSession: false,
        onFinish: () async {

          await Routing.restartToAfterHomeRoute(
            routeName: TabName.bid_My_Info,
          );

        },
      )

  );

}
// -----------------------------------------------------------------------------

/// EMAIL AUTH VALIDATION

// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _validateForm({
  required GlobalKey<FormState> formKey,
}) async {

  /// MINIMIZE KEYBOARD
  await Keyboard.closeKeyboard();

  /// CHECK VALIDITY
  final bool? _allFieldsAreValid = Formers.validateForm(formKey);


  return _allFieldsAreValid ?? false;
}
// -----------------------------------------------------------------------------

/// FORGOT PASSWORD

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onForgotPassword({
  required GlobalKey<FormState> formKey,
  required String email,
}) async {

  await _validateForm(
    formKey: formKey,
  );

  final bool _emailIsGood = Formers.emailValidator(
    email: email,
    canValidate: true,
  ) == null;

  if (_emailIsGood == true){

    final Verse _body = Verse.plain('${getWord('phid_reset_pass_email_will_be_sent_to')}\n$email');

    final bool _go = await Dialogs.confirmProceed(
      titleVerse: const Verse(
        id: 'phid_send_reset_password_email',
        translate: true,
      ),
      bodyVerse: _body,
      yesVerse: const Verse(
        id: 'phid_send',
        translate: true,
      ),
    );

    if (_go == true){

      WaitDialog.showUnawaitedWaitDialog();

      final bool _good = await EmailAuthing.sendPasswordResetEmail(
        email: email,
        onError: (String? error) async {
          await AuthProtocols.onAuthError(
            error: error,
            invoker: 'onForgotPassword',
          );
          },
      );

      await WaitDialog.closeWaitDialog();

      if (_good == true){

        await Dialogs.emailSentSuccessfullyDialogs(
          email: email,
        );

      }

    }

  }

}
// -----------------------------------------------------------------------------
