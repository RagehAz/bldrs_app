import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/lingo.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';

class Phrase {
  /// --------------------------------------------------------------------------
  const Phrase({
    @required this.value,
    this.id,
    this.langCode,
    this.trigram,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String langCode; /// language code
  final String value; /// name in this language
  final List<String> trigram;
// -----------------------------------------------------------------------------

  /// CYPHERS

// -------------------------------------
  Map<String, dynamic> toMap({bool addTrigram = true}) {

    /// START MAP
    Map<String, dynamic> _map = <String, dynamic>{
      'id' : id,
      'value': value,
    };


    /// ADD LANG CODE IF EXISTED
    if (langCode != null){
      _map = Mapper.insertPairInMap(
          map: _map,
          key: 'langCode',
          value: langCode,
      );
    }

    /// ADD TRIGRAM IF WANTED
    if (addTrigram == true){
      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'trigram',
        value: TextGen.createTrigram(input: value),
      );
    }

    return _map;
  }
// -------------------------------------
    /// uses lang codes as sub maps keys otherwise uses phrase ids as sub maps keys
  static Map<String, dynamic> cipherPhrases({
    @required List<Phrase> phrases,
    bool addTrigrams = false,
  }) {
    Map<String, dynamic> _phrasesMap = <String, dynamic>{};

    if (Mapper.canLoopList(phrases) == true){

      for (final Phrase phrase in phrases){
        _phrasesMap = Mapper.insertPairInMap(
          map: _phrasesMap,
          key: phrase.id,
          value: phrase.toMap(addTrigram: addTrigrams),
        );
      }

    }

    return _phrasesMap;
  }
// -------------------------------------
  static Phrase decipherPhrase(Map<String, dynamic> map) {

    return Phrase(
      id: map['id'],
      value: map['value'],
      langCode: map['langCode'], /// TASK : UPDATE ALL FIREBASE OLD [Name] MODELS FROM FIELD ['code'] to ['langCode']
      trigram: Mapper.getStringsFromDynamics(dynamics: map['trigram']),
    );

  }
// -------------------------------------
  static List<Phrase> decipherPhrases(Map<String, dynamic> map){
    final List<Phrase> _phrases = <Phrase>[];

    final List<String> _keys = map.keys.toList();

    if (Mapper.canLoopList(_keys)){

      for (int i = 0; i<_keys.length; i++){

        final String _key = _keys[i];
        final Phrase _phrase = decipherPhrase(map[_key]);
        _phrases.add(_phrase);

      }

    }

    return _phrases;
  }
// -----------------------------------------------------------------------------

  /// BLOGGERS

// -------------------------------------
  void blogPhrase(){

    blog('PHRASE ------------------------------------- START');

    blog('langCode : $langCode');
    blog('value : $value');

    blog('PHRASE ------------------------------------- END');
  }
// -------------------------------------
  static void blogPhrases(List<Phrase> phrases){

    // blog('PRINTING NAME --------------------------------------- START');

    if (Mapper.canLoopList(phrases)){

      for (final Phrase phrase in phrases){
        blog('langCode : [ ${phrase.langCode} ] : '
            'name : [ ${phrase.value} ] : '
            'trigramLength : ${phrase.trigram?.length}'
        );
      }

    }

    // blog('PRINTING NAME --------------------------------------- END');

  }
// -----------------------------------------------------------------------------

  /// GETTERS & SEARCHERS

// -------------------------------------
  /// Searches list of phrases of different lang codes by current the lang code
  static Phrase getPhraseByCurrentLandFromPhrases({
    @required BuildContext context,
    @required List<Phrase> phrases,
  }) {
    final String _currentLanguageCode = Wordz.languageCode(context);
    Phrase _phrase;

    if (Mapper.canLoopList(phrases)){
      _phrase = getPhraseByLangFromPhrases(
        phrases: phrases,
        langCode: _currentLanguageCode,
      );

      _phrase ??= getPhraseByLangFromPhrases(
          phrases: phrases,
          langCode: 'en',
      );
    }

    return _phrase;
  }
// -------------------------------------
  static Phrase getPhraseByLangFromPhrases({
    @required List<Phrase> phrases,
    @required String langCode,
  }){

    Phrase _phrase;

    if (Mapper.canLoopList(phrases)) {

      final Phrase _foundPhrase = phrases.singleWhere(
              (Phrase phrase) => phrase.langCode == langCode,
          orElse: () => null
      );

      if (_foundPhrase == null){
        _phrase = phrases.singleWhere(
                (Phrase name) => name.langCode == Lang.englishCode,
          orElse: () => const Phrase(value: '...'),
        );
      }

      else {
        _phrase = _foundPhrase;
      }

    }

    return _phrase;
  }
// -------------------------------------
  static List<String> _getLingCodesFromPhrases(List<Phrase> phrases){

    final List<String> _langCodes = <String>[];

    if (Mapper.canLoopList(phrases)){

      for (final Phrase phrase in phrases){
        _langCodes.add(phrase.langCode);
      }

    }

    return _langCodes;
  }
// -------------------------------------
  static List<Phrase> searchPhrasesTrigrams({
    @required List<Phrase> sourcePhrases,
    @required String inputText,
  }){
    final List<Phrase> _foundPhrases = <Phrase>[];
    final String _fixedString = TextMod.fixCountryName(inputText);

    for (final Phrase source in sourcePhrases){

      final List<String> _trigram = source.trigram;

      if (_trigram.contains(_fixedString)){
        _foundPhrases.add(source);
      }

    }

    return _foundPhrases;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  /// loops phrases for any phrase of this lang code
  static bool phrasesIncludeValueForThisLanguage({
    @required List<Phrase> phrases,
    @required String langCode,
  }){

    bool _phraseInclude = false;

    if (Mapper.canLoopList(phrases)){

      for (final Phrase phrase in phrases){

        if (phrase.langCode == langCode){
          if (phrase.value != null){

            _phraseInclude = true;
            break;

          }
        }

      }

    }


    return _phraseInclude;
  }
// -------------------------------------
  static bool phrasesIncludeThisID({
    @required List<Phrase> phrases,
    @required String id,
}){
    bool _include = false;

    if (Mapper.canLoopList(phrases) == true && stringIsNotEmpty(id) == true){

      for (final Phrase phrase in phrases){

        if (phrase.id == id){
          _include = true;
          break;
        }

      }

    }

    return _include;
  }
// -------------------------------------
  static bool phrasesIncludeThisValue({
    @required List<Phrase> phrases,
    @required String value,
  }){
    bool _include = false;

    if (Mapper.canLoopList(phrases) == true && stringIsNotEmpty(value) == true){

      for (final Phrase phrase in phrases){

        if (phrase.value == value){
          _include = true;
          break;
        }

      }

    }

    return _include;
  }
// -------------------------------------
  /// TASK : TEST THIS
  static bool phrasesAreTheSame({
    @required Phrase firstName,
    @required Phrase secondName,
  }){

    bool _namesAreTheSame = false;

    if (firstName != null && secondName != null){

      if (firstName.langCode == secondName.langCode){

        if (firstName.value == secondName.value){

          if (Mapper.listsAreTheSame(list1: firstName.trigram, list2: secondName.trigram)){

            _namesAreTheSame = true;

          }

        }

      }

    }

    return _namesAreTheSame;
  }
// -------------------------------------
  /// TASK : TEST THIS
  static bool phrasesListsAreTheSame({
    @required List<Phrase> firstPhrases,
    @required List<Phrase> secondPhrases,
  }){

    bool _listsAreTheSame = false;

    if (Mapper.canLoopList(firstPhrases) && Mapper.canLoopList(secondPhrases)){

      if (firstPhrases.length == secondPhrases.length){

        final List<String> codes = _getLingCodesFromPhrases(firstPhrases);

        bool _allLangCodesAreTheSame = true;

        for (final String langCode in codes){

          final String firstPhraseValue = getPhraseByLangFromPhrases(
              phrases: firstPhrases,
              langCode: langCode,
          )?.value;

          final String secondPhraseValue = getPhraseByLangFromPhrases(
              phrases: secondPhrases,
              langCode: langCode,
          )?.value;

          if (firstPhraseValue == secondPhraseValue){

            _allLangCodesAreTheSame = true;

          }

          else {
            _allLangCodesAreTheSame = false;
            break;
          }

        }

        if (_allLangCodesAreTheSame == true){
          _listsAreTheSame = true;
        }

      }

    }

    return _listsAreTheSame;
  }
// -----------------------------------------------------------------------------

  /// SORTING

// -------------------------------------
  static List<Phrase> sortNamesAlphabetically(List<Phrase> phrases){

    if (Mapper.canLoopList(phrases)){
      phrases.sort((Phrase a, Phrase b) => a.value.compareTo(b.value));
    }

    return phrases;
  }
// -----------------------------------------------------------------------------

  /// MODIFIERS

// -------------------------------------
  static List<Phrase> insertPhrase({
    @required List<Phrase> phrases,
    @required Phrase phrase,
}){

    final List<Phrase> _output = <Phrase>[];

    if (Mapper.canLoopList(phrases) == true && phrase != null){

      final bool _idIsTaken = phrasesIncludeThisID(
          phrases: phrases,
          id: phrase.id,
      );

      final bool _valueHasDuplicate = phrasesIncludeThisValue(
        phrases: phrases,
        value: phrase.value,
      );

      if (_idIsTaken == false && _valueHasDuplicate == false){
        _output.add(phrase);
      }

      else {

        blog('xxxxxxxxx 5od balak : insertPhrase : '
            '_idIsTaken : $_idIsTaken : '
            '_valueHasDuplicate : $_valueHasDuplicate'
        );
      }

    }

    if (_output.isEmpty){
      return null;
    }
    else {
      return _output;
    }

}

}
