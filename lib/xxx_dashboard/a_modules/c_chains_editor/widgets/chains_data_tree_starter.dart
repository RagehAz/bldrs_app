import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_dashboard/a_modules/c_chains_editor/widgets/chain_tree_viewer.dart';
import 'package:flutter/material.dart';

class ChainsTreesStarter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsTreesStarter({
    @required this.chains,
    @required this.onStripTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Chain> chains;
  final ValueChanged<String> onStripTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (canLoopList(chains) == true){
      return ListView.builder(
          key: const ValueKey<String>('ChainsTreesStarter'),
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon),
          itemCount: chains?.length,
          itemBuilder: (_, index){

            final Chain _chain = chains[index];

            return ChainTreeViewer(
              chain: _chain,
              onStripTap : onStripTap,
            );

          }
      );
    }
    else {
      return const SizedBox();
    }


  }
}
