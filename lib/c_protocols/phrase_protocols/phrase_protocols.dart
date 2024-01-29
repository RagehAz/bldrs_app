import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/countries_phrases_protocols/countries_phrases_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/keywords_phrases_protocols/keywords_phrases_protocols.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/f_helpers/tabbing/bldrs_tabber.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class PhraseProtocols {
  // -----------------------------------------------------------------------------

  const PhraseProtocols();

  // -----------------------------------------------------------------------------

  /// CURRENT APP LANGUAGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> changeAppLang({
    required BuildContext context,
    required String langCode,
  }) async {

      WaitDialog.showUnawaitedWaitDialog(
        verse: const Verse(
          id: 'phid_change_app_lang_description',
          translate: true,
        ),
      );

      final String _was = Localizer.getCurrentLangCode();

      await Localizer.changeAppLanguage(
          context: context,
          code: langCode,
      );

      /// LET'S the system load the json map for getCurrentLangCode to take effect
      await Future.delayed(const Duration(seconds: 1));

      final String _is = Localizer.getCurrentLangCode();

      if (_is != _was){

        await Future.wait([

          CountriesPhrasesProtocols.generateCountriesPhrases(
            setLangCode: langCode,
          ),

          KeywordsPhrasesProtocols.fetchAll(
            langCode: langCode,
          ),

        ]);

        await WaitDialog.closeWaitDialog();
        // await BldrsNav.pushLogoRouteAndRemoveAllBelow(
        //   animatedLogoScreen: true,
        // );
        await Nav.goBack(context: context);
        await MirageNav.goTo(tab: BldrsTab.home);

      }
      else {
        await WaitDialog.closeWaitDialog();
      }

  }
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  ///  TESTED : WORKS PERFECT
  static List<Phrase> onSearchPhrases({
    required ValueNotifier<bool> isSearching,
    required TextEditingController searchController,
    required List<Phrase> phrasesToSearchIn,
    required bool mounted,
    /// mixes between en & ar values in one list
    ValueNotifier<List<Phrase>>? mixedSearchResult,
  }){

    List<Phrase> _foundPhrases = <Phrase>[];

    if (isSearching.value  == true){

      // final List<Phrase> _enResults = Phrase.searchPhrases(
      //   phrases: enPhrase,
      //   text: searchController.text,
      //   byValue: true,
      // );
      //
      // blog('onSearchPhrases : _enResults = $_enResults');

      // final List<Phrase> _result
      _foundPhrases = Phrase.searchPhrasesRegExp(
        phrases: phrasesToSearchIn,
        text: searchController.text,
        lookIntoValues: true,
        // byID: true,
      );

      final List<String> _phids = Phrase.getPhrasesIDs(_foundPhrases);

      _foundPhrases = Phrase.searchPhrasesByIDs(
        phrases: phrasesToSearchIn,
        phids: _phids,
      );

      // blog('onSearchPhrases : _arResults = $_arResults');
      //
      // _foundPhrases = Phrase.insertPhrases(
      //   insertIn: _foundPhrases,
      //   phrasesToInsert: _enResults,
      //   forceUpdate: false,
      //   addLanguageCode: 'en',
      //   allowDuplicateIDs: false,
      // );
      //
      // blog('onSearchPhrases : _foundPhrases.length = ${_foundPhrases.length} after adding en');
      //
      // _foundPhrases = Phrase.insertPhrases(
      //   insertIn: _foundPhrases,
      //   phrasesToInsert: _arResults,
      //   forceUpdate: false,
      //   addLanguageCode: 'ar',
      //   allowDuplicateIDs: false,
      // );

      _foundPhrases = Phrase.cleanIdenticalPhrases(_foundPhrases);

    }

    if (mixedSearchResult != null){
      if (isSearching.value  == true){
        setNotifier(notifier: mixedSearchResult, mounted: mounted, value: _foundPhrases);
      }
      else {
        setNotifier(notifier: mixedSearchResult, mounted: mounted, value: <Phrase>[]);
      }
    }

    return _foundPhrases;
  }
  // -----------------------------------------------------------------------------
}
