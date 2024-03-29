import 'dart:async';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/b_screens/c_bz_screens/b_bz_editor_screen/bz_editor_screen.dart';
import 'package:bldrs/b_screens/x_situational_screens/app_langs_screen.dart';
import 'package:bldrs/b_screens/x_situational_screens/feedback_screen.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/main_providers/general_provider.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
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
  await Routing.goTo(route: ScreenName.terms);
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onPrivacyTap() async {
  await Routing.goTo(route: ScreenName.privacy);
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
Future<void> onRebootBldrsAppSystem({
  required bool hardReboot,
}) async {

  final bool _result = await rebootLogic(
      hardReboot: hardReboot,
  );

  if (_result == true) {

    await Routing.goTo(route: ScreenName.logo);

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> rebootLogic({
  required bool hardReboot,
}) async {

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
    color: hardReboot == true ? Colorz.bloodTest : Colorz.blackSemi230,
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
      if (hardReboot == false)
        LDBDoc.onLightRebootSystem(),

      if (hardReboot == true)
        LDBDoc.onHardRebootSystem(),

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
Future<void> onSignOutUser({
  required bool showConfirmDialog,
}) async {

  bool _go = true;

  if (showConfirmDialog){
    _go = await Dialogs.confirmProceed(
      titleVerse: const Verse(
        id: 'phid_confirm_signout',
        translate: true,
      ),
      yesVerse: const Verse(
        id: 'phid_signOut',
        translate: true,
      ),
    );
  }

  if (_go == true){

    /// CLEAR KEYWORDS
    final HomeProvider _homeProvider = Provider.of<HomeProvider>(getMainContext(), listen: false);
    // _homeProvider.clearKeywordsChain();
    _homeProvider.clearWallFlyerTypeAndPhid(notify: false);

    /// CLEAR BZZ
    HomeProvider.proClearActiveBz(notify: false);

    /// CLEAR USER
    UsersProvider.proSetMyUserModel(userModel: null, notify: false);

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

    await Routing.goTo(route: ScreenName.logo);

  }

}
// -----------------------------------------------------------------------------

/// SWITCH ACCOUNT OPS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> signInByAnotherAccount() async {

  await Routing.goTo(route: TabName.bid_Auth);

}
// -----------------------------------------------------------------------------
