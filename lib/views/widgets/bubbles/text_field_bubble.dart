import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

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
  final Function actionBtFunction;
  final Function horusOnTap;
  final String leadingIcon;
  final Function pasteFunction;
  final TextDirection textDirection;
  final Color bubbleColor;
  final Key key;
  final Function fieldOnTap;

  TextFieldBubble({
    @required this.title,
    this.hintText = '...',
    this.counterIsOn = false,
    this.maxLines = 1,
    this.maxLength = 100,
    this.textController,
    this.keyboardTextInputType = TextInputType.text,
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
    this.actionBtIcon,
    this.actionBtFunction,
    this.horusOnTap,
    this.leadingIcon,
    this.pasteFunction,
    this.textDirection,
    this.bubbleColor = Colorz.White20,
    this.key,
    this.fieldOnTap,
  });

  @override
  Widget build(BuildContext context) {

    // int titleVerseSize = 2;
    // double actionBtSize = superVerseRealHeight(context, titleVerseSize, 1, null);
    // double actionBtCorner = actionBtSize * 0.4;
    double leadingIconSize = leadingIcon == null ? 0 : 35;
    double leadingAndFieldSpacing = leadingIcon == null ? 0 : 5;
    double obscureBtSize = obscured == null ? 0 : 35;
    double obscureBtSpacing = obscured == null ? 0 : 5;
    double bubbleClearWidth = Scale.superBubbleClearWidth(context);
    double fieldWidth =
        bubbleClearWidth - leadingIconSize - leadingAndFieldSpacing - obscureBtSize - obscureBtSpacing;

    return
      InPyramidsBubble(
          bubbleColor: bubbleColor,
          title: title,
          redDot: fieldIsRequired,
          actionBtIcon: actionBtIcon,
          actionBtFunction: actionBtFunction,
          stretchy: false,
          bubbleWidth: Scale.superBubbleWidth(context),
          columnChildren: <Widget>[

            Container(
              // color: Colorz.BloodTest,
              child: Stack(
                alignment: Aligners.superInverseTopAlignment(context),
                children: <Widget>[

                  // --- TEXT FIELD
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      /// LEADING ICON
                      if (leadingIcon != null)
                      DreamBox(
                        height: 35,
                        width: 35,
                        icon: leadingIcon,
                        iconSizeFactor: leadingIcon == Iconz.ComWebsite ||
                            leadingIcon == Iconz.ComEmail ||
                            leadingIcon == Iconz.ComPhone ?
                        0.6 : 1,
                      ),

                      /// SPACER
                      if (leadingIcon != null)
                      Container(width: 5,),

                      /// TEXT FIELD
                      Container(
                        width: fieldWidth,
                        child: SuperTextField(
                          onTap: fieldOnTap,
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
                          key: key,
                        ),
                      ),

                      /// SPACER
                      if (obscured != null)
                      Container(width: 5,),

                      /// OBSCURE BUTTON
                      if (obscured != null)
                      DreamBox(
                        height: 35,
                        width: 35,
                        color: obscured? Colorz.Nothing : Colorz.Yellow200,
                        icon: Iconz.Views,
                        iconColor: obscured? Colorz.White20 : Colorz.Black230,
                        iconSizeFactor: 0.7,
                        bubble: false,
                        onTap: horusOnTap,
                        // boxFunction: horusOnTapCancel== null ? (){} : horusOnTapCancel, // this prevents keyboard action from going to next field in the form
                        corners: superVerseLabelCornerValue(context, 3),
                      ),


                    ],
                  ),

                  // --- LOADING INDICATOR
                  if (loading)
                  Loading(size: 35, loading: loading,),


                  keyboardTextInputType != TextInputType.url ? Container() :
                      DreamBox(
                        height: 35,
                        verse: 'paste  ',
                        verseScaleFactor: 0.5,
                        verseWeight: VerseWeight.thin,
                        verseItalic: true,
                        color: Colorz.White10,
                        onTap: pasteFunction,
                      ),

                ],
              ),
            ),

            // --- BUBBLE COMMENTS
            comments == null ? Container() :
            SuperVerse(
              verse: comments,
              italic: true,
              color: Colorz.White80,
              size: 2,
              weight: VerseWeight.thin,
              leadingDot: true,
            ),

          ]
      )
    ;
  }
}

// class ShowPassword extends StatelessWidget {
//   final bool obscured;
//   final Function onTapDown;
//   final Function onTapUp;
//   final Function onTapCancel;
//   final int verseSize;
//
//   ShowPassword({
//     this.obscured = false,
//     this.onTapDown,
//     this.onTapUp,
//     this.onTapCancel,
//     this.verseSize = 3,
// });
//
//   @override
//   Widget build(BuildContext context) {
//     return DreamBox(
//       height: 35,
//       width: 35,
//       color: obscured? Colorz.Nothing : Colorz.YellowLingerie,
//       icon: Iconz.Views,
//       iconColor: obscured? Colorz.WhiteGlass : Colorz.Black225,
//       iconSizeFactor: 0.7,
//       bubble: false,
//       onTapDown: onTapDown == null ? (){} : onTapDown,
//       onTapUp: onTapUp == null ? (){} : onTapUp,
//       onTapCancel: onTapCancel == null ? (){} : onTapCancel,
//       boxFunction: onTapCancel == null ? (){} : onTapCancel,
//       corners: superVerseLabelCornerValue(context, verseSize),
//     );
//   }
// }


