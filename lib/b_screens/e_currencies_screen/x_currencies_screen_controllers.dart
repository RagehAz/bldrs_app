import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/searching.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/phrase_protocols.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// SEARCHING

// --------------------
/// TESTED : WORKS PERFECT
void onSearchCurrencies({
  required TextEditingController searchController,
  required ValueNotifier<bool> isSearching,
  required ValueNotifier<List<CurrencyModel>> foundCurrencies,
  required PageController? pageController,
  required List<Phrase> allCurrenciesPhrases,
  required List<CurrencyModel> allCurrencies,
  required bool mounted,
}){

  Searching.triggerIsSearchingNotifier(
    text: searchController.text,
    isSearching: isSearching,
    mounted: mounted,
  );

  if (isSearching.value  == true){

    final List<CurrencyModel> _foundCurrencies = <CurrencyModel>[];

    /// SEARCH MAIN PHRASES
    final List<Phrase> _phrases = onSearchPhrases(
      searchController: searchController,
      phrasesToSearchIn: allCurrenciesPhrases,
      isSearching: isSearching,
      pageController: pageController,
      mounted: mounted,
    );

    // Phrase.blogPhrases(_phrases);

    /// WHEN FOUND PHRASES
    if (Lister.checkCanLoop(_phrases) == true){

      /// FILTER CURRENCIES FROM PHRASES
      final List<String> _filteredIDs = <String>[];
      for (final Phrase phrase in _phrases){
        final bool _isCurrency = CurrencyModel.checkVerseIsCurrency(phrase.id);
        if (_isCurrency == true){
          if (phrase.id != null){
            _filteredIDs.add(phrase.id!);
          }
        }
      }

      // Stringer.blogStrings(
      //   strings: _filteredIDs,
      //   invoker: 'onSearchCurrencies',
      // );

      for (final String id in _filteredIDs){

        final CurrencyModel? _currency = CurrencyModel.getCurrencyByID(
          allCurrencies: allCurrencies,
          currencyID: id,
      );

        _currency?.blogCurrency();

        if (_currency != null){
          _foundCurrencies.add(_currency);
        }

      }

    }

    setNotifier(
        notifier: foundCurrencies,
        mounted: mounted,
        value: _foundCurrencies
    );

  }

}
// -----------------------------------------------------------------------------

/// SELECTION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectCurrency({
  required CurrencyModel? currency,
}) async {

  await Nav.goBack(
    context: getMainContext(),
    invoker: 'onSelectCurrency',
    passedData: currency,
  );

}
// -----------------------------------------------------------------------------
