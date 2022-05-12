import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldSwitcher extends StatelessWidget {

  const TextFormFieldSwitcher({
    /// main
    @required this.isFormField,
    @required this.controller,
    @required this.hintText,
    @required this.autoFocus,
    @required this.focusNode,
    @required this.counterIsOn,
    @required this.autoValidate,

    /// box
    @required this.corners,

    /// text
    @required this.textDirection,
    @required this.obscured,
    @required this.centered,
    @required this.minLines,
    @required this.maxLines,
    @required this.maxLength,
    @required this.scrollController,

    /// keyboard
    @required this.textInputAction,
    @required this.textInputType,

    /// styling
    @required this.textWeight,
    @required this.textColor,
    @required this.textItalic,
    @required this.textSize,
    @required this.textSizeFactor,
    @required this.textShadow,
    @required this.fieldColor,

    /// functions
    @required this.onTap,
    @required this.onChanged,
    @required this.onSubmitted,
    @required this.onSavedForForm,
    @required this.onEditingComplete,
    @required this.validator,

    Key key,
  }) : super(key: key);

  /// main
  final bool isFormField;
  final TextEditingController controller;
  final String hintText;
  final bool autoFocus;
  final FocusNode focusNode;
  final bool counterIsOn;
  final bool autoValidate;

  /// box
  final double corners;

  /// keyboard
  final TextInputAction textInputAction;
  final TextInputType textInputType;

  /// TEXT
  final TextDirection textDirection;
  final bool obscured;
  final bool centered;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final ScrollController scrollController;

  /// STYLING
  final VerseWeight textWeight;
  final Color textColor;
  final bool textItalic;
  final int textSize;
  final double textSizeFactor;
  final bool textShadow;
  final Color fieldColor;

  /// functions
  final Function onTap;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onSavedForForm;
  final Function onEditingComplete;
  final String Function(String) validator;
// -----------------------------------------------------------------------------
  static TextInputType _getKeyboardType({
    @required TextInputAction textInputAction,
    @required TextInputType textInputType,
  }){
    final _textInputType = textInputAction == TextInputAction.newline ?
    TextInputType.multiline
        :
    textInputType;

    return _textInputType;
  }
// -----------------------------------------------------------------------------
  Widget counterBuilder(BuildContext context, {int currentLength, bool isFocused, int maxLength}){
    return SuperTextField.textFieldCounter(
      currentLength: currentLength,
      maxLength: maxLength,
      fieldColor: fieldColor,
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final TextStyle _style = SuperVerse.createStyle(
        context: context,
        weight: textWeight,
        color: textColor,
        italic: textItalic,
        size: textSize,
        scaleFactor: textSizeFactor,
        shadow: textShadow,
    );
// -----------------------------------------------------------------------------
    final InputDecoration _inputDecoration = SuperTextField.createDecoration(
      context: context,
      textSize: textSize,
      textSizeFactor: textSizeFactor,
      hintText: hintText,
      textItalic: textItalic,
      corners: corners,
      fieldColor: fieldColor,
      counterIsOn: counterIsOn,
    );
// -----------------------------------------------------------------------------
    const EdgeInsets _scrollPadding = EdgeInsets.only(bottom: 50);
// -----------------------------------------------------------------------------
    final int _maxLines = obscured == true ? 1 : maxLines;
// -----------------------------------------------------------------------------
    const Color _cursorColor = Colorz.yellow255;
// -----------------------------------------------------------------------------
    const MaxLengthEnforcement _maxLengthEnforced =
    // counterIsOn == true ?
    // MaxLengthEnforcement.enforced
    //     :
    MaxLengthEnforcement.none;
// -----------------------------------------------------------------------------
    final TextAlign _textAlign = centered == true ?
    TextAlign.center
        :
    TextAlign.start;
// -----------------------------------------------------------------------------
    const TextAlignVertical _textAlignVertical = TextAlignVertical.center;
// -----------------------------------------------------------------------------

    /// WHEN TEXT FORM FIELD
    if (isFormField == true){
      return TextFormField(
        /// main
        // key: fieldKey ?? key,
        controller: controller,
        autofocus: autoFocus,
        focusNode: focusNode,

        /// scrolling
        scrollPhysics: const BouncingScrollPhysics(),
        scrollPadding: _scrollPadding,

        /// text
        textDirection: textDirection,
        obscureText: obscured,
        minLines: minLines,
        maxLines: _maxLines,
        maxLength: maxLength, /// NO IMPACT
        maxLengthEnforcement: _maxLengthEnforced,
        scrollController: scrollController,

        /// keyboard
        textInputAction: textInputAction,
        keyboardType: _getKeyboardType(
          textInputAction: textInputAction,
          textInputType: textInputType,
        ),
        keyboardAppearance: Brightness.dark,

        /// styling
        style: _style,
        textAlign: _textAlign,
        cursorColor: _cursorColor,
        cursorRadius: const Radius.circular(3),
        decoration: _inputDecoration,
        textAlignVertical: _textAlignVertical,

        /// counter
        buildCounter: counterIsOn ? counterBuilder : null,

        /// functions
        onTap: onTap,
        onChanged: (String val) => onChanged(val),
        onFieldSubmitted: (String val) => onSubmitted(val),
        onSaved: (String val) => onSavedForForm(val),
        onEditingComplete: onEditingComplete,
        validator: validator,

        autovalidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,

        /// other stuff
        enabled: true, /// THIS DISABLES THE ABILITY TO OPEN THE KEYBOARD
        autocorrect: false,

      );
    }

    /// WHEN TEXT FIELD
    else {
      return TextField(
        /// main
        // key: key,
        controller: controller,
        autofocus: autoFocus,
        focusNode: focusNode,

        /// scrolling
        scrollPhysics: const BouncingScrollPhysics(),
        scrollPadding: _scrollPadding,


        /// text
        textDirection: textDirection,
        obscureText: obscured,
        minLines: minLines,
        maxLines: _maxLines,
        maxLength: maxLength, /// NO IMPACT
        maxLengthEnforcement: _maxLengthEnforced,
        scrollController: scrollController,

        /// keyboard
        textInputAction: textInputAction,
        keyboardType: _getKeyboardType(
          textInputAction: textInputAction,
          textInputType: textInputType,
        ),
        keyboardAppearance: Brightness.dark,

        /// styling
        style: _style,
        textAlign: _textAlign,
        cursorColor: _cursorColor,
        cursorRadius: const Radius.circular(3),
        decoration: _inputDecoration,
        textAlignVertical: _textAlignVertical,

        /// counter
        buildCounter: counterIsOn ? counterBuilder : null,

        /// functions
        onTap: onTap,
        onChanged: (String val) => onChanged(val),
        onSubmitted: onSubmitted == null ? null : (String val) => onSubmitted(val),
        onEditingComplete: onEditingComplete,

        /// other stuff
        enabled: true, /// THIS DISABLES THE ABILITY TO OPEN THE KEYBOARD
        autocorrect: false,
      );
    }

  }
}
