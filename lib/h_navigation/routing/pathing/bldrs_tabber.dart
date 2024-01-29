part of bldrs_routing;


enum BldrsTab {
  // --------------------
  home,
  zone,
  auth,

  myInfo,
  mySaves,
  myNotes,
  myFollows,
  mySettings,
  myBzInfo,

  myBzFlyers,
  myBzTeam,
  myBzNotes,
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
    BldrsTab.auth,

    BldrsTab.myInfo,
    BldrsTab.mySaves,
    BldrsTab.myNotes,
    BldrsTab.myFollows,
    BldrsTab.mySettings,

    BldrsTab.myBzInfo,
    BldrsTab.myBzFlyers,
    BldrsTab.myBzTeam,
    BldrsTab.myBzNotes,
    BldrsTab.myBzSettings,

    BldrsTab.appSettings,
    // --------------------
  ];

  static const int mainButtonsLength = 6;
  static const int profileButtonsLength = 5;
  static const int bzButtonsLength = 5;
  // -----------------------------------------------------------------------------

  /// MIRAGE BUTTONS (BID is ButtonID)

  // --------------------
  static const String bidHome = 'bidHome';
  static const String bidZone = 'bidZone';
  static const String bidAuth = 'bidAuth';
  static const String bidMyProfile = 'bidMyProfile';
  static const String bidMyBzz = 'bidMyBzz';
  static const String bidAppSettings = 'bidAppSettings';
  // --------------------
  static const String bidMyInfo = 'bidMyInfo';
  static const String bidMySaves = 'bidMySaves';
  static const String bidMyNotes = 'bidMyNotes';
  static const String bidMyFollows = 'bidMyFollows';
  static const String bidMySettings = 'bidMySettings';
  // --------------------
  static const String bidMyBzInfo = 'bidMyBzInfo';
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
      case BldrsTab.auth              : return const AuthPage();

      case BldrsTab.myInfo            : return const UserProfilePage();
      case BldrsTab.mySaves           : return const SavedFlyersScreen(appBarType: AppBarType.non);
      case BldrsTab.myNotes           : return const UserNotesPage();
      case BldrsTab.myFollows         : return const UserFollowingPage();
      case BldrsTab.mySettings        : return const UserSettingsPage();

      case BldrsTab.myBzInfo          : return const BzAboutPage(appBarType: AppBarType.non);
      case BldrsTab.myBzFlyers        : return const MyBzFlyersPage();
      case BldrsTab.myBzTeam          : return const BzTeamPage(appBarType: AppBarType.non);
      case BldrsTab.myBzNotes         : return const BzNotesPage(appBarType: AppBarType.non);
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
      bidHome,
      bidZone,
      bidAuth,
      bidMyProfile,
      bidMyBzz,
      bidAppSettings,

      bidMyInfo,
      bidMyNotes,
      bidMySaves,
      bidMyFollows,
      bidMySettings,
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

      generateBzBid(bzID: bzID, bid: bidMyBzInfo),
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
      case bidHome              : return BldrsTab.home;
      case bidZone                  : return BldrsTab.zone;
      case bidAuth                  : return BldrsTab.auth;
      case bidMyProfile               : return BldrsTab.myInfo;
      case bidMyBzz                   : return BldrsTab.myBzInfo;

      case bidMyInfo           : return BldrsTab.myInfo;
      case bidMyNotes  : return BldrsTab.myNotes;
      case bidMySaves          : return BldrsTab.mySaves;
      case bidMyFollows      : return BldrsTab.myFollows;
      case bidMySettings       : return BldrsTab.mySettings;

      case bidMyBzInfo             : return BldrsTab.myBzInfo;
      case bidMyBzFlyers            : return BldrsTab.myBzFlyers;
      case bidMyBzTeam              : return BldrsTab.myBzTeam;
      case bidMyBzNotes             : return BldrsTab.myBzNotes;
      case bidMyBzSettings          : return BldrsTab.myBzSettings;

      case bidAppSettings           : return BldrsTab.appSettings;
      default: return BldrsTab.home;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBidIcon(String? bid){
    switch(bid){

      case bidMyProfile                 : return UsersProvider.proGetMyUserModel(
                                                    context: getMainContext(),
                                                    listen: false
                                                )?.picPath;

      case bidMyInfo             : return Iconz.normalUser ;
      case bidMyNotes    : return Iconz.notification ;
      case bidMySaves            : return Iconz.love ;
      case bidMyFollows        : return Iconz.follow       ;
      case bidMySettings         : return Iconz.gears        ;

      case bidMyBzInfo             : return Iconz.info;
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

      case bidMyInfo                : return  'phid_profile'       ;
      case bidMyNotes               : return  'phid_notifications' ;
      case bidMySaves               : return  'phid_savedFlyers' ;
      case bidMyFollows             : return  'phid_followed_bz'   ;
      case bidMySettings            : return  'phid_settings'      ;

      case bidMyBzInfo              : return 'phid_info';
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

  /// button index

  // --------------------
  /// TESTED : WORKS PERFECT
  static int getButtonIndexInMainMirage({
    required String bid,
  }){
    switch (bid){

      case bidHome          : return 0;
      case bidZone          : return 1;
      case bidAuth          : return 2;
      case bidMyProfile     : return 3;
      case bidMyBzz         : return 4;
      case bidAppSettings   : return 5;

      default: return 0;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getButtonIndexInProfileMirage({
    required String bid,
  }){

    switch (bid){

      case bidMyInfo        : return 0;
      case bidMySaves       : return 1;
      case bidMyNotes       : return 2;
      case bidMyFollows     : return 3;
      case bidMySettings    : return 4;

      default: return 0;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getButtonIndexInMyBzzMirage({
    required String bzID,
  }){

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    return _userModel?.myBzzIDs?.indexOf(bzID) ?? 0;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getButtonIndexInBzProfileMirage({
    required String bid,
  }){

    switch (bid){

      case bidMyBzInfo      : return 0;
      case bidMyBzFlyers    : return 1;
      case bidMyBzTeam      : return 2;
      case bidMyBzNotes     : return 3;
      case bidMyBzSettings  : return 4;

      default: return 0;
    }

  }
  // --------------------
  /// TASK : DO ME
  static int getButtonIndexInKeywordsMirage({
    required String path,
  }){

    blog('obbaaaa : $path');

    return 0;
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
