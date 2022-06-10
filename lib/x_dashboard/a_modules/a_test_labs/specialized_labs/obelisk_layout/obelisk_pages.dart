import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_2_bz_flyers_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_3_bz_about_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_4_bz_authors_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_5_bz_notes_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_5_bz_targets_page.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/obelisk_layout/obelisk_page.dart';
import 'package:flutter/material.dart';

class ObeliskPages extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskPages({
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

    // final double _obeliskRadius = (ObeliskRow.circleWidth + 10) * 0.5;
    // const List<BzTab> _bzTabs = BzModel.bzTabsList;

    final double _pageWidth = ObeliskPage.getWidth(context);

    return TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: <Widget>[

        /// FLYERS
        ObeliskPage(
          screenHeight: screenHeight,
          color: Colorz.white20,
          title: BzModel.translateBzTab(BzTab.flyers),
          child: BzFlyersPage(
            height: ObeliskPage.getHeight(screenHeight: screenHeight, context: context),
            width: _pageWidth,
            topPadding: 5,
          ),
        ),

        /// ABOUT
        ObeliskPage(
          screenHeight: screenHeight,
          color: Colorz.white20,
          title: BzModel.translateBzTab(BzTab.about),
          child: BzAboutPage(
            width: _pageWidth,
          ),
        ),

        /// TEAM
        ObeliskPage(
          screenHeight: screenHeight,
          color: Colorz.white20,
          title: BzModel.translateBzTab(BzTab.authors),
          child: BzAuthorsPage(
            bubbleWidth: _pageWidth,
          ),
        ),

        /// NOTIFICATIONS
        ObeliskPage(
          screenHeight: screenHeight,
          color: Colorz.white20,
          title: BzModel.translateBzTab(BzTab.notes),
          child: BzNotesPage(
            bubbleWidth: _pageWidth,
          ),
        ),

        /// TARGETS
        ObeliskPage(
          screenHeight: screenHeight,
          color: Colorz.white20,
          title: BzModel.translateBzTab(BzTab.targets),
          child: const BzTargetsPage(),
        ),

        ObeliskPage(
          screenHeight: screenHeight,
          color: Colorz.red50,
          title: BzModel.translateBzTab(BzTab.powers),
        ),

        ObeliskPage(
          screenHeight: screenHeight,
          color: Colorz.green20,
          title: BzModel.translateBzTab(BzTab.network),
        ),

        // ObeliskPage(
        //   screenHeight: screenHeight,
        //   color: Colorz.bloodTest,
        // ),

      ],
    );

  }

}
