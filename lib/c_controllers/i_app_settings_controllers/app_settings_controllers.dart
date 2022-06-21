import 'dart:async';

import 'package:bldrs/b_views/x_screens/g_bz/b_bz_editor/a_bz_editor_screen.dart';
import 'package:bldrs/b_views/x_screens/i_app_settings/b_change_app_language_screen.dart';
import 'package:bldrs/b_views/x_screens/i_app_settings/c_about_bldrs_screen.dart';
import 'package:bldrs/b_views/x_screens/i_app_settings/d_feedback_screen.dart';
import 'package:bldrs/b_views/x_screens/i_app_settings/e_terms_and_regulations_screen.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// LANGUAGE

// ---------------------------------
Future<void> onChangeAppLanguageTap(BuildContext context) async {
  await Nav.goToNewScreen(
    context: context,
    transitionType: PageTransitionType.fade,
    screen: const SelectAppLanguageScreen(),
  );
}
// -----------------------------------------------------------------------------

/// STUFF

// ---------------------------------
Future<void> onAboutBldrsTap(BuildContext context) async {
  await Nav.goToNewScreen(
    context: context,
    transitionType: PageTransitionType.fade,
    screen: const AboutBldrsScreen(),
  );
}
// ---------------------------------
Future<void> onFeedbackTap(BuildContext context) async {
  await Nav.goToNewScreen(
    context: context,
    transitionType: PageTransitionType.fade,
    screen: const FeedBack(),
  );
}
// ---------------------------------
Future<void> onTermsAndRegulationsTap(BuildContext context) async {
  await Nav.goToNewScreen(
    context: context,
    transitionType: PageTransitionType.fade,
    screen: const TermsAndRegulationsScreen(),
  );
}
// -----------------------------------------------------------------------------

/// CREATE NEW BZ ACCOUNT

// ---------------------------------
Future<void> onCreateNewBzTap(BuildContext context) async {

  await Nav.goToNewScreen(
      context: context,
      screen: const BzEditorScreen(firstTimer: true,)
  );

}
// -----------------------------------------------------------------------------

/// SIGN OUT OPS

// ---------------------------------
Future<void> onSignOut(BuildContext context) async {

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
  _keywordsProvider.clearWallPhid(notify: false);
  _keywordsProvider.clearHomeWallFlyerType(notify: true);

  /// CLEAR BZZ
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  _bzzProvider.clearMyBzz(notify: false,);
  _bzzProvider.clearFollowedBzz(notify: false,);
  _bzzProvider.clearSponsors(notify: false,);
  _bzzProvider.clearMyActiveBz(notify: false);
  _bzzProvider.clearActiveBzFlyers(notify: true);

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
  _zoneProvider.clearSearchedCountries(notify: false);
  _zoneProvider.clearSelectedCountryCities(notify: false);
  _zoneProvider.clearSearchedCities(notify: false);
  _zoneProvider.clearSelectedCityDistricts(notify: false);
  _zoneProvider.clearSearchedDistricts(notify: true);

  await AuthLDBOps.deleteAuthModel(AuthFireOps.superUserID());
  await UserLDBOps.deleteUserOps(AuthFireOps.superUserID());
  await BzLDBOps.wipeOut(context);
  await FlyerLDBOps.wipeOut(context);

  await AuthFireOps.signOut(
      context: context,
      routeToUserChecker: true
  );

}
// -----------------------------------------------------------------------------
