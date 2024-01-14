import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/x_secondary/scope_model.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/b_variants/bz_authors_bubble/bz_authors_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/bz_flyers_bubble/bz_flyers_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/bz_scope_bubble/bz_scope_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/contacts_bubble/contacts_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/paragraph_bubble/paragraph_bubble.dart';
import 'package:bldrs/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/z_components/bz_profile/info_page/bz_stats_bubble.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class AboutBzBubbles extends StatelessWidget {
  // --------------------------------------------------------------------------
  const AboutBzBubbles({
    required this.bzModel,
    required this.showGallery,
    required this.showContacts,
    required this.showAuthors,
    super.key
  });
  // --------------------
  final BzModel? bzModel;
  final bool showGallery;
  final bool showContacts;
  final bool showAuthors;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

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
        if (Lister.checkCanLoop(_scopePhids) == true)
          BzScopeBubble(
            headline: const Verse(
              id: 'phid_scopeOfServices',
              translate: true,
            ),
            phids: _scopePhids,
          ),

        /// AUTHORS
        if (showAuthors == true)
        BzAuthorsBubble(
          bzModel: bzModel,
        ),

        /// BZ CONTACT
        if (showContacts == true && Lister.checkCanLoop(bzModel?.contacts) == true)
          ContactsBubble(
            contacts: bzModel?.contacts,
            location: bzModel?.position,
            canLaunchOnTap: true,
            showMoreButton: false,
            showBulletPoints: true,
            contactsArePublic: true,
            onMoreTap: null,
          ),

        /// STATS
        BzStatsBubble(
          bzModel: bzModel,
        ),

        /// BZ FLYERS
        if (showGallery == true && Lister.checkCanLoop(bzModel?.publication.published) == true)
        BzFlyersBubble(
          bzModel: bzModel,
        ),

      ],
    );

  }
  // --------------------------------------------------------------------------
}
