import 'dart:async';

import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/protocols/phrase_protocols.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:numeric/numeric.dart';
import 'package:provider/provider.dart';

// final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
class PhraseProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// CHANGE APP LANGUAGE

// --------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> changeAppLang({
    @required BuildContext context,
    @required String langCode,
  }) async {

    triggerUILoading(
      context: context,
      listen: false,
      callerName: 'changeAppLang',
    );

    pushWaitDialog(
      context: context,
      verse: const Verse(
        text: 'phid_change_app_lang_description',
        translate: true,
      ),
    );

    await fetchSetCurrentLangAndAllPhrases(
      context: context,
      setLangCode: langCode,
    );

    await Localizer.changeAppLanguage(context, langCode);

    triggerUILoading(
      context: context,
      listen: false,
      callerName: 'changeAppLang',
    );

    await WaitDialog.closeWaitDialog(context);

    await Nav.goBackToLogoScreen(
      context: context,
      animatedLogoScreen: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> fetchSetCurrentLangAndAllPhrases({
    @required BuildContext context,
    String setLangCode,
  }) async {

    // blog('---> fetchSetCurrentLangAndAllPhrases : START');

    await getSetCurrentLangCode(
      context: context,
      notify: false,
      setLangCode: setLangCode,
    );

    // blog('---> fetchSetCurrentLangAndAllPhrases : _currentLangCode : $_currentLangCode');

    /// THIS GENERATES COUNTRIES PHRASES AND INSERTS THEM IN LDB TO FACILITATE COUNTRY SEARCH BY NAME
    await PhraseProtocols.composeCountriesMixedLangPhrases(
      context: context,
      langCodes: <String>['en', 'ar'],
    );

    // blog('---> fetchSetCurrentLangAndAllPhrases : countriesPhrases : ${phrases.length}');

    await fetchSetMainPhrases(
        notify: true
    );

    // blog('---> fetchSetCurrentLangAndAllPhrases : END');

  }
  // -----------------------------------------------------------------------------

  /// CURRENT LANGUAGE

  // --------------------
  String _currentLangCode = 'en';
  String get currentLangCode => _currentLangCode;
  // --------------------
  /// TESTED : WORKS PERFECT
  static String proGetCurrentLangCode({
    @required BuildContext context,
    @required bool listen,
  }){
    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: listen);
    return _phraseProvider._currentLangCode;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> getSetCurrentLangCode({
    @required BuildContext context,
    @required bool notify,
    String setLangCode,
  }) async {

    /// A. DETECT DEVICE LANGUAGE
    final String _langCode = setLangCode ?? Localizer.getCurrentLangCode(context);

    /// C. SET CURRENT LANGUAGE
    _setCurrentLanguage(
      code: _langCode,
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setCurrentLanguage({
    @required String code,
    @required bool notify,
  }){

    _currentLangCode = code;

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// BASIC PHRASES (keywords phids 'phid_k_' / specs phids 'phid_s_' / general phids 'phid_' )

  // --------------------
  /// does not include trigrams : used for superPhrase translating method only not for search engines
  List<Phrase> _mainPhrases = <Phrase>[];
  List<Phrase> get mainPhrases  => _mainPhrases;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> fetchSetMainPhrases({
    @required bool notify,
  }) async {

    // blog('X1- fetchSetMainPhrases : START');

    /// phrases received from the fetch include trigrams "that was stored in LDB"
    final List<Phrase> _phrases = await PhraseProtocols.fetchMainMixedLangPhrases();

    // blog('X3- fetchSetMainPhrases : MAIN _phrases : ${_phrases.length}');

    setMainPhrases(
      setTo: _phrases,
      notify: notify,
    );

    // blog('X3- fetchSetMainPhrases : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void setMainPhrases({
    @required List<Phrase> setTo,
    @required bool notify,
  }){

    /// NOTE : FILTERS GIVEN PHRASES AS PER CURRENT LANG + REMOVE TRIGRAMS

    if (Mapper.checkCanLoopList(setTo) == true){

      /// FILTER BY LANG
      final List<Phrase> _phrasesByLang = Phrase.searchPhrasesByLang(
        phrases: setTo,
        langCode: _currentLangCode,
      );

      /// REMOVE TRIGRAMS
      final List<Phrase> _cleaned = Phrase.removeTrigramsFromPhrases(_phrasesByLang);

      /// SET
      _mainPhrases = _cleaned;

      /// NOTIFY
      if (notify == true){
        notifyListeners();
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String translatePhid(String phid){

    String _translation;

    if (
        _mainPhrases != null
        &&
        Mapper.checkCanLoopList(_mainPhrases) == true
    ){

      final Phrase _phrase = _mainPhrases.firstWhere(
              (phrase) => phrase.id == phid,
          orElse: ()=> null
      );

      if (_phrase != null){
        _translation = _phrase.value;
      }
    }

    return _translation;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool proGetPhidsAreLoaded(BuildContext context){
    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    return _phraseProvider.mainPhrases.isNotEmpty;
  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  static void wipeOut({
    @required BuildContext context,
    @required bool notify,
  }){

    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);

    /// _currentLangCode
    _phraseProvider._setCurrentLanguage(
      code: 'en',
      notify: false,
    );

    _phraseProvider._phidsPendingTranslation = [];
    _phraseProvider._usedXPhrases = [];

    /// _basicPhrases
    _phraseProvider.setMainPhrases(
        setTo: <Phrase>[],
        notify: notify
    );


  }
  // -----------------------------------------------------------------------------

  /// USED X PHRASES => for dev only

  // --------------------
  List<String> _usedXPhrases = <String>[];
  List<String> get usedXPhrases => _usedXPhrases;
  // --------------------
  void addToUsedXPhrases(String id){

    _usedXPhrases = Stringer.addStringToListIfDoesNotContainIt(
      strings: _usedXPhrases,
      stringToAdd: id,
    );

    // do not notifyListeners,, I will read it manually later

  }
  // -----------------------------------------------------------------------------

  /// PHIDS WAITING TRANSLATION

  // --------------------
  List<String> _phidsPendingTranslation = <String>[];
  List<String> get phidsPendingTranslation => _phidsPendingTranslation;
  // --------------------
  static List<String> proGetPhidsPendingTranslation({
    @required BuildContext context,
    @required bool listen,
  }){
    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: listen);
    return _phraseProvider.phidsPendingTranslation;
  }
  // --------------------
  void addToPhidsPendingTranslation(String id){

    WidgetsBinding.instance.addPostFrameCallback((_){

      _phidsPendingTranslation = Stringer.addStringToListIfDoesNotContainIt(
        strings: _phidsPendingTranslation,
        stringToAdd: id,
      );
      notifyListeners();

    });

  }
  // --------------------
  void refreshPhidsPendingTranslation(){

    if (Mapper.checkCanLoopList(_phidsPendingTranslation) == true){

      for (final String phid in _phidsPendingTranslation){

        final String _xPhrase = translatePhid(phid);

        if (_xPhrase != null){
          _phidsPendingTranslation = Stringer.removeStringsFromStrings(
              removeFrom: _phidsPendingTranslation,
              removeThis: [phid],
          );
        }

      }

    }

    notifyListeners();
  }
  // --------------------
  void removePhidFromPendingTranslation(String phid){

    _phidsPendingTranslation = Stringer.removeStringsFromStrings(
        removeFrom: _phidsPendingTranslation,
        removeThis: [phid],
    );
    notifyListeners();
  }
  // --------------------
  void setPhidsPendingTranslation({
    @required List<String> setTo,
    @required bool notify,
  }){

    blog('setPhidsPendingTranslation : setTO : $setTo');

    _phidsPendingTranslation = setTo;
    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------
}
/// ----------------------------------------------------------------------------------------
//-------------------------------------
/// ~~~~~~ SUPER PHRASE ~~~~~~
//---------------------
String xPhrase(BuildContext context, String phid, {PhraseProvider phrasePro}){

  final String id = Phider.removeIndexFromPhid(phid: phid);

  final PhraseProvider _phraseProvider = phrasePro ?? Provider.of<PhraseProvider>(context, listen: false);
  _phraseProvider.addToUsedXPhrases(id);

  /// THE ( # # ) VERSES
  if (Verse.checkPendingAssigningPhid(id) == true){
    return null;
  }

  /// THE PHID VERSES
  else {

     String _translation = _phraseProvider.translatePhid(id);

    if (_translation == null){
      _phraseProvider.addToPhidsPendingTranslation(id ?? phid);
      _translation = '^^$phid';
    }

    return _translation;
  }

}
//---------------------
List<String> xPhrases(BuildContext context, List<String> phids, {PhraseProvider phrasePro}){
  final List<String> _output = <String>[];

  if (Mapper.checkCanLoopList(phids) == true){

    for (final String phid in phids){
      final String _trans = xPhrase(context, phid, phrasePro: phrasePro);
      _output.add(_trans);
    }

  }
  return _output;



}
//---------------------
String phidIcon(BuildContext context, dynamic icon){
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

  return _chainsProvider.getPhidIcon(
    context: context,
    son: icon,
  );
}
//---------------------
/// ~~~~~~ SUPER PHRASE ~~~~~~
//-------------------------------------
/// ----------------------------------------------------------------------------------------
/// ----------------------------------------------------------------------------------------

String counterCaliber(BuildContext context, int x){
  return Numeric.formatNumToCounterCaliber(
    x: x,
    thousand: xPhrase(context, 'phid_thousand'),
    million: xPhrase(context, 'phid_million'),
  );
}
