import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_stats_bubble.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/paragraph_bubble.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
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

        /// BZ BANNER
        BzBanner(
          bzModel: bzModel,
        ),

        /// ABOUT
        if (bzModel.about != null)
          ParagraphBubble(
            title: 'About ${bzModel.name}',
            paragraph: bzModel.about,
          ),

        /// SCOPE
        if (bzModel.scope != null)
          Bubble(
            title: 'Scope of services',
            columnChildren: <Widget>[

              InfoPageKeywords(
                pageWidth: superScreenWidth(context),
                keywordsIDs: bzModel.scope,
              ),

            ],
          ),

        /// SEPARATOR
        if (bzModel.scope != null)
          const BubblesSeparator(),

        /// STATS
        if (bzModel.totalSlides != null)
          const BzStatsBubble(),

        const Horizon(),

      ],
    );

  }
}
