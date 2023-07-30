import 'dart:async';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/user_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/account_ldb_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:flutter/material.dart';
import 'package:basics/layouts/nav/nav.dart';

// -----------------------------------------------------------------------------

/// AUTHENTICATORS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> authByEmailSignIn({
  required String email,
  required String password,
  required GlobalKey<FormState> formKey,
  required bool mounted,
  required bool rememberMe,
}) async {

  /// A - PREPARE FOR AUTH AND CHECK VALIDITY
  final bool _allFieldsAreValid = _prepareForEmailAuthOps(
    formKey: formKey,
  );

  if (_allFieldsAreValid == true) {

    pushWaitDialog(
      verse: const Verse(
        id: 'phid_signing_in',
        translate: true,
      ),
    );

    final bool _success = await AuthProtocols.signInBldrsByEmail(
      email: email,
      password: password,
    );

    await _rememberEmailAndNav(
      email: email,
      success: _success,
      mounted: mounted,
      password: password,
      rememberMe: rememberMe,
    );

  }

  else {
    blog('controlEmailSignin : _allFieldsAreValid : $_allFieldsAreValid');
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> authByEmailRegister({
  required BuildContext context,
  required String email,
  required String password,
  required String passwordConfirmation,
  required GlobalKey<FormState> formKey,
  required bool rememberMe,
  required bool mounted,
}) async {

  /// A - PREPARE FOR AUTH AND CHECK VALIDITY
  final bool _allFieldsAreValid = _prepareForEmailAuthOps(
    formKey: formKey,
  );

  if (_allFieldsAreValid == true) {

    pushWaitDialog(
      verse: const Verse(
        id: 'phid_creating_new_account',
        translate: true,
      ),
    );

    ///

    final bool _success = await AuthProtocols.registerInBldrsByEmail(
      email: email,
      password: password,
    );

    await _rememberEmailAndNav(
      email: email,
      success: _success,
      mounted: mounted,
      password: password,
      rememberMe: rememberMe,
    );

  }

  ///
  else {
    blog('_allFieldsAreValid : controlEmailRegister : $_allFieldsAreValid');
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> authBySocialMedia({
  required AuthModel? authModel,
  required bool mounted,
}) async {

  if (authModel != null) {

    pushWaitDialog(
      verse: const Verse(
        id: 'phid_creating_new_account',
        translate: true,
      ),
    );

    final bool _success = await AuthProtocols.composeOrUpdateUser(
      authModel: authModel,
      authError: null,
    );

    await _rememberEmailAndNav(
      email: null,
      success: _success,
      mounted: mounted,
      password: null,
      rememberMe: false,
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _rememberEmailAndNav({
  required bool success,
  required bool rememberMe,
  required String? email,
  required String? password,
  required bool mounted,
}) async {

  /// ON SUCCESS
  if (success == true) {

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    await rememberOrForgetAccount(
      rememberMe: rememberMe,
      account: AccountModel(
        id: _userModel?.id,
        email: email,
        password: password,
      ),
    );

    if (mounted == true) {
      await WaitDialog.closeWaitDialog();
    }

    await _navAfterAuth(
      userModel: _userModel,
      firstTimer: false,
    );

  }

  /// ON FAILURE
  else {
    if (mounted == true) {
      await WaitDialog.closeWaitDialog();
    }
  }

}
// -----------------------------------------------------------------------------

/// CONTROLLING AUTH RESULT

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _navAfterAuth({
  required UserModel? userModel,
  required bool firstTimer,
}) async {

  if (userModel != null){

    if (firstTimer == true){

      final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(
        userModel: userModel,
      );

      if (_thereAreMissingFields == true){
        await _goToUserEditorForFirstTime(
          userModel: userModel,
        );
      }
      else {
        await _goToLogoScreen();
      }

    }

    else {
      await _goToLogoScreen();
    }

  }

  else {
    blog('controlAuthResult : something went wrong');
  }

}
// --------------------
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
Future<void> _goToLogoScreen() async {
  await BldrsNav.goToLogoScreenAndRemoveAllBelow(
      animatedLogoScreen: true,
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _goToUserEditorForFirstTime({
  required UserModel userModel,
}) async {

  await Nav.goToNewScreen(
      context: getMainContext(),
      screen: UserEditorScreen(
        initialTab: UserEditorTab.pic,
        userModel: userModel,
        reAuthBeforeConfirm: false,
        canGoBack: false,
        validateOnStartup: false,
        checkLastSession: false,
        onFinish: () async {
          await _goToLogoScreen();
        },
      )

  );


}
// -----------------------------------------------------------------------------

/// EMAIL AUTH VALIDATION

// --------------------
/// TESTED : WORKS PERFECT
bool _prepareForEmailAuthOps({
  required GlobalKey<FormState> formKey,
}) {

  /// MINIMIZE KEYBOARD
  Keyboard.closeKeyboard();

  /// CHECK VALIDITY
  final bool? _allFieldsAreValid = formKey.currentState?.validate();


  return _allFieldsAreValid ?? false;
}
// -----------------------------------------------------------------------------

/// REMEMBERING ME

// --------------------
/// TESTED : WORKS PERFECT
Future<void> rememberOrForgetAccount({
  required AccountModel? account,
  required bool rememberMe,
}) async {
  if (
      account != null
      &&
      account.password != null
      &&
      account.email != null
  ) {

    if (rememberMe == true) {
      await AccountLDBOps.insertAccount(
        account: account,
      );
    }

    else {
      await AccountLDBOps.deleteAccount(
        id: account.id,
      );
    }

  }
}
// -----------------------------------------------------------------------------

/// FORGOT PASSWORD

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onForgotPassword({
  required GlobalKey<FormState> formKey,
  required String email,
}) async {

  /// MINIMIZE KEYBOARD
  Keyboard.closeKeyboard();

  Formers.validateForm(formKey);

  final bool _emailIsGood = Formers.emailValidator(
    email: email,
    canValidate: true,
  ) == null;

  if (_emailIsGood == true){

    final Verse _body = Verse.plain('${xPhrase('phid_reset_pass_email_will_be_sent_to')}\n$email');

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
          await AuthProtocols.onAuthError(error: error);
          },
      );

      await WaitDialog.closeWaitDialog();

      if (_good == true){

        await Dialogs.centerNotice(
          verse: const Verse(
            id: 'phid_success',
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
          pics: await PicModel.createPicsFromLocalAssets(
            width: 300,
            assets: [
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

    }

  }

}
// -----------------------------------------------------------------------------
