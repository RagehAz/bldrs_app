import 'dart:async';

import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/secondary_models/link_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/f_bz_editor/f_x_bz_editor_screen.dart';
import 'package:bldrs/b_views/x_screens/g_user/g_1_change_app_language_screen.dart';
import 'package:bldrs/b_views/x_screens/g_user/g_2_about_bldrs_screen.dart';
import 'package:bldrs/b_views/x_screens/g_user/g_3_feedback_screen.dart';
import 'package:bldrs/b_views/x_screens/g_user/g_4_terms_and_regulations_screen.dart';
import 'package:bldrs/b_views/x_screens/g_user_editor/g_x_user_editor_screen.dart';
import 'package:bldrs/b_views/y_views/g_user/b_4_invite_businesses_screen.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/contacts_service/contacts_service.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart' as Atlas;
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer show shareAppIcon;
import 'package:bldrs/f_helpers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------

/// USER SCREEN TABS

// ---------------------------------
int getInitialUserScreenTabIndex(BuildContext context){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final UserTab _currentTab = _uiProvider.currentUserTab;
  final int _index = getUserTabIndex(_currentTab);
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

  final UserTab _newUserTab = userProfileTabsList[index];
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
// -----------------------------------------------------------------------------

/// PROFILE OPTIONS

// ---------------------------------
Future<void> onMoreOptionsTap (BuildContext context) async {
  blog('more button in user screen');

  const double _buttonHeight = 50;

    await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: _buttonHeight,
      title: 'Profile options',
      numberOfWidgets: 10,
      builder: (xxx, phrasePro){

        blog('ahoooooooo lalalala');

        return <Widget>[

          /// EDIT PROFILE
          BottomDialog.wideButton(
            context: xxx,
            height: _buttonHeight,
            verse: superPhrase(xxx, 'phid_editProfile', providerOverride: phrasePro),
            icon: Iconz.gears,
            onTap: () => onEditProfileTap(xxx),
          ),

          /// CHANGE APP LANGUAGE
          BottomDialog.wideButton(
            context: xxx,
            height: _buttonHeight,
            verse: superPhrase(xxx, 'phid_changeLanguage', providerOverride: phrasePro),
            icon: Iconz.language,
            onTap: () => _onChangeAppLanguageTap(xxx),
          ),

          const BubblesSeparator(bottomMarginIsOn: false,),

          /// ABOUT BLDRS
          BottomDialog.wideButton(
            context: xxx,
            height: _buttonHeight,
            verse: '${superPhrase(xxx, 'phid_about', providerOverride: phrasePro)} ${Wordz.bldrsFullName(xxx)}',
            icon: Iconz.pyramidSingleYellow,
            onTap: () => _onAboutBldrsTap(xxx),
          ),

          /// FEEDBACK
          BottomDialog.wideButton(
            context: xxx,
            height: _buttonHeight,
            verse: superPhrase(xxx, 'phid_feedback', providerOverride: phrasePro),
            icon: Iconz.utSearching,
            onTap: () => _onFeedbackTap(xxx),
          ),

          /// TERMS AND REGULATIONS
          BottomDialog.wideButton(
            context: xxx,
            height: _buttonHeight,
            verse: superPhrase(xxx, 'phid_termsRegulations', providerOverride: phrasePro),
            icon: Iconz.terms,
            onTap: () => _onTermsAndRegulationsTap(xxx),
          ),

          const BubblesSeparator(bottomMarginIsOn: false,),

          /// CREATE NEW BZ ACCOUNT
          BottomDialog.wideButton(
            context: xxx,
            height: _buttonHeight,
            verse: superPhrase(xxx, 'phid_createBzAccount', providerOverride: phrasePro),
            icon: Iconz.bz,
            onTap: () => _onCreateNewBzTap(xxx),
          ),

          /// INVITE FRIENDS
          BottomDialog.wideButton(
            context: xxx,
            height: _buttonHeight,
            verse: superPhrase(xxx, 'phid_inviteFriends', providerOverride: phrasePro),
            icon: Iconizer.shareAppIcon(),
            onTap: () => _onInviteFriendsTap(xxx),
          ),

          const BubblesSeparator(bottomMarginIsOn: false,),

          /// DELETE MY ACCOUNT
          BottomDialog.wideButton(
            context: xxx,
            height: _buttonHeight,
            verse: superPhrase(xxx, 'phid_delete_my_account', providerOverride: phrasePro),
            icon: Iconz.xSmall,
            onTap: () => _onDeleteMyAccount(xxx),
          ),

          /// SIGN OUT
          BottomDialog.wideButton(
            context: xxx,
            height: _buttonHeight,
            verse: superPhrase(xxx, 'phid_signOut', providerOverride: phrasePro),
            icon: Iconz.exit,
            onTap: () => _onSignOut(xxx),
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
Future<void> _onChangeAppLanguageTap(BuildContext context) async {
  await Nav.goToNewScreen(
      context: context,
      screen: const SelectAppLanguageScreen(),
  );
}
// ---------------------------------
Future<void> _onAboutBldrsTap(BuildContext context) async {
  await Nav.goToNewScreen(
      context: context,
      screen: const AboutBldrsScreen(),
  );
}
// ---------------------------------
Future<void> _onFeedbackTap(BuildContext context) async {
  await Nav.goToNewScreen(
      context: context,
      screen: const FeedBack(),
  );
}
// ---------------------------------
Future<void> _onTermsAndRegulationsTap(BuildContext context) async {
  await Nav.goToNewScreen(
      context: context,
      screen: const TermsAndRegulationsScreen(),
  );
}
// ---------------------------------
Future<void> _onCreateNewBzTap(BuildContext context) async {

  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  final UserModel _myUserModel = _usersProvider.myUserModel;

  await Nav.goToNewScreen(
      context: context,
      screen: BzEditorScreen(
          firstTimer: true,
          userModel: _myUserModel
      )
  );

}
// ---------------------------------
Future<void> _onInviteFriendsTap(BuildContext context) async {
    await Launcher.shareLink(
        context: context,
        link: LinkModel.bldrsWebSiteLink,
    );
}
// -----------------------------------------------------------------------------

/// DELETION OPS

// ---------------------------------
Future<void> _onDeleteMyAccount(BuildContext context) async {
  blog('on delete user tap');

  final UserModel _userModel = UsersProvider.proGetMyUserModel(context);

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

      final bool _userIsAuthor = UserModel.userIsAuthor(_userModel);

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
    height: superScreenHeight(context) * 0.6,
    child: Column(
      children: <Widget>[

        /// USER PIC
        UserBalloon(
          size: 80,
          balloonType: userModel?.status,
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

  final bool _passwordIsCorrect = await FireAuthOps.passwordIsCorrect(
    context: context,
    password: _password,
    email: ContactModel.getAContactValueFromContacts(
      contacts: userModel.contacts,
      contactType: ContactType.email,
    ),
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

    /// LDB : DELETE SAVED FLYERS
    await FlyersLDBOps.deleteFlyers(userModel.savedFlyersIDs);

    /// CLOSE WAITING
    WaitDialog.closeWaitDialog(context);

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Account is Deleted Successfully',
      body: 'It has been an honor.',
      confirmButtonText: 'The Honor is Mine',

    );

    /// SIGN OUT OPS
    await _onSignOut(context);
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

/// SIGN OUT OPS

// ---------------------------------
Future<void> _onSignOut(BuildContext context) async {

  /// CLEAR FLYERS
  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  _flyersProvider.clearSavedFlyers(notify: false);
  _flyersProvider.clearPromotedFlyers(notify: false);
  _flyersProvider.clearWallFlyers(notify: true);

  /// CLEAR SEARCHES
  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
  _searchProvider.clearSearchResult(notify: false);
  _searchProvider.clearSearchRecords(notify: false);
  _searchProvider.closeAllZoneSearches(notify: true);

  /// CLEAR KEYWORDS
  final ChainsProvider _keywordsProvider = Provider.of<ChainsProvider>(context, listen: false);
  // _keywordsProvider.clearKeywordsChain();
  _keywordsProvider.clearCurrentKeyword(notify: false);
  _keywordsProvider.clearCurrentSection(notify: true);

  /// CLEAR BZZ
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  _bzzProvider.clearMyBzz(notify: false,);
  _bzzProvider.clearFollowedBzz(notify: false,);
  _bzzProvider.clearSponsors(notify: false,);
  _bzzProvider.clearMyActiveBz(notify: false);
  _bzzProvider.clearActiveBzFlyers(notify: true);

  /// CLEAR USER
  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  _usersProvider.clearMyUserModelAndAuthModel();

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);

  // _zoneProvider.clearAllSearchesAndSelections();
  _zoneProvider.clearCurrentContinent(notify: false);
  _zoneProvider.clearUserCountryModel(notify: false);
  _zoneProvider.clearCurrentZoneAndCurrentCountryAndCurrentCity(notify: false);
  _zoneProvider.clearCurrentCurrencyAndAllCurrencies(notify: false);
  _zoneProvider.clearSearchedCountries(notify: false);
  _zoneProvider.clearSelectedCountryCities(notify: false);
  _zoneProvider.clearSearchedCities(notify: false);
  _zoneProvider.clearSelectedCityDistricts(notify: false);
  _zoneProvider.clearSearchedDistricts(notify: true);

  await AuthLDBOps.deleteAuthModel(FireAuthOps.superUserID());

  await FireAuthOps.signOut(
      context: context,
      routeToUserChecker: true
  );

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
  else if (ContactModel.contactIsSocialMedia(contact) == true) {
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
