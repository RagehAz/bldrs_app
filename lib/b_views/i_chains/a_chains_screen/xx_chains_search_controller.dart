import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/chain/aaa_phider.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// SEARCHING OLD METHOD

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onChainsSearchChanged({
  @required BuildContext context,
  @required String text,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<List<Chain>> foundChains,
  @required ValueNotifier<String> searchText,
  @required List<String> phidsOfAllPickers,
}) async {

  // blog('drawer receives text : $text : Length ${text.length}: isSearching : ${isSearching.value}');

  TextCheck.triggerIsSearchingNotifier(
    text: text,
    isSearching: isSearching,
    onResume: () => onChainsSearchSubmitted(
      context: context,
      foundChains: foundChains,
      isSearching: isSearching,
      searchText: searchText,
      text: text,
      phidsOfAllPickers: phidsOfAllPickers,
    ),
    onSwitchOff: () => _clearSearchResult(
      foundChains: foundChains,
    ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onChainsSearchSubmitted({
  @required BuildContext context,
  @required String text,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<List<Chain>> foundChains,
  @required ValueNotifier<String> searchText,
  @required List<String> phidsOfAllPickers,
}) async {

  searchText.value = text;

  final List<String> _phids = await _searchKeywordsPhrases(
    text: text,
    context: context,
    phidsOfAllPickers: phidsOfAllPickers,
  );


  final List<Chain> _chains = _getChainsFromPhids(
    context: context,
    phids: _phids,
  );

  // blog('search result is : -');
  // blog('phids : $_phids');
  // Chain.blogChains(_chains);
  // blog('the end of search --------------------');

  await _setFoundResults(
    context: context,
    foundChainsResult: _chains,
    foundChainsNotifier: foundChains,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<List<String>> _searchKeywordsPhrases({
  @required String text,
  @required BuildContext context,
  @required List<String> phidsOfAllPickers,
}) async {

  List<String> _phids = <String>[];

  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

  final List<Phrase> _searched = Phrase.searchPhrasesTrigrams(
    sourcePhrases: <Phrase>[..._chainsProvider.bigChainKPhrases, ..._chainsProvider.bigChainSPhrases],
    inputText: text,
  );

  blog('_searchKeywordsPhrases : found ${_searched.length} phrases');

  if (Mapper.checkCanLoopList(_searched) == true) {

    _phids = Phrase.getPhrasesIDs(_searched);

    blog('BEFORE REMOVE THEY WERE : $_phids');

    _phids = Chain.removeAllChainIDsFromKeywordsIDs(
      phids: _phids,
      allChains: _chainsProvider.getChainKAndChainS(
        context: context,
        getOnlyCityKeywordsChain: false,
      ),
    );

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
  @required List<String> phids,
}){
  final List<String> _output = <String>[];

  if (Mapper.checkCanLoopList(phids) == true){

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
  @required List<String> phids,
  @required List<String> scope,
}){
  List<String> _output = <String>[];

  if (Mapper.checkCanLoopList(phids) == true){
    _output = <String>[...phids];

    if (Mapper.checkCanLoopList(scope) == true){

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
  @required BuildContext context,
  @required List<String> phids,
}){

  List<Chain> _chains = <Chain>[];

  if (Mapper.checkCanLoopList(phids) == true){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    _chains = ChainPathConverter.findPhidsRelatedChains(
      phids: phids,
      allChains: _chainsProvider.getChainKAndChainS(
        context: context,
        getOnlyCityKeywordsChain: false,
      ),
    );

  }

  return _chains;
}
// --------------------
/// TESTED : WORKS PERFECT
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
// --------------------
/// TESTED : WORKS PERFECT
void _clearSearchResult({
  @required ValueNotifier<List<Chain>> foundChains,
}){

  foundChains.value = <Chain>[];

}
// -----------------------------------------------------------------------------
