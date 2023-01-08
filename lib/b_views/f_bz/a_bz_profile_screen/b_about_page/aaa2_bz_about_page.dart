import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/bz_authors_bubble/bz_authors_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/contacts_bubble/contacts_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/paragraph_bubble/paragraph_bubble.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_stats_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/pull_to_refresh.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/backend_lab/google_ads_test/google_ad.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzAboutPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzAboutPage({
    this.bzModel,
    this.showGallery = false,
    this.showContacts = true,
    this.showAuthors = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final bool showGallery;
  final bool showContacts;
  final bool showAuthors;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = bzModel ?? BzzProvider.proGetActiveBzModel(context: context, listen: true);

    if (bzModel == null){
      return PullToRefresh(
        fadeOnBuild: true,
        onRefresh: () async {

          final BzModel _bz = await BzProtocols.refetch(
              context: context,
              bzID:_bzModel.id,
          );

          final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
          _bzzProvider.setActiveBz(
              bzModel: _bz,
              notify: true,
          );

        },
        child: AboutBzBubbles(
          bzModel: _bzModel,
          showContacts: showContacts,
          showGallery: showGallery,
          showAuthors: showAuthors,
        ),
      );
    }

    else {
      return AboutBzBubbles(
        bzModel: _bzModel,
        showContacts: showContacts,
        showGallery: showGallery,
        showAuthors: showAuthors,
      );
    }

  }
  // -----------------------------------------------------------------------------
}

class AboutBzBubbles extends StatelessWidget {

  const AboutBzBubbles({
    @required this.bzModel,
    @required this.showGallery,
    @required this.showContacts,
    @required this.showAuthors,
    Key key
  }) : super(key: key);

  final BzModel bzModel;
  final bool showGallery;
  final bool showContacts;
  final bool showAuthors;

  @override
  Widget build(BuildContext context) {

    final double flyerBoxWidth = FlyerDim.flyerGridVerticalScrollFlyerBoxWidth(
      numberOfColumns: 2,
      gridZoneWidth: Scale.screenWidth(context),
    );
    final double _spacing = FlyerDim.flyerGridGridSpacingValue(flyerBoxWidth);
    final double _flyerHeight = FlyerDim.flyerHeightByFlyerWidth(context, flyerBoxWidth);
    final int _numberOfFlyers = bzModel?.flyersIDs?.length ?? 0;
    final double _gridHeight = (_flyerHeight + _spacing) * (_numberOfFlyers / 2).ceil();


    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      children: <Widget>[

        const GoogleAdRectangleBanner(),

        /// BZ BANNER
        BzBanner(
          boxWidth: BldrsAppBar.width(context),
          boxHeight: BldrsAppBar.width(context),
          // margins: 10,
          bzModel: bzModel,
          corners: Bubble.cornersValue,
          bigName: true,
        ),

        /// ABOUT
        if (TextCheck.isEmpty(bzModel?.about) == false)
          ParagraphBubble(
            headerViewModel: const BubbleHeaderVM(
              headlineVerse: Verse(
                text: 'phid_about_us',
                translate: true,
              ),
            ),
            paragraph: Verse(
              text: bzModel?.about,
              translate: false,
            ),
          ),

        /// SCOPE
        if (Mapper.checkCanLoopList(bzModel?.scope) == true)
          Bubble(
            bubbleHeaderVM: const BubbleHeaderVM(
              headlineVerse: Verse(
                text: 'phid_scopeOfServices',
                translate: true,
              ),
            ),
            columnChildren: <Widget>[

              PhidsViewer(
                pageWidth: Scale.screenWidth(context),
                phids: bzModel?.scope,
                onPhidTap: (String phid){
                  blog('bzAboutPage : onPhidTap : phid: $phid');
                },
                onPhidLongTap: (String phid){
                  blog('bzAboutPage : onPhidLongTap : phid: $phid');
                },
              ),

            ],
          ),

        /// AUTHORS
        if (showAuthors == true)
        BzAuthorsBubble(
          bzModel: bzModel,
        ),

        /// BZ CONTACT
        if (showContacts == true && Mapper.checkCanLoopList(bzModel?.contacts) == true)
          ContactsBubble(
            contacts: bzModel?.contacts,
            location: bzModel?.position,
            canLaunchOnTap: true,
          ),

        /// SEPARATOR
        if (Mapper.checkCanLoopList(bzModel?.scope) == true)
          const DotSeparator(),

        /// STATS
        BzStatsBubble(
          bzModel: bzModel,
        ),

        /// FLYERS GALLERY TITLE
        if (showGallery == true)
          SuperVerse(
            verse: Verse(
              text: '${xPhrase(context, 'phid_published_flyers_by')} ${bzModel?.name}',
              translate: false,
            ),
            centered: false,
            maxLines: 2,
            margin: 20,
            size: 4,
          ),

        /// BZ FLYERS
        if (showGallery == true)
          FlyersGrid(
            scrollController: ScrollController(),
            flyersIDs: bzModel?.flyersIDs,
            topPadding: 0,
            screenName: 'BzAboutPageFlyersGrid',
            gridHeight: _gridHeight,
            scrollable: false,
          ),

        // const Horizon(),

      ],
    );

  }

}
