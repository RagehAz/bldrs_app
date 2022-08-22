import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/phrase_editor_controllers.dart';
import 'package:flutter/material.dart';

class PhraseCreatorPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhraseCreatorPage({
    @required this.idController,
    @required this.enController,
    @required this.arController,
    @required this.tempMixedPhrases,
    @required this.pageController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TextEditingController idController;
  final TextEditingController enController;
  final TextEditingController arController;
  final ValueNotifier<List<Phrase>> tempMixedPhrases;
  final PageController pageController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    blog('dd');

    return SizedBox(
      key: const ValueKey<String>('PhraseCreatorPage'),
      width: _screenWidth,
      height: _screenHeight,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + 10),
        children: <Widget>[

          /// ID
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

          /// ENGLISH
          TextFieldBubble(
            title: 'English',
            hintText: 'English phrase',
            textController: enController,
            onBubbleTap: () => TextMod.controllerCopy(context, enController.text),
            pasteFunction: () => TextMod.controllerPaste(enController),
            actionBtFunction: () => TextMod.controllerClear(enController),
            actionBtIcon: Iconz.xLarge,
          ),

          /// ARABIC
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

          Align(
            alignment: Aligners.superInverseCenterAlignment(context),
            child: DreamBox(
              verse: 'Confirm'.toUpperCase(),
              height: 50,
              color: Colorz.yellow255,
              verseWeight: VerseWeight.black,
              verseItalic: true,
              verseColor: Colorz.black255,
              margins: const EdgeInsets.symmetric(horizontal: 10),
              onTap: () => onConfirmEditPhrase(
                context: context,
                pageController: pageController,
                arTextController: arController,
                enTextController: enController,
                idTextController: idController,
                tempMixedPhrases: tempMixedPhrases,
                updatedEnPhrase: Phrase(
                    id: idController.text,
                    value: enController.text,
                    langCode: 'en'
                ),
                updatedArPhrase: Phrase(
                    id: idController.text,
                    value: arController.text,
                    langCode: 'ar'
                ),
              ),
            ),
          ),

          if (Keyboard.keyboardIsOn(context) == true)
            const Horizon(
              heightFactor: 5,
            ),

        ],
      ),
    );
  }
}
