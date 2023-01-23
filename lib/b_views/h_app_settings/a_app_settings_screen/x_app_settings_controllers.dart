import 'dart:async';
import 'package:bldrs/b_views/h_app_settings/b_app_langs_screen/b_app_langs_screen.dart';
import 'package:bldrs/b_views/h_app_settings/c_about_bldrs_screen/c_about_bldrs_screen.dart';
import 'package:bldrs/b_views/h_app_settings/d_feedback_screen/d_feedback_screen.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/search_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/ldb/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/bz_editor_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// LANGUAGE

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onChangeAppLanguageTap(BuildContext context) async {
  await Nav.goToNewScreen(
    context: context,
    pageTransitionType: PageTransitionType.fade,
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
    pageTransitionType: PageTransitionType.fade,
    screen: const AboutBldrsScreen(),
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onFeedbackTap(BuildContext context) async {
  await Nav.goToNewScreen(
    context: context,
    pageTransitionType: PageTransitionType.fade,
    screen: const FeedbackScreen(),
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onTermsAndTap(BuildContext context) async {

  await Launcher.launchURL(Standards.termsAndRegulationsURL);

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onPrivacyTap(BuildContext context) async {

  await Launcher.launchURL(Standards.privacyPolicyURL);

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onInviteFriendsTap(BuildContext context) async {

  await Launcher.shareBldrsWebsiteURL(
    context: context,
  );

}
// -----------------------------------------------------------------------------

/// CREATE NEW BZ ACCOUNT

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onCreateNewBzTap(BuildContext context) async {

  await Nav.goToNewScreen(
      context: context,
      screen: const BzEditorScreen(
        // bzModel: null,
        // validateOnStartup: false,
        // checkLastSession: true,
      )
  );

}
// -----------------------------------------------------------------------------

/// SIGN OUT OPS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSignOut(BuildContext context) async {

  /// CLEAR FLYERS
  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  _flyersProvider.clearPromotedFlyers(notify: false);

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
