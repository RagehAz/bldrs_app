import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/old_phrase_editor/phrase_fire_ops.dart' as PhraseOps;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
// ---------------------------------------------------------------------------

/// SEARCH

// -----------------------------
void onSearchPhrases({
  @required String text,
  @required ValueNotifier<bool> isSearching,
  @required TextEditingController searchController,
  @required List<Phrase> enPhrase,
  @required List<Phrase> arPhrases,
  /// mixes between en & ar values in one list
  @required ValueNotifier<List<Phrase>> mixedSearchResult,
  bool forceSearch = false,
}){

  blog('onSearchPhrases : ');

  isSearching.value = TextChecker.triggerIsSearching(
    text: searchController.text,
    isSearching: isSearching.value,
    minCharLimit: forceSearch ? 1 : Standards.minSearchChar,
  );

  blog('onSearchPhrases : isSearching.value : ${isSearching.value}');

  if (isSearching.value == true){

    blog('onSearchPhrases : isSearching.value == true');


    List<Phrase> _foundPhrases = <Phrase>[];

    final List<Phrase> _enResults = Phrase.searchPhrases(
      phrases: enPhrase,
      text: searchController.text,
      byValue: true,
    );

    blog('onSearchPhrases : _enResults = $_enResults');

    final List<Phrase> _arResults = Phrase.searchPhrases(
      phrases: arPhrases,
      text: searchController.text,
      byValue: true,
    );

    blog('onSearchPhrases : _arResults = $_arResults');

    _foundPhrases = Phrase.insertPhrases(
      insertIn: _foundPhrases,
      phrasesToInsert: _enResults,
      forceUpdate: false,
      addLanguageCode: 'en',
      allowDuplicateIDs: false,
    );

    blog('onSearchPhrases : _foundPhrases.length = ${_foundPhrases.length} after adding en');

    _foundPhrases = Phrase.insertPhrases(
      insertIn: _foundPhrases,
      phrasesToInsert: _arResults,
      forceUpdate: false,
      addLanguageCode: 'ar',
      allowDuplicateIDs: false,
    );

    blog('onSearchPhrases : _foundPhrases.length = ${_foundPhrases.length} after adding ar');

    // blog('mixed phrase are : ');
    // Phrase.blogPhrases(_foundPhrases);

    final List<Phrase> _cleaned = Phrase.cleanIdenticalPhrases(_foundPhrases);

    blog('onSearchPhrases : _foundPhrases.length = ${_foundPhrases.length} after cleaning');

    mixedSearchResult.value = _cleaned;

  }

  else {
    mixedSearchResult.value = <Phrase>[];
  }

}
// ---------------------------------------------------------------------------

/// PHRASE EDITOR

// -----------------------------
void onClearText(TextEditingController controller){
  controller.text = '';
}
// -----------------------------
Future<void> onPasteText(TextEditingController controller) async {
  final String value = await FlutterClipboard.paste();
  controller.text = value;
}
// -----------------------------
Future<void> onCopyText(BuildContext context, String value) async {
  await Keyboard.copyToClipboard(
    context: context,
    copy: value,
  );
}
// ---------------------------------------------------------------------------

/// FIRE OPS

// -----------------------------
Future<bool> _preUploadCheck({
  @required List<Phrase> arOldPhrases,
  @required List<Phrase> enOldPhrases,
  @required String phraseID,
  @required String enValue,
  @required String arValue,
  @required BuildContext context,
}) async {

  bool _continueOps = true;
  String _alertMessage;
  bool _idIsTakenEn;
  bool _idIsTakenAr;
  bool _valueHasDuplicateEn;
  bool _valueHasDuplicateAr;
  Phrase _phrase;

  /// EN ID TAKEN
  _idIsTakenEn = Phrase.phrasesIncludeThisID(
    phrases: enOldPhrases,
    id: phraseID,
  );
  if (_idIsTakenEn == true){
    _phrase = Phrase.getPhraseFromPhrasesByID(
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
    _phrase = Phrase.getPhraseFromPhrasesByID(
      phrases: arOldPhrases,
      id: phraseID,
    );
    _alertMessage = 'ID is Taken : ${_phrase.id}\n: value : ${_phrase.value} : langCode : ${_phrase.langCode}';
  }

  if (_idIsTakenAr == false && _idIsTakenEn == false){

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
    _idIsTakenEn == true || _idIsTakenAr == true ? 'This will override this Phrase'
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

  return _continueOps;
}
// -----------------------------
Future<void> onUploadPhrases({
  @required List<Phrase> arOldPhrases,
  @required List<Phrase> enOldPhrases,
  @required List<Phrase> inputMixedLangPhrases,
  @required BuildContext context,
}) async {

  int _count = 0;

  final int _numberOfEnPhrases = enOldPhrases.length;
  final int _numberOfArPhrases = arOldPhrases.length;
  final int _numberOfInputMixedPhrases = inputMixedLangPhrases.length;

  blog('onUploadPhrases : '
      'numberOfEnPhrases : $_numberOfEnPhrases : '
      'numberOfArPhrases : $_numberOfArPhrases : '
      'numberOfInputMixedPhrases : $_numberOfInputMixedPhrases'
  );
  blog('expected outcome = ${_numberOfArPhrases + (_numberOfInputMixedPhrases/2)}');

  final List<String> _mixedPhrasesIDs = Phrase.getPhrasesIDs(inputMixedLangPhrases);
  final List<String> _newPhrasesIDs = Stringer.cleanDuplicateStrings(strings: _mixedPhrasesIDs);

  blog('_mixedPhrasesIDs.length : ${_mixedPhrasesIDs.length} : _newPhrasesIDs.length : ${_newPhrasesIDs.length}');

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

    _count++;
    blog('uploaded : $_phid and remaining ${_numberOfEnPhrases - _count}');

  }

}
// -----------------------------
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
// -----------------------------
Future<void> onDeletePhrase({
  @required String phraseID,
  @required List<Phrase> arPhrases,
  @required List<Phrase> enPhrases,
  @required BuildContext context,
}) async {

  final bool _continue = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Bgad ?',
    body: 'Delete This Phras ?\nID : $phraseID',
    boolDialog: true,
  );

  if (_continue == true){

    final List<Phrase> _enPhrases = Phrase.deletePhraseFromPhrases(
      phrases: enPhrases,
      phraseID: phraseID,
    );

    final List<Phrase> _arPhrases = Phrase.deletePhraseFromPhrases(
      phrases: arPhrases,
      phraseID: phraseID,
    );

    final bool _enPhrasesListsAreTheSame = Phrase.phrasesListsAreIdentical(
      phrases1: _enPhrases,
      phrases2: enPhrases,
    );

    final bool _arPhrasesAreTheSame = Phrase.phrasesListsAreIdentical(
      phrases1: _enPhrases,
      phrases2: arPhrases,
    );

    if (_enPhrasesListsAreTheSame != true && _arPhrasesAreTheSame != true){

      await PhraseOps.updatePhrases(
        context: context,
        enPhrases: _enPhrases,
        arPhrases: _arPhrases,
      );

    }

    else {

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'EH DAH !!',
        body: 'CAN NOT DELETE THIS\n id : $phraseID',
      );

    }

  }

}
// -----------------------------
Future<void> onEditPhrase({
  @required BuildContext context,
  @required String phraseID,
  @required List<Phrase> arPhrases,
  @required List<Phrase> enPhrases,
  @required PageController pageController,
  @required TextEditingController enTextController,
  @required TextEditingController arTextController,
  @required TextEditingController idTextController,
}) async {

  Nav.goBack(
    context: context,
    invoker: 'onEditPhrase',
  );

  final Phrase _enPhrase = Phrase.getPhraseFromPhrasesByID(
    phrases: enPhrases,
    id: phraseID,
  );

  final Phrase _arPhrase = Phrase.getPhraseFromPhrasesByID(
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
// ---------------------------------------------------------------------------
/// DANGEROUS
/*
Future<void> _createNewTransModel({
  @required BuildContext context,
  @required String enDocName,
  @required String arDocName,
}) async {

  // if (enDocName != 'en' && arDocName != 'ar'){

  const TransModel _enModel = TransModel(
    langCode: 'en',
    phrases: [
      Phrase(id: 'phid_inTheNameOfAllah', value: 'In the name of Allah'),
    ],
  );

  const TransModel _arModel = TransModel(
    langCode: 'ar',
    phrases: [
      Phrase(id: 'phid_inTheNameOfAllah', value: 'بسم اللّه الرحمن الرحيم'),
    ],
  );

  await createNamedDoc(
    context: context,
    collName: FireColl.translations,
    docName: enDocName,
    input: _enModel.toMap(),
  );

  await createNamedDoc(
    context: context,
    collName: FireColl.translations,
    docName: arDocName,
    input: _arModel.toMap(),
  );

  // }

  // else {
  //   blog('BITCH YOU CAN NOT DO THIS SHIT OR YOU RUINE EVERYTHING');
  // }
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
