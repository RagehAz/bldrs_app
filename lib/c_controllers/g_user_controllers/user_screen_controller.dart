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
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/f_helpers/contacts_service/contacts_service.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer show shareAppIcon;
import 'package:bldrs/f_helpers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
int getInitialUserScreenTabIndex(BuildContext context){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final UserTab _currentTab = _uiProvider.currentUserTab;
  final int _index = getUserTabIndex(_currentTab);
  return _index;
}
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
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
Future<void> onMoreOptionsTap (BuildContext context) async {
  blog('more button in user screen');

  const double _buttonHeight = 42;

    await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: _buttonHeight,
      title: 'Profile options',
      buttons: <Widget>[

        /// EDIT PROFILE
        BottomDialog.wideButton(
          context: context,
          verse: superPhrase(context, 'phid_editProfile'),
          icon: Iconz.gears,
          onTap: () => onEditProfileTap(context),
        ),

        /// CHANGE APP LANGUAGE
        BottomDialog.wideButton(
          context: context,
          verse: superPhrase(context, 'phid_changeLanguage'),
          icon: Iconz.language,
          onTap: () => _onChangeAppLanguageTap(context),
        ),

        const BubblesSeparator(bottomMarginIsOn: false,),

        /// ABOUT BLDRS
        BottomDialog.wideButton(
          context: context,
          verse: '${superPhrase(context, 'phid_about')} ${Wordz.bldrsFullName(context)}',
          icon: Iconz.pyramidSingleYellow,
          onTap: () => _onAboutBldrsTap(context),
        ),

        /// FEEDBACK
        BottomDialog.wideButton(
          context: context,
          verse: superPhrase(context, 'phid_feedback'),
          icon: Iconz.utSearching,
          onTap: () => _onFeedbackTap(context),
        ),

        /// TERMS AND REGULATIONS
        BottomDialog.wideButton(
          context: context,
          verse: superPhrase(context, 'phid_termsRegulations'),
          icon: Iconz.terms,
          onTap: () => _onTermsAndRegulationsTap(context),
        ),

        const BubblesSeparator(bottomMarginIsOn: false,),

        /// CREATE NEW BZ ACCOUNT
        BottomDialog.wideButton(
          context: context,
          verse: superPhrase(context, 'phid_createBzAccount'),
          icon: Iconz.bz,
          onTap: () => _onCreateNewBzTap(context),
        ),

        /// INVITE FRIENDS
        BottomDialog.wideButton(
          context: context,
          verse: superPhrase(context, 'phid_inviteFriends'),
          icon: Iconizer.shareAppIcon(),
          onTap: () => _onInviteFriendsTap(context),
        ),

        const BubblesSeparator(bottomMarginIsOn: false,),

        /// DELETE MY ACCOUNT
        BottomDialog.wideButton(
          context: context,
          verse: superPhrase(context, 'phid_delete_my_account'),
          icon: Iconz.xSmall,
          onTap: () => _onDeleteMyAccount(context),
        ),

        const BubblesSeparator(bottomMarginIsOn: false,),

        /// SIGN OUT
        BottomDialog.wideButton(
          context: context,
          verse: superPhrase(context, 'phid_signOut'),
          icon: Iconz.exit,
          onTap: () => _onSignOut(context),
        ),

      ],
    );

}
// -----------------------------------------------------------------------------
Future<void> _onChangeAppLanguageTap(BuildContext context) async {
  await Nav.goToNewScreen(context, const SelectAppLanguageScreen());
}
// -----------------------------------------------------------------------------
Future<void> _onAboutBldrsTap(BuildContext context) async {
  await Nav.goToNewScreen(context, const AboutBldrsScreen());
}
// -----------------------------------------------------------------------------
Future<void> _onFeedbackTap(BuildContext context) async {
  await Nav.goToNewScreen(context, const FeedBack());
}
// -----------------------------------------------------------------------------
Future<void> _onTermsAndRegulationsTap(BuildContext context) async {
  await Nav.goToNewScreen(context, const TermsAndRegulationsScreen());
}
// -----------------------------------------------------------------------------
Future<void> _onCreateNewBzTap(BuildContext context) async {

  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  final UserModel _myUserModel = _usersProvider.myUserModel;

  await Nav.goToNewScreen(
      context,
      BzEditorScreen(
          firstTimer: true,
          userModel: _myUserModel
      )
  );

}
// -----------------------------------------------------------------------------
Future<void> _onInviteFriendsTap(BuildContext context) async {
    await Launcher.shareLink(context, LinkModel.bldrsWebSiteLink);
}
// -----------------------------------------------------------------------------
Future<void> _onDeleteMyAccount(BuildContext context) async {
  blog('on delete user tap');
}
// -----------------------------------------------------------------------------
Future<void> _onSignOut(BuildContext context) async {

  /// CLEAR FLYERS
  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  _flyersProvider.clearSavedFlyers();
  _flyersProvider.clearPromotedFlyers();
  _flyersProvider.clearWallFlyers();
  _flyersProvider.clearLastWallFlyer();

  /// CLEAR SEARCHES
  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
  _searchProvider.clearSearchResult();
  _searchProvider.clearSearchRecords();
  _searchProvider.closeAllZoneSearches();

  /// CLEAR KEYWORDS
  final ChainsProvider _keywordsProvider = Provider.of<ChainsProvider>(context, listen: false);
  // _keywordsProvider.clearKeywordsChain();
  _keywordsProvider.clearCurrentKeyword();
  _keywordsProvider.clearCurrentSection();

  /// CLEAR BZZ
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  _bzzProvider.clearMyBzz();
  _bzzProvider.clearFollowedBzz();
  _bzzProvider.clearSponsors();
  _bzzProvider.clearMyActiveBz();
  _bzzProvider.clearActiveBzFlyers();

  /// CLEAR USER
  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  _usersProvider.clearMyUserModelAndCountryAndCityAndAuthModel();

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  // _zoneProvider.clearAllSearchesAndSelections();
  _zoneProvider.clearCurrentContinent();
  _zoneProvider.clearUserCountryModel();
  _zoneProvider.clearCurrentZoneAndCurrentCountryAndCurrentCity();
  _zoneProvider.clearCurrentCurrencyAndAllCurrencies();
  _zoneProvider.clearSearchedCountries();
  _zoneProvider.clearSelectedCountryCities();
  _zoneProvider.clearSearchedCities();
  _zoneProvider.clearSelectedCityDistricts();
  _zoneProvider.clearSearchedDistricts();

  await FireAuthOps.signOut(
      context: context,
      routeToUserChecker: true
  );


}
// -----------------------------------------------------------------------------
Future<void> onEditProfileTap(BuildContext context) async {

  final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
  final UserModel _myUserModel = _userProvider.myUserModel;

  await Nav.goToNewScreen(context,
      EditProfileScreen(
        userModel: _myUserModel,
        onFinish: () async {

          Nav.goBack(context);
        },
      )
  );

}
// -----------------------------------------------------------------------------
void onUserPicTap(){
  blog('user pic tapped');
}
// -----------------------------------------------------------------------------
Future<void> onInviteBusinessesTap(BuildContext context) async {
  await Nav.goToNewScreen(context, const InviteBusinessesScreen());
}
// -----------------------------------------------------------------------------
Future<void> onImportDeviceContactsTap(BuildContext context) async {

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  _uiProvider.triggerLoading(setLoadingTo: true);
  final List<Contact> _deviceContacts = await getDeviceContactsOps(context);
  _uiProvider.triggerLoading(setLoadingTo: false);

  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  _usersProvider.setMyDeviceContacts(_deviceContacts);

}
// -----------------------------------------------------------------------------
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
