import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/b_chain_box.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/d_chain_son_starter.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainSonsBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainSonsBuilder({
    @required this.initiallyExpanded,
    @required this.boxWidth,
    this.chain,
    this.onSpecTap,
    this.selectedSpecs,
    this.parentLevel = 0,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final Chain chain;
  final ValueChanged<String> onSpecTap;
  final List<String> selectedSpecs;
  final bool initiallyExpanded;
  final int parentLevel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _sonWidth = ChainBox.getSonWidth(
        parentWidth: boxWidth,
        parentLevel: parentLevel,
    );

    if (Mapper.checkCanLoopList(chain.sons) == false){
      return const SizedBox();
    }

    else {

      return SizedBox(
        key: const ValueKey<String>('ChainSonsBuilder'),
        width: boxWidth,
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: Ratioz.appBarPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                ...List.generate(chain.sons.length, (index){

                  final dynamic _son = chain.sons[index];

                  return Container(
                    width: _sonWidth,
                    margin: const EdgeInsets.only(
                      bottom: Ratioz.appBarPadding,
                      left: Ratioz.appBarPadding,
                      right: Ratioz.appBarPadding,
                    ),
                    child: ChainSonStarter(
                      son: _son,
                      sonWidth: _sonWidth,
                      onPhidTap: onSpecTap,
                      selectedPhids: selectedSpecs,
                      initiallyExpanded: initiallyExpanded,
                      parentLevel: parentLevel+1,
                    ),
                  );

                }),

              ],
            ),

        ),

      );

    }

  }
}
