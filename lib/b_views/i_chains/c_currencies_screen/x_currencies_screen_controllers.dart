import 'package:bldrs/a_models/chain/aaa_phider.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/b_phrases_editor/x_phrase_editor_controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// SEARCHING

// --------------------
void onSearchCurrencies({
  @required BuildContext context,
  @required TextEditingController searchController,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<List<CurrencyModel>> foundCurrencies,
  @required PageController pageController,
}){

  TextCheck.triggerIsSearchingNotifier(
    text: searchController.text,
    isSearching: isSearching,
  );

  if (isSearching.value == true){

    final List<CurrencyModel> _foundCurrencies = <CurrencyModel>[];

    /// SEARCH MAIN PHRASES
    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    final List<Phrase> _phrases = onSearchPhrases(
      context: context,
      searchController: searchController,
      phrasesToSearchIn: _phraseProvider.mainPhrases,
      isSearching: isSearching,
      pageController: pageController,
    );

    Phrase.blogPhrases(_phrases);

    /// WHEN FOUND PHRASES
    if (Mapper.checkCanLoopList(_phrases) == true){

      /// FILTER CURRENCIES FROM PHRASES
      final List<String> _filteredIDs = <String>[];
      for (final Phrase phrase in _phrases){
        final bool _isCurrency = Phider.checkVerseIsCurrency(phrase.id);
        if (_isCurrency == true){
          _filteredIDs.add(phrase.id);
        }
      }

      Stringer.blogStrings(strings: _filteredIDs);

      /// GET CURRENCIES
      final List<CurrencyModel> _allCurrencies = ZoneProvider.proGetAllCurrencies(
        context: context,
        listen: false,
      );

      blog('_allCurrencies : ${_allCurrencies.length} currencies');

      for (final String id in _filteredIDs){
        final CurrencyModel _currency = CurrencyModel.getCurrencyByID(
          allCurrencies: _allCurrencies,
          currencyID: id,
        );

        _currency.blogCurrency();

        if (_currency != null){
          _foundCurrencies.add(_currency);
        }

      }



    }

    foundCurrencies.value = _foundCurrencies;

  }

}
// -----------------------------------------------------------------------------

/// SELECTION

// --------------------
Future<void> onSelectCurrency({
  @required BuildContext context,
  @required CurrencyModel currency,
}) async {

  await Nav.goBack(
    context: context,
    invoker: 'onSelectCurrency',
    passedData: currency,
  );

}
// -----------------------------------------------------------------------------
