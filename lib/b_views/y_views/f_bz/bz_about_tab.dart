import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/paragraph_bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/stats_line.dart';
import 'package:bldrs/b_views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/b_views/z_components/layouts/tab_layout_model.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';

class BzAboutTab extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzAboutTab({
    @required this.bzModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  static TabModel aboutTabModel({
    @required Function onChangeTab,
    @required BzModel bzModel,
    @required bool isSelected,
    @required int tabIndex,
  }) {
    return TabModel(
      tabButton: TabButton(
        key: ValueKey<String>('bz_about_tab_${bzModel.id}'),
        verse: BzModel.bzPagesTabsTitles[tabIndex],
        icon: Iconz.info,
        iconSizeFactor: 0.7,
        isSelected: isSelected,
        onTap: () => onChangeTab(tabIndex),
      ),
      page: BzAboutTab(
        key: ValueKey<String>('bz_about_page_${bzModel.id}'),
        bzModel: bzModel,
      ),
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
          ),

        /// --- SCOPE
        if (bzModel.scope != null)
          ParagraphBubble(
            title: 'Scope of services',
            paragraph: bzModel.scope,
          ),

        if (bzModel.scope != null) const BubblesSeparator(),

        /// --- STATS
        if (bzModel.totalSlides != null)
          Bubble(title: 'Stats', columnChildren: <Widget>[
            /// FOLLOWERS
            StatsLine(
              verse: '${bzModel.totalFollowers} ${Wordz.followers(context)}',
              icon: Iconz.follow,
            ),

            /// CALLS
            StatsLine(
              verse: '${bzModel.totalCalls} ${Wordz.callsReceived(context)}',
              icon: Iconz.comPhone,
            ),

            /// SLIDES & FLYERS
            StatsLine(
              verse:
                  '${bzModel.totalSlides} ${Wordz.slidesPublished(context)} ${Wordz.inn(context)} ${bzModel.flyersIDs.length} ${Wordz.flyers(context)}',
              icon: Iconz.gallery,
            ),

            /// SAVES
            StatsLine(
              verse: '${bzModel.totalSaves} ${Wordz.totalSaves(context)}',
              icon: Iconz.saveOn,
            ),

            /// VIEWS
            StatsLine(
              verse: '${bzModel.totalViews} ${Wordz.totalViews(context)}',
              icon: Iconz.viewsIcon,
            ),

            /// SHARES
            StatsLine(
              verse: '${bzModel.totalShares} ${Wordz.totalShares(context)}',
              icon: Iconz.share,
            ),

            /// BIRTH
            StatsLine(
              verse: Timers.monthYearStringer(context, bzModel.createdAt),
              icon: Iconz.calendar,
            ),
          ]),

        const Horizon(),

      ],
    );
  }
}