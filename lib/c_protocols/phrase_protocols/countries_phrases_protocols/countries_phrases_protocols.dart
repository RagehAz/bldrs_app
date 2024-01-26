import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/models/flag_model.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/countries_phrases_protocols/countries_phrases_ldb_ops.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class CountriesPhrasesProtocols{
  // -----------------------------------------------------------------------------

  const CountriesPhrasesProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> generateCountriesPhrases({
    String? setLangCode,
  }) async {

    List<String> _langCodes = Stringer.addStringToListIfDoesNotContainIt(
      strings: ['en'],
      stringToAdd: Localizer.getCurrentLangCode(),
    );

    _langCodes = Stringer.addStringToListIfDoesNotContainIt(
      strings: _langCodes,
      stringToAdd: setLangCode,
    );

    /// THIS GENERATES COUNTRIES PHRASES AND INSERTS THEM IN LDB TO FACILITATE COUNTRY SEARCH BY NAME
    await _composeCountriesMixedLangPhrases(
      context: getMainContext(),
      langCodes: _langCodes,
    );

  }
  // -----------------------------------------------------------------------------
  static Future<List<Phrase>> _composeCountriesMixedLangPhrases({
    required BuildContext context,
    required List<String> langCodes,
  }) async {

    /// NOTE : this generates all counties phrases
    // NOTE : gets phrases from LDB or creates countries phrases then stores in LDB

    /// 1 - GET THEM FROM LDB
    List<Phrase> _allCountriesPhrases = await CountriesPhraseLDBOps.readCountriesPhrases();

    /// 2 - WHEN LDB IS EMPTY
    if (Lister.checkCanLoop(_allCountriesPhrases) == false) {

      /// CREATE THEM
      _allCountriesPhrases = Flag.createAllCountriesPhrasesForLDB(
        langCodes: langCodes,
      );

      /// THEN STORE THEM IN LDB
      await CountriesPhraseLDBOps.insertCountriesPhrases(
        countriesMixedLangsPhrases: _allCountriesPhrases,
      );

    }

    return _allCountriesPhrases;
  }
  // -----------------------------------------------------------------------------
}
