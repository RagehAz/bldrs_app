import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/x_screens/j_chains/xxxxxxxxx_chains_builder.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class ChainSonsBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainSonsBuilder({
    @required this.initiallyExpanded,
    @required this.boxWidth,
    this.chain,
    this.onSpecTap,
    this.selectedPhids,
    this.parentLevel = 0,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final Chain chain;
  final ValueChanged<String> onSpecTap;
  final List<String> selectedPhids;
  final bool initiallyExpanded;
  final int parentLevel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(chain.sons) == false){
      return const SizedBox();
    }

    else
      // if (Chain.checkSonsAreChains(chain.sons))
      {

      return ChainsBuilder(
        chains: chain.sons,
        initiallyExpanded: initiallyExpanded,
        parentLevel: parentLevel,
        boxWidth: boxWidth,
        onPhidTap: onSpecTap,
        selectedPhids: selectedPhids,
      );

    }

    // else {
    //   return Container(
    //     width: 300,
    //     height: 300,
    //     color: Colorz.yellow255,
    //     alignment: Alignment.center,
    //     child: const SuperVerse(verse: 'something is wrong here',),
    //   );
    // }

  }
}
