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
import 'package:bldrs/e_db/fire/methods/firestore.dart';
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/ops/trans_ops.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
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
  final TextEditingController _keyController = TextEditingController();
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

    const String _langCode = 'en';

    const TransModel _model = TransModel(
      langCode: _langCode,
      phrases: [
        Phrase(id: 'xxx', value: 'blah'),
      ],
    );

    await createNamedDoc(
        context: context,
        collName: FireColl.translations,
        docName: _langCode,
        input: _model.toMap(),
    );

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
  final String _collName = FireColl.translations;
  // -----------------------------
  Future<void> _onChangeDoc() async {

  }
  // ---------------------------------------------------------------------------

  /// UPLOADING

  // -----------------------------
  Future<bool> _preUploadCheck({
    @required TransModel arTransModel,
    @required TransModel enTransModel,
  }) async {

    String _alertMessage;
    bool _continueOps;

    /// EN ID TAKEN
    final bool _idIsTakenEn = Phrase.phrasesIncludeThisID(
      phrases: enTransModel.phrases,
      id: _keyController.text,
    );
    if (_idIsTakenEn == true){
      final Phrase _phrase = Phrase.getPhraseFromPhrasesByID(
          phrases: enTransModel.phrases,
          id: _keyController.text,
      );
      _alertMessage = 'ID is Taken : ${_phrase.id} : value : ${_phrase.value} : langCode : ${_phrase.langCode}';
    }

    /// EN VALUE DUPLICATE
    final bool _valueHasDuplicateEn = Phrase.phrasesIncludeThisValue(
      phrases: enTransModel.phrases,
      value: _englishController.text,
    );
    if (_valueHasDuplicateEn == true){
      final Phrase _phrase = Phrase.getPhraseFromPhrasesByID(
        phrases: enTransModel.phrases,
        id: _englishController.text,
      );
      _alertMessage = 'VALUE is Taken : ${_phrase.id} : value : ${_phrase.value} : langCode : ${_phrase.langCode}';
    }


    /// AR ID TAKEN
    final bool _idIsTakenAr = Phrase.phrasesIncludeThisID(
      phrases: arTransModel.phrases,
      id: _keyController.text,
    );
    if (_idIsTakenAr == true){
      final Phrase _phrase = Phrase.getPhraseFromPhrasesByID(
        phrases: arTransModel.phrases,
        id: _keyController.text,
      );
      _alertMessage = 'ID is Taken : ${_phrase.id} : value : ${_phrase.value} : langCode : ${_phrase.langCode}';
    }

    /// EN VALUE DUPLICATE
    final bool _valueHasDuplicateAr = Phrase.phrasesIncludeThisValue(
      phrases: arTransModel.phrases,
      value: _arabicController.text,
    );
    if (_valueHasDuplicateAr == true){
      final Phrase _phrase = Phrase.getPhraseFromPhrasesByID(
        phrases: arTransModel.phrases,
        id: _arabicController.text,
      );
      _alertMessage = 'VALUE is Taken : ${_phrase.id} : value : ${_phrase.value} : langCode : ${_phrase.langCode}';
    }

    // so ..

    if (_alertMessage != null){

      _continueOps = await CenterDialog.showCenterDialog(
        context: context,
        title: '7aseb !',
        boolDialog: true,
        body: '$_alertMessage\n Wanna continue uploading ?',
      );

    }

    return _continueOps;
  }
  // -----------------------------
  Future<void> _onUploadPhrase({
    @required TransModel arTransModel,
    @required TransModel enTransModel,
  }) async {

    final bool _continueOps = await _preUploadCheck(
        arTransModel: arTransModel,
        enTransModel: enTransModel
    );

    if (_continueOps == true){

      final List<Phrase> _enPhrases = Phrase.insertPhrase(
        forceUpdate: true,
        phrases: enTransModel.phrases,
        phrase: Phrase(
          id: _keyController.text,
          langCode: 'en',
          value: _englishController.text,
        ),
      );

      final List<Phrase> _arPhrases = Phrase.insertPhrase(
        forceUpdate: true,
        phrases: arTransModel.phrases,
        phrase:Phrase(
          id: _keyController.text,
          langCode: 'ar',
          value: _arabicController.text,
        ),
      );

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
          collName: _collName,
          docName: 'en',
          field: 'phrases',
          input: Phrase.cipherPhrases(phrases: _enPhrases),
        );

        await updateDocField(
          context: context,
          collName: _collName,
          docName: 'ar',
          field: 'phrases',
          input:  Phrase.cipherPhrases(phrases: _arPhrases),
        );

        await TopDialog.showTopDialog(
          context: context,
          verse: 'Added : ${_keyController.text}',
          secondLine: '${_englishController.text} : ${_arabicController.text}',
        );

      }

    }

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
    final double _fieldWidth = _screenWidth - 20;

    final double _clearWidth = Bubble.clearWidth(context);

    return DashBoardLayout(
        pageTitle: 'Translations Lab',
        onBldrsTap: _onBldrsTap,
        scrollerIsOn: false,
        listWidgets: <Widget>[

          /// DATA ENTRY
          ValueListenableBuilder(
            valueListenable: _phrasesExpanded,
            child: Column(
              children: <Widget>[

                TextFieldBubble(
                  title: 'Key',
                  hintText: 'Phrase key',
                  textController: _keyController,
                  onBubbleTap: () => _onCopyText(_keyController),
                  pasteFunction: () => _onPasteText(_keyController),
                  actionBtFunction: () => _onClearText(_keyController),
                  actionBtIcon: Iconz.xLarge,

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

          /// PHRASES BUBBLE
          ValueListenableBuilder(
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
                              height: _phrasesHeight + _buttonsHeight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

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
                                            width: 270,
                                            height: _buttonsHeight,
                                            color: Colorz.yellow255,
                                            verse: 'Upload Phrase to\nfirebaseDB / CollName / DocName',
                                            verseColor: Colorz.black255,
                                            secondLineColor: Colorz.black255,
                                            verseShadow: false,
                                            verseMaxLines: 2,
                                            verseScaleFactor: 0.6,
                                            verseCentered: false,
                                            onTap: () => _onUploadPhrase(
                                              enTransModel: enTransModel,
                                              arTransModel: arTransModel,
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
                                itemCount: _enPhrases.length,
                                itemBuilder: (_, index){

                                  final int _number = index + 1;

                                  final Phrase _enPhrase = _enPhrases[index];
                                  final Phrase _arPhrase = _arPhrases[index];

                                  final String _dataKey = _enPhrase.id;
                                  final String _enValue = _enPhrase.value;
                                  final String _arValue = _arPhrase.value;

                                  return
                                    DataStrip(
                                      dataKey: '$_number : $_dataKey',
                                      dataValue: '$_enValue : $_arValue',
                                      onTap: (){
                                        blog('wtf');
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

          const Horizon(),

        ],
    );
  }
}
