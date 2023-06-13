import 'dart:async';

import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/bz_editor_screen.dart';
import 'package:bldrs/b_views/h_app_settings/b_app_langs_screen/b_app_langs_screen.dart';
import 'package:bldrs/b_views/h_app_settings/c_about_bldrs_screen/c_about_bldrs_screen.dart';
import 'package:bldrs/b_views/h_app_settings/d_feedback_screen/d_feedback_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/main_providers/general_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// LANGUAGE

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onChangeAppLanguageTap() async {
  await Nav.goToNewScreen(
    context: getMainContext(),
    pageTransitionType: PageTransitionType.fade,
    screen: const AppLangsScreen(),
  );
}
// -----------------------------------------------------------------------------

/// STUFF

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAboutBldrsTap() async {
  await Nav.goToNewScreen(
    context: getMainContext(),
    pageTransitionType: PageTransitionType.fade,
    screen: const AboutBldrsScreen(),
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onFeedbackTap() async {
  await Nav.goToNewScreen(
    context: getMainContext(),
    pageTransitionType: PageTransitionType.fade,
    screen: const FeedbackScreen(),
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onTermsAndTap() async {

  await Launcher.launchURL(Standards.termsAndRegulationsURL);

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onPrivacyTap() async {

  await Launcher.launchURL(Standards.privacyPolicyURL);

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onInviteFriendsTap() async {

  await Launcher.shareBldrsWebsiteURL();

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

/// REBOOT ( CLEAR CACHE & RESTART )

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onRebootSystem() async {

  final bool _result = await CenterDialog.showCenterDialog(
    titleVerse: const Verse(
      id: 'phid_restart_app',
      translate: true,
    ),
    bodyVerse: const Verse(
      pseudo: 'This will clear all local data, and restart the app. Are you sure ?',
      id: 'phid_restart_app_body',
      translate: true,
    ),
    boolDialog: true,
    invertButtons: true,
    confirmButtonVerse: const Verse(
      id: 'phid_confirm',
      translate: true,
    ),
  );

  if (_result == true) {
    pushWaitDialog(
      verse: const Verse(
        id: 'phid_restarting',
        translate: true,
      ),
    );

    await Future.wait(<Future>[
      /// WIPE OUT LDB
      LDBDoc.wipeOutEntireLDB(),

      /// WIPE OUT PRO
      GeneralProvider.wipeOutAllProviders(),
    ]);

    /// SIGN OUT
    await AuthProtocols.signOutBldrs(routeToLogoScreen: true);

    await WaitDialog.closeWaitDialog();
  }

}
// -----------------------------------------------------------------------------

/// SIGN OUT OPS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSignOut() async {

  /// CLEAR KEYWORDS
  final ChainsProvider _keywordsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);
  // _keywordsProvider.clearKeywordsChain();
  _keywordsProvider.clearWallFlyerTypeAndPhid(notify: true);

  /// CLEAR BZZ
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(getMainContext(), listen: false);
  _bzzProvider.clearMyBzz(notify: false,);
  _bzzProvider.clearFollowedBzz(notify: false,);
  _bzzProvider.clearSponsors(notify: false,);
  _bzzProvider.clearMyActiveBz(notify: false);

  /// CLEAR USER
  final UsersProvider _usersProvider = Provider.of<UsersProvider>(getMainContext(), listen: false);
  _usersProvider.clearMyUserModel(
    notify: true,
  );

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(getMainContext(), listen: false);

  // _zoneProvider.clearAllSearchesAndSelections();
  _zoneProvider.clearCurrentContinent(notify: false);
  _zoneProvider.clearCurrentZone(notify: false);
  _zoneProvider.clearCurrentCurrencyAndAllCurrencies(notify: false);

  final String _userID = Authing.getUserID();
  await UserLDBOps.deleteUserOps(_userID);
  await BzLDBOps.wipeOut(getMainContext());
  await FlyerLDBOps.wipeOut(getMainContext());

  await AuthProtocols.signOutBldrs(
      routeToLogoScreen: true
  );

}
// -----------------------------------------------------------------------------
