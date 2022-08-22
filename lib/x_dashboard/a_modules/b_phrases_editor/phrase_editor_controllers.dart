import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/c_protocols/phrase_protocols/phrase_protocols.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
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
    _foundPhrases = Phrase.searchPhrasesRegExp(
      phrases: allMixedPhrases,
      text: searchController.text,
      lookIntoValues: true,
      // byID: true,
    );

    final List<String> _phids = Phrase.getPhrasesIDs(_foundPhrases);

    _foundPhrases = Phrase.searchPhrasesByIDs(
      phrases: allMixedPhrases,
      phids: _phids,
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
/// TESTED : WORKS PERFECT
Future<void> onTapEditPhrase({
  @required BuildContext context,
  @required String phraseID,
  // @required List<Phrase> arPhrases,
  // @required List<Phrase> enPhrases,
  @required PageController pageController,
  @required TextEditingController enTextController,
  @required TextEditingController arTextController,
  @required TextEditingController idTextController,
  @required ValueNotifier<List<Phrase>> tempMixedPhrases,
}) async {

  /// CLOSE BOTTOM DIALOG
  Nav.goBack(
    context: context,
    invoker: 'onTapEditPhrase',
  );

  final Phrase _enPhrase = Phrase.searchPhraseByIDAndLangCode(
    phrases: tempMixedPhrases.value,
    phid: phraseID,
    langCode: 'en',
  );

  final Phrase _arPhrase = Phrase.searchPhraseByIDAndLangCode(
    phrases: tempMixedPhrases.value,
    phid: phraseID,
    langCode: 'ar',
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
/// TESTED : WORKS PERFECT
Future<void> onConfirmEditPhrase({
  @required BuildContext context,
  @required ValueNotifier<List<Phrase>> tempMixedPhrases,
  @required Phrase updatedEnPhrase,
  @required Phrase updatedArPhrase,
  @required PageController pageController,
  @required TextEditingController enTextController,
  @required TextEditingController arTextController,
  @required TextEditingController idTextController,
}) async {

  bool _canContinue = await Dialogz.confirmProceed(
    context: context,
  );

  if (_canContinue == true){
    _canContinue = await _preEditCheck(
      context: context,
      arOldPhrases: Phrase.searchPhrasesByLang(phrases: tempMixedPhrases.value, langCode: 'ar'),
      enOldPhrases: Phrase.searchPhrasesByLang(phrases: tempMixedPhrases.value, langCode: 'en'),
      enValue: updatedEnPhrase.value,
      arValue: updatedArPhrase.value,
      phraseID: updatedEnPhrase.id,
    );
  }

  if (_canContinue == true){

    List<Phrase> _output = <Phrase>[...tempMixedPhrases.value];

    /// REMOVE OLD PHRASES IF EXISTED
    final bool _idExists = Phrase.checkPhrasesIncludeThisID(
        phrases: tempMixedPhrases.value,
        id: idTextController.text,
    );
    // blog('_idExists : $_idExists');
    if (_idExists == true){
      _output = Phrase.deletePhidFromPhrases(
          phrases: _output,
          phid: idTextController.text,
      );
    }

    /// ADD UPDATED PHRASES
    _output.insert(0, updatedEnPhrase);
    _output.insert(0, updatedArPhrase);

    // blog('deletePhidFromPhrases : inserted : id  ${updatedEnPhrase.id} : '
    //     '${updatedEnPhrase.value} : lang : ${updatedEnPhrase.langCode}');
    // blog('deletePhidFromPhrases : inserted : id  ${updatedArPhrase.id} : '
    //     '${updatedArPhrase.value} : lang : ${updatedArPhrase.langCode}');


    tempMixedPhrases.value = Phrase.sortPhrasesByID(phrases: _output);

    // blog(
    //     'added : ${updatedEnPhrase.value} : ${updatedArPhrase.value}\n'
    //     '0 : ${tempMixedPhrases.value[0].id} : ${_output[0].id}\n'
    //     '1 : ${tempMixedPhrases.value[1].id} : ${_output[1].id}\n'
    //     '2 : ${tempMixedPhrases.value[2].id} : ${_output[2].id}\n'
    // );

    await _goBackToPhrasesPageAndResetControllers(
      pageController: pageController,
      arTextController: arTextController,
      enTextController: enTextController,
      idTextController: idTextController,
    );

    await TopDialog.showSuccessDialog(
      context: context,
      firstLine: 'Phrases Updated',
    );

  }

}
// --------------
/// TESTED : WORKS PERFECT
Future<bool> _preEditCheck({
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
    bool _idIsTakenEn;
    bool _idIsTakenAr;
    bool _valueHasDuplicateEn;
    bool _valueHasDuplicateAr;
    Phrase _phrase;

    /// EN ID TAKEN
    _idIsTakenEn = Phrase.checkPhrasesIncludeThisID(
      phrases: enOldPhrases,
      id: phraseID,
    );
    if (_idIsTakenEn == true){
      _phrase = Phrase.searchPhraseByIDAndLangCode(
        phrases: enOldPhrases,
        phid: phraseID,
        langCode: 'en'
      );
      _alertMessage = 'ID is Taken : ${_phrase.id}\n: value : ${_phrase.value} : langCode : ${_phrase.langCode}';
    }

    /// AR ID TAKEN
    _idIsTakenAr = Phrase.checkPhrasesIncludeThisID(
      phrases: arOldPhrases,
      id: phraseID,
    );
    if (_idIsTakenAr == true){
      _phrase = Phrase.searchPhraseByIDAndLangCode(
        phrases: arOldPhrases,
        phid: phraseID,
        langCode: 'ar',
      );
      _alertMessage = 'ID is Taken : ${_phrase.id}\n: value : ${_phrase.value} : langCode : ${_phrase.langCode}';
    }

    if (_idIsTakenAr == false && _idIsTakenEn == false){

      /// EN VALUE DUPLICATE
      _valueHasDuplicateEn = Phrase.checkPhrasesIncludeThisValue(
        phrases: enOldPhrases,
        value: enValue,
      );
      if (_valueHasDuplicateEn == true){
        _phrase = Phrase.searchPhraseByIdenticalValue(
          phrases: enOldPhrases,
          value: enValue,
        );
        _alertMessage = 'VALUE is Taken : ${_phrase.value}\nid : ${_phrase.id} : langCode : ${_phrase.langCode}';
      }

      /// EN VALUE DUPLICATE
      _valueHasDuplicateAr = Phrase.checkPhrasesIncludeThisValue(
        phrases: arOldPhrases,
        value: arValue,
      );
      if (_valueHasDuplicateAr == true){
        _phrase = Phrase.searchPhraseByIdenticalValue(
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

  }

  return _continueOps;
}
// --------------
/// TESTED : WORKS PERFECT
Future<void> _goBackToPhrasesPageAndResetControllers({
  @required PageController pageController,
  @required TextEditingController enTextController,
  @required TextEditingController arTextController,
  @required TextEditingController idTextController,
}) async {

  enTextController.text = '';
  arTextController.text = '';
  idTextController.text = '';

  await Sliders.slideToBackFrom(
    pageController: pageController,
    currentSlide: 1,
  );

}
// -----------------------------
/// DELETE
// --------------
/// TESTED : WORKS PERFECT
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
        phid: phraseID,
    );

    // blog('onDeletePhrase : ${tempMixedPhrases.value.length} GIVEN LENGTH : BUT  ${_result.length} phrases in output');

    tempMixedPhrases.value = _result;
    //     Phrase.symmetrizePhrases(
    //     phrasesToSymmetrize: _result,
    //     allMixedPhrases: tempMixedPhrases.value,
    // );

    // blog('onDeletePhrase : ${tempMixedPhrases.value.length} GIVEN LENGTH');

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

// -----------------------------
/// TESTED : WORKS PERFECT
Future<void> onSyncPhrases({
  @required BuildContext context,
  @required ValueNotifier<List<Phrase>> tempMixedPhrases,
  @required ValueNotifier<List<Phrase>> initialMixedPhrases,
  @required PageController pageController,
  @required TextEditingController enTextController,
  @required TextEditingController arTextController,
  @required TextEditingController idTextController,
}) async {

  final bool _continue = await Dialogz.confirmProceed(context: context);

  if (_continue == true){

    await PhraseProtocols.renovateMainPhrases(
      context: context,
      updatedMixedMainPhrases: tempMixedPhrases.value,
      showWaitDialog: true,
    );

    initialMixedPhrases.value = tempMixedPhrases.value;

    await _goBackToPhrasesPageAndResetControllers(
      pageController: pageController,
      arTextController: arTextController,
      enTextController: enTextController,
      idTextController: idTextController,
    );

    await TopDialog.showSuccessDialog(
      context: context,
      firstLine: 'Sync Successful',
    );

  }


}
// ---------------------------------------------------------------------------

/// OLD FIRE READ OPS

// -----------------------------
/// TASK : DELETE AFTER DELETING PHRASES FIRE COLL FROM FIREBASE
Future<List<Phrase>> readMainPhrasesFromFire({
  @required BuildContext context,
  @required String langCode,
}) async {

  final Map<String, dynamic> _phrasesMap = await Fire.readDoc(
      context: context,
      collName: FireColl.phrases,
      docName: langCode,
  );

  if (_phrasesMap != null){

    final List<Phrase> _phrasesModels = Phrase.decipherOneLangPhrasesMap(
      map: _phrasesMap,
      addLangCodeOverride: langCode,
    );

    return _phrasesModels;
  }

  else {
    return null;
  }

}
// ---------------------------------------------------------------------------
