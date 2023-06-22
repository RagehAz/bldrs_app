import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/a_flyers_page/aaa1_bz_flyers_page.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/b_about_page/aaa2_bz_about_page.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/c_team_page/bz_team_page.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/d_bz_notes_page/bz_notes_page.dart';
// import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/bz_targets_page.dart';
// import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/bz_powers_page.dart';
// import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/aaa7_bz_network_page.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/h_bz_settings_page/bz_settings_page.dart';
import 'package:bldrs/z_grid/z_grid.dart';
import 'package:flutter/material.dart';

class MyBzScreenPages extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MyBzScreenPages({
    @required this.screenHeight,
    @required this.tabController,
    @required this.scrollController,
    @required this.zGridController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final TabController tabController;
  final ZGridController zGridController;
  final ScrollController scrollController;
  /// --------------------------------------------------------------------------
  static List<Widget> pages({
    @required ScrollController scrollController,
    @required ZGridController zGridController,
  }){
    return <Widget>[

    const BzAboutPage(),

    BzFlyersPage(
      zGridController: zGridController,
      scrollController: scrollController,
    ),

    const BzTeamPage(),

    const BzNotesPage(),

    // BzTargetsPage(),
    //
    // BzPowersPage(),
    //
    // BzNetworkPage(),

    const BzSettingsPage(),

  ];
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: pages(
        zGridController: zGridController,
        scrollController: scrollController,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
