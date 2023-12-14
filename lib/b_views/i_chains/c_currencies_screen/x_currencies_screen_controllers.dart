import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/models/phrase_model.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/protocols/phrase_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
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
  required bool mounted,
}){

  TextCheck.triggerIsSearchingNotifier(
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
    if (Lister.checkCanLoopList(_phrases) == true){

      /// FILTER CURRENCIES FROM PHRASES
      final List<String> _filteredIDs = <String>[];
      for (final Phrase phrase in _phrases){
        final bool _isCurrency = Phider.checkVerseIsCurrency(phrase.id);
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

      final BuildContext _context = getMainContext();

      for (final String id in _filteredIDs){

        final CurrencyModel? _currency = ZoneProvider.proGetCurrencyByCurrencyID(
          context: _context,
          currencyID: id,
          listen: false
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
