import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/in_pyramids/in_pyramids_items/in_pyramids_bubble.dart';
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
  final String errorMessageIfEmpty;
  final TextInputAction keyboardTextInputAction;
  final String initialTextValue;

  TextFieldBubble({
    @required this.title,
    this.hintText = '...',
    this.counterIsOn = false,
    this.maxLines = 1,
    this.maxLength = 100,
    this.textController,
    @required this.keyboardTextInputType,
    this.textOnChanged,
    this.obscured = false,
    this.fieldIsFormField,
    this.onSaved,
    this.errorMessageIfEmpty,
    this.keyboardTextInputAction,
    this.initialTextValue,
  });

  @override
  Widget build(BuildContext context) {
    return
      InPyramidsBubble(
          bubbleColor: Colorz.WhiteAir,
          columnChildren: <Widget>[

            SuperVerse(
              verse: title,
              margin: 5,
            ),

            SuperTextField(
              fieldIsFormField: fieldIsFormField,
              hintText: hintText,
              counterIsOn: counterIsOn,
              keyboardTextInputType: keyboardTextInputType,
              maxLines: maxLines,
              maxLength: maxLength,
              textController: textController,
              onChanged: textOnChanged,
              obscured: obscured,
              onSaved: onSaved,
              errorMessageIfEmpty: errorMessageIfEmpty,
              keyboardTextInputAction: keyboardTextInputAction,
              initialValue: initialTextValue,
            ),

          ]
      )
    ;
  }
}