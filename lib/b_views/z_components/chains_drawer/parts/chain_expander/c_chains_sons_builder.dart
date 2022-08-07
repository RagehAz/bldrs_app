import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/b_chain_box.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/d_chain_son_starter.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainSonsBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainSonsBuilder({
    @required this.initiallyExpanded,
    @required this.boxWidth,
    @required this.boxHeight,
    this.chain,
    this.onKeywordTap,
    this.selectedKeywordsIDs,
    this.parentLevel = 1,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final double boxHeight;
  final Chain chain;
  final ValueChanged<String> onKeywordTap;
  final List<String> selectedKeywordsIDs;
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
        width: boxWidth,
        height: boxHeight,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: chain.sons.length,
            itemBuilder: (_, index) {

              final dynamic _son = chain.sons[index];

              return Container(
                color: Colorizer.createRandomColor(),
                alignment: Aligners.superInverseCenterAlignment(context),
                margin: const EdgeInsets.all(Ratioz.appBarPadding),
                child: ChainSonStarter(
                  son: _son,
                  sonWidth: _sonWidth,
                  onKeywordTap: onKeywordTap,
                  selectedKeywordsIDs: selectedKeywordsIDs,
                  initiallyExpanded: initiallyExpanded,
                  parentLevel: parentLevel,
                ),
              );
            }
        ),

      );
    }

  }
}
