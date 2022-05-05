import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
Future<void> onUploadChains() async {

  // final Chain _keywordsChain = _chainsProvider.keywordsChain;
  // final Chain _specsChain = _chainsProvider.specsChain;

  // final Chain _keywordsChain = await ChainOps.readKeywordsChain(context);

  // _keywordsChain?.blogChain();
  //
  // final List<Chain> _newSpecsChains = <Chain>[
  //   propertySalePrice,
  //   propertyRentPrice,
  //   propertyDecorationStyle,
  //   designType,
  //   projectCost,
  //   constructionDuration,
  // ];
  //
  // await onAddMoreSpecsChainsToExistingSpecsChains(
  //   context: context,
  //   chainsToAdd: _newSpecsChains,
  // );


  // return 'b';
}
// -----------------------------------------------------------------------------
Future<void> onSearchChains({
  @required String text,
  @required ValueNotifier<String> searchValue,
  @required ValueNotifier<bool> isSearching,
  @required List<Chain> allChains,
  @required List<String> allChainsPaths,
  @required ValueNotifier<List<Chain>> foundChains,
}) async {

  searchValue.value = text;

  triggerIsSearchingNotifier(
    text: text,
    isSearching: isSearching,

  );

  blog('text is : $text : isSearching : ${isSearching.value}');

  if (isSearching.value == true){
    _searchChainsOps(
      chains: allChains,
      text: text,
      foundChains: foundChains,
      allChainsPaths: allChainsPaths
    );
  }

}
// ------------------------------------------------
void _searchChainsOps({
  @required List<Chain> chains,
  @required String text,
  @required List<String> allChainsPaths,
  @required ValueNotifier<List<Chain>> foundChains,
}){

  blog('all paths : $allChainsPaths');

  /// SEARCH CHAINS FOR MATCH CASES
  final List<String> _foundPaths = ChainPathConverter.findPathsContainingPhid(
      paths: allChainsPaths,
      phid: text
  );

  blog('found paths : $_foundPaths');

  final List<Chain> _foundPathsChains = ChainPathConverter.createChainsFromPaths(
    paths: _foundPaths,
  );

  /// SET FOUND CHAINS AS SEARCH RESULT
  foundChains.value = _foundPathsChains;

}
// ------------------------------------------------
