import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/chain_expander_by_flyer_type.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/a_chain_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
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
  bool _canBuildChain(Chain chain){
    return Mapper.checkCanLoopList(chain?.sons) == true;
  }
// -----------------------------------------------------------------------------
  bool _allChainsCanNotBeBuilt(BuildContext context){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    final Chain _propertyChain = _chainsProvider.getKeywordsChainByFlyerType(
      flyerType: FlyerType.property,
        getRefinedCityChain: true,
    );
    final Chain _designChain = _chainsProvider.getKeywordsChainByFlyerType(
      flyerType: FlyerType.design,
        getRefinedCityChain: true,
    );
    final Chain _craftChain = _chainsProvider.getKeywordsChainByFlyerType(
      flyerType: FlyerType.craft,
        getRefinedCityChain: true,
    );
    final Chain _productChain = _chainsProvider.getKeywordsChainByFlyerType(
      flyerType: FlyerType.product,
        getRefinedCityChain: true,
    );
    final Chain _equipmentChain = _chainsProvider.getKeywordsChainByFlyerType(
      flyerType: FlyerType.equipment,
        getRefinedCityChain: true,
    );

    bool _allCanNotBeBuilt = false;

    if (
    _canBuildChain(_propertyChain) == false &&
        _canBuildChain(_designChain) == false &&
        _canBuildChain(_craftChain) == false &&
        _canBuildChain(_productChain) == false &&
        _canBuildChain(_equipmentChain) == false

    ){
      _allCanNotBeBuilt = true;
    }

    return _allCanNotBeBuilt;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: true);

    final Chain _propertyChain = _chainsProvider.getKeywordsChainByFlyerType(
      flyerType: FlyerType.property,
      getRefinedCityChain: true,
    );
    final Chain _designChain = _chainsProvider.getKeywordsChainByFlyerType(
      flyerType: FlyerType.design,
      getRefinedCityChain: true,
    );
    final Chain _craftChain = _chainsProvider.getKeywordsChainByFlyerType(
      flyerType: FlyerType.craft,
      getRefinedCityChain: true,
    );
    final Chain _productChain = _chainsProvider.getKeywordsChainByFlyerType(
      flyerType: FlyerType.product,
      getRefinedCityChain: true,
    );
    final Chain _equipmentChain = _chainsProvider.getKeywordsChainByFlyerType(
      flyerType: FlyerType.equipment,
      getRefinedCityChain: true,
    );

    final bool _noChainsHere = _allChainsCanNotBeBuilt(context);

    return Column(
      // key: ValueKey<String>(ZoneProvider.proGetCurrentZone(context: context, listen: true).cityID),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        if (_noChainsHere == false)
        SuperVerse(
          verse: superPhrase(context, 'phid_select_a_section'),
          weight: VerseWeight.black,
          italic: true,
          centered: false,
          size: 3,
          margin: Ratioz.appBarMargin,
        ),

        if (_noChainsHere == true)
          Center(
            child: Container(
              width: bubbleWidth,
              height: Scale.superScreenHeight(context),
              padding: Scale.superMargins(margins: 20),
              child: const SuperVerse(
                verse: 'No Available Flyers in This City yet',
                weight: VerseWeight.black,
                italic: true,
                size: 3,
                maxLines: 3,
                margin: Ratioz.appBarMargin,
              ),
            ),
          ),

        /// REAL ESTATE
        if (_canBuildChain(_propertyChain) == true)
          ChainBubble(
              title: superPhrase(context, 'phid_realEstate'),
              icon: Iconz.pyramidSingleYellow,
              bubbleWidth: bubbleWidth,
              buttons: <Widget>[

                ChainExpanderForFlyerType(
                  bubbleWidth: bubbleWidth,
                  deactivated: true,
                  flyerType: FlyerType.property,
                  chain: _propertyChain,
                ),

              ]
          ),

        /// Construction
        if (_canBuildChain(_designChain) == true || _canBuildChain(_craftChain) == true)
          ChainBubble(
              title: superPhrase(context, 'phid_construction'),
              icon: Iconz.pyramidSingleYellow,
              bubbleWidth: bubbleWidth,
              buttons: <Widget>[

                if (_canBuildChain(_designChain) == true)
                ChainExpanderForFlyerType(
                  bubbleWidth: bubbleWidth,
                  deactivated: false,
                  flyerType: FlyerType.design,
                  chain: _designChain,
                ),

                MainLayout.spacer10,

                if (_canBuildChain(_craftChain) == true)
                ChainExpanderForFlyerType(
                  bubbleWidth: bubbleWidth,
                  deactivated: false,
                  flyerType: FlyerType.craft,
                  chain: _craftChain,
                ),

              ]
          ),

        /// Supplies
        if (_canBuildChain(_productChain) == true || _canBuildChain(_equipmentChain) == true)
          ChainBubble(
            title: superPhrase(context, 'phid_supplies'),
            icon: Iconz.pyramidSingleYellow,
            bubbleWidth: bubbleWidth,
            buttons: <Widget>[

              if (_canBuildChain(_productChain) == true)
              ChainExpanderForFlyerType(
                bubbleWidth: bubbleWidth,
                deactivated: false,
                flyerType: FlyerType.product,
                chain: _productChain,
              ),

              MainLayout.spacer10,

              if (_canBuildChain(_equipmentChain) == true)
              ChainExpanderForFlyerType(
                bubbleWidth: bubbleWidth,
                deactivated: false,
                flyerType: FlyerType.equipment,
                chain: _equipmentChain,
              ),

            ],
          ),

      ],
    );
  }
}
