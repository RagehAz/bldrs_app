import 'dart:async';

import 'package:bldrs/b_views/b_auth/a_auth_screen.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/bz_editor_screen.dart';
import 'package:bldrs/b_views/h_app_settings/b_app_langs_screen/b_app_langs_screen.dart';
import 'package:bldrs/b_views/h_app_settings/d_feedback_screen/d_feedback_screen.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/main_providers/general_provider.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// LANGUAGE

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onChangeAppLanguageTap() async {
  await BldrsNav.goToNewScreen(
    screen: const AppLangsScreen(),
  );
}
// -----------------------------------------------------------------------------

/// STUFF

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onFeedbackTap() async {
  await BldrsNav.goToNewScreen(
    screen: const FeedbackScreen(),
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onTermsAndTap() async {
  await BldrsNav.pushTermsScreen();
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onPrivacyTap() async {
  await BldrsNav.pushPrivacyScreen();
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onInviteFriendsTap() async {

  await Dialogs.centerNotice(
    verse: const Verse(id: 'phid_be_selective', translate: true),
    body: const Verse(id: 'phid_why_be_selective', translate: true),
  );

  await Launcher.shareBldrsWebsiteURL();

}
// -----------------------------------------------------------------------------

/// CREATE NEW BZ ACCOUNT

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onCreateNewBzTap() async {

  await BldrsNav.goToNewScreen(
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
Future<void> onRebootBldrsAppSystem() async {

  final bool _result = await rebootLogic();

  if (_result == true) {

    await BldrsNav.pushLogoRouteAndRemoveAllBelow(
      animatedLogoScreen: true,
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> rebootLogic() async {

  final bool _result = await BldrsCenterDialog.showCenterDialog(
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

    WaitDialog.showUnawaitedWaitDialog(
      verse: const Verse(
        id: 'phid_restarting',
        translate: true,
      ),
    );

    await Future.wait(<Future>[
      /// WIPE OUT LDB
      LDBDoc.onLightRebootSystem(),

      /// WIPE OUT PRO
      GeneralProvider.wipeOutAllProviders(),
    ]);

    await WaitDialog.closeWaitDialog();

    /// SIGN OUT
    await AuthProtocols.signOutBldrs();

  }

  return _result;
}
// -----------------------------------------------------------------------------

/// SIGN OUT OPS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSignOut() async {

  final bool _go = await Dialogs.confirmProceed(
    titleVerse: const Verse(
      id: 'phid_confirm_signout',
      translate: true,
    ),
    yesVerse: const Verse(
      id: 'phid_signOut',
      translate: true,
    ),
  );

  if (_go == true){

    /// CLEAR KEYWORDS
    final ChainsProvider _keywordsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);
    // _keywordsProvider.clearKeywordsChain();
    _keywordsProvider.clearWallFlyerTypeAndPhid(notify: false);

    /// CLEAR BZZ
    HomeProvider.proClearActiveBz(notify: false);

    /// CLEAR USER
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(getMainContext(), listen: false);
    _usersProvider.clearMyUserModel(
      notify: false,
    );

    // final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(getMainContext(), listen: false);
    // _zoneProvider.clearAllSearchesAndSelections();
    // _zoneProvider.clearCurrentContinent(notify: false);
    // _zoneProvider.clearCurrentZone(notify: false);
    // _zoneProvider.clearCurrentCurrencyAndAllCurrencies(notify: false);

    final String? _userID = Authing.getUserID();
    await UserLDBOps.deleteUserOps(_userID);
    await BzLDBOps.wipeOut();
    await FlyerLDBOps.wipeOut();

    await AuthProtocols.signOutBldrs();

    await BldrsNav.pushLogoRouteAndRemoveAllBelow(
      animatedLogoScreen: true,
    );

  }

}
// -----------------------------------------------------------------------------

/// SWITCH ACCOUNT OPS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> signInByAnotherAccount() async {

  await BldrsNav.goToNewScreen(
      screen: const AuthScreen(),
  );

}
// -----------------------------------------------------------------------------
