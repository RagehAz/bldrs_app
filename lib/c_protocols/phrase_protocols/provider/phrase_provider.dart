/// DEPRECATED
/*
//---------------------
String? word(String? phid){

  final String? id = Phider.removeIndexFromPhid(phid: phid);

  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(getMainContext(), listen: false);
  _phraseProvider.addToUsedXPhrases(id);

  /// THE ( # # ) VERSES
  if (Verse.checkPendingAssigningPhid(id) == true){
    return null;
  }

  /// THE PHID VERSES
  else {

     String? _translation = _phraseProvider.translatePhid(id);

    if (_translation == null){
      _phraseProvider.addToPhidsPendingTranslation(id ?? phid);
      _translation = '^^$phid';
    }

    return _translation;
  }

}
//---------------------
List<String> words(List<String> phids){
  final List<String> _output = <String>[];

  if (Lister.checkCanLoopList(phids) == true){

    for (final String phid in phids){
      final String? _trans = word(phid);
      if (_trans != null){
        _output.add(_trans);
      }
    }

  }
  return _output;



}
  // -----------------------------------------------------------------------------

  /// CURRENT LANGUAGE

  // --------------------
  String _currentLangCode = 'en';
  String get currentLangCode => _currentLangCode;
  // --------------------
  // /// TESTED : WORKS PERFECT
  // static String proGetCurrentLangCode({
  //   required BuildContext context,
  //   required bool listen,
  // }){
  //   final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: listen);
  //   return _phraseProvider._currentLangCode;
  // }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> getSetCurrentLangCode({
    required bool notify,
    String? setLangCode,
  }) async {

    /// A. DETECT DEVICE LANGUAGE
    final String _langCode = setLangCode ?? Localizer.getCurrentLangCode();

    /// C. SET CURRENT LANGUAGE
    _setCurrentLanguage(
      code: _langCode,
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setCurrentLanguage({
    required String code,
    required bool notify,
  }){

    _currentLangCode = code;

    if (notify == true){
      notifyListeners();
    }

  }


   // -----------------------------------------------------------------------------

  /// PHIDS WAITING TRANSLATION

  // --------------------
  List<String> _phidsPendingTranslation = <String>[];
  List<String> get phidsPendingTranslation => _phidsPendingTranslation;
  // --------------------
  static List<String> proGetPhidsPendingTranslation({
    required BuildContext context,
    required bool listen,
  }){
    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: listen);
    return _phraseProvider.phidsPendingTranslation;
  }
  // --------------------
  void addToPhidsPendingTranslation(String? id){

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

    if (Lister.checkCanLoopList(_phidsPendingTranslation) == true){

      for (final String phid in _phidsPendingTranslation){

        final String? _word = translatePhid(phid);

        if (_word != null){
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
    required List<String> setTo,
    required bool notify,
  }){

    blog('setPhidsPendingTranslation : setTO : $setTo');

    _phidsPendingTranslation = setTo;
    if (notify == true){
      notifyListeners();
    }

  }

    // -----------------------------------------------------------------------------

  /// USED X PHRASES => for dev only

  // --------------------
  List<String> _usedXPhrases = <String>[];
  List<String> get usedXPhrases => _usedXPhrases;
  // --------------------
  void addToUsedXPhrases(String? id){

    _usedXPhrases = Stringer.addStringToListIfDoesNotContainIt(
      strings: _usedXPhrases,
      stringToAdd: id,
    );

    // do not notifyListeners,, I will read it manually later

  }
  // -----------------------------------------------------------------------------

  /// BASIC PHRASES (keywords phids 'phid_k_' / specs phids 'phid_s_' / general phids 'phid_' )

  // --------------------
  // /// does not include trigrams : used for superPhrase translating method only not for search engines
  // List<Phrase> _mainPhrases = <Phrase>[];
  // List<Phrase> get mainPhrases  => _mainPhrases;
  // // --------------------
  // /// TESTED : WORKS PERFECT
  // Future<void> fetchSetMainPhrases({
  //   required bool notify,
  // }) async {
  //
  //   // blog('X1- fetchSetMainPhrases : START');
  //
  //   /// phrases received from the fetch include trigrams "that was stored in LDB"
  //   final List<Phrase> _phrases = await PhraseProtocols.fetchMainMixedLangPhrases();
  //
  //   // blog('X3- fetchSetMainPhrases : MAIN _phrases : ${_phrases.length}');
  //
  //   setMainPhrases(
  //     setTo: _phrases,
  //     notify: notify,
  //   );
  //
  //   // blog('X3- fetchSetMainPhrases : END');
  //
  // }
  // // --------------------
  // /// TESTED : WORKS PERFECT
  // void setMainPhrases({
  //   required List<Phrase> setTo,
  //   required bool notify,
  // }){
  //
  //   /// NOTE : FILTERS GIVEN PHRASES AS PER CURRENT LANG + REMOVE TRIGRAMS
  //
  //   if (Lister.checkCanLoopList(setTo) == true){
  //
  //     /// FILTER BY LANG
  //     final List<Phrase> _phrasesByLang = Phrase.searchPhrasesByLang(
  //       phrases: setTo,
  //       langCode: Localizer.getCurrentLangCode(),
  //     );
  //
  //     /// REMOVE TRIGRAMS
  //     final List<Phrase> _cleaned = Phrase.removeTrigramsFromPhrases(_phrasesByLang);
  //
  //     /// SET
  //     _mainPhrases = _cleaned;
  //
  //     /// NOTIFY
  //     if (notify == true){
  //       notifyListeners();
  //     }
  //
  //   }
  //
  // }
  // // --------------------
  // /// TESTED : WORKS PERFECT
  // String? translatePhid(String? phid){
  //
  //   String? _translation;
  //
  //   if (Lister.checkCanLoopList(_mainPhrases) == true && phid != null){
  //
  //     final Phrase? _phrase = _mainPhrases.firstWhereOrNull(
  //             (phrase) => phrase.id == phid,
  //     );
  //
  //     if (_phrase != null && _phrase.value?.toLowerCase() != 'null'){
  //       _translation = _phrase.value;
  //     }
  //   }
  //
  //   return _translation;
  // }
  // // --------------------
  // /// TESTED : WORKS PERFECT
  // static bool proGetPhidsAreLoaded(){
  //   final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(getMainContext(), listen: false);
  //   return _phraseProvider.mainPhrases.isNotEmpty;
  // }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static void wipeOut({
    required bool notify,
  }){

    /*
        String _currentLangCode = 'en';
        List<Phrase> _mainPhrases = <Phrase>[];
        List<String> _usedXPhrases = <String>[];
        List<String> _phidsPendingTranslation = <String>[];
     */

    // final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(getMainContext(), listen: false);
    //
    // /// _basicPhrases
    // _phraseProvider.setMainPhrases(
    //     setTo: <Phrase>[],
    //     notify: notify
    // );

  }
  // -----------------------------------------------------------------------------

 */
