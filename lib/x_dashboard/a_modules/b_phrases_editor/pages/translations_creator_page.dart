import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
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
            onBubbleTap: () => TextMod.controllerCopy(context, idController.text),
            pasteFunction: () => TextMod.controllerPaste(idController),
            actionBtFunction: () => TextMod.controllerClear(idController),
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
            onBubbleTap: () => TextMod.controllerCopy(context, enController.text),
            pasteFunction: () => TextMod.controllerPaste(enController),
            actionBtFunction: () => TextMod.controllerClear(enController),
            actionBtIcon: Iconz.xLarge,
          ),

          TextFieldBubble(
            title: 'عربي',
            hintText: 'مصطلح عربي',
            textController: arController,
            onBubbleTap: () => TextMod.controllerCopy(context, arController.text),
            pasteFunction: () => TextMod.controllerPaste(arController),
            actionBtFunction: () => TextMod.controllerClear(arController),
            actionBtIcon: Iconz.xLarge,
            textDirection: TextDirection.ltr,
          ),

          if (Keyboard.keyboardIsOn(context) == true)
            const Horizon(
              heightFactor: 3,
            ),

        ],
      ),
    );
  }
}
