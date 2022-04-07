import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Phrase {
  /// --------------------------------------------------------------------------
  const Phrase({
    @required this.value,
    @required this.id,
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
  Map<String, dynamic> toMap({
    @required bool includeID,
    bool includeTrigram = false,
    bool includeLangCode = false,
    String overrideLangCode,
  }) {

    /// START MAP
    Map<String, dynamic> _map = <String, dynamic>{
      /// 'id' : id, DO NOT put id in the single phrase map, will be used as phrases map key
      'value': value,
    };

    /// WHEN INCLUDES ID
    if (includeID == true){
      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'id',
        value: id,
      );

    }

    /// WHEN INCLUDING LANGUAGE CODE
    if (includeLangCode == true){

      /// ADD LANG CODE IF EXISTED
      if (langCode != null){
        _map = Mapper.insertPairInMap(
          map: _map,
          key: 'langCode',
          value: overrideLangCode ?? langCode,
        );
      }

    }

    /// WHEN INCLUDING TRIGRAM
    if (includeTrigram == true){

      final bool _trigramExists = Mapper.canLoopList(trigram);

      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'trigram',
        value: _trigramExists ?
        trigram
            :
        TextGen.createTrigram(input: value),
      );
    }

    return _map;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT : used to upload to firebase
  static Map<String, dynamic> cipherOneLangPhrasesToMap({
    @required List<Phrase> phrases,
    bool addTrigrams = false,
    bool includeLangCode = false,
    String overrideLangCode,
  }) {
    Map<String, dynamic> _phrasesMap = <String, dynamic>{};

    if (Mapper.canLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        _phrasesMap = Mapper.insertPairInMap(
          map: _phrasesMap,
          key: phrase.id,
          value: phrase.toMap(
            includeID: false,
            includeTrigram: addTrigrams,
            includeLangCode: includeLangCode,
            overrideLangCode: overrideLangCode,
          ),

        );
      }

    }

    return _phrasesMap;
  }
// -------------------------------------
  /// used to store in LDB
  static List<Map<String, dynamic>> cipherOneLangPhrasesToMaps({
    @required List<Phrase> phrases,
    bool addTrigrams = false,
    bool includeLangCode = false,
    String overrideLangCode,
}){

    final List<Map<String, dynamic>> _maps = <Map<String,dynamic>>[];

    if (Mapper.canLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        final Map<String, dynamic> _map = phrase.toMap(
          includeID: true,
          includeTrigram: addTrigrams,
          includeLangCode: includeLangCode,
          overrideLangCode: overrideLangCode,
        );

        _maps.add(_map);

      }

    }

    return _maps;
}
// -------------------------------------
  static Phrase decipherPhrase({
    @required String id,
    @required Map<String, dynamic> map,
    String langCodeOverride,
    bool includeTrigram,
  }) {

    final List<String> _trigram = _getTrigramIfNeeded(
      includeTrigram: includeTrigram,
      existingTrigram: Mapper.getStringsFromDynamics(dynamics: map['trigram']),
      originalString: map['value'],
    );

    return Phrase(
      id: id ?? map['id'],
      value: map['value'],
      langCode: langCodeOverride ?? map['langCode'],
      trigram: _trigram,
    );

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> decipherOneLangPhrasesMap({
    @required Map<String, dynamic> map,
    String addLangCodeOverride,
    bool includeTrigrams = false,
}){
    final List<Phrase> _phrases = <Phrase>[];

    final List<String> _keys = map?.keys?.toList();

    if (Mapper.canLoopList(_keys)){

      for (int i = 0; i<_keys.length; i++){

        final String _key = _keys[i];
        final Phrase _phrase = decipherPhrase(
          id: _key,
          map: map[_key],
          langCodeOverride: addLangCodeOverride,
          includeTrigram: includeTrigrams,
        );
        _phrases.add(_phrase);

      }

    }

    return _phrases;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> decipherOneLangPhrasesMaps({
    @required List<Map<String, dynamic>> maps,
    String langCodeOverride,
    bool includeTrigrams = false,
  }){

    final List<Phrase> _phrases = <Phrase>[];

    if (Mapper.canLoopList(maps) == true){

      for (int i = 0; i< maps.length; i++){

        final Map<String, dynamic> _map = maps[i];

        final Phrase _phrase = decipherPhrase(
          id: _map['id'],
          map: _map,
          langCodeOverride: langCodeOverride,
          includeTrigram: includeTrigrams,
        );

        _phrases.add(_phrase);
      }

    }

    return _phrases;
  }
// -------------------------------------
  /// TESTED :
  static List<Phrase> decipherMixedLangPhrases({
  @required List<Map<String, dynamic>> maps,
}){
    final List<Phrase> _phrases = <Phrase>[];

    if (Mapper.canLoopList(maps) == true){

      for (final Map<String, dynamic> map in maps){

        final Phrase _phrase = decipherPhrase(
          id: map['id'],
          map: map,
          langCodeOverride: map['langCode'],
          includeTrigram: true,
        );

        _phrases.add(_phrase);

      }

    }

    return _phrases;
  }
// -------------------------------------
  /// TESTED :
  static List<Map<String, dynamic>> cipherMixedLangPhrases({
  @required List<Phrase> phrases,
}){
    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.canLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        Map<String, dynamic> _map = phrase.toMap(
          includeID: true,
          includeTrigram: true,
          overrideLangCode: phrase.langCode,
          includeLangCode: true,
        );

        /// used as primary key, due to duplicates in both ids and langCodes
        _map = Mapper.insertPairInMap(
            map: _map,
            key: 'primaryKey',//'id_langCode',
            value: '${phrase.id}_${phrase.langCode}',
        );

        _maps.add(_map);

      }

    }

    return _maps;
  }
// -----------------------------------------------------------------------------

  /// STREAMING

// -------------------------------------
  static List<Phrase> getPhrasesFromStream({
    @required DocumentSnapshot<Object> doc,
    @required String langCode,
  }) {

    final Map<String, dynamic> _map = Mapper.getMapFromDocumentSnapshot(doc);

    final List<Phrase> _models = Phrase.decipherOneLangPhrasesMap(
      map: _map,
      addLangCodeOverride: langCode,
    );

    return _models;
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
  /// TESTED : WORKS PERFECT
  static void blogPhrases(List<Phrase> phrases){

    int _count = 1;

    if (Mapper.canLoopList(phrases)){

      for (final Phrase phrase in phrases){
        blog(
            '#$_count : '
            'id : [ ${phrase.id} ] : '
            'langCode : [ ${phrase.langCode} ] : '
            'name : [ ${phrase.value} ] : '
            'trigramLength : ${phrase.trigram?.length}'
        );
        _count++;
      }

    }
    else {
      blog('phrases ARE FUCKING NULL');
    }

  }
// -----------------------------------------------------------------------------

  /// GETTERS & SEARCHERS

// -------------------------------------
  /// Searches list of phrases of different lang codes by current the lang code
  static Phrase getPhraseByCurrentLangFromMixedLangPhrases({
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

      _phrase = phrases.singleWhere(
              (Phrase phrase) => phrase.langCode == langCode,
          orElse: () => null
      );


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
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getPhrasesIDs(List<Phrase> phrases){

    final List<String> _output = <String>[];

    if (Mapper.canLoopList(phrases) == true){

      for (final Phrase phrase in phrases){
        _output.add(phrase.id);
      }

    }

    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Phrase getPhraseByIDAndLangCodeFromPhrases({
    @required String langCode,
    @required String phid,
    @required List<Phrase> phrases,
}){

    Phrase _phrase;

    if (Mapper.canLoopList(phrases) == true){

       _phrase = phrases.firstWhere(
            (ph) => ph.id == phid && ph.langCode == langCode,
        orElse: ()=> null,
      );

    }

    return _phrase;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  static bool phrasesIncludeIdenticalPhrase({
    @required List<Phrase> phrases,
    @required Phrase firstPhrase,
}){
    bool _include = false;

    if (Mapper.canLoopList(phrases) == true && firstPhrase != null){

      for (final Phrase secondPhrase in phrases){

        final bool _found =
            firstPhrase.id == secondPhrase.id
            &&
            firstPhrase.value == secondPhrase.value
            &&
            firstPhrase.langCode == secondPhrase.langCode;

       if (_found == true){
         _include = true;
         break;
       }

      }

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

    return cleanIdenticalPhrases(_output);
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
  static List<Phrase> cleanIdenticalPhrases(List<Phrase> phrases){
    final List<Phrase> _output = <Phrase>[];

    if (Mapper.canLoopList(phrases) == true){

      for (final Phrase firstPhrase in phrases){

        final bool _contains = phrasesIncludeIdenticalPhrase(
          phrases: _output,
          firstPhrase: firstPhrase,
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
  /// TESTED : WORKS PERFECT
  static List<Phrase> onlyIncludeIDAndValue({
  @required List<Phrase> phrases,
}){
    final List<Phrase> _output = <Phrase>[];

    if (Mapper.canLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        final Phrase _phrase = Phrase(
          id: phrase.id,
          value: phrase.value,
        );

        _output.add(_phrase);

      }

    }

    return _output;
  }
// -------------------------------------
  static List<String> _getTrigramIfNeeded({
    @required bool includeTrigram,
    @required List<String> existingTrigram,
    @required String originalString,
}){
    List<String> _output;

    if (includeTrigram == true){

      final bool _hasExitingOne = Mapper.canLoopList(existingTrigram);

      if (_hasExitingOne == true){
        _output = existingTrigram;
      }
      else {
        _output = TextGen.createTrigram(input: originalString);
      }

    }

    return _output;
}
// -----------------------------------------------------------------------------

  /// KEYWORDS AND SPECS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getKeywordsIDsFromPhrases({
  @required List<Phrase> allPhrases,
}){

    final List<Phrase> _keywordsPhrases = <Phrase>[];

    for (final Phrase phrase in allPhrases){

      final String _phidK = TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: phrase.id,
        numberOfCharacters: 7, //'phid_k'
      );

      final bool _isKeyword = _phidK == 'phid_k_';

      if (_isKeyword == true){
        _keywordsPhrases.add(phrase);
      }

    }

    final List<String> _keywordsPhrasesIDs = getPhrasesIDs(_keywordsPhrases);

    return _keywordsPhrasesIDs;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getSpecsIDsFromPhrases({
    @required List<Phrase> allPhrases,
  }){

    final List<Phrase> _specsIDs = <Phrase>[];

    for (final Phrase phrase in allPhrases){

      final String _phidK = TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: phrase.id,
        numberOfCharacters: 7, //'phid_s_'
      );

      final bool _isKeyword = _phidK == 'phid_s_';

      if (_isKeyword == true){
        _specsIDs.add(phrase);
      }

    }

    final List<String> _specsPhraseIDs = getPhrasesIDs(_specsIDs);

    return _specsPhraseIDs;
  }
// -------------------------------------
}
