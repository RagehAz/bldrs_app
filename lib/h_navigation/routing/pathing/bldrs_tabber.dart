// ignore_for_file: constant_identifier_names
part of bldrs_routing;

class BldrsTabber {
  // -----------------------------------------------------------------------------

  const BldrsTabber();

  // -----------------------------------------------------------------------------

  /// ALL TABS

  // -----------------------------------------------------------------------------
  static const List<String> allTabs = <String>[
    // --------------------
    TabName.bid_Home,
    TabName.bid_Zone,
    TabName.bid_Auth,

    TabName.bid_My_Info,
    TabName.bid_My_Saves,
    TabName.bid_My_Notes,
    TabName.bid_My_Follows,
    TabName.bid_My_Settings,

    TabName.bid_MyBz_Info,
    TabName.bid_MyBz_Flyers,
    TabName.bid_MyBz_Team,
    TabName.bid_MyBz_Notes,
    TabName.bid_MyBz_Settings,

    TabName.bid_AppSettings,
    // --------------------
  ];
  // -----------------------------------------------------------------------------
  static const int mainButtonsLength = 6;
  static const int profileButtonsLength = 5;
  static const int bzButtonsLength = 5;
  // -----------------------------------------------------------------------------

  /// ALL VIEWS WIDGETS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Widget _getViewWidget(String bid){

    switch (bid){
    // --------------------
      case TabName.bid_Home               : return const FlyersWallPage();
      case TabName.bid_Zone               : return const ZonePage();
      case TabName.bid_Auth               : return const AuthPage();
      case TabName.bid_AppSettings        : return const AppSettingsPage();

      case TabName.bid_MyProfile          : return const UserProfilePage();
      case TabName.bid_MyBzz              : return const BzAboutPage(appBarType: AppBarType.non);

      case TabName.bid_My_Info            : return const UserProfilePage();
      case TabName.bid_My_Saves           : return const SavedFlyersScreen(appBarType: AppBarType.non);
      case TabName.bid_My_Notes           : return const UserNotesPage();
      case TabName.bid_My_Follows         : return const UserFollowingPage();
      case TabName.bid_My_Settings        : return const UserSettingsPage();

      case TabName.bid_MyBz_Info          : return const BzAboutPage(appBarType: AppBarType.non);
      case TabName.bid_MyBz_Flyers        : return const MyBzFlyersPage();
      case TabName.bid_MyBz_Team          : return const BzTeamPage(appBarType: AppBarType.non);
      case TabName.bid_MyBz_Notes         : return const BzNotesPage(appBarType: AppBarType.non);
      case TabName.bid_MyBz_Settings      : return const BzSettingsPage();

      default: return const FlyersWallPage();
    // --------------------
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Widget> getAllViewsWidgets() {
    final List<Widget> _views = [];

    for (int i = 0; i < allTabs.length; i++){
      final String _tab = allTabs[i];
      final Widget _viewWidget = _getViewWidget(_tab);
      _views.add(_viewWidget);
    }

    return _views;
  }

  // -----------------------------------------------------------------------------

  /// TAB GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static int _getTabIndex(String bid){
    final int _index = allTabs.indexWhere((element) => element == bid);
    return _index == -1 ? 0 : _index;
  }

  // -----------------------------------------------------------------------------

  /// button index

  // --------------------
  /// TESTED : WORKS PERFECT
  static int getButtonIndexInMainMirage({
    required String bid,
  }){
    switch (bid){

      case TabName.bid_Home          : return 0;
      case TabName.bid_Zone          : return 1;
      case TabName.bid_Auth          : return 2;
      case TabName.bid_MyProfile     : return 3;
      case TabName.bid_MyBzz         : return 4;
      case TabName.bid_AppSettings   : return 5;

      default: return 0;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getButtonIndexInProfileMirage({
    required String bid,
  }){

    switch (bid){

      case TabName.bid_My_Info        : return 0;
      case TabName.bid_My_Saves       : return 1;
      case TabName.bid_My_Notes       : return 2;
      case TabName.bid_My_Follows     : return 3;
      case TabName.bid_My_Settings    : return 4;

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

    // blog('_userModel?.myBzzIDs?.indexOf(bzID) : ${_userModel?.myBzzIDs?.indexOf(bzID)}');

    return _userModel?.myBzzIDs?.indexOf(bzID) ?? 0;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getButtonIndexInBzProfileMirage({
    required String bid,
  }){

    switch (bid){

      case TabName.bid_MyBz_Info      : return 0;
      case TabName.bid_MyBz_Flyers    : return 1;
      case TabName.bid_MyBz_Team      : return 2;
      case TabName.bid_MyBz_Notes     : return 3;
      case TabName.bid_MyBz_Settings  : return 4;

      default: return 0;
    }

  }
  // -----------------------------------------------------------------------------

  /// GO TO TAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToTab({
    required String bid,
  }) async {

    final TabController? _controller  = HomeProvider.proGetTabController(
      context: getMainContext(),
      listen: false,
    );

    _controller?.animateTo(
      _getTabIndex(bid),
      duration: const Duration(milliseconds: 700),
    );

  }
  // -----------------------------------------------------------------------------
}
