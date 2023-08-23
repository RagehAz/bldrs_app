import 'dart:async';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/user_editor_screen.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/b_views/h_app_settings/fcm_topics_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// INVITE BZZ

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onInviteBusinessesTap(BuildContext context) async {
  // await Nav.goToNewScreen(
  //   context: context,
  //   screen: const InviteBusinessesScreen(),
  // );
}
// -----------------------------------------------------------------------------

/// EDIT

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onEditProfileTap({
  required UserEditorTab initialTab,
}) async {

  final UserModel? _myUserModel = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
  );

  await Nav.goToNewScreen(
      context: getMainContext(),
      screen: UserEditorScreen(
        initialTab: initialTab,
        firstTimer: false,
        userModel: _myUserModel,
        reAuthBeforeConfirm: true,
        validateOnStartup: true,
        // checkLastSession: true,
        canGoBack: true,
        onFinish: () async {
          await BldrsNav.restartAndRoute(
            routeName: Routing.myUserScreen,
          );
        },
      )
  );

}
// -----------------------------------------------------------------------------

/// FCM TOPICS SETTINGS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoToFCMTopicsScreen(BuildContext context) async {

  await Nav.goToNewScreen(
      context: context,
      screen: const FCMTopicsScreen(
        partyType: PartyType.user,
      ),
  );

}
// -----------------------------------------------------------------------------

/// DELETION OPS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onDeleteMyAccount() async {

  bool _continue = await _authorshipDeletionCheckups();

  if (_continue == true){
    _continue = await reAuthenticateUser(
      dialogTitleVerse: const Verse(
        id: 'phid_delete_your_account_?',
        translate: true,
      ),
      dialogBodyVerse: const Verse(
        id: 'phid_delete_account_description',
        translate: true,
      ),
      confirmButtonVerse: const Verse(
        id: 'phid_yes_delete',
        translate: true,
      ),
    );
  }

  if (_continue == true){

    await UserProtocols.wipeUser(
      context: getMainContext(),
      showWaitDialog: true,
    );

    blog('finished wipe user protocols');

    await CenterDialog.showCenterDialog(
      titleVerse: const Verse(
        pseudo: 'Account is Deleted Successfully',
        id: 'phid_account_is_deleted',
        translate: true,
      ),
      bodyVerse: const Verse(
        id: 'phid_it_has_been_an_honor',
        translate: true,
      ),
      confirmButtonVerse: const Verse(
        id: 'phid_the_honor_is_mine',
        translate: true,
      ),
    );

    blog('finished center dialog');

    /// SIGN OUT OPS
    await onSignOut();

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _authorshipDeletionCheckups() async {

  bool _canDelete = false;

  final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    context: getMainContext(),
    listen: false,
  );

  if (_userModel != null){

    final bool _userIsAuthor = UserModel.checkUserIsAuthor(_userModel);

    // blog('_userIsAuthor : $_userIsAuthor');

    /// USER IS AN AUTHOR
    if (_userIsAuthor == true){

      final List<BzModel> _myBzzModels = BzzProvider.proGetMyBzz(
        context: getMainContext(),
        listen: false,
      );

      final List<BzModel> _myBzzICreated = BzModel.getBzzByCreatorID(
        bzzModels: _myBzzModels,
        creatorID: _userModel.id,
      );

      final List<BzModel> _myBzzIDidNotCreate = BzModel.getBzzIDidNotCreate(
        bzzModels: _myBzzModels,
        userID: _userModel.id,
      );

      /// USER HAS CREATED SOME BZZ
      if (Mapper.checkCanLoopList(_myBzzICreated) == true){

        /// SHOW WILL DELETE BZZ DIALOG
        _canDelete = await Dialogs.bzzBannersDialog(
          invertButtons: true,
          bzzModels: _myBzzICreated,
          titleVerse: const Verse(
            id: 'phid_delete_bz_accounts_?',
            translate: true,
          ),
          bodyVerse: Verse(
            id: 'phid_bzz_deletion_warning',
            variables: _myBzzICreated.length,
            translate: true,
          ),
          confirmButtonVerse: const Verse(
            id: 'phid_delete',
            translate: true,
          ),
        );
        // blog('_authorshipDeletionCheckups received : $_canDelete');


      }
      /// USER HAS NO CREATED BZZ BUT MIGHT BE AUTHOR IN OTHERS
      else {
        _canDelete = true;
      }

      /// USER IS AUTHOR BUT DID NOT CREATE ANY BZZ
      if (_canDelete == true){
        if (Mapper.checkCanLoopList(_myBzzIDidNotCreate) == true){

            /// SHOW WILL EXIT BZZ DIALOG
            _canDelete = await Dialogs.bzzBannersDialog(
              bzzModels: _myBzzIDidNotCreate,
              invertButtons: true,
              titleVerse: const Verse(
                id: 'phid_delete_bz_membership',
                translate: true,
              ),
              bodyVerse: Verse(
                id: 'phid_delete_bz_membership_description',
                translate: true,
                variables: _myBzzIDidNotCreate.length,
              ),
              confirmButtonVerse: const Verse(
                id: 'phid_exit',
                translate: true,
              ),
            );

          }
      }

    }

    /// USER IS NOT AN AUTHOR
    else {
      _canDelete = true;
    }

  }

  // blog('_authorshipDeletionCheckups _canDelete : $_canDelete');

  return _canDelete;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> reAuthenticateUser({
  required Verse dialogTitleVerse,
  required Verse dialogBodyVerse,
  required Verse confirmButtonVerse,
}) async {

  bool _canContinue = false;

  final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    context: getMainContext(),
    listen: false,
  );

  if (_userModel != null){

    _canContinue = await Dialogs.userDialog(
      titleVerse: dialogTitleVerse,
      bodyVerse: dialogBodyVerse,
      confirmButtonVerse: confirmButtonVerse,
      invertButtons: true,
      userModel: _userModel,
    );

    if (_canContinue == true){

      final bool? _passwordIsCorrect = await _checkPassword(
        userModel: _userModel,
      );

      await Keyboard.closeKeyboard();

      /// NO PASSWORD PROVIDED
      if (_passwordIsCorrect == null){
        _canContinue = false;
      }

      /// ON WRONG PASSWORD
      else if (_passwordIsCorrect == false){

        unawaited(TopDialog.showTopDialog(
          firstVerse: const Verse(
            id: 'phid_wrongPassword',
            translate: true,
          ),
          secondVerse: const Verse(
            id: 'phid_please_try_again',
            translate: true,
          ),
        ));

        _canContinue = false;

      }

      // /// ON CORRECT PASSWORD
      // else {
      //
      // }

    }

  }


  return _canContinue;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool?> _checkPassword({
  required UserModel? userModel,
}) async {

  bool? _passwordIsCorrect;

  final String? _password = await Dialogs.showPasswordDialog();

  if (Mapper.boolIsTrue(_password?.isNotEmpty) == true){

    final String? _authEmail = await Authing.getAuthEmail();

    final String? _email = ContactModel.getValueFromContacts(
      contacts: userModel?.contacts,
      contactType: ContactType.email,
    ) ?? _authEmail;

    if (_password != null && _email != null){
      _passwordIsCorrect = await EmailAuthing.checkPasswordIsCorrect(
        password: _password,
        email: _email,
      );
    }

  }

  return _passwordIsCorrect;
}
// -----------------------------------------------------------------------------
