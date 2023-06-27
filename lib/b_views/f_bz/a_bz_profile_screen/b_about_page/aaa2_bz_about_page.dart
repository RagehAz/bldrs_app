import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/layouts/handlers/pull_to_refresh.dart';
import 'package:basics/layouts/separators/dot_separator.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/bz_authors_bubble/bz_authors_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/contacts_bubble/contacts_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/paragraph_bubble/paragraph_bubble.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_stats_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:provider/provider.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class BzAboutPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzAboutPage({
    this.bzModel,
    this.showGallery = false,
    this.showContacts = true,
    this.showAuthors = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final bool showGallery;
  final bool showContacts;
  final bool showAuthors;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel? _bzModel = bzModel ?? BzzProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );

    if (bzModel == null){
      return PullToRefresh(
        circleColor: Colorz.yellow255,
        fadeOnBuild: true,
        onRefresh: () async {

          final BzModel _bz = await BzProtocols.refetch(
              bzID:_bzModel?.id,
          );

          final BzzProvider _bzzProvider = Provider.of<BzzProvider>(getMainContext(), listen: false);
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
    required this.bzModel,
    required this.showGallery,
    required this.showContacts,
    required this.showAuthors,
    super.key
  });
  
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
    final double _flyerHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
    );
    final int _numberOfFlyers = bzModel?.flyersIDs?.length ?? 0;
    final double _gridHeight = (_flyerHeight + _spacing) * (_numberOfFlyers / 2).ceil();


    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      children: <Widget>[

        // const GoogleAdRectangleBanner(),

        /// BZ BANNER
        BzBanner(
          boxWidth: Bubble.bubbleWidth(context: context),
          // boxHeight: BldrsAppBar.width(),
          // margins: 10,
          bzModel: bzModel,
          corners: Bubble.cornersValue,
          bigName: true,
        ),

        /// ABOUT
        if (TextCheck.isEmpty(bzModel?.about) == false)
          ParagraphBubble(
            headerViewModel: BldrsBubbleHeaderVM.bake(
              context: context,
              headlineVerse: const Verse(
                id: 'phid_about_us',
                translate: true,
              ),
            ),
            paragraph: Verse(
              id: bzModel?.about,
              translate: false,
            ),
          ),

        /// SCOPE
        // if (Mapper.checkCanLoopList(bzModel?.scope) == true)
        //   Bubble(
        //     bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        //       context: context,
        //       headlineVerse: const Verse(
        //         id: 'phid_scopeOfServices',
        //         translate: true,
        //       ),
        //     ),
        //     columnChildren: <Widget>[
        //
        //       PhidsViewer(
        //         pageWidth: Scale.screenWidth(context),
        //         phids: bzModel?.scope,
        //         onPhidTap: (String phid){
        //           blog('bzAboutPage : onPhidTap : phid: $phid');
        //         },
        //         onPhidLongTap: (String phid){
        //           blog('bzAboutPage : onPhidLongTap : phid: $phid');
        //         },
        //       ),
        //
        //     ],
        //   ),

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
          BldrsText(
            verse: Verse(
              id: '${xPhrase('phid_published_flyers_by')} ${bzModel?.name}',
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
            flyersIDs: bzModel?.flyersIDs,
            topPadding: 0,
            screenName: 'BzAboutPageFlyersGrid',
            gridHeight: _gridHeight,
            scrollable: false,
            gridType: FlyerGridType.heroic,
            hasResponsiveSideMargin: true,
          ),

        // const Horizon(),

      ],
    );

  }

}
