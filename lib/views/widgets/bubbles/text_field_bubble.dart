import 'package:bldrs/view_brains/drafters/aligners.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/texters.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

import 'in_pyramids_bubble.dart';

class TextFieldBubble extends StatelessWidget {
  final String title;
  final String hintText;
  final bool counterIsOn;
  final int maxLines;
  final int maxLength;
  final TextEditingController textController;
  final TextInputType keyboardTextInputType;
  final Function textOnChanged;
  final bool obscured;
  final bool fieldIsFormField;
  final Function onSaved;
  final TextInputAction keyboardTextInputAction;
  final String initialTextValue;
  final Function validator;
  final String comments;
  final bool fieldIsRequired;
  final bool loading;
  final String actionBtIcon;
  final Color actionBtColor;
  final Function actionBtFunction;
  final Function horusOnTapDown;
  final Function horusOnTapUp;
  final Function horusOnTapCancel;
  final String leadingIcon;
  final Function pasteFunction;
  final TextDirection textDirection;
  final Color bubbleColor;

  TextFieldBubble({
    @required this.title,
    this.hintText = '...',
    this.counterIsOn = false,
    this.maxLines = 1,
    this.maxLength = 100,
    this.textController,
    @required this.keyboardTextInputType,
    this.textOnChanged,
    this.obscured,
    this.fieldIsFormField,
    this.onSaved,
    this.keyboardTextInputAction,
    this.initialTextValue,
    this.validator,
    this.comments,
    this.fieldIsRequired = false,
    this.loading = false,
    this.actionBtColor,
    this.actionBtIcon,
    this.actionBtFunction,
    this.horusOnTapDown,
    this.horusOnTapUp,
    this.horusOnTapCancel,
    this.leadingIcon,
    this.pasteFunction,
    this.textDirection,
    this.bubbleColor = Colorz.WhiteGlass,
  });

  @override
  Widget build(BuildContext context) {

    int titleVerseSize = 2;
    double actionBtSize = superVerseRealHeight(context, titleVerseSize, 1, null);
    double actionBtCorner = actionBtSize * 0.4;
    double leadingIconSize = 35;
    double leadingAndFieldSpacing = 5;
    double bubbleClearWidth = superBubbleClearWidth(context);
    double fieldWidth = leadingIcon == null ? bubbleClearWidth : bubbleClearWidth - leadingIconSize - leadingAndFieldSpacing;

    return
      InPyramidsBubble(
          bubbleColor: bubbleColor,
          columnChildren: <Widget>[

            Container(
              // color: Colorz.YellowSmoke,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  // --- BUBBLE TITLE
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                    child: SuperVerse(
                      verse: title,
                      size: titleVerseSize,
                      redDot: fieldIsRequired,
                    ),
                  ),

                  // --- ACTION BUTTON
                  actionBtIcon == null ? Container() :
                  DreamBox(
                    height: actionBtSize,
                    width: actionBtSize,
                    corners: actionBtCorner,
                    color: actionBtColor,
                    icon: actionBtIcon,
                    iconSizeFactor: 0.6,
                    boxFunction: actionBtFunction,
                  ),

                ],
              ),
            ),

            Container(
              // color: Colorz.BloodTest,
              child: Stack(
                alignment: superInverseTopAlignment(context),
                children: <Widget>[

                  // --- TEXT FIELD
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      leadingIcon == null ? Container() :
                      DreamBox(
                        height: 35,
                        width: 35,
                        icon: leadingIcon,
                        iconSizeFactor: leadingIcon == Iconz.ComWebsite ||
                            leadingIcon == Iconz.ComEmail ||
                            leadingIcon == Iconz.ComPhone ?
                        0.6 : 1,
                      ),

                      leadingIcon == null ? Container() :
                      Container(
                        width: 5,
                      ),

                      Container(
                        width: fieldWidth,
                        child: SuperTextField(
                          textDirection: textDirection,
                          fieldIsFormField: fieldIsFormField,
                          hintText: hintText,
                          counterIsOn: counterIsOn,
                          keyboardTextInputType: keyboardTextInputType,
                          maxLines: maxLines,
                          maxLength: maxLength,
                          textController: textController,
                          onChanged: textOnChanged,
                          obscured: obscured == null ? false : obscured,
                          onSaved: onSaved,
                          keyboardTextInputAction: keyboardTextInputAction,
                          initialValue: initialTextValue,
                          validator: validator,
                          inputSize: 2,

                        ),
                      ),

                    ],
                  ),

                  // --- LOADING INDICATOR
                  loading == false ? Container() :
                  Loading(size: 35,),

                  // --- PASSWORD REVEALER ON TAP
                  obscured == null ? Container() :
                  Align(
                    alignment: textDirection == TextDirection.ltr ? Alignment.centerRight : superCenterAlignment(context),
                    child: ShowPassword(
                      obscured: obscured,
                      onTapDown: horusOnTapDown,
                      onTapUp: horusOnTapUp,
                      onTapCancel: horusOnTapCancel,
                      verseSize: 2,
                    ),
                  ),

                  keyboardTextInputType != TextInputType.url ? Container() :
                      DreamBox(
                        height: 35,
                        verse: 'paste  ',
                        verseScaleFactor: 0.5,
                        verseWeight: VerseWeight.thin,
                        verseItalic: true,
                        color: Colorz.WhiteAir,
                        boxFunction: pasteFunction,
                      ),

                ],
              ),
            ),

            // --- BUBBLE COMMENTS
            comments == null ? Container() :
            SuperVerse(
              verse: comments,
              italic: true,
              color: Colorz.WhiteSmoke,
              size: 2,
              weight: VerseWeight.thin,
              leadingDot: true,
            ),

          ]
      )
    ;
  }
}

class ShowPassword extends StatelessWidget {
  final bool obscured;
  final Function onTapDown;
  final Function onTapUp;
  final Function onTapCancel;
  final int verseSize;

  ShowPassword({
    this.obscured = false,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.verseSize = 3,
});

  @override
  Widget build(BuildContext context) {
    return DreamBox(
      height: 35,
      width: 35,
      color: obscured? Colorz.Nothing : Colorz.YellowLingerie,
      icon: Iconz.Views,
      iconColor: obscured? Colorz.WhiteGlass : Colorz.BlackBlack,
      iconSizeFactor: 0.7,
      bubble: false,
      onTapDown: onTapDown == null ? (){} : onTapDown,
      onTapUp: onTapUp == null ? (){} : onTapUp,
      onTapCancel: onTapCancel == null ? (){} : onTapCancel,
      boxFunction: onTapCancel == null ? (){} : onTapCancel,
      corners: superVerseLabelCornerValue(context, verseSize),
    );
  }
}


