import 'dart:math';

import 'package:bldrs/a_models/kw/chain/chain_properties.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/secondary_models/translation_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart';
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/ops/trans_ops.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:bldrs/f_helpers/theme/wordz.dart';
import 'package:bldrs/xxx_dashboard/b_views/c_components/layout/dashboard_layout.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart' as StreamChecker;


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
  // ---------------------------------------------------------------------------
  Stream<TransModel> _arStream;
  Stream<TransModel> _enStream;
  @override
  void initState() {
    super.initState();

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
  Future<void> _onCopyText(TextEditingController controller) async {
    await Keyboarders.copyToClipboard(
      context: context,
      copy: controller.text,
    );
  }
  // -----------------------------------------------------------------------
  Future<void> _onChangeDoc() async {

  }
  // ---------------------------------------------------------------------------

  /// EXPANDING BUBBLE

  // -----------------------------
  final ValueNotifier<bool> _phrasesExpanded = ValueNotifier(false);
  // ---------------------------------
  void _triggerPhrasesExpansion(){
    _phrasesExpanded.value = !_phrasesExpanded.value;
  }
  // -----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    // final double _fieldWidth = _screenWidth - 20;

    final double _clearWidth = Bubble.clearWidth(context);

    return DashBoardLayout(
      key: const ValueKey<String>('DashBoardLayout_translations_lab'),
      pageTitle: 'Translations Lab',
        onBldrsTap: _onBldrsTap,
        scrollerIsOn: false,
        listWidgets: <Widget>[

          /// PHRASES BUBBLE
          ValueListenableBuilder(
              key: const ValueKey<String>('phrases_bubble'),
              valueListenable: _phrasesExpanded,
              child: transModelStreamBuilder(
                context: context,
                stream: _arStream,
                builder: (_, TransModel arTransModel){

                  final List<Phrase> _arPhrases = arTransModel?.phrases;

                  return transModelStreamBuilder(
                      context: context,
                      stream: _enStream,
                      builder: (_, TransModel enTransModel){

                        final List<Phrase> _enPhrases = enTransModel?.phrases;

                        final bool _canBuildPhrases =
                            canLoopList(_enPhrases) == true
                                &&
                                canLoopList(_arPhrases) == true;

                        return ValueListenableBuilder(
                          valueListenable: _phrasesExpanded,
                          builder: (_, bool expanded, Widget child){

                            final double _phrasesHeight = expanded ? 500 : 200;
                            const double _buttonsHeight = 40;

                            return SizedBox(
                              width: _clearWidth,
                              // height: _phrasesHeight + _buttonsHeight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  SuperVerse(
                                    verse: '${_enPhrases.length} phrases',
                                    size: 2,
                                    centered: false,
                                    weight: VerseWeight.thin,
                                    margin: 5,
                                    italic: true,
                                  ),

                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[

                                          DreamBox(
                                            height: _buttonsHeight,
                                            verse: 'Change',
                                            secondLine: 'Doc.',
                                            verseMaxLines: 2,
                                            verseScaleFactor: 0.6,
                                            color: Colorz.blue125,
                                            onTap: _onChangeDoc,
                                          ),

                                          DreamBox(
                                            width: 100,
                                            height: _buttonsHeight,
                                            color: Colorz.red255,
                                            verseColor: Colorz.black255,
                                            secondLineColor: Colorz.black255,
                                            verseShadow: false,
                                            verseMaxLines: 2,
                                            verseScaleFactor: 0.6,
                                            verseCentered: true,
                                            verse: 'Upload group',
                                            onTap: () async {

                                              await _addWordsFromJSONToFirebaseForTheFirstTime(
                                                context: context,
                                                arOldPhrases: _arPhrases,
                                                enOldPhrases: _enPhrases,
                                              );

                                            },
                                          ),

                                          DreamBox(
                                            width: 150,
                                            height: _buttonsHeight,
                                            color: Colorz.yellow255,
                                            verse: 'Upload',
                                            verseColor: Colorz.black255,
                                            secondLineColor: Colorz.black255,
                                            verseShadow: false,
                                            verseMaxLines: 2,
                                            verseScaleFactor: 0.6,
                                            verseCentered: true,
                                            onTap: () => _onUploadPhrase(
                                              context: context,
                                              enOldPhrases: _enPhrases,
                                              arOldPhrases: _arPhrases,
                                              enValue: _englishController.text,
                                              arValue: _arabicController.text,
                                              phraseID: _idController.text,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: _clearWidth,
                                    height: _phrasesHeight,
                                    child: _canBuildPhrases == true ? child : null,
                                  ),

                                ],
                              ),
                            );

                          },

                          child: Scroller(
                            controller: _docScrollController,
                            child: ListView.builder(
                                controller: _docScrollController,
                                physics: const BouncingScrollPhysics(),
                                itemCount: _arPhrases.length,
                                itemBuilder: (_, index){

                                  final int _number = index + 1;

                                  final bool _canBuild = _number <= _arPhrases.length && _number <= _enPhrases.length;

                                  final Phrase _enPhrase = _canBuild  ? _enPhrases[index]  : null;
                                  final Phrase _arPhrase = _canBuild  ? _arPhrases[index] : null;

                                  final String _dataKey = _enPhrase?.id;
                                  final String _enValue = _enPhrase?.value;
                                  final String _arValue = _arPhrase?.value;

                                  return
                                    DataStrip(
                                      dataKey: '$_number : $_dataKey',
                                      dataValue: '$_enValue : $_arValue',
                                      onTap: () async {

                                        await _onDeletePhrase(
                                          context: context,
                                          phraseID: _dataKey,
                                          arPhrases: _arPhrases,
                                          enPhrases: _enPhrases,
                                        );

                                      },
                                      withHeadline: true,
                                    );

                                }
                            ),
                          ),

                        );

                      }
                  );

                },
              ),

              builder: (_, bool expanded, Widget widgets){
                return Bubble(
                  title: 'English doc',
                  bubbleColor: Colorz.black255,
                  actionBtIcon: expanded ? Iconz.arrowDown : Iconz.arrowUp,
                  actionBtFunction: _triggerPhrasesExpansion,
                  columnChildren: <Widget>[widgets],
                );
              }
          ),

          /// DATA ENTRY
          ValueListenableBuilder(
            key: const ValueKey<String>('phrases_data_entry'),
            valueListenable: _phrasesExpanded,
            child: Column(
              children: <Widget>[

                TextFieldBubble(
                  title: 'Key',
                  hintText: 'Phrase key',
                  textController: _idController,
                  onBubbleTap: () => _onCopyText(_idController),
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
                  onBubbleTap: () => _onCopyText(_englishController),
                  pasteFunction: () => _onPasteText(_englishController),
                  actionBtFunction: () => _onClearText(_englishController),
                  actionBtIcon: Iconz.xLarge,
                ),

                TextFieldBubble(
                  title: 'عربي',
                  hintText: 'مصطلح عربي',
                  textController: _arabicController,
                  onBubbleTap: () => _onCopyText(_arabicController),
                  pasteFunction: () => _onPasteText(_arabicController),
                  actionBtFunction: () => _onClearText(_arabicController),
                  actionBtIcon: Iconz.xLarge,
                ),

              ],
            ),
            builder: (_, expanded, Widget child){

              if (expanded == true){
                return const SizedBox();
              }

              else {
                return child;
              }

            },
          ),

          const Horizon(heightFactor: 5),

        ],
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
        forceUpdate: true,
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
      forceUpdate: true,
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
      forceUpdate: true,
      phrases: enOldPhrases,
      phrase: Phrase(
        id: phraseID,
        value: enValue,
      ),
    );

    blog('4');

    final List<Phrase> _arPhrases = Phrase.insertPhrase(
      forceUpdate: true,
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
// ---------------------------------------------------------------------------
/// DANGEROUS
Future<void> _createNewTransModel({
  @required BuildContext context,
  @required String enDocName,
  @required String arDocName,
}) async {

  if (enDocName != 'en' && arDocName != 'ar'){

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

  }

  else {
    blog('BITCH YOU CAN NOT DO THIS SHIT OR YOU RUINE EVERYTHING');
  }
}