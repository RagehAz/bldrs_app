import 'dart:async';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/c_protocols/phrase_protocols/phrase_protocols.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';
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

    unawaited(
        WaitDialog.showWaitDialog(
          context: context,
          loadingVerse: 'phid_change_app_lang_description',
        )
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

    WaitDialog.closeWaitDialog(context);

    await Nav.goBackToLogoScreen(
      context: context,
      animatedLogoScreen: true,
    );

  }
  // --------------------
  Future<void> fetchSetCurrentLangAndAllPhrases({
    @required BuildContext context,
    String setLangCode,
  }) async {

    await getSetCurrentLangCode(
      context: context,
      notify: false,
      setLangCode: setLangCode,
    );

    await PhraseProtocols.generateCountriesMixedLangPhrases(
      context: context,
      langCodes: <String>['en', 'ar'],
    );

    await fetchSetMainPhrases(
        context: context,
        notify: true
    );

  }
  // -----------------------------------------------------------------------------

  /// CURRENT LANGUAGE

  // --------------------
  String _currentLangCode = 'en';
  String get currentLangCode => _currentLangCode;
  // --------------------
  static String proGetCurrentLangCode({
    @required BuildContext context,
    @required bool listen,
  }){
    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: listen);
    return _phraseProvider._currentLangCode;
  }
  // --------------------
  Future<void> getSetCurrentLangCode({
    @required BuildContext context,
    @required bool notify,
    String setLangCode,
  }) async {

    /// A. DETECT DEVICE LANGUAGE
    final String _langCode = setLangCode ?? Words.languageCode(context);

    /// C. SET CURRENT LANGUAGE
    _setCurrentLanguage(
      code: _langCode,
      notify: notify,
    );

  }
  // --------------------
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
  Future<void> fetchSetMainPhrases({
    @required BuildContext context,
    @required bool notify,
  }) async {

    /// phrases received from the fetch include trigrams "that was stored in LDB"
    final List<Phrase> _phrases = await PhraseProtocols.fetchMainMixedLangPhrases(
      context: context,
    );

    setMainPhrases(
      setTo: _phrases,
      notify: notify,
    );

  }
  // --------------------
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
  String getTranslatedPhraseByID(String id){

    String _translation;

    if (
    _mainPhrases != null
        &&
        Mapper.checkCanLoopList(_mainPhrases) == true
    ){

      final Phrase _phrase = _mainPhrases.singleWhere(
              (phrase) => phrase.id == id,
          orElse: ()=> null
      );

      if (_phrase != null){
        _translation = _phrase.value;
      }
    }

    return _translation;
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
}
/// ----------------------------------------------------------------------------------------
//-------------------------------------
/// ~~~~~~ SUPER PHRASE ~~~~~~
//---------------------
String xPhrase(BuildContext context, String id, {PhraseProvider phrasePro}){

  final PhraseProvider _phraseProvider = phrasePro ?? Provider.of<PhraseProvider>(context, listen: false);
  _phraseProvider.addToUsedXPhrases(id);

  if (_stringNeedTranslation(id) == true){
    return null;
  }

  else {
    return _phraseProvider.getTranslatedPhraseByID(id);
  }

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
bool _stringNeedTranslation(String string){
  bool _need = false;

  if (
  TextMod.removeAllCharactersAfterNumberOfCharacters(
      input: string,
      numberOfChars: 2
  ) == '##'
  ){
    _need = true;
  }

  return _need;
}
/// ----------------------------------------------------------------------------------------
