import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/texting/super_text_field/super_text_field.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class BldrsTextField extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsTextField({
    required this.appBarType,
    required this.width,
    this.height,
    this.globalKey,
    this.textController,

    /// main
    this.isFormField,
    this.initialValue,
    this.hintVerse,
    this.autofocus = false,
    this.focusNode,
    this.counterIsOn = false,
    this.autoValidate = true,

    /// box
    this.margins,
    this.corners = Ratioz.boxCorner12,
    this.fieldColor = Colorz.white10,

    /// text
    this.textDirection,
    this.hintTextDirection,
    this.centered = false,
    this.maxLines = 7,
    this.minLines = 1,
    this.maxLength = 50,
    this.scrollController,

    /// keyboard
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,

    /// styling
    this.textWeight = VerseWeight.regular,
    this.textColor = Colorz.white255,
    this.textItalic = false,
    this.textSize = 2,
    this.textScaleFactor = 1,
    this.textShadow = false,

    /// functions
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onSavedForForm,
    this.onEditingComplete,
    // this.onPaste,
    this.validator,

    this.isFloatingField = false,
    this.isObscured,

    this.forceMaxLength = false,
    this.lineThrough = false,
    this.lineThroughColor = Colorz.red125,

    this.autoCorrect = false,
    this.enableSuggestions = false,

    super.key
  });
  // --------------------------------------------------------------------------
  /// main
  final bool? isFormField;
  final TextEditingController? textController;
  final String? initialValue;
  final Verse? hintVerse;
  final bool autofocus;
  final FocusNode? focusNode;
  final bool counterIsOn;
  final bool autoValidate;

  /// box
  final double width;
  final double? height;
  final dynamic margins;
  final double corners;
  final Color fieldColor;

  /// keyboard
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;

  /// text
  final TextDirection? textDirection;
  final TextDirection? hintTextDirection;
  final bool centered;
  final int maxLines;
  final int minLines;
  final int maxLength;
  final ScrollController? scrollController;

  /// styling
  final VerseWeight textWeight;
  final Color textColor;
  final bool textItalic;
  final int textSize;
  final double textScaleFactor;
  final bool textShadow;

  /// functions
  final Function? onTap;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSubmitted;
  final ValueChanged<String?>? onSavedForForm;
  final Function? onEditingComplete;
  // final ValueChanged<String> onPaste;
  /// should return error string or null if there is no error
  final String? Function(String?)? validator;

  final bool isFloatingField;
  final ValueNotifier<bool>? isObscured;
  final GlobalKey? globalKey;
  final AppBarType? appBarType;

  final bool forceMaxLength;
  final bool lineThrough;
  final Color? lineThroughColor;

  final bool autoCorrect;
  final bool enableSuggestions;
  // --------------------------------------------------------------------------
   /// TESTED : WORKS PERFECT
  static EdgeInsets getFieldScrollPadding({
    required BuildContext context,
    required AppBarType? appBarType,
  }){

    final EdgeInsets _scrollPadding = EdgeInsets.only(
      bottom: 100 + MediaQuery.of(context).viewInsets.bottom,
      top: BldrsAppBar.collapsedHeight(context, appBarType) + BldrsBubbleHeader.getHeight() + Bubble.paddingValue() + 20,
    );

    return _scrollPadding;
  }
  // --------------------
  /// TESTED : ACCEPTED
  static double getFieldHeight({
    required BuildContext context,
    required int minLines,
    required int textSize,
    required double scaleFactor,
    required bool withBottomMargin,
    required bool withCounter,
  }){

    final _textHeight = BldrsText.superVerseRealHeight(
      context: context,
      size: textSize,
      sizeFactor: scaleFactor,
      hasLabelBox: false,
    );

    /// INNER FIELD PADDING
    final double _textFieldPadding = BldrsText.superVerseSidePaddingValues(context, textSize);

    /// UNDER TEXT FIELD BOX MARGIN : THAT WE CAN NOT REMOVE
    final double _bottomMargin = withBottomMargin == true ? 7 : 0;

    final double _counterPaddingValue = withCounter ? 2.5 : 0;
    final double _counterHeight = withCounter ? BldrsText.superVerseRealHeight(
      context: context,
      size: 2,
      sizeFactor: 1,
      hasLabelBox: true,
    ) : 0;

    final double _totalCounterBoxHeight = _counterHeight + (2 * _counterPaddingValue);


    final double _concludedHeight = (_textFieldPadding * 2) + (minLines * _textHeight) + _bottomMargin + _totalCounterBoxHeight;

    return _concludedHeight;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _verseSizeValue = BldrsText.superVerseSizeValue(context, textSize, textScaleFactor) * 1.4;
    final double _textFieldPadding = BldrsText.superVerseSidePaddingValues(context, textSize);
    final EdgeInsets _scrollPadding = getFieldScrollPadding(
      context: context,
      appBarType: appBarType,
    );

    return SuperTextField(
      height: height,
      width: width,
      globalKey: globalKey,
      textController: textController,

      /// main
      isFormField: isFormField ?? true,
      initialValue: initialValue,
      autofocus: autofocus,
      focusNode: focusNode,
      counterIsOn: counterIsOn,
      autoValidate: autoValidate,

      /// HINT
      hintText: Verse.bakeVerseToString(
        verse: hintVerse,
      ),

      /// box
      margins: margins,
      corners: corners,
      fieldColor: fieldColor,

      /// text
      textDirection: textDirection ?? UiProvider.getAppTextDir(),
      hintTextDirection: hintTextDirection ?? UiProvider.getAppTextDir(),
      centered: centered,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      scrollController: scrollController,

      /// keyboard
      textInputType: textInputType,
      textInputAction: textInputAction,

      /// styling
      textWeight: BldrsText.superVerseWeight(textWeight),
      textColor: textColor,
      textItalic: textItalic,
      textHeight: _verseSizeValue,
      textShadows: BldrsText.verseShadows(
        context: context,
        size: textSize,
        shadowIsOn: textShadow,
        textColor: textColor,
        scaleFactor: textScaleFactor,
        weight: textWeight,
        // shadowColor: shadowColor,
      ),
      // package: 'bldrs_theme',
      cursorColor: Colorz.yellow255,
      letterSpacing: BldrsText.superVerseLetterSpacing(textWeight, _verseSizeValue),
      wordSpacing: BldrsText.superVerseWordSpacing(
        verseSize: _verseSizeValue,
        weight: textWeight,
      ),
      scrollPadding: _scrollPadding,
      textFont: BldrsText.superVerseFont(textWeight),

      /// functions
      onTap: onTap,
      onChanged: onChanged == null ? null : (String? text) => onChanged!(text),
      onSubmitted: onSubmitted == null ? null : (String? text) => onSubmitted!(text),
      onSavedForForm: onSavedForForm == null ? null : (String? text) => onSavedForForm!(text),
      onEditingComplete: onEditingComplete,
      validator: validator,

      isObscured: isObscured,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),

      textPadding: EdgeInsets.symmetric(
        horizontal: _textFieldPadding,
      ),
      errorTextColor: Colorz.red255,
      enabledBorderColor: Colorz.nothing,
      focusedBorderColor: Colorz.yellow80,
      // errorBorderColor: Colorz.red125,
      focusedErrorBorderColor: Colorz.yellow80,

      forceMaxLength: forceMaxLength,
      lineThrough: lineThrough,
      lineThroughColor: lineThroughColor,

      autoCorrect: autoCorrect,
      enableSuggestions: enableSuggestions,
    );
  }
  // --------------------------------------------------------------------------
}
