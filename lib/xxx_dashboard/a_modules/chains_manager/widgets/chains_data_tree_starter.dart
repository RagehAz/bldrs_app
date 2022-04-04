import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_dashboard/a_modules/chains_manager/widgets/chain_tree_viewer.dart';
import 'package:flutter/material.dart';

class ChainsTreesStarter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsTreesStarter({
    @required this.chains,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Chain> chains;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
        itemCount: chains.length,
        itemBuilder: (_, index){

          final Chain _chain = chains[index];

          return ChainTreeViewer(
            chain: _chain,
          );

        }
    );
  }
}
