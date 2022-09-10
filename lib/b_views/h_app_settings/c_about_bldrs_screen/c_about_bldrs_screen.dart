import 'package:bldrs/b_views/z_components/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/paragraph_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/tile_bubble.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

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
      sectionButtonIsOn: false,
      pageTitleVerse: '##About Bldrs.net',
      skyType: SkyType.non,
      layoutWidget: Scroller(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: const <Widget>[

            Stratosphere(),

            LogoSlogan(
              sizeFactor: 0.7,
              showSlogan: true,
            ),


            ParagraphBubble(
              maxLines: 1000,
              bubbleColor: Colorz.white20,
              title: '##Bldrs.net',
              paragraph: '##Is the Network of builders\n'
                  'categorizing major Bldrs sectors as\n'
                  'Real-estate, Construction & Supplies.\n',
            ),

            ParagraphBubble(
              bubbleColor: Colorz.white20,
              paragraph: '##So whenever you need to connect with a professional '
                  'or a company in a specific field or trade to aid you in '
                  'building you projects, you have all Businesses here for you',
            ),

            DotSeparator(),

            SuperVerse(
              verse: '##Bldrs.net Business types',
              size: 4,
              italic: true,
            ),

            TileBubble(
              bubbleHeaderVM: BubbleHeaderVM(
                headlineVerse: '##Developers',
                leadingIcon: Iconz.bxPropertiesOn,
              ),
              bubbleColor: Colorz.white20,
              secondLineVerse: '##Real-Estate developers, they control the construction '
                  'development over plots & lands, then lease property contracts '
                  'for sale or rent.\n'
                  '\n'
                  'in Short... if You are looking for a property directly from '
                  'its creator, then these are the companies to contact',
            ),

            TileBubble(
              bubbleHeaderVM: BubbleHeaderVM(
                headlineVerse: '##Brokers',
                leadingIcon: Iconz.bxPropertiesOn,
              ),
              bubbleColor: Colorz.white20,
              secondLineVerse: '##Real-Estate Brokerage individuals or companies, they '
                  'consult, provide and assist you in your property purchasing '
                  'journey.\n'
                  '\n'
                  'in Short... if You are looking for someone to get you the best '
                  'property deals, these are the ones to contact',
            ),

            TileBubble(
              bubbleHeaderVM: BubbleHeaderVM(
                headlineVerse: '##Designers',
                leadingIcon: Iconz.bxDesignsOn,
              ),
              bubbleColor: Colorz.white20,
              secondLineVerse: '##Architects, Decorators, Landscapers, Engineers, '
                  'Planners and Designers of any urban construct you see in buildings'
                  ' inside-out and their surroundings\n'
                  '\n'
                  'in Short... if You have an idea or project to plan its '
                  'construction, you must contact these people',
            ),

            TileBubble(
              bubbleHeaderVM: BubbleHeaderVM(
                headlineVerse: '##Contractors',
                leadingIcon: Iconz.bxProjectsOn,
              ),
              bubbleColor: Colorz.white20,
              secondLineVerse: '##The Builders of properties, they contract owners in '
                  'specific trades to build, they manage construction progress and'
                  ' quality then deliver contract deliverables\n'
                  '\n'
                  'in Short... if You have a project in construction, '
                  'they build it for you',
            ),

            TileBubble(
              bubbleHeaderVM: BubbleHeaderVM(
                headlineVerse: '##Artisans',
                leadingIcon: Iconz.bxTradesOn,
              ),
              bubbleColor: Colorz.white20,
              secondLineVerse: '##Masons, Carpenters, Smiths, Glaziers, Technicians, '
                  'Artists, Artisans, Painters, Plasterers ... etc\n'
                  '\n'
                  'in Short... The Work-force and the actual builders of all constructs',
            ),

            TileBubble(
              bubbleHeaderVM: BubbleHeaderVM(
                headlineVerse: '##Manufacturers',
                leadingIcon: Iconz.bxProductsOn,
              ),
              bubbleColor: Colorz.white20,
              secondLineVerse: '##Factories and Workshops that fabricates & manufactures '
                  'all construction products and equipment\n'
                  '\n'
                  'in Other words... If you want customization or want to get a big batch of '
                  'construction products or equipment, these are the companies '
                  'to contact',
            ),

            TileBubble(
              bubbleHeaderVM: BubbleHeaderVM(
                headlineVerse: '##Suppliers',
                leadingIcon: Iconz.bxProductsOn,
              ),
              bubbleColor: Colorz.white20,
              secondLineVerse: '##Those companies that import, supply, transport, sell '
                  'or rent construction products and equipment\n'
                  '\n'
                  'They Supply Floor, cieling, wall products, paints, wood & '
                  'timber, doors & windows, wall papers, cables, sand, cement '
                  '... etc and any product used in the creation of properties\n'
                  '\n'
                  'in Other words... If you want customization or want to get a big batch of '
                  'construction products or equipment, these are the companies '
                  'to contact',
            ),

            DotSeparator(color: Colorz.yellow80),

            Horizon(),

          ],
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
