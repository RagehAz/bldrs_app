import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/c_protocols/phrase_protocols/phrase_protocols.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
// ---------------------------------------------------------------------------

/// SEARCH

// -----------------------------
///  TESTED : WORKS PERFECT
void onPhrasesSearchChanged({
  @required ValueNotifier<bool> isSearching,
  @required TextEditingController searchController,
  @required List<Phrase> allMixedPhrases,
  @required ValueNotifier<List<Phrase>> mixedSearchResult,
}){

  TextChecker.triggerIsSearchingNotifier(
    text: searchController.text,
    isSearching: isSearching,
  );

  if (isSearching.value == true){

    _onSearchPhrases(
      allMixedPhrases: allMixedPhrases,
      isSearching: isSearching,
      mixedSearchResult: mixedSearchResult,
      searchController: searchController,
    );

  }

}
// -----------------------------
///  TESTED : WORKS PERFECT
void onPhrasesSearchSubmit({
  @required ValueNotifier<bool> isSearching,
  @required TextEditingController searchController,
  @required List<Phrase> allMixedPhrases,
  @required ValueNotifier<List<Phrase>> mixedSearchResult,
}){

  isSearching.value = true;

  _onSearchPhrases(
    allMixedPhrases: allMixedPhrases,
    isSearching: isSearching,
    mixedSearchResult: mixedSearchResult,
    searchController: searchController,
  );

}
// -----------------------------
///  TESTED : WORKS PERFECT
void _onSearchPhrases({
  @required ValueNotifier<bool> isSearching,
  @required TextEditingController searchController,
  @required List<Phrase> allMixedPhrases,
  /// mixes between en & ar values in one list
  @required ValueNotifier<List<Phrase>> mixedSearchResult,
}){

  if (isSearching.value == true){

    List<Phrase> _foundPhrases = <Phrase>[];

    // final List<Phrase> _enResults = Phrase.searchPhrases(
    //   phrases: enPhrase,
    //   text: searchController.text,
    //   byValue: true,
    // );
    //
    // blog('onSearchPhrases : _enResults = $_enResults');

    // final List<Phrase> _result
    _foundPhrases = Phrase.searchPhrases(
      phrases: allMixedPhrases,
      text: searchController.text,
      byValue: true,
      // byID: true,
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

    // blog('onSearchPhrases : _foundPhrases.length = ${_foundPhrases.length} after adding ar');

    // blog('mixed phrase are : ');
    // Phrase.blogPhrases(_foundPhrases);

    final List<Phrase> _cleaned = Phrase.cleanIdenticalPhrases(_foundPhrases);

    // blog('onSearchPhrases : _foundPhrases.length = ${_foundPhrases.length} after cleaning');

    mixedSearchResult.value = _cleaned;

  }

  else {
    mixedSearchResult.value = <Phrase>[];
  }

}
// ---------------------------------------------------------------------------

/// MODIFIERS

// -----------------------------
/// EDIT - ADD
// --------------
Future<void> onTapEditPhrase({
  @required BuildContext context,
  @required String phraseID,
  @required List<Phrase> arPhrases,
  @required List<Phrase> enPhrases,
  @required PageController pageController,
  @required TextEditingController enTextController,
  @required TextEditingController arTextController,
  @required TextEditingController idTextController,
}) async {

  /// CLOSE BOTTOM DIALOG
  Nav.goBack(
    context: context,
    invoker: 'onTapEditPhrase',
  );

  final Phrase _enPhrase = Phrase.getPhraseFromPhrasesByIDWithLangCode(
    phrases: enPhrases,
    id: phraseID,
  );

  final Phrase _arPhrase = Phrase.getPhraseFromPhrasesByIDWithLangCode(
    phrases: arPhrases,
    id: phraseID,
  );

  enTextController.text = _enPhrase.value;
  arTextController.text = _arPhrase.value;
  idTextController.text = _enPhrase.id;

  await Sliders.slideToNext(
    pageController: pageController,
    numberOfSlides: 2,
    currentSlide: 0,
  );

}
// --------------
Future<void> onConfirmEditPhrase({
  @required BuildContext context,
  @required ValueNotifier<List<Phrase>> tempMixedPhrases,
  @required Phrase updatedEnPhrase,
  @required Phrase updatedArPhrase,
}) async {

  final bool _canContinue = await _preUploadCheck(
    context: context,
    arOldPhrases: Phrase.getPhrasesByLangFromPhrases(phrases: tempMixedPhrases.value, langCode: 'ar'),
    enOldPhrases: Phrase.getPhrasesByLangFromPhrases(phrases: tempMixedPhrases.value, langCode: 'en'),
    arValue: updatedArPhrase.value,
    enValue: updatedEnPhrase.value,
    phraseID: updatedEnPhrase.id,
  );

  if (_canContinue == true){

    List<Phrase> _output = tempMixedPhrases.value;

    /// REMOVE OLD PHRASES IF EXISTED
    final bool _idExists = Phrase.phrasesIncludeThisID(
        phrases: tempMixedPhrases.value,
        id: updatedArPhrase.id,
    );
    if (_idExists == true){
      _output = Phrase.deletePhidFromPhrases(
          phrases: _output,
          phid: updatedArPhrase.id,
      );
    }

    /// ADD UPDATED PHRASES
    _output = Phrase.insertPhrases(
      insertIn: tempMixedPhrases.value,
      phrasesToInsert: <Phrase>[updatedEnPhrase, updatedArPhrase],
      allowDuplicateIDs: true,
      forceUpdate: false,
    );

    tempMixedPhrases.value = _output;

    await TopDialog.showSuccessDialog(
      context: context,
      firstLine: 'Phrases Updated',
    );

  }

}
// --------------
Future<bool> _preUploadCheck({
  @required List<Phrase> arOldPhrases,
  @required List<Phrase> enOldPhrases,
  @required String phraseID,
  @required String enValue,
  @required String arValue,
  @required BuildContext context,
}) async {

  bool _continueOps = true;

  /// INPUTS ARE INVALID
  if (
      Stringer.checkStringIsEmpty(phraseID) == true ||
      Stringer.checkStringIsEmpty(enValue) == true ||
      Stringer.checkStringIsEmpty(arValue) == true
  ){
    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Check inputs',
      body: 'The ID or one of the values is empty.',
      color: Colorz.red255,
    );

    _continueOps = false;
  }

  /// INPUTS ARE VALID
  else {

    String _alertMessage;
    bool _idIsTaken;
    bool _idIsTakenAr;
    bool _valueHasDuplicateEn;
    bool _valueHasDuplicateAr;
    Phrase _phrase;

    /// EN ID TAKEN
    _idIsTaken = Phrase.phrasesIncludeThisID(
      phrases: enOldPhrases,
      id: phraseID,
    );
    if (_idIsTaken == true){
      _phrase = Phrase.getPhraseFromPhrasesByIDWithLangCode(
        phrases: enOldPhrases,
        id: phraseID,

      );
      _alertMessage = 'ID is Taken : ${_phrase.id}\n: value : ${_phrase.value} : langCode : ${_phrase.langCode}';
    }

    /// AR ID TAKEN
    _idIsTakenAr = Phrase.phrasesIncludeThisID(
      phrases: arOldPhrases,
      id: phraseID,
    );
    if (_idIsTakenAr == true){
      _phrase = Phrase.getPhraseFromPhrasesByIDWithLangCode(
        phrases: arOldPhrases,
        id: phraseID,
      );
      _alertMessage = 'ID is Taken : ${_phrase.id}\n: value : ${_phrase.value} : langCode : ${_phrase.langCode}';
    }

    if (_idIsTakenAr == false && _idIsTaken == false){

      /// EN VALUE DUPLICATE
      _valueHasDuplicateEn = Phrase.phrasesIncludeThisValue(
        phrases: enOldPhrases,
        value: enValue,
      );
      if (_valueHasDuplicateEn == true){
        _phrase = Phrase.getPhraseFromPhrasesByValue(
          phrases: enOldPhrases,
          value: enValue,
        );
        _alertMessage = 'VALUE is Taken : ${_phrase.value}\nid : ${_phrase.id} : langCode : ${_phrase.langCode}';
      }

      /// EN VALUE DUPLICATE
      _valueHasDuplicateAr = Phrase.phrasesIncludeThisValue(
        phrases: arOldPhrases,
        value: arValue,
      );
      if (_valueHasDuplicateAr == true){
        _phrase = Phrase.getPhraseFromPhrasesByValue(
          phrases: arOldPhrases,
          value: arValue,
        );
        _alertMessage = 'VALUE is Taken : ${_phrase.value}\nid : ${_phrase.id} : langCode : ${_phrase.langCode}';
      }

    }

    // so ..

    if (_alertMessage != null){

      final String _actionTypeMessage =
      _idIsTaken == true || _idIsTakenAr == true ? 'This will override this Phrase'
          :
      _valueHasDuplicateAr == true || _valueHasDuplicateEn == true ? 'This will add New Phrase'
          :
      'This Will Upload';

      _continueOps = await CenterDialog.showCenterDialog(
        context: context,
        title: '7aseb !',
        boolDialog: true,
        body: '$_alertMessage\n'
            '$_actionTypeMessage\n'
            'Wanna continue uploading ?',
      );

    }

  }

  return _continueOps;
}
// -----------------------------
/// DELETE
// --------------
Future<void> onDeletePhrase({
  @required BuildContext context,
  @required String phraseID,
  @required ValueNotifier<List<Phrase>> tempMixedPhrases,
}) async {

  final bool _continue = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Bgad ?',
    boolDialog: true,
    body: 'Delete This Phrase ?'
        '\n\nPhid : $phraseID',
  );

  if (_continue == true){

    /// CLOSE BOTTOM DIALOG
    Nav.goBack(
      context: context,
      invoker: 'onDeletePhrase',
    );

    final List<Phrase> _result = Phrase.deletePhidFromPhrases(
        phrases: tempMixedPhrases.value,
        phid: phraseID
    );

    tempMixedPhrases.value = _result;

    await TopDialog.showSuccessDialog(
      context: context,
      firstLine: 'Phrase has been deleted',
    );


    /// old shit , delete this
    // final List<Phrase> _enPhrases = Phrase.deletePhidFromPhrases(
    //   phrases: enPhrases,
    //   phid: phraseID,
    // );
    //
    // final List<Phrase> _arPhrases = Phrase.deletePhidFromPhrases(
    //   phrases: arPhrases,
    //   phid: phraseID,
    // );
    //
    // final bool _enPhrasesListsAreTheSame = Phrase.phrasesListsAreIdentical(
    //   phrases1: _enPhrases,
    //   phrases2: enPhrases,
    // );
    //
    // final bool _arPhrasesAreTheSame = Phrase.phrasesListsAreIdentical(
    //   phrases1: _enPhrases,
    //   phrases2: arPhrases,
    // );
    //
    // if (_enPhrasesListsAreTheSame != true && _arPhrasesAreTheSame != true){
    //
    //   await PhraseOps.updatePhrases(
    //     context: context,
    //     enPhrases: _enPhrases,
    //     arPhrases: _arPhrases,
    //   );
    //
    // }
    //
    // else {
    //
    //   await CenterDialog.showCenterDialog(
    //     context: context,
    //     title: 'EH DAH !!',
    //     body: 'CAN NOT DELETE THIS\n id : $phraseID',
    //   );
    //
    // }

  }

}
// ---------------------------------------------------------------------------

/// SYNC

// ---------------------------------------------------------------------------
Future<void> onSyncPhrases({
  @required BuildContext context,
  @required ValueNotifier<List<Phrase>> tempMixedPhrases,
  @required ValueNotifier<List<Phrase>> initialMixedPhrases,
}) async {

  await PhraseProtocols.renovateMainPhrases(
    context: context,
    updatedMixedMainPhrases: tempMixedPhrases.value,
  );

  initialMixedPhrases.value = tempMixedPhrases.value;

  await TopDialog.showSuccessDialog(
    context: context,
    firstLine: 'Sync Successful',
  );

}
// -----------------------------
/*
Future<void> onUploadPhrases({
  @required List<Phrase> arOldPhrases,
  @required List<Phrase> enOldPhrases,
  @required List<Phrase> inputMixedLangPhrases,
  @required BuildContext context,
}) async {

  // int _count = 0;

  // final int _numberOfEnPhrases = enOldPhrases.length;
  // final int _numberOfArPhrases = arOldPhrases.length;
  // final int _numberOfInputMixedPhrases = inputMixedLangPhrases.length;

  // blog('onUploadPhrases : '
  //     'numberOfEnPhrases : $_numberOfEnPhrases : '
  //     'numberOfArPhrases : $_numberOfArPhrases : '
  //     'numberOfInputMixedPhrases : $_numberOfInputMixedPhrases'
  // );
  // blog('expected outcome = ${_numberOfArPhrases + (_numberOfInputMixedPhrases/2)}');

  final List<String> _mixedPhrasesIDs = Phrase.getPhrasesIDs(inputMixedLangPhrases);
  final List<String> _newPhrasesIDs = Stringer.cleanDuplicateStrings(strings: _mixedPhrasesIDs);

  // blog('_mixedPhrasesIDs.length : ${_mixedPhrasesIDs.length} : _newPhrasesIDs.length : ${_newPhrasesIDs.length}');

  for (final String _phid in _newPhrasesIDs){

    final Phrase _enPhrase = Phrase.getPhraseByIDAndLangCodeFromPhrases(
      phrases: inputMixedLangPhrases,
      phid: _phid,
      langCode: 'en',
    );

    final Phrase _arPhrase = Phrase.getPhraseByIDAndLangCodeFromPhrases(
      phrases: inputMixedLangPhrases,
      phid: _phid,
      langCode: 'ar',
    );

    await onUploadPhrase(
        arOldPhrases: arOldPhrases,
        enOldPhrases: enOldPhrases,
        context: context,
        phraseID: _phid,
        enValue: _enPhrase.value,
        arValue: _arPhrase.value,
    );

    // _count++;
    // blog('uploaded : $_phid and remaining ${_numberOfEnPhrases - _count}');

  }

}
 */
// -----------------------------
/*
Future<void> onUploadPhrase({
  @required List<Phrase> arOldPhrases,
  @required List<Phrase> enOldPhrases,
  @required BuildContext context,
  @required String phraseID,
  @required String enValue,
  @required String arValue,
}) async {

  final bool _continueOps = await _preUploadCheck(
    arOldPhrases: arOldPhrases,
    enOldPhrases: enOldPhrases,
    context: context,
    phraseID: phraseID,
    arValue: arValue,
    enValue: enValue,
  );

  if (_continueOps == true){


    final List<Phrase> _enPhrases = Phrase.insertPhrase(
      forceUpdateDuplicate: true,
      phrases: enOldPhrases,
      phrase: Phrase(
        id: phraseID,
        value: enValue,
      ),
    );

    // blog('4');

    final List<Phrase> _arPhrases = Phrase.insertPhrase(
      forceUpdateDuplicate: true,
      phrases: arOldPhrases,
      phrase: Phrase(
        id: phraseID,
        value: arValue,
      ),
    );

    // blog('5');

    if (_enPhrases == null || _arPhrases == null){

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Obaaaaa',
        body: 'Keda fi 7aga mesh mazboota \n could not upload or update',
      );

    }

    else {

      final bool _success = await PhraseOps.updatePhrases(
          context: context,
          enPhrases: _enPhrases,
          arPhrases: _arPhrases,
      );

      if (_success == true){
        await TopDialog.showTopDialog(
          context: context,
          firstLine: 'Added id :$phraseID',
          secondLine: '$enValue : $arValue',
        );
      }

      else {
        await TopDialog.showTopDialog(
          context: context,
          firstLine: 'Failed to add :$phraseID',
          secondLine: '$enValue : $arValue',
          color: Colorz.red255,
        );
      }

    }

  }

}
 */
// ---------------------------------------------------------------------------
/// DONE
/*
Future<void> _addWordsFromJSONToFirebaseForTheFirstTime({
  @required BuildContext context,
  @required List<Phrase> enOldPhrases,
  @required List<Phrase> arOldPhrases,
}) async {

  const List<String> _jsonIDs = superJSONWords;

  List<Phrase> _enPhrases = <Phrase>[
    ...enOldPhrases ?? []
  ];
  List<Phrase> _arPhrases = <Phrase>[
    ...arOldPhrases ?? []
  ];

  for (final String id in _jsonIDs){

    final Phrase _enPhrase = Phrase(
      id: 'phid_$id',
      value: await Localizer.getTranslationFromJSONByLangCode(
        context: context,
        jsonKey: id,
        langCode: 'en',
      ),
    );
    _enPhrases = Phrase.insertPhrase(
      phrases: _enPhrases,
      phrase: _enPhrase,
      forceUpdateDuplicate: true,
    );

    final Phrase _arPhrase = Phrase(
      id: 'phid_$id',
      value: await Localizer.getTranslationFromJSONByLangCode(
        context: context,
        jsonKey: id,
        langCode: 'ar',
      ),
    );
    _arPhrases = Phrase.insertPhrase(
      phrases: _arPhrases,
      phrase: _arPhrase,
      forceUpdateDuplicate: true,
    );

  }

  await updateDocField(
    context: context,
    collName: FireColl.translations,
    docName: 'en',
    field: 'phrases',
    input: Phrase.cipherPhrases(phrases: _enPhrases),
  );

  await updateDocField(
    context: context,
    collName: FireColl.translations,
    docName: 'ar',
    field: 'phrases',
    input:  Phrase.cipherPhrases(phrases: _arPhrases),
  );

}
// -----------------------------
Future<void> _onAddKeywordsToOriginalPhrases({
  @required BuildContext context,
  @required List<Phrase> originalEnPhrases,
  @required List<Phrase> originalArPhrases,
}) async {

  const String _docName = FireDoc.keys_propertiesKeywords; // <----------------------

  final Map<String, dynamic> _docMap = await readDoc(
    context: context,
    collName: FireColl.keys,
    docName: _docName,
  );


  final List<String> _keys = _docMap.keys.toList();

  final List<Phrase> _enPhrasesToAdd = <Phrase>[];
  final List<Phrase> _arPhrasesToAdd = <Phrase>[];
  final List<String> _keywordsIDs = <String>[];

  for (final String key in _keys){

    final Map<String, dynamic> _keywordMap = _docMap[key];
    final String _keywordID = 'phid_k_${_keywordMap['id']}';

    final Phrase _enPhrase = Phrase(
      id: _keywordID,
      value: _keywordMap['names']['en']['value'],
    );

    final Phrase _arPhrase = Phrase(
      id: _keywordID,
      value: _keywordMap['names']['ar']['value'],
    );

    _enPhrasesToAdd.add(_enPhrase);
    _arPhrasesToAdd.add(_arPhrase);
    _keywordsIDs.add(_keywordID);
  }

  final List<Phrase> _enResult = <Phrase>[...originalEnPhrases, ..._enPhrasesToAdd];
  final List<Phrase> _arResult = <Phrase>[...originalArPhrases, ..._arPhrasesToAdd];

  /// update english translations
  await updateDocField(
    context: context,
    collName: FireColl.translations,
    docName: 'en',
    field: 'phrases',
    input: Phrase.cipherPhrases(phrases: _enResult),
  );

  /// update arabic translations
  await updateDocField(
    context: context,
    collName: FireColl.translations,
    docName: 'ar',
    field: 'phrases',
    input: Phrase.cipherPhrases(phrases: _arResult),
  );

  await updateDocField(
    context: context,
    collName: FireColl.keys,
    docName: 'keywords',
    field: _docName,
    input: _keywordsIDs,
  );

  Phrase.blogPhrases(_enResult);
  Phrase.blogPhrases(_arResult);
  blog('number of keywords = ${_keys.length} + ${originalEnPhrases.length} existing = ${_keys.length + originalEnPhrases.length} TOTAL');
  blog('final list is ${_enResult.length} english : ${_arResult.length} arabic');

}
// -----------------------------
*/
// ---------------------------------------------------------------------------
