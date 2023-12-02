import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/layouts/separators/dot_separator.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/x_secondary/scope_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/flyers_shelf/flyers_shelf.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/bz_authors_bubble/bz_authors_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/contacts_bubble/contacts_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/paragraph_bubble/paragraph_bubble.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_stats_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class AboutBzBubbles extends StatelessWidget {

  const AboutBzBubbles({
    required this.bzModel,
    required this.showGallery,
    required this.showContacts,
    required this.showAuthors,
    super.key
  });

  final BzModel? bzModel;
  final bool showGallery;
  final bool showContacts;
  final bool showAuthors;

  @override
  Widget build(BuildContext context) {

    // final double flyerBoxWidth = FlyerDim.flyerGridVerticalScrollFlyerBoxWidth(
    //   numberOfColumns: 2,
    //   gridZoneWidth: Scale.screenWidth(context),
    // );
    // final double _spacing = FlyerDim.flyerGridGridSpacingValue(flyerBoxWidth);
    // final double _flyerHeight = FlyerDim.flyerHeightByFlyerWidth(
    //   flyerBoxWidth: flyerBoxWidth,
    // );
    // final int _numberOfFlyers = bzModel?.publication.published.length ?? 0;
    // final double _gridHeight = (_flyerHeight + _spacing) * (_numberOfFlyers / 2).ceil();
    final List<String> _scopePhids = ScopeModel.getPhids(bzModel?.scopes);

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
        if (Mapper.checkCanLoopList(_scopePhids) == true)
          Bubble(
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              context: context,
              headlineVerse: const Verse(
                id: 'phid_scopeOfServices',
                translate: true,
              ),
            ),
            columnChildren: <Widget>[

              PhidsViewer(
                pageWidth: Scale.screenWidth(context),
                phids: _scopePhids,
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
            showMoreButton: false,
            showBulletPoints: true,
            contactsArePublic: true,
            onMoreTap: null,
          ),

        /// SEPARATOR
        if (Mapper.checkCanLoopList(_scopePhids) == true)
          const DotSeparator(),

        /// STATS
        BzStatsBubble(
          bzModel: bzModel,
        ),

        // /// FLYERS GALLERY TITLE
        // if (showGallery == true && Mapper.checkCanLoopList(bzModel?.publication.published) == true)
        //   Container(
        //     width: Scale.screenWidth(context),
        //     alignment: Alignment.center,
        //     child: BldrsText(
        //       width: Bubble.bubbleWidth(context: context),
        //       verse: Verse(
        //         id: '${getWord('phid_published_flyers_by')}\n${bzModel?.name}',
        //         translate: false,
        //       ),
        //       centered: false,
        //       maxLines: 4,
        //       margin: 20,
        //       size: 3,
        //       appIsLTR: UiProvider.checkAppIsLeftToRight(),
        //       textDirection: UiProvider.getAppTextDir(),
        //     ),
        //   ),

        /// BZ FLYERS
        if (showGallery == true && Mapper.checkCanLoopList(bzModel?.publication.published) == true)
        FlyersShelf(
          flyerBoxWidth: Scale.screenShortestSide(context) * 0.3,
          titleIcon: Iconz.flyerGrid,
          titleVerse: Verse(
            id: '${getWord('phid_published_flyers_by')} ${bzModel?.name}',
            translate: false,
          ),
          flyersIDs: bzModel?.publication.published ?? [],
        ),

        // /// BZ FLYERS
        // if (showGallery == true)
        //   FlyersGrid(
        //     flyersIDs: bzModel?.publication.published,
        //     topPadding: 0,
        //     screenName: 'BzAboutPageFlyersGrid',
        //     gridHeight: _gridHeight,
        //     scrollable: false,
        //     gridType: FlyerGridType.jumper,
        //     hasResponsiveSideMargin: true,
        //     numberOfColumnsOrRows: Scale.isLandScape(context) == true ? 4 : 2,
        //   ),

        // const Horizon(),

      ],
    );

  }

}
