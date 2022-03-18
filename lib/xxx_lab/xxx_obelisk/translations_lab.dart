import 'package:bldrs/a_models/kw/chain/chain_properties.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/xxx_dashboard/b_views/c_components/layout/dashboard_layout.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class TranslationsLab extends StatefulWidget {

  const TranslationsLab({
    Key key
  }) : super(key: key);

  @override
  _TranslationsLabState createState() => _TranslationsLabState();
}

class _TranslationsLabState extends State<TranslationsLab> {

  final TextEditingController _englishController = TextEditingController();
  final TextEditingController _arabicController = TextEditingController();

  Future<void> _onBldrsTap() async {

  }

  Future<void> _printKeywords() async {
    // -----------------------------------------------------------------------
    List<KW> _keywords = ChainProperties.chain.sons;

  }
  // -----------------------------------------------------------------------
  void _onClearText(TextEditingController controller){

    setState(() {
      controller.text = '';
    });

  }
  // -----------------------------
  Future<void> _onPasteText(TextEditingController controller) async {

    final String value = await FlutterClipboard.paste();
    setState(() {
      _englishController.text = value;
    });

  }
  // -----------------------------
  Future<void> _onCopyText(TextEditingController controller) async {
    await Keyboarders.copyToClipboard(
      context: context,
      copy: controller.text,
    );
  }
  // -----------------------------
  Future<void> _onChangeDoc() async {

  }
  // -----------------------------
  Future<void> _onUploadPhrase() async {

  }
  // -----------------------------------------------------------------------
  bool _phrasesExpanded = false;
  // ---------------------------------
  void _triggerPhrasesExpansion(){
    setState(() {
      _phrasesExpanded = !_phrasesExpanded;
    });
  }
  // -----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    final double _fieldWidth = _screenWidth - 20;

    return DashBoardLayout(
        pageTitle: 'Translations Lab',
        onBldrsTap: _onBldrsTap,
        scrollable: false,
        listWidgets: <Widget>[

          if (_phrasesExpanded == false)
          Column(
            children: <Widget>[

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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    DreamBox(
                      height: 50,
                      verse: 'Change\nDoc.',
                      verseMaxLines: 2,
                      verseScaleFactor: 0.7,
                      onTap: _onChangeDoc,
                    ),

                    DreamBox(
                      width: 270,
                      height: 50,
                      color: Colorz.yellow255,
                      verse: 'Upload Phrase to\nfirebaseDB / CollName / DocName',
                      verseColor: Colorz.black255,
                      secondLineColor: Colorz.black255,
                      verseShadow: false,
                      verseMaxLines: 2,
                      verseScaleFactor: 0.6,
                      verseCentered: false,
                      onTap: _onUploadPhrase,
                    ),

                  ],
                ),
              ),

            ],
          ),


          Bubble(
            title: 'English doc',
            bubbleColor: Colorz.black255,
            actionBtIcon: _phrasesExpanded ? Iconz.arrowDown : Iconz.arrowUp,
            actionBtFunction: _triggerPhrasesExpansion,
            columnChildren: <Widget>[

              Container(
                width: Bubble.clearWidth(context),
                height: _phrasesExpanded ? 500 :  200,
                color: Colorz.blue125,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 30,
                    itemBuilder: (_, index){

                      return
                        DataStrip(
                          dataKey: 'dataKey',
                          dataValue: 'Value',
                          onTap: (){},
                          withHeadline: true,
                        );

                    }
                    ),
              ),

            ],
          ),

        ],
    );
  }
}
