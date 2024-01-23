import 'dart:async';

import 'package:basics/helpers/animators/sliders.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/countries_phrases_protocols/countries_phrases_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/keywords_phrases_protocols/keywords_phrases_protocols.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
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

          KeywordsPhrasesProtocols.downloadAll(
            langCode: langCode,
          ),

        ]);

        // final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
        // await _chainsProvider.fetchSortSetBldrsChains(
        //   notify: true,
        // );

        await WaitDialog.closeWaitDialog();

        await BldrsNav.pushLogoRouteAndRemoveAllBelow(
          animatedLogoScreen: true,
        );

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
    required PageController? pageController,
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

    if (pageController != null){
      if (pageController.position.pixels >= Scale.screenWidth(getMainContext()) == true){
        Sliders.slideToBackFrom(
          pageController: pageController,
          currentSlide: 1,
        );
      }
    }

    return _foundPhrases;
  }
  // --------------------
  /// TASK : DO ME
  static Future<List<Phrase>> generatePhrasesFromChain({
    required dynamic chain,
    required BuildContext context,
  }) async {

    /// should include en - ar phrases for all IDs
    final List<Phrase> _phrases = <Phrase>[];

    if (chain != null){

      // final List<String> _sonsPhids = Chain.getOnlyPhidsSonsFromChain(
      //   chain: chain,
      // );
      //
      // if (chain.id != null && chain.id != ''){
      //   _sonsPhids.add(chain.id!);
      // }
      //
      // _phrases = await generateMixedLangPhrasesFromPhids(
      //   context: context,
      //   phids: Phider.removePhidsIndexes(<String>[..._sonsPhids,]),
      // );

    }

    return _phrases;
  }
  // --------------------
  /// TASK : DO ME
  static Future<List<Phrase>> generatePhrasesFromChains({
    required List<dynamic>? chains,
    required BuildContext context,
  }) async {
    final List<Phrase> _phrases = <Phrase>[];

    // if (Lister.checkCanLoop(chains) == true){
    //
    //   Future<void> _generate(Chain chain) async {
    //     final List<Phrase> _chainPhrases = await generatePhrasesFromChain(
    //       chain: chain,
    //       context: context,
    //     );
    //     _phrases.addAll(_chainPhrases);
    //   }
    //
    //   await Future.wait(<Future>[
    //     ...List.generate(chains!.length, (index){
    //       return _generate(chains[index]);
    //     }),
    //   ]);
    //
    // }

    return _phrases;
  }
  // -----------------------------------------------------------------------------
}
