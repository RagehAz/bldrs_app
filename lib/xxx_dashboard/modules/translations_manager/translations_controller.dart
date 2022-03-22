import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart';
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

void onSearchChanged({
  @required String text,
  @required ValueNotifier<bool> isSearching,
  @required TextEditingController searchController,
  @required List<Phrase> enPhrase,
  @required List<Phrase> arPhrases,
  /// mixes between en & ar values in one list
  @required ValueNotifier<List<Phrase>> mixedSearchResult,
}){

  blog('text : $text');

  isSearching.value = TextChecker.triggerIsSearching(
    text: searchController.text,
    isSearching: isSearching.value,
  );

  if (isSearching.value == true){

    List<Phrase> _foundPhrases = <Phrase>[];

    final List<Phrase> _enResults = Phrase.searchPhrases(
      phrases: enPhrase,
      text: searchController.text,
      byValue: true,
    );

    final List<Phrase> _arResults = Phrase.searchPhrases(
      phrases: arPhrases,
      text: searchController.text,
      byValue: true,
    );

    _foundPhrases = Phrase.insertPhrases(
      insertIn: _foundPhrases,
      phrasesToInsert: _enResults,
      forceUpdate: false,
      addLanguageCode: 'en',
      allowDuplicateIDs: true,
    );

    _foundPhrases = Phrase.insertPhrases(
      insertIn: _foundPhrases,
      phrasesToInsert: _arResults,
      forceUpdate: false,
      addLanguageCode: 'ar',
      allowDuplicateIDs: true,
    );

    blog('mixed phrase are : ');
    Phrase.blogPhrases(_foundPhrases);

    mixedSearchResult.value = _foundPhrases;
  }

  else {
    mixedSearchResult.value = <Phrase>[];
  }

}

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
  await Keyboarders.copyToClipboard(
    context: context,
    copy: value,
  );
}
// -----------------------------------------------------------------------

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
*/
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
/*
Future<void> _onUploadPhrases({
  @required List<Phrase> arOldPhrases,
  @required List<Phrase> enOldPhrases,
  @required BuildContext context,
  @required List<Phrase> arNewPhrases,
  @required List<Phrase> enNewPhrases,
}) async {


}
*/
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

    blog('4');

    final List<Phrase> _arPhrases = Phrase.insertPhrase(
      forceUpdateDuplicate: true,
      phrases: arOldPhrases,
      phrase:Phrase(
        id: phraseID,
        value: arValue,
      ),
    );

    blog('5');

    if (_enPhrases == null || _arPhrases == null){

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Obaaaaa',
        body: 'Keda fi 7aga mesh mazboota \n could not upload or update',
      );

    }

    else {

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

      await TopDialog.showTopDialog(
        context: context,
        verse: 'Added id :$phraseID',
        secondLine: '$enValue : $arValue',
      );

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

    final bool _enPhrasesListsAreTheSame = Phrase.phrasesListsAreTheSame(
      firstPhrases: _enPhrases,
      secondPhrases: enPhrases,
    );

    final bool _arPhrasesAreTheSame = Phrase.phrasesListsAreTheSame(
      firstPhrases: _enPhrases,
      secondPhrases: arPhrases,
    );

    if (_enPhrasesListsAreTheSame != true && _arPhrasesAreTheSame != true){

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

  goBack(context);

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

  await slideToNext(pageController, 2, 0);

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
