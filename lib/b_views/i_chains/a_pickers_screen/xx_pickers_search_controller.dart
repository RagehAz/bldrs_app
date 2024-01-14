import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/searching.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// CHAINS SEARCH TRIGGER

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onChainsSearchChanged({
  required BuildContext context,
  required String? text,
  required ValueNotifier<bool> isSearching,
  required ValueNotifier<List<Chain>> foundChains,
  required ValueNotifier<String?> searchText,
  required List<String> phidsOfAllPickers,
  required List<Chain>? chains,
  required bool mounted,
}) async {

  blog('drawer receives text : $text : Length ${text?.length}: isSearching : ${isSearching.value}');

  Searching.triggerIsSearchingNotifier(
    text: text,
    isSearching: isSearching,
    mounted: mounted,
    onResume: () => onSearchChains(
      context: context,
      foundChains: foundChains,
      isSearching: isSearching,
      searchText: searchText,
      text: text,
      phidsOfAllPickers: phidsOfAllPickers,
      chains: chains,
      mounted: mounted,
    ),
    onSwitchOff: () => _clearSearchResult(
      foundChains: foundChains,
      mounted: mounted,
    ),
  );

}
// -----------------------------------------------------------------------------

/// SEARCHING CHAINS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSearchChains({
  required BuildContext context,
  required String? text,
  required ValueNotifier<bool> isSearching,
  required ValueNotifier<List<Chain>> foundChains,
  required ValueNotifier<String?> searchText,
  required List<String> phidsOfAllPickers,
  required List<Chain>? chains,
  required bool mounted,
}) async {

  setNotifier(notifier: searchText, mounted: mounted, value: text);

  final List<String> _phids = await _searchKeywordsPhrases(
    text: text,
    phidsOfAllPickers: phidsOfAllPickers,
  );


  final List<Chain> _chains = _getChainsFromPhids(
    phids: _phids,
  );

  final List<Chain> _foundPathsChains = ChainPathConverter.findPhidRelatedChains(
    chains: chains,
    phid: text,
  );

  final List<Chain> _combinedChains = <Chain>[..._foundPathsChains, ..._chains];
  final List<String> _combinedPaths = ChainPathConverter.generateChainsPaths(
    parentID: '',
    chains: _combinedChains,
  );
  /// THIS WILL INCLUDE ALL RELATED PATHS : WHICH IS TOO MUCH
  /*

  final List<String> _lastNodes = ChainPathConverter.getPathsLastNodes(_combinedPaths);
  _combinedChains = ChainPathConverter.findPhidsRelatedChains(
      chains: chains,
      phids: _lastNodes,
  );
  */

  Stringer.blogStrings(strings: _combinedPaths, invoker: 'onSearchChains : _combinedPaths');

  await _setFoundResults(
    context: context,
    foundChainsResult: ChainPathConverter.createChainsFromPaths(paths: _combinedPaths),
    foundChainsNotifier: foundChains,
    mounted: mounted,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<List<String>> _searchKeywordsPhrases({
  required String? text,
  required List<String> phidsOfAllPickers,
}) async {

  List<String> _phids = <String>[];

  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);

  final List<Phrase> _searched = Phrase.searchPhrasesTrigrams(
    sourcePhrases: _chainsProvider.chainsPhrases,
    inputText: text,
  );

  Phrase.blogPhrases(_searched);
  blog('_searchKeywordsPhrases : found ${_searched.length} phrases');


  if (Lister.checkCanLoop(_searched) == true) {

    _phids = Phrase.getPhrasesIDs(_searched);

    blog('BEFORE REMOVE THEY WERE : $_phids');

    // _phids = Chain.removeAllChainIDsFromKeywordsIDs(
    //   phids: _phids,
    //   allChains: _chainsProvider.bldrsChains,
    // );

    _phids = _removeCurrenciesFromPhids(
      phids: _phids,
    );

    _phids = _removePhidsOutOfScope(
      scope: phidsOfAllPickers,
      phids: _phids,
    );

    blog('AFTER REMOVE THEY ARE : $_phids');

  }

  return _phids;
}
// --------------------
/// TESTED : WORKS PERFECT
List<String> _removeCurrenciesFromPhids({
  required List<String> phids,
}){
  final List<String> _output = <String>[];

  if (Lister.checkCanLoop(phids) == true){

    for (final String phid in phids){

      final bool _isCurrency = Phider.checkVerseIsCurrency(phid);

      if (_isCurrency == false){
        _output.add(phid);
      }

    }

  }

  return _output;
}
// --------------------
/// TESTED : WORKS PERFECT
List<String> _removePhidsOutOfScope({
  required List<String> phids,
  required List<String> scope,
}){
  List<String> _output = <String>[];

  if (Lister.checkCanLoop(phids) == true){
    _output = <String>[...phids];

    if (Lister.checkCanLoop(scope) == true){

      for (final String phid in phids){

        final bool _withinScope = Stringer.checkStringsContainString(
          strings: scope,
          string: phid,
        );

        if (_withinScope == false){
          _output.remove(phid);
        }

      }

    }

  }

  return _output;
}
// --------------------
/// TESTED : WORKS PERFECT
List<Chain> _getChainsFromPhids({
  required List<String> phids,
}){

  List<Chain> _chains = <Chain>[];

  if (Lister.checkCanLoop(phids) == true){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);

    _chains = ChainPathConverter.findPhidsRelatedChains(
      phids: phids,
      chains: _chainsProvider.bldrsChains,
    );

  }

  return _chains;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _setFoundResults({
  required BuildContext context,
  required ValueNotifier<List<Chain>> foundChainsNotifier,
  required List<Chain> foundChainsResult,
  required bool mounted,
}) async {

  /// found results
  if (Lister.checkCanLoop(foundChainsResult) == true) {

    setNotifier(
        notifier: foundChainsNotifier,
        mounted: mounted,
        value: foundChainsResult,
    );

  }

  /// did not find results
  else {

    setNotifier(
        notifier: foundChainsNotifier,
        mounted: mounted,
        value: <Chain>[],
    );

  }

}
// -----------------------------------------------------------------------------

/// CLEAR SEARCH

// --------------------
/// TESTED : WORKS PERFECT
void _clearSearchResult({
  required ValueNotifier<List<Chain>> foundChains,
  required bool mounted,
}){

  setNotifier(
      notifier: foundChains,
      mounted: mounted,
      value: <Chain>[],
  );

}
// -----------------------------------------------------------------------------
