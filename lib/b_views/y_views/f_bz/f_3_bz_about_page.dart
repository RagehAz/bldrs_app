import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_stats_bubble.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/paragraph_bubble.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:flutter/material.dart';

class BzAboutPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzAboutPage({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[

        /// BZ BANNER
        BzBanner(
          bzModel: _bzModel,
        ),

        /// ABOUT
        if (_bzModel.about != null)
          ParagraphBubble(
            title: 'About ${_bzModel.name}',
            paragraph: _bzModel.about,
          ),

        /// SCOPE
        if (_bzModel.scope != null)
          Bubble(
            title: 'Scope of services',
            columnChildren: <Widget>[

              InfoPageKeywords(
                pageWidth: Scale.superScreenWidth(context),
                keywordsIDs: _bzModel.scope,
              ),

            ],
          ),

        /// SEPARATOR
        if (_bzModel.scope != null)
          const BubblesSeparator(),

        /// STATS
        if (_bzModel.totalSlides != null)
          const BzStatsBubble(),

        const Horizon(),

      ],
    );

  }
}
