import 'package:bldrs/b_views/y_views/f_bz/f_2_bz_flyers_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_3_bz_about_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_4_bz_authors_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_5_bz_notes_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_5_bz_targets_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_6_bz_powers_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_7_bz_network_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_8_bz_settings.dart';
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
