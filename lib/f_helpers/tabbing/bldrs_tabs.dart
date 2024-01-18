import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/a_flyers_wall_page/flyers_wall_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/b_zones_page/zone_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/a_my_profile_page/aaa1_user_profile_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/b_my_saves_page/saved_flyers_screen.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/c_my_notifications_page/user_notes_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/d_user_follows_page/user_following_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/e_my_settings_page/user_settings_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_auth_page/auth_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/a_bz_about_page/bz_about_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/b_bz_flyer_page/my_bz_flyers_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/c_bz_team_page/bz_team_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/e_app_settings_page/app_settings_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/d_bz_notes_page/bz_notes_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/e_bz_settings_page/bz_settings_page.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

enum BldrsTab {
  // --------------------
  home,
  zone,
  signIn,

  myProfile,
  mySaves,
  myNotifications,
  myFollows,
  mySettings,
  myBzProfile,

  myBzFlyers,
  myBzTeam,
  myBzNotifications,
  myBzSettings,

  appSettings,
  // --------------------
}

class BldrsTabber {
  // -----------------------------------------------------------------------------

  const BldrsTabber();

  // -----------------------------------------------------------------------------

  /// ALL TABS

  // -----------------------------------------------------------------------------
  static const List<BldrsTab> allTabs = <BldrsTab>[
    // --------------------
    BldrsTab.home,
    BldrsTab.zone,
    BldrsTab.signIn,

    BldrsTab.myProfile,
    BldrsTab.mySaves,
    BldrsTab.myNotifications,
    BldrsTab.myFollows,
    BldrsTab.mySettings,

    BldrsTab.myBzProfile,
    BldrsTab.myBzFlyers,
    BldrsTab.myBzTeam,
    BldrsTab.myBzNotifications,
    BldrsTab.myBzSettings,

    BldrsTab.appSettings,
    // --------------------
  ];
  // -----------------------------------------------------------------------------

  /// MIRAGE BUTTONS (BID is ButtonID)

  // --------------------
  static const String bidSections = 'bidSections';
  static const String bidZone = 'bidZone';
  static const String bidSign = 'bidSign';
  static const String bidProfile = 'bidProfile';
  static const String bidBzz = 'bidBzz';
  static const String bidAppSettings = 'bidAppSettings';
  // --------------------
  static const String bidProfileInfo = 'bidProfileInfo';
  static const String bidProfileNotifications = 'bidProfileNotifications';
  static const String bidProfileSaves = 'bidProfileSaves';
  static const String bidProfileFollowing = 'bidProfileFollowing';
  static const String bidProfileSettings = 'bidProfileSettings';
  // --------------------
  static const String bidMyBzAbout = 'bidMyBzAbout';
  static const String bidMyBzFlyers = 'bidMyBzFlyers';
  static const String bidMyBzTeam = 'bidMyBzTeam';
  static const String bidMyBzNotes = 'bidMyBzNotes';
  static const String bidMyBzSettings = 'bidMyBzSettings';
  // -----------------------------------------------------------------------------

  /// ALL VIEWS WIDGETS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Widget _getViewWidget(BldrsTab bldrsTab){

    switch (bldrsTab){
    // --------------------
      case BldrsTab.home              : return const FlyersWallPage();
      case BldrsTab.zone              : return const ZonePage();
      case BldrsTab.signIn            : return const AuthPage();

      case BldrsTab.myProfile         : return const UserProfilePage();
      case BldrsTab.mySaves           : return const SavedFlyersScreen(appBarType: AppBarType.non);
      case BldrsTab.myNotifications   : return const UserNotesPage();
      case BldrsTab.myFollows         : return const UserFollowingPage();
      case BldrsTab.mySettings        : return const UserSettingsPage();

      case BldrsTab.myBzProfile       : return const BzAboutPage(appBarType: AppBarType.non);
      case BldrsTab.myBzFlyers        : return const MyBzFlyersPage();
      case BldrsTab.myBzTeam          : return const BzTeamPage(appBarType: AppBarType.non);
      case BldrsTab.myBzNotifications : return const BzNotesPage(appBarType: AppBarType.non);
      case BldrsTab.myBzSettings      : return const BzSettingsPage();

      case BldrsTab.appSettings       : return const AppSettingsPage();

      default: return const FlyersWallPage();
    // --------------------
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Widget> getAllViewsWidgets() {
    final List<Widget> _views = [];

    for (int i = 0; i < allTabs.length; i++){
      final BldrsTab _tab = allTabs[i];
      final Widget _viewWidget = _getViewWidget(_tab);
      _views.add(_viewWidget);
    }

    return _views;
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateAllBids({
    required BuildContext context,
    required bool listen,
  }){

    const List<String> _initialList = [
      bidSections,
      bidZone,
      bidSign,
      bidProfile,
      bidBzz,
      bidAppSettings,

      bidProfileInfo,
      bidProfileNotifications,
      bidProfileSaves,
      bidProfileFollowing,
      bidProfileSettings,
    ];

    final List<String> _myBzzBids = generateMyBzzBids(
      context: context,
      listen: listen,
    );

    return Stringer.addStringsToStringsIfDoNotContainThem(
        listToTake: _initialList,
        listToAdd: _myBzzBids,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateMyBzzBids({
    required BuildContext context,
    required bool listen,
  }){
    final List<String> _output = [];

    final List<String> _myBzzIDs = UsersProvider.proGetMyBzzIDs(
        context: context,
        listen: listen
    );

    if (Lister.checkCanLoop(_myBzzIDs) == true){

      for (final String bzID in _myBzzIDs){

        _output.addAll([
          ...generateBzBids(bzID: bzID),
        ]);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateBzBids({
    required String bzID,
  }){
    final List<String> _output = [];

    _output.addAll([

      generateBzBid(bzID: bzID, bid: bidMyBzAbout),
      generateBzBid(bzID: bzID, bid: bidMyBzFlyers),
      generateBzBid(bzID: bzID, bid: bidMyBzTeam),
      generateBzBid(bzID: bzID, bid: bidMyBzNotes),
      generateBzBid(bzID: bzID, bid: bidMyBzSettings),

    ]);

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateBzBid({
    required String bzID,
    required String? bid,
  }){

    if (bid == null){
      return 'bidBz/$bzID';
    }

    else {
      return 'bidBz_$bid/$bzID';
    }

  }
  // -----------------------------------------------------------------------------

  /// BidBz break-down

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBzIDFromBidBz({
    required String? bzBid,
  }){
    String? _output;

    if (checkBidIsBidBz(bid: bzBid) == true){

      _output = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: bzBid,
        specialCharacter: '/',
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBidFromBidBz({
    required String? bzBid,
  }){
    String? _output;

    if (checkBidIsBidBz(bid: bzBid) == true){

      _output = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: bzBid,
          specialCharacter: '_',
      );

      _output = TextMod.removeTextAfterLastSpecialCharacter(
          text: _output,
          specialCharacter: '/',
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkBidIsBidBz({
    required String? bid,
  }){
    return TextCheck.stringStartsExactlyWith(text: bid, startsWith: 'bidBz');
  }
  // -----------------------------------------------------------------------------

  /// TAB GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getTabID(BldrsTab tab){
    return TextMod.removeTextBeforeFirstSpecialCharacter(
        text: tab.toString(),
        specialCharacter: '.',
    )!;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int _getTabIndex(BldrsTab tab){
    final int _index = allTabs.indexWhere((element) => element == tab);
    return _index == -1 ? 0 : _index;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BldrsTab getTabByBid(String? bid){

    switch(bid){
      case bidSections              : return BldrsTab.home;
      case bidZone                  : return BldrsTab.zone;
      case bidSign                  : return BldrsTab.signIn;
      case bidProfile               : return BldrsTab.myProfile;
      case bidBzz                   : return BldrsTab.myBzProfile;

      case bidProfileInfo           : return BldrsTab.myProfile;
      case bidProfileNotifications  : return BldrsTab.myNotifications;
      case bidProfileSaves          : return BldrsTab.mySaves;
      case bidProfileFollowing      : return BldrsTab.myFollows;
      case bidProfileSettings       : return BldrsTab.mySettings;

      case bidMyBzAbout             : return BldrsTab.myBzProfile;
      case bidMyBzFlyers            : return BldrsTab.myBzFlyers;
      case bidMyBzTeam              : return BldrsTab.myBzTeam;
      case bidMyBzNotes             : return BldrsTab.myBzNotifications;
      case bidMyBzSettings          : return BldrsTab.myBzSettings;

      case bidAppSettings           : return BldrsTab.appSettings;
      default: return BldrsTab.home;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBidIcon(String? bid){
    switch(bid){

      case bidProfile                 : return UsersProvider.proGetMyUserModel(
                                                    context: getMainContext(),
                                                    listen: false
                                                )?.picPath;

      case bidProfileInfo             : return Iconz.normalUser ;
      case bidProfileNotifications    : return Iconz.notification ;
      case bidProfileSaves            : return Iconz.love ;
      case bidProfileFollowing        : return Iconz.follow       ;
      case bidProfileSettings         : return Iconz.gears        ;

      case bidMyBzAbout             : return Iconz.info;
      case bidMyBzFlyers            : return Iconz.flyerGrid;
      case bidMyBzTeam              : return Iconz.bz;
      case bidMyBzNotes             : return Iconz.notification;
      case bidMyBzSettings          : return Iconz.gears;
    // case BzTab.targets  : return Iconz.target     ;
    // case BzTab.powers   : return Iconz.power      ;
    // case BzTab.network  : return Iconz.follow     ;

      default : return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? _getBidPhid(String? bid){

    String? _bid = bid;
    if (checkBidIsBidBz(bid: _bid) == true){
      _bid = getBidFromBidBz(bzBid: _bid);
    }

    switch(_bid){

      case bidProfileInfo           : return  'phid_profile'       ;
      case bidProfileNotifications  : return  'phid_notifications' ;
      case bidProfileSaves          : return  'phid_savedFlyers' ;
      case bidProfileFollowing      : return  'phid_followed_bz'   ;
      case bidProfileSettings       : return  'phid_settings'      ;

      case bidMyBzAbout             : return 'phid_info';
      case bidMyBzFlyers            : return 'phid_flyers';
      case bidMyBzTeam              : return 'phid_team';
      case bidMyBzNotes             : return 'phid_notifications';
      case bidMyBzSettings          : return 'phid_settings';
    // case BzTab.targets  : return 'phid_targets'  ; break;
    // case BzTab.powers   : return 'phid_powers'  ; break;
    // case BzTab.network  : return 'phid_network'  ; break;

      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse translateBid(String? bid){
    final String? _phid = _getBidPhid(bid);
    return Verse(
      id: _phid,
      translate: true,
    );
  }
  // -----------------------------------------------------------------------------

  /// GO TO TAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToTab({
    required BldrsTab tab,
  }) async {

    final BuildContext context = getMainContext();

    HomeProvider.proSetCurrentTab(
      context: context,
      tab: tab,
      notify: true,
    );

    final TabController? _controller  = HomeProvider.proGetTabController(
      context: context,
      listen: false,
    );

    _controller?.animateTo(
      _getTabIndex(tab),
      duration: const Duration(milliseconds: 700),
    );

  }
  // -----------------------------------------------------------------------------
}
