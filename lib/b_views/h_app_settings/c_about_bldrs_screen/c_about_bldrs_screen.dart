import 'package:bldrs/b_views/z_components/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/paragraph_bubble/paragraph_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:night_sky/night_sky.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/customs/super_headline.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';

class AboutBldrsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AboutBldrsScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramidsAreOn: true,
      pyramidType: PyramidType.crystalYellow,
      appBarType: AppBarType.basic,
      historyButtonIsOn: false,
      title: const Verse(
        id: 'phid_about_bldrsnet',
        translate: true,
      ),
      skyType: SkyType.non,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          const Stratosphere(),

          /// LOGO
          const LogoSlogan(
            sizeFactor: 0.7,
            showSlogan: true,
          ),

          const DotSeparator(),

          /// BLDRS.NET
          ParagraphBubble(
            maxLines: 1000,
            bubbleColor: Colorz.white20,
            headerViewModel: BldrsBubbleHeaderVM.bake(
              context: context,
              headlineVerse: const Verse(
                id: 'phid_bldrsFullName',
                translate: true,
              ),
            ),
            paragraph: const Verse(
              id: 'Is the Network of builders\n'
                    'categorizing major Bldrs sectors as\n'
                    'Real-estate, Construction & Supplies.\n',
              translate: false,
            ),
          ),

          /// SO
          ParagraphBubble(
            bubbleColor: Colorz.white20,
            headerViewModel: BldrsBubbleHeaderVM.bake(
              context: context,
            ),
            paragraph: const Verse(
              id: 'So whenever you need to connect with a professional '
                    'or a company in a specific field or trade to aid you in '
                    'building you projects, you have all Businesses here for you',
              translate: false,
            ),
          ),

          const DotSeparator(),

          const SuperHeadline(
            verse: Verse(
              pseudo: 'Bldrs.net Business types',
              id: 'phid_bldrs_bzz_types',
              translate: true,
            ),
          ),

          /// DEVELOPERS
          BldrsTileBubble(
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              context: context,
              headlineVerse: const Verse(
                  id: 'phid_developers',
                  translate: true,
              ),
              leadingIcon: Iconz.bxPropertiesOn,
            ),
            bubbleColor: Colorz.white20,
            secondLineVerse: const Verse(
              id: 'Real-Estate developers, they control the construction '
                  'development over plots & lands, then lease property contracts '
                  'for sale or rent.\n'
                  '\n'
                  'in Short... if You are looking for a property directly from '
                  'its creator, then these are the companies to contact',
              translate: false,
            ),
          ),

          /// BROKERS
          BldrsTileBubble(
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              context: context,
              headlineVerse: const Verse(
                id: 'phid_brokers',
                translate: true,
              ),
              leadingIcon: Iconz.bxPropertiesOn,
            ),
            bubbleColor: Colorz.white20,
            secondLineVerse: const Verse(
              id: 'Real-Estate Brokerage individuals or companies, they '
                    'consult, provide and assist you in your property purchasing '
                    'journey.\n'
                    '\n'
                    'in Short... if You are looking for someone to get you the best '
                    'property deals, these are the ones to contact',
              translate: false,
            ),
          ),

          /// DESIGNERS
          BldrsTileBubble(
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              context: context,
              headlineVerse: const Verse(
                id: 'phid_designers',
                translate: true,
              ),
              leadingIcon: Iconz.bxDesignsOn,
            ),
            bubbleColor: Colorz.white20,
            secondLineVerse: const Verse(
              id: 'Architects, Decorators, Landscapers, Engineers, '
                    'Planners and Designers of any urban construct you see in buildings'
                    ' inside-out and their surroundings\n'
                    '\n'
                    'in Short... if You have an idea or project to plan its '
                    'construction, you must contact these people',
              translate: false,
            ),
            ),

          /// CONTRACTORS
          BldrsTileBubble(
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              context: context,
              headlineVerse: const Verse(
                id: 'phid_contractors',
                translate: true,
              ),
              leadingIcon: Iconz.bzUndertakingOn,
            ),
            bubbleColor: Colorz.white20,
            secondLineVerse: const Verse(
              id: 'The Builders of properties, they contract owners in '
                  'specific trades to build, they manage construction progress and'
                  ' quality then deliver contract deliverables\n'
                  '\n'
                  'in Short... if You have a project in construction, '
                  'they build it for you',
              translate: false,
            ),
          ),

          /// ARTISANS
          BldrsTileBubble(
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              context: context,
              headlineVerse: const Verse(
                id: 'phid_artisans',
                translate: true,
              ),
              leadingIcon: Iconz.bxTradesOn,
            ),
            bubbleColor: Colorz.white20,
            secondLineVerse: const Verse(
              id: 'Masons, Carpenters, Smiths, Glaziers, Technicians, '
                    'Artists, Artisans, Painters, Plasterers ... etc\n'
                    '\n'
                    'in Short... The Work-force and the actual builders of all constructs',
              translate: false,
            ),
          ),

          /// MANUFACTURERS
          BldrsTileBubble(
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              context: context,
              headlineVerse: const Verse(
                id: 'phid_manufacturers',
                translate: true,
              ),
              leadingIcon: Iconz.bxProductsOn,
            ),
            bubbleColor: Colorz.white20,
            secondLineVerse: const Verse(
              id: 'Factories and Workshops that fabricates & manufactures '
                    'all construction products and equipment\n'
                    '\n'
                    'in Other words... If you want customization or want to get a big batch of '
                    'construction products or equipment, these are the companies '
                    'to contact',
              translate: false,
            ),
          ),

          /// SUPPLIERS
         BldrsTileBubble(
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              context: context,
              headlineVerse: const Verse(
                id: 'phid_suppliers',
                translate: true,
              ),
              leadingIcon: Iconz.bxProductsOn,
            ),
            bubbleColor: Colorz.white20,
            secondLineVerse: const Verse(
              id: 'Those companies that import, supply, transport, sell '
                    'or rent construction products and equipment\n'
                    '\n'
                    'They Supply Floor, ceiling, wall products, paints, wood & '
                    'timber, doors & windows, wall papers, cables, sand, cement '
                    '... etc and any product used in the creation of properties\n'
                    '\n'
                    'in Other words... If you want customization or want to get a big batch of '
                    'construction products or equipment, these are the companies '
                    'to contact',
              translate: false,
            )
          ),

          const DotSeparator(color: Colorz.yellow80),

          const Horizon(),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
