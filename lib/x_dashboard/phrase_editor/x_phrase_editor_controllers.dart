import 'dart:async';

import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/protocols/phrase_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/phrase_editor/phrase_editor_screen.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stringer/stringer.dart';
// ---------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
Future<void> prepareFastPhidCreation({
  @required BuildContext context,
  @required Verse untranslatedVerse,
  @required ValueNotifier<bool> isSearching,
  @required TextEditingController searchController,
  @required List<Phrase> allMixedPhrases,
  @required ValueNotifier<List<Phrase>> mixedSearchResult,
  @required TextEditingController idTextController,
  @required TextEditingController enTextController,
  @required PageController pageController,
  @required FocusNode enNode,
  @required bool mounted,
}) async {

  if (untranslatedVerse != null){

    if (mounted == true){
      searchController.text = untranslatedVerse.id;
      idTextController.text = untranslatedVerse.id;
      enTextController.text = TextMod.removeTextBeforeLastSpecialCharacter(untranslatedVerse.pseudo, '#') ?? '';
    }

    onPhrasesSearchSubmit(
      isSearching: isSearching,
      mixedSearchResult: mixedSearchResult,
      searchController: searchController,
      allMixedPhrases: allMixedPhrases,
      context: context,
      pageController: pageController,
      mounted: mounted,
    );

    if (mounted == true) {
      await Sliders.slideToNext(
        pageController: pageController,
        numberOfSlides: 2,
        currentSlide: 0,
      );
    }

    if (mounted == true){
      Formers.focusOnNode(enNode);
    }

  }

}
// ---------------------------------------------------------------------------

/// SEARCH

// --------------------
///  TESTED : WORKS PERFECT
void onPhrasesSearchChanged({
  @required BuildContext context,
  @required ValueNotifier<bool> isSearching,
  @required TextEditingController searchController,
  @required List<Phrase> allMixedPhrases,
  @required ValueNotifier<List<Phrase>> mixedSearchResult,
  @required PageController pageController,
  @required bool mounted,
}){

  TextCheck.triggerIsSearchingNotifier(
    text: searchController.text,
    isSearching: isSearching,
    mounted: mounted,
  );

  if (isSearching.value  == true){

    onSearchPhrases(
      context: context,
      phrasesToSearchIn: allMixedPhrases,
      isSearching: isSearching,
      mixedSearchResult: mixedSearchResult,
      searchController: searchController,
      pageController: pageController,
      mounted: mounted,
    );

  }

}
// --------------------
///  TESTED : WORKS PERFECT
void onPhrasesSearchSubmit({
  @required BuildContext context,
  @required ValueNotifier<bool> isSearching,
  @required TextEditingController searchController,
  @required List<Phrase> allMixedPhrases,
  @required ValueNotifier<List<Phrase>> mixedSearchResult,
  @required PageController pageController,
  @required bool mounted,
}){

  setNotifier(
      notifier: isSearching,
      mounted: mounted,
      value: true,
  );

  onSearchPhrases(
    context: context,
    phrasesToSearchIn: allMixedPhrases,
    isSearching: isSearching,
    mixedSearchResult: mixedSearchResult,
    searchController: searchController,
    pageController: pageController,
    mounted: mounted,
  );

}
// ---------------------------------------------------------------------------

/// MODIFIERS

// --------------------
/// EDIT - ADD
// ------
/// TESTED : WORKS PERFECT
Future<void> onTapEditPhrase({
  @required BuildContext context,
  @required String phid,
  // @required List<Phrase> arPhrases,
  // @required List<Phrase> enPhrases,
  @required PageController pageController,
  @required TextEditingController enTextController,
  @required TextEditingController arTextController,
  @required TextEditingController idTextController,
  @required ValueNotifier<List<Phrase>> tempMixedPhrases,
}) async {

  /// CLOSE BOTTOM DIALOG
  await Nav.goBack(
    context: context,
    invoker: 'onTapEditPhrase',
    addPostFrameCallback: true,
  );

  final Phrase _enPhrase = Phrase.searchPhraseByIDAndLangCode(
    phrases: tempMixedPhrases.value,
    phid: phid,
    langCode: 'en',
  );

  final Phrase _arPhrase = Phrase.searchPhraseByIDAndLangCode(
    phrases: tempMixedPhrases.value,
    phid: phid,
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
// ------
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
  @required ValueNotifier<List<Phrase>> mixedSearchResult,
  @required TextEditingController searchController,
  @required ValueNotifier<bool> isSearching,
  @required bool mounted,
}) async {

  searchController.text = idTextController.text;

  bool _canContinue = await Dialogs.confirmProceed(
    context: context,
  );

  if (_canContinue == true){
    _canContinue = await _preEditCheck(
      context: context,
      arOldPhrases: Phrase.searchPhrasesByLang(phrases: tempMixedPhrases.value, langCode: 'ar'),
      enOldPhrases: Phrase.searchPhrasesByLang(phrases: tempMixedPhrases.value, langCode: 'en'),
      enValue: updatedEnPhrase.value,
      arValue: updatedArPhrase.value,
      phid: updatedEnPhrase.id,
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
    _output.insert(0, updatedEnPhrase.completeTrigram());
    _output.insert(0, updatedArPhrase.completeTrigram());

    // blog('deletePhidFromPhrases : inserted : id  ${updatedEnPhrase.id} : '
    //     '${updatedEnPhrase.value} : lang : ${updatedEnPhrase.langCode}');
    // blog('deletePhidFromPhrases : inserted : id  ${updatedArPhrase.id} : '
    //     '${updatedArPhrase.value} : lang : ${updatedArPhrase.langCode}');

    setNotifier(
        notifier: tempMixedPhrases,
        mounted: mounted,
        value: Phrase.sortPhrasesByIDAndLang(phrases: _output),
    );

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

    onSearchPhrases(
      context: context,
      pageController: pageController,
      isSearching: isSearching,
      searchController: searchController,
      phrasesToSearchIn: tempMixedPhrases.value,
      mixedSearchResult: mixedSearchResult,
      mounted: mounted,
    );

    await Dialogs.showSuccessDialog(
      context: context,
      firstLine: const Verse(id: 'Phrases Updated', translate: false),
    );

  }

}
// ------
/// TESTED : WORKS PERFECT
Future<bool> _preEditCheck({
  @required List<Phrase> arOldPhrases,
  @required List<Phrase> enOldPhrases,
  @required String phid,
  @required String enValue,
  @required String arValue,
  @required BuildContext context,
}) async {

  bool _continueOps = true;

  /// INPUTS ARE INVALID
  if (
      TextCheck.isEmpty(phid) == true
      ||
      TextCheck.isEmpty(enValue) == true
      ||
      TextCheck.isEmpty(arValue) == true
  ){
    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(id: 'Check inputs', translate: false),
      bodyVerse: const Verse(id: 'The ID or one of the values is empty.', translate: false),
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
      id: phid,
    );
    if (_idIsTakenEn == true){
      _phrase = Phrase.searchPhraseByIDAndLangCode(
          phrases: enOldPhrases,
          phid: phid,
          langCode: 'en'
      );
      _alertMessage = 'ID is Taken : ${_phrase.id}\n: value : ${_phrase.value} : langCode : ${_phrase.langCode}';
    }

    /// AR ID TAKEN
    _idIsTakenAr = Phrase.checkPhrasesIncludeThisID(
      phrases: arOldPhrases,
      id: phid,
    );
    if (_idIsTakenAr == true){
      _phrase = Phrase.searchPhraseByIDAndLangCode(
        phrases: arOldPhrases,
        phid: phid,
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
        titleVerse: const Verse(id: '7aseb !', translate: false),
        boolDialog: true,
        bodyVerse: Verse.plain('$_alertMessage\n\n$_actionTypeMessage\n\nWanna continue uploading ?'),
      );

    }

  }

  return _continueOps;
}
// ------
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
// --------------------
/// DELETE
// ------
/// TESTED : WORKS PERFECT
Future<void> onDeletePhrase({
  @required BuildContext context,
  @required String phid,
  @required ValueNotifier<List<Phrase>> tempMixedPhrases,
  @required bool mounted,
}) async {

  final bool _continue = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(id: 'Bgad ?', translate: false),
    boolDialog: true,
    bodyVerse:  Verse.plain('Delete This Phrase ?\n\nPhid : $phid'),
  );

  if (_continue == true){

    /// CLOSE BOTTOM DIALOG
    await Nav.goBack(
      context: context,
      invoker: 'onDeletePhrase',
    );

    final List<Phrase> _result = Phrase.deletePhidFromPhrases(
      phrases: tempMixedPhrases.value,
      phid: phid,
    );

    // blog('onDeletePhrase : ${tempMixedPhrases.value.length} GIVEN LENGTH : BUT  ${_result.length} phrases in output');

    setNotifier(
        notifier: tempMixedPhrases,
        mounted: mounted,
        value: _result
    );

    //     Phrase.symmetrizePhrases(
    //     phrasesToSymmetrize: _result,
    //     allMixedPhrases: tempMixedPhrases.value,
    // );

    // blog('onDeletePhrase : ${tempMixedPhrases.value.length} GIVEN LENGTH');

    await Dialogs.showSuccessDialog(
      context: context,
      firstLine: const Verse(id: 'Phrase has been deleted', translate: false),
    );

  }

}
// --------------------
/// SELECTION
// ------
/// TESTED : WORKS PERFECT
Future<void> onSelectPhrase({
  @required BuildContext context,
  @required String phid,
}) async {

  final bool _continue = await Dialogs.goBackDialog(
    context: context,
    titleVerse: const Verse(id: 'Select This & go Back ?', translate: false),
    bodyVerse: Verse.plain('$phid\n${xPhrase( context, phid)}'),
    confirmButtonVerse: const Verse(id: 'Select & Back', translate: false),
  );

  if (_continue == true){

    /// CLOSE BOTTOM DIALOG
    await Nav.goBack(
      context: context,
      invoker: 'onDeletePhrase',
    );

    /// GO BACK AND PASS PHID
    await Nav.goBack(
      context: context,
      invoker: 'onDeletePhrase',
      passedData: phid,
    );

  }

}
// ---------------------------------------------------------------------------

/// SYNC

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSyncPhrases({
  @required BuildContext context,
  @required ValueNotifier<List<Phrase>> tempMixedPhrases,
  @required ValueNotifier<List<Phrase>> initialMixedPhrases,
  @required PageController pageController,
  @required TextEditingController enTextController,
  @required TextEditingController arTextController,
  @required TextEditingController idTextController,
  @required bool mounted,
}) async {

  final bool _continue = await Dialogs.confirmProceed(context: context);

  if (_continue == true){

    await PhraseProtocols.renovateMainPhrases(
      context: context,
      updatedMixedMainPhrases: tempMixedPhrases.value,
      showWaitDialog: true,
    );

    setNotifier(
      notifier: initialMixedPhrases,
      mounted: mounted,
      value: tempMixedPhrases.value,
    );

    await _goBackToPhrasesPageAndResetControllers(
      pageController: pageController,
      arTextController: arTextController,
      enTextController: enTextController,
      idTextController: idTextController,
    );

    await Dialogs.showSuccessDialog(
      context: context,
      firstLine: const Verse(id: 'Sync Successful', translate: false),
    );

  }

}
// ---------------------------------------------------------------------------

/// FAST METHODS

// --------------------
/// TESTED : WORKS PERFECT
Future<String> pickAPhidFast(BuildContext context) async {

  final String _phid = await Nav.goToNewScreen(
    context: context,
    screen: const PhraseEditorScreen(),
  );

  return _phid;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> createAPhidFast({
  @required BuildContext context,
  @required Verse verse,
}) async {

  await Nav.goToNewScreen(
    context: context,
    screen: PhraseEditorScreen(
      createPhid: verse,
    ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> showPhidsPendingTranslationDialog(BuildContext context) async {

  await BottomDialog.showStatefulBottomDialog(
    context: context,
    draggable: true,
    titleVerse: const Verse(id: 'Phids Pending Translation', translate: false),
    builder: (BuildContext xxx, Function setState){

      final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: true);

      return  SizedBox(
        width: BottomDialog.clearWidth(context),
        height: BottomDialog.clearHeight(context: context, draggable: true, titleIsOn: true),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _phraseProvider.phidsPendingTranslation.length + 1,
            // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
            itemBuilder: (_, index){

              final bool _isLast = index == _phraseProvider.phidsPendingTranslation.length;

              if (_isLast == false){

                final String _phid = _phraseProvider.phidsPendingTranslation[index];

                return DataStrip(
                  width: BottomDialog.clearWidth(context),
                  dataKey: 'X : $index',
                  dataValue: _phid,
                  onKeyTap: () async {

                    final bool _result = await Dialogs.confirmProceed(
                      context: context,
                      titleVerse: const Verse(id: 'phid_delete', translate: true),
                    );

                    if (_result == true){

                      setState((){
                        _phraseProvider.removePhidFromPendingTranslation(_phid);
                      });

                    }

                  },
                  onValueTap: () async {

                    blog('1. aho starting');

                    await Future.delayed(const Duration(milliseconds: 300), () async {

                      blog('2. waited 300 ms');

                      await Keyboard.copyToClipboard(
                        context: xxx,
                        copy: _phid,
                        milliseconds: 0,
                      );

                      blog('3. copied shit to clipboard');

                      await Nav.goBack(
                        context: xxx,
                        invoker: 'showPhidsPendingTranslationDialog',
                        addPostFrameCallback: true,
                      );

                      blog('4.went back');

                    });

                  },
                );

              }

              else {

                return BottomDialog.wideButton(
                  context: context,
                  verse: const Verse(id: 'Clear All', translate: false),
                  onTap: () async {

                    _phraseProvider.setPhidsPendingTranslation(
                      setTo: const [],
                      notify: true,
                    );

                    await Nav.goBack(
                        context: context,
                        invoker: 'fuck you bitch'
                    );

                  }
                );

              }

            }
        ),
      );

    }
  );

}
// ---------------------------------------------------------------------------

/// TESTED : WORKS PERFECT
Future<void> goToFastTranslator({
  @required BuildContext context,
  @required Verse verse,
}) async {

  blog('fuck you : $verse');

  if (verse.pseudo != null){

  }

  await createAPhidFast(
    context: context,
    verse: verse,
  );

  await Keyboard.copyToClipboard(context: context, copy: verse.id);

}

// ---------------------------------------------------------------------------
