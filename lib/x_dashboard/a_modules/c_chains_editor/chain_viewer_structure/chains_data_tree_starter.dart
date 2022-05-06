import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chain_viewer_structure/chain_tree_viewer.dart';
import 'package:flutter/material.dart';

class ChainsTreesStarter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsTreesStarter({
    @required this.width,
    @required this.chains,
    @required this.onStripTap,
    this.searchValue,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final List<Chain> chains;
  final ValueChanged<String> onStripTap;
  final ValueNotifier<String> searchValue;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (canLoopList(chains) == true){
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
            );

          }
      );
    }
    else {
      return const SizedBox();
    }


  }
}
