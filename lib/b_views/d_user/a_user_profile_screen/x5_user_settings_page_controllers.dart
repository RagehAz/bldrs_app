import 'dart:async';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/a_user_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
Future<void> onEditProfileTap(BuildContext context) async {

  final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
  final UserModel _myUserModel = _userProvider.myUserModel;

  await Nav.goToNewScreen(
      context: context,
      screen: EditProfileScreen(
        userModel: _myUserModel,
        reAuthBeforeConfirm: true,
        canGoBack: true,
        onFinish: () async {
          Nav.goBack(
            context: context,
            invoker: 'onEditProfileTap',
          );
        },
      )
  );

}
// -----------------------------------------------------------------------------

/// DELETION OPS

// --------------------
Future<void> onDeleteMyAccount(BuildContext context) async {
  blog('on delete user tap aho');

  bool _continue = await _authorshipDeletionCheckups(context);

  if (_continue == true){
    _continue = await reAuthenticateUser(
      context: context,
      dialogTitleVerse: const Verse(
        text: 'phid_delete_your_account_?',
        translate: true,
      ),
      dialogBodyVerse: const Verse(
        pseudo: 'Are you sure you want to delete your Account ?',
        text: 'phid_delete_account_description',
        translate: true,
      ),
      confirmButtonVerse: const Verse(
        text: 'phid_yes_delete',
        translate: true,
      ),
    );
  }

  if (_continue == true){

    await UserProtocols.wipeUser(
      context: context,
      showWaitDialog: true,
    );

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        pseudo: 'Account is Deleted Successfully',
        text: 'phid_account_is_deleted',
        translate: true,
      ),
      bodyVerse: const Verse(
        text: 'phid_it_has_been_an_honor',
        translate: true,
      ),
      confirmButtonVerse: const Verse(
        text: 'phid_the_honor_is_mine',
        translate: true,
      ),
    );

    /// SIGN OUT OPS
    await onSignOut(context);

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _authorshipDeletionCheckups(BuildContext context) async {

  bool _canDeleteAndExitMyBzz = false;

  final UserModel _userModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  if (_userModel != null){

    final bool _userIsAuthor = UserModel.checkUserIsAuthor(_userModel);

    blog('_userIsAuthor : $_userIsAuthor');

    /// USER IS AN AUTHOR
    if (_userIsAuthor == true){

      final List<BzModel> _myBzzModels = BzzProvider.proGetMyBzz(
        context: context,
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
        _canDeleteAndExitMyBzz = await Dialogs.bzzBannersDialog(
          context: context,
          bzzModels: _myBzzICreated,
          titleVerse: const Verse(
            pseudo: 'Your business Accounts Will be permanently deleted',
            text: 'phid_bz_will_be_deleted',
            translate: true,
          ),
          bodyVerse: Verse(
            text: 'You have created ${_myBzzICreated.length} business accounts which will be permanently deleted if you continue.',
            variables: _myBzzICreated.length,
            translate: true,
          ),
          confirmButtonVerse: const Verse(
            text: 'phid_delete_all',
            translate: true,
          ),
        );

      }
      /// USER HAS NO CREATED BZZ BUT MIGHT BE AUTHOR IN OTHERS
      else {
        _canDeleteAndExitMyBzz = true;
      }

      /// USER IS AUTHOR BUT DID NOT CREATE ANY BZZ
      if (Mapper.checkCanLoopList(_myBzzIDidNotCreate) == true && _canDeleteAndExitMyBzz == true){

        /// SHOW WILL EXIT BZZ DIALOG
        _canDeleteAndExitMyBzz = await Dialogs.bzzBannersDialog(
          context: context,
          bzzModels: _myBzzIDidNotCreate,
          titleVerse: const Verse(
            pseudo: 'Delete your membership in these Business accounts',
            text: 'phid_delete_bz_membership',
            translate: true,
          ),
          bodyVerse: Verse(
            pseudo: 'You are a member in ${_myBzzIDidNotCreate.length} business accounts which you will delete your membership in each of them if you continue.',
            text: 'phid_delete_bz_membership_description',
            translate: true,
            variables: _myBzzIDidNotCreate.length,
          ),
          confirmButtonVerse: const Verse(
            text: 'phid_continue',
            translate: true,
          ),
        );

      }
      /// BOGUS USE CASE,
      else {
        _canDeleteAndExitMyBzz = true;
      }

    }

    /// USER IS NOT AN AUTHOR
    else {
      _canDeleteAndExitMyBzz = true;
    }

  }

  blog('_canDeleteAndExitMyBzz : $_canDeleteAndExitMyBzz');

  return _canDeleteAndExitMyBzz;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> reAuthenticateUser({
  @required BuildContext context,
  @required Verse dialogTitleVerse,
  @required Verse dialogBodyVerse,
  @required Verse confirmButtonVerse,
}) async {

  bool _canContinue = false;

  final UserModel _userModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  if (_userModel != null){

    _canContinue = await Dialogs.userDialog(
      context: context,
      titleVerse: dialogTitleVerse,
      bodyVerse: dialogBodyVerse,
      confirmButtonVerse: confirmButtonVerse,
      userModel: _userModel,
    );

    if (_canContinue == true){

      final bool _passwordIsCorrect = await _checkPassword(
        context: context,
        userModel: _userModel,
      );

      Keyboard.closeKeyboard(context);

      /// NO PASSWORD PROVIDED
      if (_passwordIsCorrect == null){

        _canContinue = false;

      }

      /// ON WRONG PASSWORD
      else if (_passwordIsCorrect == false){

        unawaited(TopDialog.showTopDialog(
          context: context,
          firstVerse: const Verse(
            text: 'phid_wrong_password',
            translate: true,
          ),
          secondVerse: const Verse(
            text: 'phid_please_try_again',
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
Future<bool> _checkPassword({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  bool _passwordIsCorrect;

  final String _password = await Dialogs.showPasswordDialog(context);

  if (_password.isNotEmpty == true){

    final AuthModel _authModel = await AuthLDBOps.readAuthModel();

    final String _email = ContactModel.getValueFromContacts(
      contacts: userModel?.contacts,
      contactType: ContactType.email,
    ) ?? _authModel.email;

    _passwordIsCorrect = await AuthFireOps.passwordIsCorrect(
      context: context,
      password: _password,
      email: _email,
    );

  }

  return _passwordIsCorrect;
}
// -----------------------------------------------------------------------------
