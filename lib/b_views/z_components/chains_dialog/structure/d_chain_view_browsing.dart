

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_crafts.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_designs.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_equipment.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_products.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_properties.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/z_components/chains_dialog/components/chain_bubble.dart';
import 'package:bldrs/b_views/z_components/chains_dialog/chain_expander_by_flyer_type.dart';
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
    @required this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    const Chain _propertiesChain = ChainProperties.chain;
    const Chain _designsChain = ChainDesigns.chain;
    const Chain _craftsChain = ChainCrafts.chain;
    const Chain _productsChain = ChainProducts.chain;
    const Chain _equipmentChain = ChainEquipment.chain;

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
              bubbleWidth: width,
              buttons: <Widget>[

                ChainExpanderByFlyerType(
                  bubbleWidth: width,
                  inActiveMode: false,
                  flyerType: FlyerType.property,
                  chain: _propertiesChain,
                ),

              ]
          ),

        /// Construction
        if (_generalProvider.sectionIsOnline(BzSection.construction))
          ChainBubble(
              title: superPhrase(context, 'phid_construction'),
              icon: Iconz.pyramidSingleYellow,
              bubbleWidth: width,
              buttons: <Widget>[

                ChainExpanderByFlyerType(
                  bubbleWidth: width,
                  inActiveMode: false,
                  flyerType: FlyerType.design,
                  chain: _designsChain,
                ),

                MainLayout.spacer10,

                ChainExpanderByFlyerType(
                  bubbleWidth: width,
                  inActiveMode: false,
                  flyerType: FlyerType.craft,
                  chain: _craftsChain,
                ),

              ]
          ),

        /// Supplies
        if (_generalProvider.sectionIsOnline(BzSection.supplies))
          ChainBubble(
            title: superPhrase(context, 'phid_supplies'),
            icon: Iconz.pyramidSingleYellow,
            bubbleWidth: width,
            buttons: <Widget>[

              ChainExpanderByFlyerType(
                bubbleWidth: width,
                inActiveMode: false,
                flyerType: FlyerType.product,
                chain: _productsChain,
              ),

              MainLayout.spacer10,

              ChainExpanderByFlyerType(
                bubbleWidth: width,
                inActiveMode: false,
                flyerType: FlyerType.equipment,
                chain: _equipmentChain,
              ),

            ],
          ),

      ],
    );
  }
}
