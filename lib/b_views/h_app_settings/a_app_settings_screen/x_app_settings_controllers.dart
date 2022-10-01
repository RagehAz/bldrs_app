import 'dart:async';

import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/a_bz_editor_screen.dart';
import 'package:bldrs/b_views/h_app_settings/b_app_langs_screen/b_app_langs_screen.dart';
import 'package:bldrs/b_views/h_app_settings/c_about_bldrs_screen/c_about_bldrs_screen.dart';
import 'package:bldrs/b_views/h_app_settings/d_feedback_screen/d_feedback_screen.dart';
import 'package:bldrs/b_views/h_app_settings/e_terms_screen/e_terms_screen.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/auth_ldb_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/bz_ldb_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/flyer_ldb_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// LANGUAGE

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onChangeAppLanguageTap(BuildContext context) async {
  await Nav.goToNewScreen(
    context: context,
    transitionType: PageTransitionType.fade,
    screen: const AppLangsScreen(),
  );
}
// -----------------------------------------------------------------------------

/// STUFF

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAboutBldrsTap(BuildContext context) async {
  await Nav.goToNewScreen(
    context: context,
    transitionType: PageTransitionType.fade,
    screen: const AboutBldrsScreen(),
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onFeedbackTap(BuildContext context) async {
  await Nav.goToNewScreen(
    context: context,
    transitionType: PageTransitionType.fade,
    screen: const FeedBack(),
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onTermsAndRegulationsTap(BuildContext context) async {
  await Nav.goToNewScreen(
    context: context,
    transitionType: PageTransitionType.fade,
    screen: const TermsScreen(),
  );
}
// --------------------
/// TESTED : WORKS PERFECT
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
    link: Standards.bldrsWebSiteLink,
  );
  // }

}
// -----------------------------------------------------------------------------

/// CREATE NEW BZ ACCOUNT

// --------------------
Future<void> onCreateNewBzTap(BuildContext context) async {

  await Nav.goToNewScreen(
      context: context,
      screen: const BzEditorScreen(firstTimer: true,)
  );

}
// -----------------------------------------------------------------------------

/// SIGN OUT OPS

// --------------------
Future<void> onSignOut(BuildContext context) async {

  /// CLEAR FLYERS
  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
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
  _keywordsProvider.clearWallFlyerTypeAndPhid(notify: true);

  /// CLEAR BZZ
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  _bzzProvider.clearMyBzz(notify: false,);
  _bzzProvider.clearFollowedBzz(notify: false,);
  _bzzProvider.clearSponsors(notify: false,);
  _bzzProvider.clearMyActiveBz(notify: false);

  /// CLEAR USER
  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  _usersProvider.clearMyUserModelAndAuthModel(
    notify: true,
  );

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  // _zoneProvider.clearAllSearchesAndSelections();
  _zoneProvider.clearCurrentContinent(notify: false);
  _zoneProvider.clearCurrentZone(notify: false);
  _zoneProvider.clearCurrentCurrencyAndAllCurrencies(notify: false);

  await AuthLDBOps.deleteAuthModel(AuthFireOps.superUserID());
  await UserLDBOps.deleteUserOps(AuthFireOps.superUserID());
  await BzLDBOps.wipeOut(context);
  await FlyerLDBOps.wipeOut(context);

  await AuthFireOps.signOut(
      context: context,
      routeToLogoScreen: true
  );

}
// -----------------------------------------------------------------------------
