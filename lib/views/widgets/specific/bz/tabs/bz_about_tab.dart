import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/general/bubbles/paragraph_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/stats_line.dart';
import 'package:bldrs/views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/tab_layout.dart';
import 'package:flutter/material.dart';

class BzAboutTab extends StatelessWidget {
  final BzModel bzModel;

  const BzAboutTab({
    @required this.bzModel,
});
// -----------------------------------------------------------------------------
  static aboutTabModel({
    @required Function onChangeTab,
    @required BzModel bzModel,
    @required bool isSelected,
    @required int tabIndex,
  }){
    return
      TabModel(
        tabButton: TabButton(
          verse: BzModel.bzPagesTabsTitles[tabIndex],
          icon: Iconz.Info,
          iconSizeFactor: 0.7,
          isSelected: isSelected,
          onTap: () => onChangeTab(tabIndex),
        ),
        page: BzAboutTab(bzModel: bzModel,),
      );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[

        /// --- ABOUT
        if (bzModel.bzAbout != null)
          ParagraphBubble(
            title: 'About ${bzModel.bzName}',
            paragraph: bzModel.bzAbout,
            maxLines: 5,
            centered: false,
          ),

        /// --- SCOPE
        if (bzModel.bzScope != null)
          ParagraphBubble(
            title: 'Scope of services',
            paragraph: bzModel.bzScope,
            maxLines: 5,
          ),

        if (bzModel.bzScope != null)
          BubblesSeparator(),

        /// --- STATS
        if (bzModel.bzTotalSlides != null)
          Bubble(
              title: 'Stats',
              centered: false,
              columnChildren: <Widget>[

                /// FOLLOWERS
                StatsLine(
                  verse: '${bzModel.bzTotalFollowers} ${Wordz.followers(context)}',
                  icon: Iconz.Follow,
                ),

                /// CALLS
                StatsLine(
                  verse: '${bzModel.bzTotalCalls} ${Wordz.callsReceived(context)}',
                  icon: Iconz.ComPhone,
                ),

                /// SLIDES & FLYERS
                StatsLine(
                  verse: '${bzModel.bzTotalSlides} ${Wordz.slidesPublished(context)} ${Wordz.inn(context)} ${bzModel.nanoFlyers.length} ${Wordz.flyers(context)}',
                  icon: Iconz.Gallery,
                ),

                /// SAVES
                StatsLine(
                  verse: '${bzModel.bzTotalSaves} ${Wordz.totalSaves(context)}',
                  icon: Iconz.SaveOn,
                ),

                /// VIEWS
                StatsLine(
                  verse: '${bzModel.bzTotalViews} ${Wordz.totalViews(context)}',
                  icon: Iconz.Views,
                ),

                /// SHARES
                StatsLine(
                  verse: '${bzModel.bzTotalShares} ${Wordz.totalShares(context)}',
                  icon: Iconz.Share,
                ),

                /// BIRTH
                StatsLine(
                  verse: '${Timers.monthYearStringer(context,bzModel.createdAt)}',
                  icon: Iconz.Calendar,
                ),

              ]
          ),

        const PyramidsHorizon(),

      ],
    );
  }
}
