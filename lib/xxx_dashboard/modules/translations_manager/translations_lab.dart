import 'dart:math';

import 'package:bldrs/a_models/kw/chain/chain_properties.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/secondary_models/translation_model.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/streamers/trans_mdel_streamer.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart';
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/ops/trans_ops.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:bldrs/f_helpers/theme/wordz.dart';
import 'package:bldrs/xxx_dashboard/b_views/c_components/layout/dashboard_layout.dart';
import 'package:bldrs/xxx_dashboard/modules/translations_manager/widgets/translations_page.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart' as StreamChecker;
import 'package:provider/provider.dart';


class TranslationsLab extends StatefulWidget {

  const TranslationsLab({
    Key key
  }) : super(key: key);

  @override
  _TranslationsLabState createState() => _TranslationsLabState();
}

class _TranslationsLabState extends State<TranslationsLab> {
  // ---------------------------------------------------------------------------
  // const List<KW> _keywords = ChainProperties.chain.sons;
  // ---------------------------------------------------------------------------
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _englishController = TextEditingController();
  final TextEditingController _arabicController = TextEditingController();
  ScrollController _docScrollController;
  final TextEditingController _searchController = TextEditingController();
  PageController _pageController;
  final ValueNotifier<String> _newID = ValueNotifier('');
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
  final ValueNotifier<List<Phrase>> _mixedSearchedPhrases = ValueNotifier(<Phrase>[]);
  // ---------------------------------------------------------------------------
  Stream<TransModel> _arStream;
  Stream<TransModel> _enStream;
  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _idController.addListener(() {
      _newID.value = _idController.text;
    });

    _arStream = getTransModelStream(
      context: context,
      langCode: 'ar',
    );

    _enStream = getTransModelStream(
      context: context,
      langCode: 'en',
    );

    _docScrollController = ScrollController();
  }
  // ---------------------------------------------------------------------------

  /// BUTTONS

  // -----------------------------
  Future<void> _onBldrsTap() async {

    await _createNewTransModel(context: context, enDocName: 'en', arDocName: 'ar');

  }
  // -----------------------------
  void _onClearText(TextEditingController controller){
      controller.text = '';
  }
  // -----------------------------
  Future<void> _onPasteText(TextEditingController controller) async {
    final String value = await FlutterClipboard.paste();
    controller.text = value;
  }
  // -----------------------------
  Future<void> _onCopyText(String value) async {
    await Keyboarders.copyToClipboard(
      context: context,
      copy: value,
    );
  }
  // -----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    const double _buttonsHeight = 40;

    return TransModelStreamer(
        stream: _arStream,
        builder: (_, TransModel arTransModel) {

          final List<Phrase> _arPhrases = Phrase.sortPhrasesByID(
            phrases: arTransModel?.phrases,
          );

          return TransModelStreamer(
              stream: _enStream,
              builder: (_, TransModel enTransModel) {

                final List<Phrase> _enPhrases = Phrase.sortPhrasesByID(
                  phrases: enTransModel?.phrases,
                );

                return MainLayout(
                  key: const ValueKey<String>('DashBoardLayout_translations_lab'),
                  historyButtonIsOn: false,
                  skyType: SkyType.black,
                  pyramidsAreOn: true,
                  sectionButtonIsOn: false,
                  zoneButtonIsOn: false,
                  appBarType: AppBarType.search,
                  searchController: _searchController,
                  onSearchChanged: (String text){

                    blog('text : $text');

                    _isSearching.value = TextChecker.triggerIsSearching(
                      text: _searchController.text,
                      isSearching: _isSearching.value,
                    );

                    if (_isSearching.value == true){

                      List<Phrase> _foundPhrases = <Phrase>[];

                      final List<Phrase> _enResults = Phrase.searchPhrases(
                        phrases: _enPhrases,
                        text: _searchController.text,
                        byValue: true,
                      );

                      final List<Phrase> _arResults = Phrase.searchPhrases(
                        phrases: _arPhrases,
                        text: _searchController.text,
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

                      _mixedSearchedPhrases.value = _foundPhrases;
                    }

                    else {
                      _mixedSearchedPhrases.value = <Phrase>[];
                    }

                  },
                  searchHint: 'Search ${_enPhrases.length} phrases by ID only',
                  appBarRowWidgets: <Widget>[

                    const Expander(),

                    /// UPLOAD GROUP
                    DreamBox(
                      height: _buttonsHeight,
                      color: Colorz.red255,
                      verseShadow: false,
                      verseMaxLines: 2,
                      verseScaleFactor: 0.6,
                      verse: 'Upload',
                      secondLine: 'group',
                      margins: const EdgeInsets.symmetric(horizontal: 5),
                      onTap: () async {

                        await _addWordsFromJSONToFirebaseForTheFirstTime(
                          context: context,
                          arOldPhrases: _arPhrases,
                          enOldPhrases: _enPhrases,
                        );

                        },
                    ),

                    /// UPLOAD BUTTON
                    ValueListenableBuilder(
                        valueListenable: _newID,
                        builder: (_, String newID, Widget child){

                          return DreamBox(
                            height: _buttonsHeight,
                            color: Colorz.yellow255,
                            verse: 'Upload',
                            verseColor: Colorz.black255,
                            secondLineColor: Colorz.black255,
                            secondLine: newID,
                            verseShadow: false,
                            verseMaxLines: 2,
                            verseScaleFactor: 0.6,
                            onTap: () async {

                              if (TextChecker.stringIsNotEmpty(_idController.text) == true){
                                await _onUploadPhrase(
                                  context: context,
                                  enOldPhrases: _enPhrases,
                                  arOldPhrases: _arPhrases,
                                  enValue: _englishController.text,
                                  arValue: _arabicController.text,
                                  phraseID: _idController.text,
                                );
                              }

                              else {
                                await TopDialog.showTopDialog(
                                    context: context,
                                    verse: 'ID is Empty',
                                );
                              }

                            },
                          );

                        }
                    ),

                    /// BLDRS BUTTON
                    GestureDetector(
                      onTap: _onBldrsTap,
                      child: const Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: BldrsName(
                          size: 40,
                        ),
                      ),
                    ),

                  ],

                  layoutWidget: PageView(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[

                      /// TRANSLATION PAGE
                      ValueListenableBuilder(
                          valueListenable: _isSearching,
                          builder: (_, bool isSearching, Widget child){

                            /// SEARCHING PAGE
                            if (isSearching == true){

                              return ValueListenableBuilder(
                                valueListenable: _mixedSearchedPhrases,
                                builder: (_, List<Phrase> mixedPhrases, Widget child){

                                  final List<Phrase> _enSearchedPhrases = Phrase.getPhrasesByLangFromPhrases(
                                    phrases: mixedPhrases,
                                    langCode: 'en',
                                  );

                                  final List<Phrase> _arSearchedPhrases = Phrase.getPhrasesByLangFromPhrases(
                                    phrases: mixedPhrases,
                                    langCode: 'ar',
                                  );

                                  return TranslationsPage(
                                    enPhrases: _enSearchedPhrases,
                                    arPhrases: _arSearchedPhrases,
                                    scrollController: _docScrollController,
                                    onCopyValue: (String value) => _onCopyText(value),
                                    onDeletePhrase: (String phraseID) => _onDeletePhrase(
                                      context: context,
                                      phraseID: phraseID,
                                      enPhrases: _enPhrases,
                                      arPhrases: _arPhrases,
                                    ),
                                    onEditPhrase: (String phraseID) async {

                                      await _onEditPhrase(
                                        context: context,
                                        pageController: _pageController,
                                        enPhrases: _enPhrases,
                                        arPhrases: _arPhrases,
                                        phraseID: phraseID,
                                        enTextController: _englishController,
                                        arTextController: _arabicController,
                                        idTextController: _idController,
                                      );

                                    },
                                  );

                                },
                              );


                            }

                            /// VIEW PAGE
                            else {
                              return child;
                            }

                          },
                        child: TranslationsPage(
                          scrollController: _docScrollController,
                          arPhrases: _arPhrases,
                          enPhrases: _enPhrases,
                          onCopyValue: (String value) => _onCopyText(value),
                          onEditPhrase: (String phraseID) => _onEditPhrase(
                            context: context,
                            pageController: _pageController,
                            enPhrases: _enPhrases,
                            arPhrases: _arPhrases,
                            phraseID: phraseID,
                            enTextController: _englishController,
                            arTextController: _arabicController,
                            idTextController: _idController,
                          ),
                          onDeletePhrase: (String phraseID) => _onDeletePhrase(
                            context: context,
                            phraseID: phraseID,
                            enPhrases: _enPhrases,
                            arPhrases: _arPhrases,
                          ),
                        ),
                      ),

                      /// CREATOR
                      Container(
                        key: const ValueKey<String>('translations_creator_page'),
                        width: _screenWidth,
                        height: _screenHeight,
                        padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + 10),
                        child: Column(
                          children: <Widget>[

                            TextFieldBubble(
                              title: 'Key',
                              hintText: 'Phrase key',
                              textController: _idController,
                              onBubbleTap: () => _onCopyText(_idController.text),
                              pasteFunction: () => _onPasteText(_idController),
                              actionBtFunction: () => _onClearText(_idController),
                              actionBtIcon: Iconz.xLarge,
                              columnChildren: <Widget>[

                                Row(
                                  children: <Widget>[

                                    DreamBox(
                                      height: 35,
                                      width: 150,
                                      verse: 'Add [phid_] to ID',
                                      verseScaleFactor: 0.6,
                                      onTap: (){
                                        _idController.text = 'phid_${_idController.text}';
                                      },
                                    ),

                                  ],
                                ),

                              ],
                            ),

                            TextFieldBubble(
                              title: 'English',
                              hintText: 'English phrase',
                              textController: _englishController,
                              onBubbleTap: () => _onCopyText(_englishController.text),
                              pasteFunction: () => _onPasteText(_englishController),
                              actionBtFunction: () => _onClearText(_englishController),
                              actionBtIcon: Iconz.xLarge,
                            ),

                            TextFieldBubble(
                              title: 'عربي',
                              hintText: 'مصطلح عربي',
                              textController: _arabicController,
                              onBubbleTap: () => _onCopyText(_arabicController.text),
                              pasteFunction: () => _onPasteText(_arabicController),
                              actionBtFunction: () => _onClearText(_arabicController),
                              actionBtIcon: Iconz.xLarge,
                            ),

                          ],
                        ),
                      ),

                      // const Horizon(heightFactor: 5),

                    ],
                  ),

                );
              }
              );
        }
        );

  }
}
// ---------------------------------------------------------------------------
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
Future<void> _onUploadPhrases({
  @required List<Phrase> arOldPhrases,
  @required List<Phrase> enOldPhrases,
  @required BuildContext context,
  @required List<Phrase> arNewPhrases,
  @required List<Phrase> enNewPhrases,
}) async {


}
// -----------------------------
Future<void> _onUploadPhrase({
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
Future<void> _onDeletePhrase({
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

Future<void> _onEditPhrase({
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