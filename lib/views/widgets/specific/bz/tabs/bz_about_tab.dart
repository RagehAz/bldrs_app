import 'package:bldrs/controllers/drafters/timerz.dart' as Timers;
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/general/bubbles/paragraph_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/stats_line.dart';
import 'package:bldrs/views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/tab_layout.dart';
import 'package:flutter/material.dart';

class BzAboutTab extends StatelessWidget {
  final BzModel bzModel;

  const BzAboutTab({
    @required this.bzModel,
    Key key,
  }) :   super(key: key);
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
        if (bzModel.about != null)
          ParagraphBubble(
            title: 'About ${bzModel.name}',
            paragraph: bzModel.about,
            maxLines: 5,
            centered: false,
          ),

        /// --- SCOPE
        if (bzModel.scope != null)
          ParagraphBubble(
            title: 'Scope of services',
            paragraph: bzModel.scope,
            maxLines: 5,
          ),

        if (bzModel.scope != null)
          const BubblesSeparator(),

        /// --- STATS
        if (bzModel.totalSlides != null)
          Bubble(
              title: 'Stats',
              centered: false,
              columnChildren: <Widget>[

                /// FOLLOWERS
                StatsLine(
                  verse: '${bzModel.totalFollowers} ${Wordz.followers(context)}',
                  icon: Iconz.Follow,
                ),

                /// CALLS
                StatsLine(
                  verse: '${bzModel.totalCalls} ${Wordz.callsReceived(context)}',
                  icon: Iconz.ComPhone,
                ),

                /// SLIDES & FLYERS
                StatsLine(
                  verse: '${bzModel.totalSlides} ${Wordz.slidesPublished(context)} ${Wordz.inn(context)} ${bzModel.flyersIDs.length} ${Wordz.flyers(context)}',
                  icon: Iconz.Gallery,
                ),

                /// SAVES
                StatsLine(
                  verse: '${bzModel.totalSaves} ${Wordz.totalSaves(context)}',
                  icon: Iconz.SaveOn,
                ),

                /// VIEWS
                StatsLine(
                  verse: '${bzModel.totalViews} ${Wordz.totalViews(context)}',
                  icon: Iconz.Views,
                ),

                /// SHARES
                StatsLine(
                  verse: '${bzModel.totalShares} ${Wordz.totalShares(context)}',
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
