import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/e_db/fire/ops/chain_ops.dart' as ChainOps;

// -----------------------------------------------------------------------------
Future<void> onAddMoreSpecsChainsToExistingSpecsChains({
  @required BuildContext context,
  @required List<Chain> chainsToAdd,
}) async {

  if (Mapper.canLoopList(chainsToAdd) == true){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    await ChainOps.addChainsToSpecsChainSons(
      context: context,
      chainsToAdd: chainsToAdd,
    );

    await _chainsProvider.reloadAllChains(context);

  }

}
// -----------------------------------------------------------------------------
