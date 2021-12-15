import 'package:bldrs/b_views/widgets/general/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/paragraph_bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/tile_bubble.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class AboutBldrsScreen extends StatelessWidget {

  const AboutBldrsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.pyramidsYellow,
      appBarType: AppBarType.basic,
      // appBarBackButton: true,
      pageTitle: 'About Bldrs.net',
      skyType: SkyType.black,
      layoutWidget: Scroller(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: const <Widget>[

            Stratosphere(),

            LogoSlogan(
              sizeFactor: 0.87,
            ),

            ParagraphBubble(
                maxLines: 1000,
                title: 'Bldrs.net',
                paragraph: 'Is the Network of builders\n'
                    'categorizing major Bldrs sectors as\n'
                    'Real-estate, Construction & Supplies.\n'
            ),

            ParagraphBubble(
              paragraph: 'So whenever you need to connect with a professional '
                  'or a company in a specific field or trade to aid you in '
                  'building you projects, you have all Businesses here for you',
            ),

            BubblesSeparator(),

            ParagraphBubble(
              title: 'Bldrs.net Business types',
              centered: true,
              maxLines: 100,
              bubbleWidth: 200,
              paragraph: '',
            ),

            TileBubble(
              verse: 'Developers',
              icon: Iconz.bxPropertiesOn,
              iconSizeFactor: 1,
              secondLine:
                  'Real-Estate developers, they control the construction '
                  'development over plots & lands, then lease property contracts '
                  'for sale or rent.\n'
                  '\n'
                  'in Short... if You are looking for a property directly from '
                  'its creator, then these are the companies to contact',
            ),

            TileBubble(
              verse: 'Brokers',
              icon: Iconz.bxPropertiesOn,
              iconSizeFactor: 1,
              secondLine:
                  'Real-Estate Brokerage individuals or companies, they '
                  'consult, provide and assist you in your property purchasing '
                  'journey.\n'
                  '\n'
                  'in Short... if You are looking for someone to get you the best '
                  'property deals, these are the ones to contact',
            ),

            TileBubble(
              verse: 'Designers',
              icon: Iconz.bxDesignsOn,
              iconSizeFactor: 1,
              secondLine: 'Architects, Decorators, Landscapers, Engineers, '
                  'Planners and Designers of any urban construct you see in buildings'
                  ' inside-out and their surroundings\n'
                  '\n'
                  'in Short... if You have an idea or project to plan its '
                  'construction, you must contact these people',
            ),

            TileBubble(
              verse: 'Contractors',
              icon: Iconz.bxProjectsOn,
              iconSizeFactor: 1,
              secondLine: 'The Builders of properties, they contract owners in '
                  'specific trades to build, they manage construction progress and'
                  ' quality then deliver contract deliverables\n'
                  '\n'
                  'in Short... if You have a project in construction, '
                  'they build it for you',
            ),

            TileBubble(
              verse: 'Crafts-men',
              icon: Iconz.bxCraftsOn,
              iconSizeFactor: 1,
              secondLine: 'Masons, Carpenters, Smiths, Glaziers, Technicians, '
                  'Artists, Artisans, Painters, Plasterers ... etc\n'
                  '\n'
                  'in Short... The Work-force and the actual builders of all constructs',
            ),

            TileBubble(
              verse: 'Manufacturers',
              icon: Iconz.bxProductsOn,
              iconSizeFactor: 1,
              secondLine:
                  'Factories and Workshops that fabricates & manufactures '
                  'all construction products and equipment\n'
                  '\n'
                  'in Other words... If you want customization or want to get a big batch of '
                  'construction products or equipment, these are the companies '
                  'to contact',
            ),

            TileBubble(
              verse: 'Suppliers',
              icon: Iconz.bxProductsOn,
              iconSizeFactor: 1,
              secondLine:
                  'Those companies that import, supply, transport, sell '
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

            BubblesSeparator(),

            Horizon(),
          ],
        ),
      ),
    );
  }
}
