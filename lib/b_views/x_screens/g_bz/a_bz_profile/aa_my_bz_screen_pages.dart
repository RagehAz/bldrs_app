import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/aaa1_bz_flyers_page.dart';
import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/aaa2_bz_about_page.dart';
import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/aaa3_bz_authors_page.dart';
import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/aaa4_bz_notes_page.dart';
import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/aaa5_bz_targets_page.dart';
import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/aaa6_bz_powers_page.dart';
import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/aaa7_bz_network_page.dart';
import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/aaa8_bz_settings.dart';
import 'package:flutter/material.dart';

class MyBzScreenPages extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MyBzScreenPages({
    @required this.screenHeight,
    @required this.tabController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final TabController tabController;
  /// --------------------------------------------------------------------------
  static const List<Widget> pages = <Widget>[

      BzFlyersPage(),

      BzAboutPage(),

      BzAuthorsPage(),

      BzNotesPage(),

      BzTargetsPage(),

      BzPowersPage(),

      BzNetworkPage(),

      BzSettingsPage(),

  ];
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: pages,
    );

  }

}
