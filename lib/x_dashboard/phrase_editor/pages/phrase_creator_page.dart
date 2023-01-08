import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';



import 'package:bldrs/x_dashboard/phrase_editor/z_components/google_translate_bubble.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class PhraseCreatorPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhraseCreatorPage({
    @required this.idController,
    @required this.enController,
    @required this.arController,
    @required this.appBarType,
    @required this.idNode,
    @required this.enNode,
    @required this.arNode,
    @required this.globalKey,
    @required this.onConfirmEdits,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TextEditingController idController;
  final TextEditingController enController;
  final TextEditingController arController;
  final AppBarType appBarType;
  final FocusNode idNode;
  final FocusNode enNode;
  final FocusNode arNode;
  final GlobalKey<FormState> globalKey;
  final Function onConfirmEdits;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    // --------------------
    return SizedBox(
      key: const ValueKey<String>('PhraseCreatorPage'),
      width: _screenWidth,
      height: _screenHeight,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + 20),
        children: <Widget>[

          /// ID
          TextFieldBubble(
            formKey: globalKey,
            bubbleHeaderVM: BubbleHeaderVM(
              headlineVerse: const Verse(
                text: 'Key',
                translate: false,
              ),
              leadingIcon:  Iconz.xSmall,
              onLeadingIconTap: () => TextMod.controllerClear(idController),
            ),
            isFormField: true,
            focusNode: idNode,

            appBarType: appBarType,
            hintVerse: const Verse(
              text: 'Phrase key',
              translate: false,
            ),
            textController: idController,
            onBubbleTap: () => TextMod.controllerCopy(context, idController.text),
            pasteFunction: () => TextMod.controllerPaste(idController),
            keyboardTextInputAction: TextInputAction.next,
            onSubmitted: (String text){
              Formers.focusOnNode(enNode);
            },
            columnChildren: <Widget>[

              Row(
                children: <Widget>[

                  DreamBox(
                    height: 35,
                    width: 150,
                    verse: const Verse(
                      text: 'Add [phid_] to ID',
                      translate: false,
                    ),
                    verseScaleFactor: 0.6,
                    onTap: (){
                      idController.text = 'phid_${idController.text}';
                    },
                  ),

                ],
              ),

            ],
          ),

          const SizedBox(width: 10, height: 5,),

          GoogleTranslateBubble(
            enController: enController,
          ),

          /// ENGLISH
          TextFieldBubble(
            formKey: globalKey,
            bubbleHeaderVM: BubbleHeaderVM(
              headlineVerse: const Verse(
                text: 'English',
                translate: false,
              ),
              onLeadingIconTap: () => TextMod.controllerClear(enController),
              leadingIcon: Iconz.xSmall,

            ),
            isFormField: true,
            focusNode: enNode,
            appBarType: appBarType,
            hintVerse: const Verse(
              text: 'English phrase',
              translate: false,
            ),
            textController: enController,
            onBubbleTap: () => TextMod.controllerCopy(context, enController.text),
            pasteFunction: () => TextMod.controllerPaste(enController),
            keyboardTextInputAction: TextInputAction.next,
            onSubmitted: (String text){
              Formers.focusOnNode(arNode);
            },
          ),

          const SizedBox(width: 10, height: 5,),

          /// ARABIC
          TextFieldBubble(
            formKey: globalKey,
            bubbleHeaderVM: BubbleHeaderVM(
              headlineVerse: const Verse(
                text: 'عربي',
                translate: false,
              ),
              leadingIcon: Iconz.xSmall,
              onLeadingIconTap: () => TextMod.controllerClear(arController),
            ),
            isFormField: true,
            focusNode: arNode,
            appBarType: appBarType,
            hintVerse: const Verse(
              text: 'مصطلح عربي',
              translate: false,
            ),
            textController: arController,
            onBubbleTap: () => TextMod.controllerCopy(context, arController.text),
            pasteFunction: () => TextMod.controllerPaste(arController),
            textDirection: TextDirection.ltr,
            keyboardTextInputAction: TextInputAction.done,
          ),

          const SizedBox(width: 10, height: 5,),


          Align(
            alignment: Aligners.superInverseCenterAlignment(context),
            child: DreamBox(
              verse: const Verse(
                text: 'Confirm',
                translate: false,
                casing: Casing.upperCase,
              ),
              height: 50,
              color: Colorz.yellow255,
              verseWeight: VerseWeight.black,
              verseItalic: true,
              verseColor: Colorz.black255,
              margins: const EdgeInsets.symmetric(horizontal: 10),
              onTap: onConfirmEdits,
            ),
          ),

          const Horizon(),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
