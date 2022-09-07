import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/old_editor/chain_viewer_structure/chain_tree_viewer.dart';
import 'package:flutter/material.dart';

class ChainsTreesStarter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsTreesStarter({
    @required this.width,
    @required this.chains,
    @required this.onStripTap,
    this.searchValue,
    this.initiallyExpanded = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final List<Chain> chains;
  final ValueChanged<String> onStripTap;
  final ValueNotifier<String> searchValue;
  final bool initiallyExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(chains) == true){
      return ListView.builder(
          key: const ValueKey<String>('ChainsTreesStarter'),
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: Ratioz.horizon),
          itemCount: chains?.length,
          itemBuilder: (_, index){

            final Chain _chain = chains[index];

            return ChainTreeViewer(
              width: width,
              chain: _chain,
              onStripTap : onStripTap,
              searchValue: searchValue,
              initiallyExpanded: initiallyExpanded,
              index: index,
            );

          }
      );
    }
    else {
      return const SizedBox();
    }


  }
  /// --------------------------------------------------------------------------
}
