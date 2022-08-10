import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------

/// SEARCHING OLD METHOD

// --------------------------------------------
Future<void> onChainsSearchChanged({
  @required BuildContext context,
  @required String text,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<List<Chain>> foundChains,
  @required ValueNotifier<String> searchText,
}) async {

  // blog('drawer receives text : $text : Length ${text.length}: isSearching : ${isSearching.value}');

  TextChecker.triggerIsSearchingNotifier(
    text: text,
    isSearching: isSearching,
    onResume: () => onChainsSearchSubmitted(
      context: context,
      foundChains: foundChains,
      isSearching: isSearching,
      searchText: searchText,
      text: text,
    ),
    onSwitchOff: () => _clearSearchResult(
        foundChains: foundChains,
    ),
  );

}
// --------------------------------------------
Future<void> onChainsSearchSubmitted({
  @required BuildContext context,
  @required String text,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<List<Chain>> foundChains,
  @required ValueNotifier<String> searchText,
}) async {

  searchText.value = text;

  final List<String> _phids = await _searchKeywordsPhrases(
    text: text,
    context: context,
  );

  final List<Chain> _chains = _getChainsFromPhids(
    context: context,
    phids: _phids,
  );

  // blog('search result is : -');
  // blog('phids : $_phids');
  // Chain.blogChains(_chains);
  // blog('the end of search ------------------------------------------------------------------------');

  await _setFoundResults(
    context: context,
    foundChainsResult: _chains,
    foundChainsNotifier: foundChains,
  );

}
// --------------------------------------------
/// TESTED : WORKS PERFECT
Future<List<String>> _searchKeywordsPhrases({
  @required String text,
  @required BuildContext context,
}) async {

  List<String> _phidKs = <String>[];

  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

  final List<Phrase> _searched = Phrase.searchPhrasesTrigrams(
    sourcePhrases: _chainsProvider.allKeywordsChainPhrases,
    inputText: text,
  );

  blog('_searchKeywordsPhrases : found ${_searched.length} phrases');

  if (Mapper.checkCanLoopList(_searched) == true) {

    _phidKs = Phrase.getKeywordsIDsFromPhrases(allPhrases: _searched);

    blog('BEFORE REMOVE THEY WERE : $_phidKs');

    _phidKs = Chain.removeAllChainIDsFromKeywordsIDs(
      phidKs: _phidKs,
      allChains: getAllChains(
        context: context,
        getOnlyCityKeywordsChain: false,
      ),
    );

    blog('AFTER REMOVE THEY ARE : $_phidKs');

  }

  return _phidKs;
}
// --------------------------------------------
/// TESTED : WORKS PERFECT
List<Chain> _getChainsFromPhids({
  @required BuildContext context,
  @required List<String> phids,
}){

  List<Chain> _chains = <Chain>[];

  if (Mapper.checkCanLoopList(phids) == true){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    _chains = ChainPathConverter.findPhidsRelatedChains(
      allChains: _chainsProvider.allKeywordsChain.sons,
      phids: phids,
    );

  }

  return _chains;
}
// --------------------------------------------
Future<void> _setFoundResults({
  @required BuildContext context,
  @required ValueNotifier<List<Chain>> foundChainsNotifier,
  @required List<Chain> foundChainsResult,
}) async {

  /// found results
  if (Mapper.checkCanLoopList(foundChainsResult) == true) {

    foundChainsNotifier.value = foundChainsResult;

  }

  /// did not find results
  else {

    foundChainsNotifier.value = <Chain>[];

  }

}
// --------------------------------------------
void _clearSearchResult({
  @required ValueNotifier<List<Chain>> foundChains,
}){

  foundChains.value = <Chain>[];

}
// -----------------------------------------------------------------------------

/// SEARCHING TEMP METHOD

// --------------------------------
/*
Future<void> onChainsSearchChanged({
  @required String text,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<List<Chain>> foundChains,
  @required ValueNotifier<List<String>> foundPhids,
  @required List<Chain> chains,
}) async {

  TextChecker.triggerIsSearchingNotifier(
    text: text,
    isSearching: isSearching,
    onResume: () => _searchChainsOps(
      chains: chains,
      text: text,
      foundChains: foundChains,
    ),
    onSwitchOff: () => _clearSearchResult(
        foundChains: foundChains,
        foundPhids: foundPhids
    ),
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
  @required ValueNotifier<List<Chain>> foundChains,
  @required List<Chain> chains,
}) async {

  _searchChainsOps(
    chains: chains,
    text: text,
    foundChains: foundChains,
  );

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

 */
// -----------------------------------------------------------------------------
