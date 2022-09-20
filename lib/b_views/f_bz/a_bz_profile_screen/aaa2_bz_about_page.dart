import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_stats_bubble.dart';
import 'package:bldrs/b_views/z_components/editors/contacts_bubble.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/paragraph_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:flutter/material.dart';

class BzAboutPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzAboutPage({
    this.bzModel,
    this.showGallery = false,
    this.showContacts = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final bool showGallery;
  final bool showContacts;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = bzModel ?? BzzProvider.proGetActiveBzModel(context: context, listen: true);

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      children: <Widget>[

        /// BZ BANNER
        BzBanner(
          boxWidth: BldrsAppBar.width(context),
          boxHeight: BldrsAppBar.width(context),
          // margins: 10,
          bzModel: _bzModel,
          corners: Bubble.cornersValue,
          bigName: true,
        ),

        /// ABOUT
        if (TextCheck.isEmpty(_bzModel.about) == false)
          ParagraphBubble(
            headerViewModel: const BubbleHeaderVM(
              headlineVerse: Verse(
                text: 'phid_about_us',
                translate: true,
              ),
            ),
            paragraph: Verse(
              text: _bzModel.about,
              translate: false,
            ),
          ),

        /// BZ CONTACT
        if (showContacts == true && Mapper.checkCanLoopList(_bzModel?.contacts) == true)
          ContactsBubble(
            contacts: _bzModel?.contacts,
            location: _bzModel?.position,
            canLaunchOnTap: true,
          ),


        /// SCOPE
        if (Mapper.checkCanLoopList(_bzModel.scope) == true)
          Bubble(
            headerViewModel: const BubbleHeaderVM(
              headlineVerse: Verse(
                text: 'phid_scopeOfServices',
                translate: true,
              ),
            ),
            columnChildren: <Widget>[

              PhidsViewer(
                pageWidth: Scale.superScreenWidth(context),
                phids: _bzModel.scope,
              ),

            ],
          ),

        /// SEPARATOR
        if (Mapper.checkCanLoopList(_bzModel.scope) == true)
          const DotSeparator(),

        /// STATS
        BzStatsBubble(
          bzModel: _bzModel,
        ),

        /// FLYERS GALLERY TITLE
        if (showGallery == true)
          SuperVerse(
            verse: Verse(
              text: '##Flyers By ${bzModel.name}',
              translate: false,
              variables: bzModel.name,
            ),
            centered: false,
            maxLines: 2,
            margin: 20,
            size: 4,
          ),

        /// TASK : TEST PAGINATION OF BZ FLYERS IN BZ ABOUT PAGE REACHED FROM FOLLOWED BZ ON TAP
        /// BZ FLYERS
        if (showGallery == true)
          FlyersGrid(
            scrollController: ScrollController(),
            paginationFlyersIDs: _bzModel.flyersIDs,
            topPadding: 0,
            heroTag: 'BzAboutPageFlyersGrid',
          ),

        const Horizon(),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
