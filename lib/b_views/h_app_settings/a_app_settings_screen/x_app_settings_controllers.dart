import 'dart:async';

import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/general_provider.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/bz_editor_screen.dart';
import 'package:bldrs/b_views/h_app_settings/b_app_langs_screen/b_app_langs_screen.dart';
import 'package:bldrs/b_views/h_app_settings/c_about_bldrs_screen/c_about_bldrs_screen.dart';
import 'package:bldrs/b_views/h_app_settings/d_feedback_screen/d_feedback_screen.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
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

/// REBOOT ( CLEAR CACHE & RESTART )

// --------------------
Future<void> onRebootSystem(BuildContext context) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
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
      context: context,
      verse: const Verse(
        id: 'phid_restarting',
        translate: true,
      ),
    );

    await Future.wait(<Future>[
      /// WIPE OUT LDB
      LDBDoc.wipeOutEntireLDB(),

      /// WIPE OUT PRO
      GeneralProvider.wipeOutAllProviders(context),
    ]);

    /// SIGN OUT
    await AuthProtocols.signOutBldrs(context: context, routeToLogoScreen: true);

    await WaitDialog.closeWaitDialog(context);
  }

}
// -----------------------------------------------------------------------------

/// SIGN OUT OPS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSignOut(BuildContext context) async {

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

  final String _userID = Authing.getUserID();
  await AuthLDBOps.deleteAuthModel(_userID);
  await UserLDBOps.deleteUserOps(_userID);
  await BzLDBOps.wipeOut(context);
  await FlyerLDBOps.wipeOut(context);

  await AuthProtocols.signOutBldrs(
      context: context,
      routeToLogoScreen: true
  );

}
// -----------------------------------------------------------------------------
