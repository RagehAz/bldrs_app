import 'dart:async';

import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/note_red_dot.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/c_protocols/phrase_protocols/phrase_protocols.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/firestore.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/b_phrases_editor/b_phrase_editor_screen.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/a_notes_creator_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
export 'package:bldrs/b_views/z_components/app_bar/app_bar_button.dart';
export 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
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
}) async {

  if (untranslatedVerse != null){

    searchController.text = untranslatedVerse.text;
    idTextController.text = untranslatedVerse.text;
    enTextController.text = TextMod.removeTextBeforeLastSpecialCharacter(untranslatedVerse.pseudo, '#') ?? '';

    onPhrasesSearchSubmit(
      isSearching: isSearching,
      mixedSearchResult: mixedSearchResult,
      searchController: searchController,
      allMixedPhrases: allMixedPhrases,
      context: context,
      pageController: pageController,
    );

    await Sliders.slideToNext(
      pageController: pageController,
      numberOfSlides: 2,
      currentSlide: 0,
    );

    Formers.focusOnNode(enNode);

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
}){

  TextCheck.triggerIsSearchingNotifier(
    text: searchController.text,
    isSearching: isSearching,
  );

  if (isSearching.value == true){

    onSearchPhrases(
      context: context,
      phrasesToSearchIn: allMixedPhrases,
      isSearching: isSearching,
      mixedSearchResult: mixedSearchResult,
      searchController: searchController,
      pageController: pageController,
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
}){

  isSearching.value = true;

  onSearchPhrases(
    context: context,
    phrasesToSearchIn: allMixedPhrases,
    isSearching: isSearching,
    mixedSearchResult: mixedSearchResult,
    searchController: searchController,
    pageController: pageController,
  );

}
// --------------------
///  TESTED : WORKS PERFECT
List<Phrase> onSearchPhrases({
  @required BuildContext context,
  @required ValueNotifier<bool> isSearching,
  @required TextEditingController searchController,
  @required List<Phrase> phrasesToSearchIn,
  @required PageController pageController,
  /// mixes between en & ar values in one list
  ValueNotifier<List<Phrase>> mixedSearchResult,
}){

  List<Phrase> _foundPhrases = <Phrase>[];

  if (isSearching.value == true){

    // final List<Phrase> _enResults = Phrase.searchPhrases(
    //   phrases: enPhrase,
    //   text: searchController.text,
    //   byValue: true,
    // );
    //
    // blog('onSearchPhrases : _enResults = $_enResults');

    // final List<Phrase> _result
    _foundPhrases = Phrase.searchPhrasesRegExp(
      phrases: phrasesToSearchIn,
      text: searchController.text,
      lookIntoValues: true,
      // byID: true,
    );

    final List<String> _phids = Phrase.getPhrasesIDs(_foundPhrases);

    _foundPhrases = Phrase.searchPhrasesByIDs(
      phrases: phrasesToSearchIn,
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

    _foundPhrases = Phrase.cleanIdenticalPhrases(_foundPhrases);

  }

  if (mixedSearchResult != null){
    if (isSearching.value == true){
      mixedSearchResult.value = _foundPhrases;
    }
    else {
      mixedSearchResult.value = <Phrase>[];
    }
  }

  if (pageController.position.pixels >= Scale.superScreenWidth(context) == true){
    Sliders.slideToBackFrom(
      pageController: pageController,
      currentSlide: 1,
    );
  }

  return _foundPhrases;
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


    tempMixedPhrases.value = Phrase.sortPhrasesByIDAndLang(phrases: _output);

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
    );

    await Dialogs.showSuccessDialog(
      context: context,
      firstLine: const Verse(text: 'Phrases Updated', translate: false),
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
      titleVerse: const Verse(text: 'Check inputs', translate: false),
      bodyVerse: const Verse(text: 'The ID or one of the values is empty.', translate: false),
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
        titleVerse: const Verse(text: '7aseb !', translate: false),
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
}) async {

  final bool _continue = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(text: 'Bgad ?', translate: false),
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

    tempMixedPhrases.value = _result;
    //     Phrase.symmetrizePhrases(
    //     phrasesToSymmetrize: _result,
    //     allMixedPhrases: tempMixedPhrases.value,
    // );

    // blog('onDeletePhrase : ${tempMixedPhrases.value.length} GIVEN LENGTH');

    await Dialogs.showSuccessDialog(
      context: context,
      firstLine: const Verse(text: 'Phrase has been deleted', translate: false),
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
    titleVerse: const Verse(text: 'Select This & go Back ?', translate: false),
    bodyVerse: Verse.plain('$phid\n${xPhrase( context, phid)}'),
    confirmButtonVerse: const Verse(text: 'Select & Back', translate: false),
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
}) async {

  final bool _continue = await Dialogs.confirmProceed(context: context);

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

    await Dialogs.showSuccessDialog(
      context: context,
      firstLine: const Verse(text: 'Sync Successful', translate: false),
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
    titleVerse: const Verse(text: 'Phids Pending Translation', translate: false),
    builder: (_, Function setState){

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
                      titleVerse: const Verse(text: 'phid_delete', translate: true),
                    );

                    if (_result == true){

                      setState((){
                        _phraseProvider.removePhidFromPendingTranslation(_phid);
                      });

                    }

                  },
                  onValueTap: () async {

                    await Keyboard.copyToClipboard(
                      context: context,
                      copy: _phid,
                      milliseconds: 100,
                      awaitTheDialog: true,
                    );

                    await Nav.goBack(
                      context: context,
                      invoker: 'showPhidsPendingTranslationDialog',
                      // addPostFrameCallback: false,
                    );

                  },
                );

              }

              else {

                return BottomDialog.wideButton(
                  context: context,
                  verse: const Verse(text: 'Clear All', translate: false),
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

/// OLD FIRE READ OPS

// --------------------
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
class FastTranslatorButton extends StatelessWidget {
  /// ---------------------------------------------------------------------------
  const FastTranslatorButton({
    @required this.isInTransScreen,
    @required this.pyramidsAreOn,
    Key key
  }) : super(key: key);
  /// ---------------------------------------------------------------------------
  final bool isInTransScreen;
  final bool pyramidsAreOn;
  /// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _user = UsersProvider.proGetMyUserModel(context: context, listen: true);

    final List<String> _phidsPendingTranslation = PhraseProvider.proGetPhidsPendingTranslation(
      context: context,
      listen: true,
    );

    if (_user?.isAdmin == true){

      return Container(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeightWithoutSafeArea(context),
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              /// TRANSLATION BUTTON
              if (Mapper.checkCanLoopList(_phidsPendingTranslation) == true)
              NoteRedDotWrapper(
                childWidth: 40,
                redDotIsOn: true,
                count: _phidsPendingTranslation.length,
                shrinkChild: true,
                child: DreamBox(
                  height: 40,
                  width: 40,
                  corners: 20,
                  color: isInTransScreen == true ? Colorz.yellow255 : Colorz.green50,
                  icon: Iconz.language,
                  iconSizeFactor: 0.6,
                  onTap: () async {

                    if (isInTransScreen == true){

                      await showPhidsPendingTranslationDialog(context);

                    }

                    else {

                      await createAPhidFast(
                        context: context,
                        verse: Verse.plain(_phidsPendingTranslation[0]),
                      );

                    }
                  },
                ),
              ),

              /// CREATE NOTES BUTTON
              if (pyramidsAreOn == true)
              DreamBox(
                height: 40,
                width: 40,
                corners: 20,
                color: isInTransScreen == true ? Colorz.yellow255 : Colorz.green50,
                icon: Iconz.news,
                iconSizeFactor: 0.6,
                onTap: () => Nav.goToNewScreen(
                  context: context,
                  screen: const NotesCreatorScreen(),
                ),
              ),

            ],
          ),
        ),
      );

    }

    else {

      return const SizedBox();

    }

  }
  /// ---------------------------------------------------------------------------
}
// ---------------------------------------------------------------------------
