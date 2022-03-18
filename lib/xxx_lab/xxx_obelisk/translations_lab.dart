import 'package:bldrs/a_models/kw/chain/chain_crafts.dart';
import 'package:bldrs/a_models/kw/chain/chain_properties.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/main_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_text_field.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
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

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _fieldWidth = _screenWidth - 20;

    return DashBoardLayout(
        pageTitle: 'Translations Lab',
        onBldrsTap: _onBldrsTap,
        listWidgets: <Widget>[

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
              children: <Widget>[

                DreamBox(
                  height: 50,
                  verse: 'Do the\ndamn thing',
                  verseMaxLines: 2,
                  verseScaleFactor: 0.7,
                  onTap: _printKeywords,
                ),

              ],
            ),
          ),


        ],
    );
  }
}
