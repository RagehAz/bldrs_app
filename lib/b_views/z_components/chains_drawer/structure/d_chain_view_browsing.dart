import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/chain_expander_by_flyer_type.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/a_chain_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainViewBrowsing extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainViewBrowsing({
    @required this.bubbleWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double bubbleWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    // const Chain _propertiesChain = ChainProperties.chain;
    // const Chain _designsChain = ChainDesigns.chain;
    // const Chain _craftsChain = ChainCrafts.chain;
    // const Chain _productsChain = ChainProducts.chain;
    // const Chain _equipmentChain = ChainEquipment.chain;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SuperVerse(
          verse: superPhrase(context, 'phid_select_a_section'),
          weight: VerseWeight.black,
          italic: true,
          centered: false,
          size: 3,
          margin: Ratioz.appBarMargin,
        ),

        /// REAL ESTATE
        if (_generalProvider.sectionIsOnline(BzSection.realestate))
          ChainBubble(
              title: superPhrase(context, 'phid_realEstate'),
              icon: Iconz.pyramidSingleYellow,
              bubbleWidth: bubbleWidth,
              buttons: <Widget>[

                ChainExpanderByFlyerType(
                  bubbleWidth: bubbleWidth,
                  deactivated: false,
                  flyerType: FlyerType.property,
                ),

              ]
          ),

        /// Construction
        if (_generalProvider.sectionIsOnline(BzSection.construction))
          ChainBubble(
              title: superPhrase(context, 'phid_construction'),
              icon: Iconz.pyramidSingleYellow,
              bubbleWidth: bubbleWidth,
              buttons: <Widget>[

                ChainExpanderByFlyerType(
                  bubbleWidth: bubbleWidth,
                  deactivated: false,
                  flyerType: FlyerType.design,
                ),

                MainLayout.spacer10,

                ChainExpanderByFlyerType(
                  bubbleWidth: bubbleWidth,
                  deactivated: false,
                  flyerType: FlyerType.craft,
                ),

              ]
          ),

        /// Supplies
        if (_generalProvider.sectionIsOnline(BzSection.supplies))
          ChainBubble(
            title: superPhrase(context, 'phid_supplies'),
            icon: Iconz.pyramidSingleYellow,
            bubbleWidth: bubbleWidth,
            buttons: <Widget>[

              ChainExpanderByFlyerType(
                bubbleWidth: bubbleWidth,
                deactivated: false,
                flyerType: FlyerType.product,
              ),

              MainLayout.spacer10,

              ChainExpanderByFlyerType(
                bubbleWidth: bubbleWidth,
                deactivated: false,
                flyerType: FlyerType.equipment,
              ),

            ],
          ),

      ],
    );
  }
}
