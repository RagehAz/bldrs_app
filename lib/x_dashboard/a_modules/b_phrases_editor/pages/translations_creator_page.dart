import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/translations_controller.dart';
import 'package:flutter/material.dart';

class TranslationsCreatorPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TranslationsCreatorPage({
    @required this.idController,
    @required this.enController,
    @required this.arController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TextEditingController idController;
  final TextEditingController enController;
  final TextEditingController arController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return SizedBox(
      key: const ValueKey<String>('translations_creator_page'),
      width: _screenWidth,
      height: _screenHeight,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + 10),
        children: <Widget>[

          TextFieldBubble(
            title: 'Key',
            hintText: 'Phrase key',
            textController: idController,
            onBubbleTap: () => onCopyText(context, idController.text),
            pasteFunction: () => onPasteText(idController),
            actionBtFunction: () => onClearText(idController),
            actionBtIcon: Iconz.xLarge,
            // isError: ,
            columnChildren: <Widget>[

              Row(
                children: <Widget>[

                  DreamBox(
                    height: 35,
                    width: 150,
                    verse: 'Add [phid_] to ID',
                    verseScaleFactor: 0.6,
                    onTap: (){
                      idController.text = 'phid_${idController.text}';
                    },
                  ),

                ],
              ),

            ],
          ),

          TextFieldBubble(
            title: 'English',
            hintText: 'English phrase',
            textController: enController,
            onBubbleTap: () => onCopyText(context, enController.text),
            pasteFunction: () => onPasteText(enController),
            actionBtFunction: () => onClearText(enController),
            actionBtIcon: Iconz.xLarge,
          ),

          TextFieldBubble(
            title: 'عربي',
            hintText: 'مصطلح عربي',
            textController: arController,
            onBubbleTap: () => onCopyText(context, arController.text),
            pasteFunction: () => onPasteText(arController),
            actionBtFunction: () => onClearText(arController),
            actionBtIcon: Iconz.xLarge,
            textDirection: TextDirection.ltr,
          ),

          if (Keyboarders.keyboardIsOn(context) == true)
            const Horizon(
              heightFactor: 3,
            ),

        ],
      ),
    );
  }
}
