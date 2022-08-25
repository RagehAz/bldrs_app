import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
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

  /// CLONING

// -------------------------------------
  /// TESTED : WORKS PERFECT
  Phrase copyWith({
    String id,
    String langCode,
    String value,
    List<String> trigram,
  }){
    return Phrase(
      id: id ?? this.id,
      langCode: langCode ?? this.langCode,
      value: value ?? this.value,
      trigram: trigram ?? this.trigram,
    );
  }
// -----------------------------------------------------------------------------

  /// CYPHERS

// ------------------------------------------
  ///  TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherPhrasesToReal(List<Phrase> phrases){

    Map<String, dynamic> _map;

    if (Mapper.checkCanLoopList(phrases) == true){
      _map = {};

      for (final Phrase phrase in phrases){

        _map = Mapper.insertPairInMap(
            map: _map,
            key: phrase.id,
            value: phrase.value,
        );

      }

    }

    return _map;
  }
// ------------------------------------------
  ///  TESTED : WORKS PERFECT
  static List<Phrase> decipherPhrasesFromReal({
    @required String langCode,
    @required Map<String, dynamic> map,
    bool includeTrigram = true,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (map != null){

      final List<String> _keys = map.keys.toList();

      if (Mapper.checkCanLoopList(_keys) == true){

        for (final String key in _keys){

          final List<String> _trigram =
          includeTrigram == true ?
          Stringer.createTrigram(
            input: map[key],
            // removeSpaces: false,
            )
              :
          null;

          final Phrase _phrase = Phrase(
            id: key,
            value: map[key],
            langCode: langCode,
            trigram: _trigram,
          );

          _output.add(_phrase);

        }

      }

    }

    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
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

      final bool _trigramExists = Mapper.checkCanLoopList(trigram);

      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'trigram',
        value: _trigramExists ?
        trigram
            :
        Stringer.createTrigram(input: value),
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

    if (Mapper.checkCanLoopList(phrases) == true){

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

    if (Mapper.checkCanLoopList(phrases) == true){

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
  /// TESTED : WORKS PERFECT
  static Phrase decipherPhrase({
    @required String id,
    @required Map<String, dynamic> map,
    String langCodeOverride,
    bool includeTrigram,
  }) {

    final List<String> _trigram = _getTrigramIfIncluded(
      includeTrigram: includeTrigram,
      existingTrigram: Stringer.getStringsFromDynamics(dynamics: map['trigram']),
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

    if (Mapper.checkCanLoopList(_keys)){

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

    if (Mapper.checkCanLoopList(maps) == true){

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
  /// TESTED : WORKS PERFECT
  static List<Phrase> decipherMixedLangPhrases({
    @required List<Map<String, dynamic>> maps,
  }){
    final List<Phrase> _phrases = <Phrase>[];

    if (Mapper.checkCanLoopList(maps) == true){

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
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherMixedLangPhrases({
    @required List<Phrase> phrases,
    bool includeTrigrams = true,
  }){
    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.checkCanLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        Map<String, dynamic> _map = phrase.toMap(
          includeID: true,
          includeTrigram: includeTrigrams,
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

    final Map<String, dynamic> _map = Mapper.getMapFromDocumentSnapshot(
      docSnapshot: doc,
      addDocSnapshot: false,
      addDocID: false,
    );

    final List<Phrase> _models = Phrase.decipherOneLangPhrasesMap(
      map: _map,
      addLangCodeOverride: langCode,
    );

    return _models;
  }
// -----------------------------------------------------------------------------

  /// BLOGGERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  void blogPhrase(){
    blog('PHRASE : langCode : $langCode : id : $id : $value : trigram(${trigram.length})');
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static void blogPhrases(List<Phrase> phrases){

    int _count = 1;

    if (Mapper.checkCanLoopList(phrases)){

      for (final Phrase phrase in phrases){
        blog(
            '  #$_count : '
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

  /// GETTERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> _getLingCodesFromPhrases(List<Phrase> phrases){

    final List<String> _langCodes = <String>[];

    if (Mapper.checkCanLoopList(phrases)){

      for (final Phrase phrase in phrases){
        _langCodes.add(phrase.langCode);
      }

    }

    return _langCodes;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getPhrasesIDs(List<Phrase> phrases){

    List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        _output = Stringer.addStringToListIfDoesNotContainIt(
          strings: _output,
          stringToAdd: phrase.id,
        );

      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// SEARCHERS

// -------------------------------------
  /// BY ID
// -----------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchPhrasesByID({
    @required List<Phrase> phrases,
    @required String phid,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Mapper.checkCanLoopList(phrases) == true && phid != null){

      final List<Phrase> _phrases = phrases.where((ph) => ph.id == phid).toList();

      if (Mapper.checkCanLoopList(_phrases) == true){
        _output.addAll(_phrases);
      }

    }

    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchPhrasesByIDs({
    @required List<Phrase> phrases,
    @required List<String> phids,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Mapper.checkCanLoopList(phrases) == true && Mapper.checkCanLoopList(phids) == true){

      for (final String phid in phids){

        final List<Phrase> _phrases = searchPhrasesByID(
          phrases: phrases,
          phid: phid,
        );

        if (Mapper.checkCanLoopList(_phrases) == true){
          _output.addAll(_phrases);
        }

      }

    }

    return _output;
  }
// -------------------------------------
  /// BY ID + LANG
// -----------------
  /// TESTED : WORKS PERFECT
  static Phrase searchPhraseByIDAndLangCode({
    @required List<Phrase> phrases,
    @required String phid,
    @required String langCode,
  }){
    Phrase _phrase;

    if (Mapper.checkCanLoopList(phrases) == true && Stringer.checkStringIsNotEmpty(phid) == true){

      /// SEARCH PHRASES

      final List<Phrase> _phrasesByID = searchPhrasesByID(
        phrases: phrases,
        phid: phid,
      );

      if (langCode == null){
        _phrase = searchFirstPhraseByLang(
            phrases: _phrasesByID,
            langCode: 'en',
        );
      }
      else {
        _phrase = searchFirstPhraseByLang(
            phrases: _phrasesByID,
            langCode: langCode,
        );
      }




      // _phrase = phrases.firstWhere((ph){
      //
      //   bool _found = false;
      //
      //   if (ph.id == id){
      //     _found = true;
      //   }
      //
      //   if (searchLangCode != null){
      //
      //     if (ph.langCode == searchLangCode){
      //       _found = true;
      //     }
      //     else {
      //       _found = false;
      //     }
      //
      //   }
      //
      //
      //   return _found;
      // });


    }

    return _phrase;
  }
// -------------------------------------
  /// BY LANG
// -----------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchPhrasesByLang({
    @required List<Phrase> phrases,
    @required String langCode,
  }){
    List<Phrase> _output = <Phrase>[];

    if (Mapper.checkCanLoopList(phrases) == true){
      _output = phrases.where((phr) => phr?.langCode == langCode).toList();
    }

    return _output;
  }
// -----------------
  /// TESTED : WORKS PERFECT
  static Phrase searchFirstPhraseByCurrentLang({
    @required BuildContext context,
    @required List<Phrase> phrases,
  }) {

    /// NOTE : Searches list of phrases of different lang codes by current lang code

    final String _currentLanguageCode = Words.languageCode(context);
    Phrase _phrase;

    if (Mapper.checkCanLoopList(phrases)){
      _phrase = searchFirstPhraseByLang(
        phrases: phrases,
        langCode: _currentLanguageCode,
      );

      _phrase ??= searchFirstPhraseByLang(
        phrases: phrases,
        langCode: 'en',
      );
    }

    return _phrase;
  }
// -----------------
  /// TESTED : WORKS PERFECT
  static Phrase searchFirstPhraseByLang({
    @required List<Phrase> phrases,
    @required String langCode,
  }){

    Phrase _phrase;

    if (Mapper.checkCanLoopList(phrases) == true) {

      _phrase = phrases.firstWhere(
              (Phrase phrase) => phrase.langCode == langCode,
          orElse: () => null
      );


    }

    return _phrase;
  }
// -------------------------------------
  /// BY VALUE / TRIGRAM ( SEARCH )
// -----------------
  static Phrase searchPhraseByIdenticalValue({
    @required List<Phrase> phrases,
    @required String value,
  }){
    Phrase _phrase;

    if (Mapper.checkCanLoopList(phrases) == true && Stringer.checkStringIsNotEmpty(value) == true){

      for (final Phrase phrase in phrases){

        if (phrase.value == value){
          _phrase = phrase;
          break;
        }

      }

    }

    return _phrase;
  }
// -----------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchPhrasesRegExp({
    @required List<Phrase> phrases,
    @required String text,
    bool lookIntoIDs = true,
    bool lookIntoValues = false,
  }){
    final List<Phrase> _result = <Phrase>[];

    if (Mapper.checkCanLoopList(phrases) && text.isNotEmpty){

      if (lookIntoIDs == true){

        final List<Phrase> _byID = phrases.where((ph){

          return
            TextChecker.stringContainsSubStringRegExp(
              string: ph.id,
              subString: text,
            ) == true;

        }).toList();

        _result.addAll(_byID);
      }

      if (lookIntoValues == true){

        final List<Phrase> _byValue = phrases.where((ph){

          return
            TextChecker.stringContainsSubStringRegExp(
              string: ph.value,
              subString: text,
            ) == true;

        }).toList();

        _result.addAll(_byValue);
      }

    }

    // blog('found those phrases');
    // Phrase.blogPhrases(_result,);

    return cleanIdenticalPhrases(_result);
  }
// -----------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchPhrasesTrigrams({
    @required List<Phrase> sourcePhrases,
    @required String inputText,
  }){
    final List<Phrase> _foundPhrases = <Phrase>[];
    final String _fixedString = TextMod.fixCountryName(inputText);

    for (final Phrase source in sourcePhrases){

      final List<String> _trigram = source?.trigram;

      final bool _trigramContains = Stringer.checkStringsContainString(
          strings: _trigram,
          string: _fixedString
      );

      if (_trigramContains == true){
        _foundPhrases.add(source);
      }

    }

    return _foundPhrases;
  }
// -----------------------------------------------------------------------------

  /// SYMMETRY

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> symmetrizePhrase({
    @required Phrase phrase,
    @required List<Phrase> allMixedPhrases,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (phrase != null && Mapper.checkCanLoopList(allMixedPhrases) == true){
      if (phrase.langCode != null){

        final String _secondLang = phrase.langCode == 'en' ? 'ar' : 'en';

        final Phrase _otherLangPhrase = searchPhraseByIDAndLangCode(
          phrases: allMixedPhrases,
          phid: phrase.id,
          langCode: _secondLang,
        );

        if (_otherLangPhrase != null){
          _output.addAll(<Phrase>[
            phrase,
            _otherLangPhrase,
          ]);
        }

      }
    }

    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> symmetrizePhrases({
    @required List<Phrase> phrasesToSymmetrize,
    @required List<Phrase> allMixedPhrases,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Mapper.checkCanLoopList(phrasesToSymmetrize) == true){

      for (final Phrase phrase in phrasesToSymmetrize){

        final List<Phrase> _pair = symmetrizePhrase(
            phrase: phrase,
            allMixedPhrases: allMixedPhrases
        );

        if (Mapper.checkCanLoopList(_pair) == true){
          _output.addAll(_pair);
        }

      }

    }

    return cleanIdenticalPhrases(_output);
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkPhrasesIncludeIdenticalPhrase({
    @required List<Phrase> phrases,
    @required Phrase firstPhrase,
  }){
    bool _include = false;

    if (Mapper.checkCanLoopList(phrases) == true && firstPhrase != null){

      for (final Phrase secondPhrase in phrases){

        final bool _found =
            firstPhrase?.id == secondPhrase?.id
                &&
                firstPhrase?.value == secondPhrase?.value
                &&
                firstPhrase?.langCode == secondPhrase?.langCode;

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
  static bool checkPhrasesIncludeValueForThisLanguage({
    @required List<Phrase> phrases,
    @required String langCode,
  }){

    bool _phraseInclude = false;

    if (Mapper.checkCanLoopList(phrases)){

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
  /// TESTED : WORKS PERFECT
  static bool checkPhrasesIncludeThisID({
    @required List<Phrase> phrases,
    @required String id,
  }){
    bool _include = false;

    if (Mapper.checkCanLoopList(phrases) == true && Stringer.checkStringIsNotEmpty(id) == true){

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
  static bool checkPhrasesIncludeThisValue({
    @required List<Phrase> phrases,
    @required String value,
  }){
    bool _include = false;

    if (Mapper.checkCanLoopList(phrases) == true && Stringer.checkStringIsNotEmpty(value) == true){

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
  static bool checkPhrasesAreIdentical({
    @required Phrase phrase1,
    @required Phrase phrase2,
  }){

    bool _areIdentical = false;

    if (phrase1 != null && phrase2 != null){

      if (phrase1.langCode == phrase2.langCode){

        if (phrase1.value == phrase2.value){

          if (Mapper.checkListsAreIdentical(list1: phrase1.trigram, list2: phrase2.trigram)){

            _areIdentical = true;

          }

        }

      }

    }

    return _areIdentical;
  }
// -------------------------------------
  /// TASK : TEST THIS
  static bool phrasesListsAreIdentical({
    @required List<Phrase> phrases1,
    @required List<Phrase> phrases2,
  }){

    bool _listsAreIdentical = false;

    if (Mapper.checkCanLoopList(phrases1) && Mapper.checkCanLoopList(phrases2)){

      if (phrases1.length == phrases2.length){

        final List<String> codes = _getLingCodesFromPhrases(phrases1);

        bool _allLangCodesAreIdentical = true;

        for (final String langCode in codes){

          final String _value1 = searchFirstPhraseByLang(
            phrases: phrases1,
            langCode: langCode,
          )?.value;

          final String _value2 = searchFirstPhraseByLang(
            phrases: phrases2,
            langCode: langCode,
          )?.value;

          if (_value1 == _value2){

            _allLangCodesAreIdentical = true;

          }

          else {
            _allLangCodesAreIdentical = false;
            break;
          }

        }

        if (_allLangCodesAreIdentical == true){
          _listsAreIdentical = true;
        }

      }

    }

    return _listsAreIdentical;
  }
// -------------------------------------
  static bool isKeywordPhid(String phid){
    final String _phidK = TextMod.removeAllCharactersAfterNumberOfCharacters(
      input: phid,
      numberOfChars: 7, //'ph id _k_'
    );
    return _phidK == 'phid_k_';
  }
// -------------------------------------
  static bool isSpecPhid(String phid){
    final String _phids = TextMod.removeAllCharactersAfterNumberOfCharacters(
      input: phid,
      numberOfChars: 7, //'phid_s_'
    );
    return _phids == 'phid_s_';
  }

// -----------------------------------------------------------------------------

  /// SORTING

// -------------------------------------
  static List<Phrase> sortNamesAlphabetically(List<Phrase> phrases){

    if (Mapper.checkCanLoopList(phrases)){
      phrases.sort((Phrase a, Phrase b) => a.value.compareTo(b.value));
    }

    return phrases;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> sortPhrasesByID({
    @required List<Phrase> phrases,
  }){

    if (Mapper.checkCanLoopList(phrases)){
      phrases.sort((Phrase a, Phrase b) => a.id.compareTo(b.id));
    }

    return phrases;
  }
// -----------------------------------------------------------------------------

  /// INSERT

// -------------------------------------
  /// TESTED : WORKS PERFECT
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

    if (Stringer.checkStringIsNotEmpty(addLanguageCode)){
      _phraseToInsert = Phrase(
        id: phrase.id,
        value: phrase.value,
        langCode: addLanguageCode,
        trigram: phrase.trigram,
      );
    }

    if (phrases != null && phrase != null){

      final bool _idIsTaken = checkPhrasesIncludeThisID(
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

    // blog('after adding one phrase : ${phrase.id} ,, this list is :-');
    // blogPhrases(_output);

    /// if (_output.isEmpty || _existingPhraseIndex == -1){
    ///   return null;
    /// }
    /// else {
    return _output;
    /// }

  }
// -------------------------------------
  /// TASK :DOES NOT WORK GOOD THIS BITCH
  static List<Phrase> insertPhrases({
    @required List<Phrase> insertIn,
    @required List<Phrase> phrasesToInsert,
    @required bool forceUpdate,
    String addLanguageCode,
    bool allowDuplicateIDs,
  }){

    List<Phrase> _output = <Phrase>[];

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
  /// TASK :DOES NOT WORK GOOD THIS BITCH
  static List<Phrase> _combinePhrasesListsAndAllowDuplicateIDs({
    @required List<Phrase> insertIn,
    @required List<Phrase> phrasesToInsert,
    String addLanguageCodeToInsertedPhrases,
  }){

    final List<Phrase> _output = <Phrase>[];

    if (Mapper.checkCanLoopList(insertIn) == true){
      _output.addAll(insertIn);
    }

    if (Mapper.checkCanLoopList(phrasesToInsert) == true){

      List<Phrase> _phrasesToInsert = <Phrase>[...phrasesToInsert];

      if (Stringer.checkStringIsNotEmpty(addLanguageCodeToInsertedPhrases) == true){
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
  /// TASK :DOES NOT WORK GOOD THIS BITCH
  static List<Phrase> _addLangCodeToPhrases({
    @required String langCode,
    @required List<Phrase> phrases,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Mapper.checkCanLoopList(phrases) == true){

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
// -------------------------------------
  /// TASK :DOES NOT WORK GOOD THIS BITCH
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

    if (Mapper.checkCanLoopList(phrasesToInsert) == true){

      for (final Phrase phrase in phrasesToInsert){

        _output = insertPhrase(
          phrases: _output,
          phrase: phrase,
          forceUpdateDuplicate: forceUpdate,
          addLanguageCode: addLanguageCode,
        );

      }

    }

    // blog('_combinePhrasesWithoutDuplicateIDs : output phrases inserted are : ${_output.length} phrases ');
    // Phrase.blogPhrases(_output);

    return _output;

  }
// -----------------------------------------------------------------------------

  /// CLEANING

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> cleanIdenticalPhrases(List<Phrase> phrases){
    final List<Phrase> _output = <Phrase>[];

    if (Mapper.checkCanLoopList(phrases) == true){

      for (final Phrase firstPhrase in phrases){

        final bool _contains = checkPhrasesIncludeIdenticalPhrase(
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
  /// TESTED : WORKS PERFECT
  static List<Phrase> cleanDuplicateIDs({
    @required List<Phrase> phrases,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Mapper.checkCanLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        final bool _contains = checkPhrasesIncludeThisID(
            phrases: _output,
            id: phrase.id
        );

        if (_contains == false){
          _output.add(phrase);
        }

      }

    }

    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> removeTrigramsFromPhrases(List<Phrase> phrases){
    final List<Phrase> _output = <Phrase>[];

    if (Mapper.checkCanLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        final Phrase _cleaned = Phrase(
          id: phrase.id,
          value: phrase.value,
          langCode: phrase.langCode,
        );

        _output.add(_cleaned);

      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// DELETING

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> deletePhidFromPhrases({
    @required List<Phrase> phrases,
    @required String phid,
  }){

    List<Phrase> _output = <Phrase>[];

    if (
    Mapper.checkCanLoopList(phrases) == true
        &&
        Stringer.checkStringIsNotEmpty(phid) == true
    ){

      _output = <Phrase>[...phrases];

      for (int i = 0; i< phrases.length; i++){

        if (phrases[i].id == phid){
          // _output.removeAt(i);
          _output.remove(phrases[i]);
          // blog('deletePhidFromPhrases : deleted : $i : id  ${phrases[i].id} : ${phrases[i].value} : lang : ${phrases[i].langCode}');
        }

      }

    }

    // blog('deletePhidFromPhrases : list had ${phrases.length} : but now has : ${_output.length} phrases');

    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> onlyIncludeIDAndValue({
    @required List<Phrase> phrases,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Mapper.checkCanLoopList(phrases) == true){

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
  /// TESTED : WORKS PERFECT
  static List<String> _getTrigramIfIncluded({
    @required bool includeTrigram,
    @required List<String> existingTrigram,
    @required String originalString,
  }){
    List<String> _output;

    if (includeTrigram == true){

      final bool _hasExitingOne = Mapper.checkCanLoopList(existingTrigram);

      if (_hasExitingOne == true){
        _output = existingTrigram;
      }
      else {
        _output = Stringer.createTrigram(input: originalString);
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
    bool includeChainsIDs = true,
  }){

    final List<Phrase> _keywordsPhrases = <Phrase>[];

    for (final Phrase phrase in allPhrases){

      final bool _isKeyword = isKeywordPhid(phrase.id);

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

      final bool _isSpec = isSpecPhid(phrase.id);

      if (_isSpec == true){
        _specsIDs.add(phrase);
      }

    }

    final List<String> _specsPhraseIDs = getPhrasesIDs(_specsIDs);

    return _specsPhraseIDs;
  }
// -------------------------------------
}
