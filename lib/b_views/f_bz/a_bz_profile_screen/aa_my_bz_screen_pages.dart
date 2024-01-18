import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/b_bz_flyer_page/bz_flyers_view.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/b_bz_flyer_page/bz_flyers_page_controllers.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/a_bz_about_page/bz_about_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/c_bz_team_page/bz_team_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/d_bz_notes_page/bz_notes_page.dart';
// import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/bz_targets_page.dart';
// import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/bz_powers_page.dart';
// import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/aaa7_bz_network_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/e_bz_settings_page/bz_settings_page.dart';
import 'package:basics/z_grid/z_grid.dart';
import 'package:flutter/material.dart';

class MyBzScreenPages extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MyBzScreenPages({
    required this.screenHeight,
    required this.tabController,
    required this.scrollController,
    required this.zGridController,
    required this.activePhid,
    required this.mounted,
    required this.bzModel,
    super.key
  });
  // -------------------------
  final double screenHeight;
  final TabController tabController;
  final ZGridController zGridController;
  final ScrollController scrollController;
  final ValueNotifier<String?> activePhid;
  final bool mounted;
  final BzModel bzModel;
  // --------------------------------------------------------------------------
  static List<Widget> pages({
    required ScrollController scrollController,
    required ZGridController zGridController,
    required ValueNotifier<String?> activePhid,
    required bool mounted,
    required BzModel? bzModel,
  }){
    return <Widget>[

    const BzAboutPage(),

    BzFlyersView(
      zGridController: zGridController,
      scrollController: scrollController,
      activePhid: activePhid,
      mounted: mounted,
      bzModel: bzModel,
      showAddFlyerButton: true,
      onFlyerOptionsTap: (FlyerModel flyerModel) => onFlyerBzOptionsTap(
        flyer: flyerModel,
      ),
      onlyShowPublished: false,
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
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: pages(
        zGridController: zGridController,
        scrollController: scrollController,
        activePhid: activePhid,
        mounted: mounted,
        bzModel: bzModel,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
