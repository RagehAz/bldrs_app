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

    final List<String> _keys = map?.keys?.toList();

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

    blog('id : $id');
    blog('langCode : $langCode');
    blog('value : $value');

    blog('PHRASE ------------------------------------- END');
  }
// -------------------------------------
  static void blogPhrases(List<Phrase> phrases){

    // blog('PRINTING NAME --------------------------------------- START');

    if (Mapper.canLoopList(phrases)){

      for (final Phrase phrase in phrases){
        blog(
            'id : [ ${phrase.id} ] : '
            'langCode : [ ${phrase.langCode} ] : '
            'name : [ ${phrase.value} ] : '
            'trigramLength : ${phrase.trigram?.length}'
        );
      }

    } else {

      // blog('phrases ARE FUCKING NULL');

    }

    // blog('PRINTING NAME --------------------------------------- END');

  }
// -----------------------------------------------------------------------------

  /// GETTERS & SEARCHERS

// -------------------------------------
  /// Searches list of phrases of different lang codes by current the lang code
  static Phrase getPhraseByCurrentLangFromPhrases({
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
        _phrase = phrases.singleWhere((Phrase name) => name.langCode == Lang.englishCode,
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
  static List<Phrase> getPhrasesByLangFromPhrases({
    @required List<Phrase> phrases,
    @required String langCode,
}){
    List<Phrase> _output = <Phrase>[];

    if (Mapper.canLoopList(phrases) == true){
      _output = phrases.where((phr) => phr.langCode == langCode).toList();
    }

    return _output;
  }
// -------------------------------------
  static Phrase getPhraseFromPhrasesByID({
    @required List<Phrase> phrases,
    @required String id,
    String addLangCode,
}){
    Phrase _phrase;

    if (Mapper.canLoopList(phrases) == true && stringIsNotEmpty(id) == true){

      for (final Phrase phrase in phrases){

        if (phrase.id == id){

          _phrase = Phrase(
            id: id,
            value: phrase.value,
            trigram: phrase.trigram,
            langCode: addLangCode ?? phrase.langCode,
          );

          break;
        }

      }

    }

    return _phrase;
  }
// -------------------------------------
  static Phrase getPhraseFromPhrasesByValue({
    @required List<Phrase> phrases,
    @required String value,
  }){
    Phrase _phrase;

    if (Mapper.canLoopList(phrases) == true && stringIsNotEmpty(value) == true){

      for (final Phrase phrase in phrases){

        if (phrase.value == value){
          _phrase = phrase;
          break;
        }

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
  static List<Phrase> getAllLanguagesPhrasesOfMixedPhrases({
    @required List<Phrase> enPhrases,
    @required List<Phrase> arPhrases,
    @required List<Phrase> mixedPhrases,
}){
    final List<Phrase> _output = <Phrase>[];

    if (Mapper.canLoopList(mixedPhrases) == true){

      for (final Phrase phrase in mixedPhrases){

        final Phrase _en = getPhraseFromPhrasesByID(
          phrases: enPhrases,
          id: phrase.id,
          addLangCode: 'en',
        );

        final Phrase _ar = getPhraseFromPhrasesByID(
          phrases: arPhrases,
          id: phrase.id,
          addLangCode: 'ar',
        );

        _output.addAll(<Phrase>[_en, _ar]);
      }

    }

    // blog('all mixed shit kollo fba3don in the blender keda ');
    // blogPhrases(_output);

    return _output;
  }
// -------------------------------------
  static List<Phrase> searchPhrases({
    @required List<Phrase> phrases,
    @required String text,
    bool byID = true,
    bool byValue = false,
}){
    final List<Phrase> _result = <Phrase>[];

    if (Mapper.canLoopList(phrases) && text.isNotEmpty){

      if (byID == true){

        final List<Phrase> _byID = phrases.where((ph){

          return
            stringContainsSubStringRegExp(
              string: ph.id,
              subString: text,
            ) == true;

        }).toList();

        _result.addAll(_byID);
      }

      if (byValue == true){

        final List<Phrase> _byValue = phrases.where((ph){

          return
            stringContainsSubStringRegExp(
              string: ph.value,
              subString: text,
            ) == true;

        }).toList();

        _result.addAll(_byValue);
      }

    }

    blog('found those phrases');
    Phrase.blogPhrases(_result,);

    return _result;
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
  static bool phrasesIncludeIdenticalPhrases({
  @required List<Phrase> phrases,
}){
    bool _include = false;

    if (Mapper.canLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        final Phrase _found = phrases.firstWhere((ph){

          final bool _condition =
          ph.id == phrase.id
          &&
          ph.value == phrase.value
          &&
          ph.langCode == phrase.langCode
          &&
          Mapper.listsAreTheSame(list1: ph.trigram, list2: phrase.trigram) == true
          ;

          return _condition;
        }, orElse: () => null);

        if (_found != null){
          _include = true;
          break;
        }

      }

    }

    else {
      _include = false;
    }

    return _include;
  }
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
    @required Phrase firstPhrase,
    @required Phrase secondPhrase,
  }){

    bool _namesAreTheSame = false;

    if (firstPhrase != null && secondPhrase != null){

      if (firstPhrase.langCode == secondPhrase.langCode){

        if (firstPhrase.value == secondPhrase.value){

          if (Mapper.listsAreTheSame(list1: firstPhrase.trigram, list2: secondPhrase.trigram)){

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
// -------------------------------------
  static List<Phrase> sortPhrasesByID({@required List<Phrase> phrases}){

    if (Mapper.canLoopList(phrases)){
      phrases.sort((Phrase a, Phrase b) => a.id.compareTo(b.id));
    }

    return phrases;

  }
// -----------------------------------------------------------------------------

  /// MODIFIERS

// -------------------------------------
  static List<Phrase> insertPhrase({
    @required List<Phrase> phrases,
    @required Phrase phrase,
    @required bool forceUpdateDuplicate,
    String addLanguageCode,
  }){

    final List<Phrase> _output =
    phrases == null ? <Phrase>[]
        :

    phrases.isNotEmpty ? phrases
        :
    <Phrase>[];


    int _existingPhraseIndex;
    Phrase _phraseToInsert = phrase;
    if (stringIsNotEmpty(addLanguageCode)){
      _phraseToInsert = Phrase(
        id: phrase.id,
        value: phrase.value,
        langCode: addLanguageCode,
        trigram: phrase.trigram,
      );
    }

    if (phrases != null && phrase != null){

      final bool _idIsTaken = phrasesIncludeThisID(
        phrases: phrases,
        id: phrase.id,
      );

      if (_idIsTaken == false){
        _output.add(_phraseToInsert);
      }

      else {

        if (forceUpdateDuplicate == true){

          _existingPhraseIndex = phrases.indexWhere((ph) => ph.id == phrase.id);
          if (_existingPhraseIndex != -1){
            _output.insert(_existingPhraseIndex, _phraseToInsert);
          }

        }

      }

    }

    blog('after adding one phrase : ${phrase.id} ,, this list is :-');
    blogPhrases(_output);

    // if (_output.isEmpty || _existingPhraseIndex == -1){
    //   return null;
    // }
    // else {
      return _output;
    // }

  }
// -------------------------------------
  static List<Phrase> insertPhrases({
    @required List<Phrase> insertIn,
    @required List<Phrase> phrasesToInsert,
    @required bool forceUpdate,
    String addLanguageCode,
    bool allowDuplicateIDs,
}){

    List<Phrase> _output;

    if (allowDuplicateIDs == true){
      _output = _combinePhrasesListsAndAllowDuplicateIDs(
        insertIn: insertIn,
        phrasesToInsert: phrasesToInsert,
        addLanguageCodeToInsertedPhrases: addLanguageCode,
      );
    }

    else {
      _output = _combinePhrasesWithoutDuplicateIDs(
        phrasesToInsert: phrasesToInsert,
        insertIn: insertIn,
        forceUpdate: forceUpdate,
        addLanguageCode: addLanguageCode,
      );
    }

    return _output;
  }
// -------------------------------------
  static List<Phrase> _combinePhrasesListsAndAllowDuplicateIDs({
    @required List<Phrase> insertIn,
    @required List<Phrase> phrasesToInsert,
    String addLanguageCodeToInsertedPhrases,
  }){

    final List<Phrase> _output = <Phrase>[];

    if (Mapper.canLoopList(insertIn) == true){
      _output.addAll(insertIn);
    }

    if (Mapper.canLoopList(phrasesToInsert) == true){

      List<Phrase> _phrasesToInsert = phrasesToInsert;

      if (stringIsNotEmpty(addLanguageCodeToInsertedPhrases) == true){
        _phrasesToInsert = _addLangCodeToPhrases(
          phrases: phrasesToInsert,
          langCode: addLanguageCodeToInsertedPhrases,
        );
      }

      _output.addAll(_phrasesToInsert);
    }

    // blog('THE FUCKINGGGGGGGGGGG THING IS :');
    // blogPhrases(_output);

    return _cleanIdenticalPhrases(_output);
  }
// -------------------------------------
  static List<Phrase> _addLangCodeToPhrases({
    @required String langCode,
    @required List<Phrase> phrases,
}){
    final List<Phrase> _output = <Phrase>[];

    if (Mapper.canLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        final Phrase _phrase = Phrase(
          value: phrase.value,
          id: phrase.id,
          langCode: langCode,
          trigram: phrase.trigram,
        );

        _output.add(_phrase);

      }

    }

    return _output;
  }

  static List<Phrase> _combinePhrasesWithoutDuplicateIDs({
    @required List<Phrase> insertIn,
    @required List<Phrase> phrasesToInsert,
    @required bool forceUpdate,
    String addLanguageCode,
  }){

    List<Phrase> _output = insertIn == null ? <Phrase>[]
        :
    insertIn.isNotEmpty ? insertIn
        :
    <Phrase>[]
    ;

    if (Mapper.canLoopList(phrasesToInsert)){

      for (final Phrase phrase in phrasesToInsert){

        _output = insertPhrase(
          phrases: _output,
          phrase: phrase,
          forceUpdateDuplicate: forceUpdate,
          addLanguageCode: addLanguageCode,
        );

      }

    }

    blog('output phrases inserted are : -');
    Phrase.blogPhrases(_output);

    return _output;

  }
// -------------------------------------
  static List<Phrase> _cleanIdenticalPhrases(List<Phrase> phrases){
    final List<Phrase> _output = <Phrase>[];

    if (Mapper.canLoopList(phrases) == true){

      for (final Phrase firstPhrase in phrases){

        final bool _contains = phrasesIncludeIdenticalPhrases(
          phrases: phrases,
        );

        if (_contains == false){
          _output.add(firstPhrase);
        }

      }

    }

    // blog('phrases have become this after clean up');
    //   blogPhrases(_output);

    return _output;
  }
// -------------------------------------
  static List<Phrase> deletePhraseFromPhrases({
    @required List<Phrase> phrases,
    @required String phraseID,
  }){

    final List<Phrase> _output = <Phrase>[...phrases];

    if (Mapper.canLoopList(phrases) == true && stringIsNotEmpty(phraseID) == true){

      _output.removeWhere((ph) => ph.id == phraseID);

    }

    return _output;
  }
// -------------------------------------

}
