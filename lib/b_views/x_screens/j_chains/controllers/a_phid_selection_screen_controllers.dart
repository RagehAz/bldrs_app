import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:flutter/material.dart';
// ------------------------------------------------
Future<void> onChainsSearchChanged({
  @required String text,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<List<Chain>> foundChains,
  @required List<Chain> chains,
}) async {

  TextChecker.triggerIsSearchingNotifier(
    text: text,
    isSearching: isSearching,
  );

  if (isSearching.value == true){
    _searchChainsOps(
      chains: chains,
      text: text,
      foundChains: foundChains,
    );
  }

}
// ------------------------------------------------
Future<void> onChainsSearchSubmitted({
  @required String text,
  @required ValueNotifier<bool> isSearching,
}) async {



}
// ------------------------------------------------
void _searchChainsOps({
  @required List<Chain> chains,
  @required String text,
  @required ValueNotifier<List<Chain>> foundChains,
}){

  final List<Chain> _foundPathsChains = ChainPathConverter.findPhidRelatedChains(
    allChains: chains,
    phid: text,
  );

  /// SET FOUND CHAINS AS SEARCH RESULT
  foundChains.value = _foundPathsChains;

}
// ------------------------------------------------

void onSelectPhid({
  @required String phid,
}){

  blog('selected phid is : $phid');

}
