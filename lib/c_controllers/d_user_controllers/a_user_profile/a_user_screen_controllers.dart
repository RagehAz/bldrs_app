import 'dart:async';

import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/secondary_models/link_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/d_user/b_user_editor/a_user_editor_screen.dart';
import 'package:bldrs/b_views/x_screens/d_user/c_invite_people/c_invite_businesses_screen.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/i_app_settings_controllers/app_settings_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/contacts_service/contacts_service.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart' as Atlas;
import 'package:bldrs/f_helpers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
/*
/// USER SCREEN TABS

// ---------------------------------
int getInitialUserScreenTabIndex(BuildContext context){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final UserTab _currentTab = _uiProvider.currentUserTab;
  final int _index = UserModel.getUserTabIndex(_currentTab);
  return _index;
}
// ---------------------------------
void onChangeUserScreenTabIndexWhileAnimation({
  @required BuildContext context,
  @required TabController tabController,
}){

  if (tabController.indexIsChanging == false) {

    final int _indexFromAnimation = (tabController.animation.value).round();
    onChangeUserScreenTabIndex(
      context: context,
      index: _indexFromAnimation,
      tabController: tabController,
    );

  }

}
// ---------------------------------
void onChangeUserScreenTabIndex({
  @required BuildContext context,
  @required int index,
  @required TabController tabController,
}) {

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  final UserTab _newUserTab = UserModel.userProfileTabsList[index];
  final UserTab _previousUserTab = _uiProvider.currentUserTab;

  /// ONLY WHEN THE TAB CHANGES FOR REAL IN THE EXACT MIDDLE BETWEEN BUTTONS
  if (_newUserTab != _previousUserTab){
    // blog('index is $index');
    _uiProvider.setCurrentUserTab(_newUserTab);
    tabController.animateTo(index,
        curve: Curves.easeIn,
        duration: Ratioz.duration150ms
    );
  }

}
 */
// -----------------------------------------------------------------------------

/// PROFILE OPTIONS

// ---------------------------------
Future<void> onMoreOptionsTap (BuildContext ctx) async {
  blog('more button in user screen');

  const double _buttonHeight = 50;

    await BottomDialog.showButtonsBottomDialog(
      context: ctx,
      draggable: true,
      buttonHeight: _buttonHeight,
      title: 'Profile options',
      numberOfWidgets: 10,
      builder: (context, phrasePro){

        blog('ahoooooooo lalalala');

        return <Widget>[

          /// EDIT PROFILE
          BottomDialog.wideButton(
            context: context,
            height: _buttonHeight,
            verse: superPhrase(context, 'phid_editProfile', providerOverride: phrasePro),
            icon: Iconz.gears,
            onTap: () => onEditProfileTap(context),
          ),

          // /// CHANGE APP LANGUAGE
          // BottomDialog.wideButton(
          //   context: xxx,
          //   height: _buttonHeight,
          //   verse: superPhrase(xxx, 'phid_changeLanguage', providerOverride: phrasePro),
          //   icon: Iconz.language,
          //   onTap: () => onChangeAppLanguageTap(xxx),
          // ),

          // const BubblesSeparator(bottomMarginIsOn: false,),

          // /// ABOUT BLDRS
          // BottomDialog.wideButton(
          //   context: xxx,
          //   height: _buttonHeight,
          //   verse: '${superPhrase(xxx, 'phid_about', providerOverride: phrasePro)} ${Wordz.bldrsFullName(xxx)}',
          //   icon: Iconz.pyramidSingleYellow,
          //   onTap: () => onAboutBldrsTap(xxx),
          // ),

          // /// FEEDBACK
          // BottomDialog.wideButton(
          //   context: xxx,
          //   height: _buttonHeight,
          //   verse: superPhrase(xxx, 'phid_feedback', providerOverride: phrasePro),
          //   icon: Iconz.utSearching,
          //   onTap: () => onFeedbackTap(xxx),
          // ),

          // /// TERMS AND REGULATIONS
          // BottomDialog.wideButton(
          //   context: context,
          //   height: _buttonHeight,
          //   verse: superPhrase(context, 'phid_termsRegulations', providerOverride: phrasePro),
          //   icon: Iconz.terms,
          //   onTap: () => onTermsAndRegulationsTap(context),
          // ),

          // const BubblesSeparator(bottomMarginIsOn: false,),

          // /// CREATE NEW BZ ACCOUNT
          // BottomDialog.wideButton(
          //   context: context,
          //   height: _buttonHeight,
          //   verse: superPhrase(context, 'phid_createBzAccount', providerOverride: phrasePro),
          //   icon: Iconz.bz,
          //   onTap: () => onCreateNewBzTap(context),
          // ),

          // /// INVITE FRIENDS
          // BottomDialog.wideButton(
          //   context: context,
          //   height: _buttonHeight,
          //   verse: superPhrase(context, 'phid_inviteFriends', providerOverride: phrasePro),
          //   icon: Iconizer.shareAppIcon(),
          //   onTap: () => onInviteFriendsTap(context),
          // ),

          // const BubblesSeparator(bottomMarginIsOn: false,),

          /// DELETE MY ACCOUNT
          BottomDialog.wideButton(
            context: context,
            height: _buttonHeight,
            verse: superPhrase(context, 'phid_delete_my_account', providerOverride: phrasePro),
            icon: Iconz.xSmall,
            onTap: () => onDeleteMyAccount(context),
          ),

          /// SIGN OUT
          BottomDialog.wideButton(
            context: context,
            height: _buttonHeight,
            verse: superPhrase(context, 'phid_signOut', providerOverride: phrasePro),
            icon: Iconz.exit,
            onTap: () => onSignOut(context),
          ),

        ];

      },

    );

}
// ---------------------------------
Future<void> onEditProfileTap(BuildContext context) async {

  final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
  final UserModel _myUserModel = _userProvider.myUserModel;

  await Nav.goToNewScreen(
      context: context,
      screen: EditProfileScreen(
        userModel: _myUserModel,
        onFinish: () async {
          Nav.goBack(context);
        },
      )
  );

}
// ---------------------------------
Future<void> onInviteFriendsTap(BuildContext context) async {

  // final bool _result = await CenterDialog.showCenterDialog(
  //   context: context,
  //   title: 'Share App Link ?',
  //   body: LinkModel.bldrsWebSiteLink.url,
  //   boolDialog: true,
  // );
  //
  // if (_result == true){
    await Launcher.shareLink(
      context: context,
      link: LinkModel.bldrsWebSiteLink,
    );
  // }

}
// -----------------------------------------------------------------------------

/// DELETION OPS

// ---------------------------------
Future<void> onDeleteMyAccount(BuildContext context) async {
  blog('on delete user tap');

  final UserModel _userModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  if (_userModel != null){

    final bool _result = await _showDeleteUserDialog(
      context: context,
      userModel: _userModel,
    );

    if (_result == true){

      final bool _passwordIsCorrect = await _checkPassword(
        context: context,
        userModel: _userModel,
      );

      /// ON WRONG PASSWORD
      if (_passwordIsCorrect == false){

        unawaited(
            TopDialog.showTopDialog(
              context: context,
              firstLine: 'Wrong password',
              secondLine: 'Please try again',
            ));

      }

      /// ON CORRECT PASSWORD
      else {

        /// START WAITING : DIALOG IS CLOSED INSIDE BELOW DELETION OPS
        unawaited(WaitDialog.showWaitDialog(
          context: context,
          loadingPhrase: 'Deleting your Account',
        ));

        final bool _userIsAuthor = UserModel.checkUserIsAuthor(_userModel);

        /// WHEN USER IS AUTHOR
        if (_userIsAuthor == true){

          await _deleteAuthorUserOps(
            context: context,
            userModel: _userModel,
          );

        }

        /// WHEN USER IS NOT AUTHOR
        else {

          await _deleteNonAuthorUserOps(
            context: context,
            userModel: _userModel,
          );

        }

      }

    }

  }

}
// ---------------------------------
Future<bool> _showDeleteUserDialog({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Delete your Account',
    body: 'Are you sure you want to delete your Account ?',
    confirmButtonText: 'Yes, Delete',
    boolDialog: true,
    height: Scale.superScreenHeight(context) * 0.6,
    child: Column(
      children: <Widget>[

        /// USER PIC
        UserBalloon(
          size: 80,
          userStatus: userModel?.status,
          userModel: userModel,
          loading: false,
        ),

        /// USER NAME
        SuperVerse(
          verse: userModel?.name,
          shadow: true,
          size: 4,
          margin: 5,
          maxLines: 2,
          labelColor: Colorz.white10,
        ),

      ],
    ),
  );

  return _result;
}
// ---------------------------------
Future<bool> _checkPassword({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  final String _password = await CenterDialog.showPasswordDialog(context);

  final AuthModel _authModel = await AuthLDBOps.readAuthModel();

  final String _email = ContactModel.getAContactValueFromContacts(
    contacts: userModel?.contacts,
    contactType: ContactType.email,
  ) ?? _authModel.email;

  final bool _passwordIsCorrect = await AuthFireOps.passwordIsCorrect(
    context: context,
    password: _password,
    email: _email,
  );

  return _passwordIsCorrect;
}
// ---------------------------------
Future<void> _deleteNonAuthorUserOps({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  /// TASK SHOULD DELETE QUESTIONS, RECORDS, SEARCHES

  /// FIRE : DELETE USER OPS
  final bool _success = await UserFireOps.deleteNonAuthorUserOps(
      context: context,
      userModel: userModel
  );

  if (_success == true){

    /// LDB : DELETE USER MODEL
    await UserLDBOps.deleteUserOps(userModel.id);
    await AuthLDBOps.deleteAuthModel(userModel.id);

    /// LDB : DELETE SAVED FLYERS
    await FlyerLDBOps.deleteFlyers(userModel.savedFlyersIDs);

    /// CLOSE WAITING
    WaitDialog.closeWaitDialog(context);

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
Future<void> _deleteAuthorUserOps({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'Should Delete Author User sequence now',
  );

  /// CLOSE WAITING
  WaitDialog.closeWaitDialog(context);

}
// -----------------------------------------------------------------------------

/// INVITE BZZ SCREEN

// ---------------------------------
Future<void> onInviteBusinessesTap(BuildContext context) async {
  await Nav.goToNewScreen(
    context: context,
    screen: const InviteBusinessesScreen(),
  );
}
// ---------------------------------
Future<void> onImportDeviceContactsTap(BuildContext context) async {

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  _uiProvider.triggerLoading(
    callerName: 'onImportDeviceContactsTap',
    setLoadingTo: true,
    notify: true,
  );

  final List<Contact> _deviceContacts = await getDeviceContactsOps(context);

  _uiProvider.triggerLoading(
    callerName: 'onImportDeviceContactsTap',
    setLoadingTo: false,
    notify: true,
  );

  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  _usersProvider.setMyDeviceContacts(_deviceContacts);

}
// ---------------------------------
void onDeviceContactsSearch({
  @required BuildContext context,
  @required String value,
}){

  final String _fixed = TextMod.fixSearchText(value);
  blog('Searching contacts value is : $value : fixed : $_fixed');

  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  _usersProvider.searchDeviceContacts(value);

}
// -----------------------------------------------------------------------------

/// USER PROFILE PAGE

// ---------------------------------
void onUserPicTap(){
  blog('user pic tapped');
}
// ---------------------------------
Future<void> onUserContactTap(ContactModel contact) async {

  if (contact.contactType == ContactType.email){
    blog('User Email : ${contact.value}');
  }
  else if (ContactModel.checkContactIsSocialMedia(contact) == true) {
    await Launcher.launchURL('https://${contact.value}');
  }
  else if (contact.contactType == ContactType.website){
    await Launcher.launchURL('https://${contact.value}');
  }
  else if (contact.contactType == ContactType.phone){
    await Launcher.launchCall(contact.value);
  }
  else {
    contact.blogContact(methodName: 'onUserContactTap');
  }

}
// ---------------------------------
Future<void> onUserLocationTap(GeoPoint geoPoint) async {

  Atlas.blogGeoPoint(
    point: geoPoint,
    methodName: 'onUserLocationTap',
  );

}
// -----------------------------------------------------------------------------
