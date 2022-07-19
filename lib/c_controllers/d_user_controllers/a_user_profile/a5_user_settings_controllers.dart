import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/d_user/b_user_editor/a_user_editor_screen.dart';
import 'package:bldrs/b_views/x_screens/d_user/c_invite_people/c_invite_businesses_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart' as Dialogz;
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/i_app_settings_controllers/app_settings_controllers.dart';
import 'package:bldrs/c_protocols/user_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// INVITE BZZ

// ---------------------------------
/// TESTED : WORKS PERFECT
Future<void> onInviteBusinessesTap(BuildContext context) async {
  await Nav.goToNewScreen(
    context: context,
    screen: const InviteBusinessesScreen(),
  );
}
// -----------------------------------------------------------------------------

/// EDIT

// ---------------------------------
/// TESTED : WORKS PERFECT
Future<void> onEditProfileTap(BuildContext context) async {

  final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
  final UserModel _myUserModel = _userProvider.myUserModel;

  await Nav.goToNewScreen(
      context: context,
      screen: EditProfileScreen(
        userModel: _myUserModel,
        canGoBack: true,
        onFinish: () async {
          Nav.goBack(context);
        },
      )
  );

}
// -----------------------------------------------------------------------------

/// DELETION OPS

// ---------------------------------
Future<void> onDeleteMyAccount(BuildContext context) async {
  blog('on delete user tap aho');

  bool _continue = await _authorshipDeletionCheckups(context);

  if (_continue == true){
    _continue = await _userPasswordCheckups(context);
  }

  if (_continue == true){

    await UserProtocol.deleteUserProtocol(
      context: context,
      showWaitDialog: true,
    );

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Account is Deleted Successfully',
      body: 'It has been an honor.',
      confirmButtonText: 'The Honor is Mine',
    );

    /// SIGN OUT OPS
    await onSignOut(context);

  }

}
// ---------------------------------
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
        _canDeleteAndExitMyBzz = await Dialogz.bzzBannersDialog(
          context: context,
          bzzModels: _myBzzICreated,
          title: 'Your business Accounts Will be permanently deleted',
          body: 'You have created ${_myBzzICreated.length} business accounts which will be permanently deleted if you continue.',
          confirmButtonText: 'Delete All',
        );

      }
      /// USER HAS NO CREATED BZZ BUT MIGHT BE AUTHOR IN OTHERS
      else {
        _canDeleteAndExitMyBzz = true;
      }

      /// USER IS AUTHOR BUT DID NOT CREATE ANY BZZ
      if (Mapper.checkCanLoopList(_myBzzIDidNotCreate) == true && _canDeleteAndExitMyBzz == true){

        /// SHOW WILL EXIT BZZ DIALOG
        _canDeleteAndExitMyBzz = await Dialogz.bzzBannersDialog(
          context: context,
          bzzModels: _myBzzIDidNotCreate,
          title: 'Delete your membership in these Business accounts',
          body: 'You are a member in ${_myBzzIDidNotCreate.length} business accounts which you will delete your membership in each of them if you continue.',
          confirmButtonText: 'Continue',
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
// ---------------------------------
/// TESTED : WORKS PERFECT
Future<bool> _userPasswordCheckups(BuildContext context) async {

  bool _canContinue = false;

  final UserModel _userModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  if (_userModel != null){

    _canContinue = await Dialogz.userDialog(
      context: context,
      title: 'Delete your Account',
      body: 'Are you sure you want to delete your Account ?',
      confirmButtonText: 'Yes, Delete',
      userModel: _userModel,
    );

    if (_canContinue == true){

      final bool _passwordIsCorrect = await _checkPassword(
        context: context,
        userModel: _userModel,
      );

      closeKeyboard(context);

      /// NO PASSWORD PROVIDED
      if (_passwordIsCorrect == null){

        _canContinue = false;

      }

      /// ON WRONG PASSWORD
      else if (_passwordIsCorrect == false){

        unawaited(TopDialog.showTopDialog(
          context: context,
          firstLine: 'Wrong password',
          secondLine: 'Please try again',
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
// ---------------------------------
/// TESTED : WORKS PERFECT
Future<bool> _checkPassword({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  bool _passwordIsCorrect;

  final String _password = await Dialogz.showPasswordDialog(context);

  if (_password.isNotEmpty == true){

    final AuthModel _authModel = await AuthLDBOps.readAuthModel();

    final String _email = ContactModel.getAContactValueFromContacts(
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
