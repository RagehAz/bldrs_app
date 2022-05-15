import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/paragraph_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/stats_line.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class BzAboutPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzAboutPage({
    @required this.bzModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
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
          InfoPageKeywords(
            pageWidth: superScreenWidth(context),
            keywordsIDs: bzModel.scope,
          ),

        if (bzModel.scope != null) const BubblesSeparator(),

        /// --- STATS
        if (bzModel.totalSlides != null)
          Bubble(title: 'Stats', columnChildren: <Widget>[
            /// FOLLOWERS
            StatsLine(
              verse: '${bzModel.totalFollowers} ${superPhrase(context, 'phid_followers')}',
              icon: Iconz.follow,
            ),

            /// CALLS
            StatsLine(
              verse: '${bzModel.totalCalls} ${superPhrase(context, 'phid_callsReceived')}',
              icon: Iconz.comPhone,
            ),

            /// SLIDES & FLYERS
            StatsLine(
              verse: '${bzModel.totalSlides} '
                  '${superPhrase(context, 'phid_slidesPublished')} '
                  '${superPhrase(context, 'phid_inn')} '
                  '${bzModel.flyersIDs.length} '
                  '${superPhrase(context, 'phid_flyers')}',
              icon: Iconz.gallery,
            ),

            /// SAVES
            StatsLine(
              verse: '${bzModel.totalSaves} ${superPhrase(context, 'phid_totalSaves')}',
              icon: Iconz.saveOn,
            ),

            /// VIEWS
            StatsLine(
              verse: '${bzModel.totalViews} ${superPhrase(context, 'phid_total_flyer_views')}',
              icon: Iconz.viewsIcon,
            ),

            /// SHARES
            StatsLine(
              verse: '${bzModel.totalShares} ${superPhrase(context, 'phid_totalShares')}',
              icon: Iconz.share,
            ),

            /// BIRTH
            StatsLine(
              verse: Timers.getString_in_bldrs_since_month_yyyy(context, bzModel.createdAt),
              icon: Iconz.calendar,
            ),
          ]),

        const Horizon(),

      ],
    );
  }
}
