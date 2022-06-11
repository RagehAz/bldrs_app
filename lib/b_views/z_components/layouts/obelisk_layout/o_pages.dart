import 'package:bldrs/b_views/y_views/f_bz/f_2_bz_flyers_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_3_bz_about_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_4_bz_authors_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_5_bz_notes_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_5_bz_targets_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_6_bz_powers_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_7_bz_network_page.dart';
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
  @override
  Widget build(BuildContext context) {

    return TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: const <Widget>[

        BzFlyersPage(),

        BzAboutPage(),

        BzAuthorsPage(),

        BzNotesPage(),

        BzTargetsPage(),

        BzPowersPage(),

        BzNetworkPage(),

      ],
    );

  }

}
