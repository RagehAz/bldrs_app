import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/aa_home_screen_view.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/a_app_settings_screen.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
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

class BldrsTabs {
  // -----------------------------------------------------------------------------

  const BldrsTabs();

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

  /// ALL VIEWS WIDGETS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Widget _getViewWidget(BldrsTab bldrsTab){

    switch (bldrsTab){
      // --------------------
      case BldrsTab.home              : return const HomeFlyersGrid();
      case BldrsTab.zone              : return Container();
      case BldrsTab.signIn            : return Container();

      case BldrsTab.myProfile         : return Container();
      case BldrsTab.mySaves           : return Container();
      case BldrsTab.myNotifications   : return Container();
      case BldrsTab.myFollows         : return Container();
      case BldrsTab.mySettings        : return Container();

      case BldrsTab.myBzProfile       : return Container();
      case BldrsTab.myBzFlyers        : return Container();
      case BldrsTab.myBzTeam          : return Container();
      case BldrsTab.myBzNotifications : return Container();
      case BldrsTab.myBzSettings      : return Container();

      case BldrsTab.appSettings       : return const AppSettingsScreen();
      default: return Container();
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
