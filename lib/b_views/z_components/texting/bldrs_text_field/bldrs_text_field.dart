import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:super_text_field/super_text_field.dart';

class BldrsTextField extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsTextField({
    @required this.appBarType,
    @required this.globalKey,
    @required this.width,
    @required this.titleVerse,
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
    Key key,
  }) : super(key: key);
  // --------------------------------------------------------------------------
  /// main
  final Verse titleVerse;
  final bool isFormField;
  final TextEditingController textController;
  final String initialValue;
  final Verse hintVerse;
  final bool autofocus;
  final FocusNode focusNode;
  final bool counterIsOn;
  final bool autoValidate;

  /// box
  final double width;
  final dynamic margins;
  final double corners;
  final Color fieldColor;

  /// keyboard
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  /// text
  final TextDirection textDirection;
  final bool centered;
  final int maxLines;
  final int minLines;
  final int maxLength;
  final ScrollController scrollController;

  /// styling
  final VerseWeight textWeight;
  final Color textColor;
  final bool textItalic;
  final int textSize;
  final double textScaleFactor;
  final bool textShadow;

  /// functions
  final Function onTap;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onSavedForForm;
  final Function onEditingComplete;
  // final ValueChanged<String> onPaste;
  /// should return error string or null if there is no error
  final String Function(String) validator;

  final bool isFloatingField;
  final ValueNotifier<bool> isObscured;
  final GlobalKey globalKey;
  final AppBarType appBarType;
  // --------------------------------------------------------------------------
   /// TESTED : WORKS PERFECT
  static EdgeInsets getFieldScrollPadding({
    @required BuildContext context,
    @required AppBarType appBarType,
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
    @required BuildContext context,
    @required int minLines,
    @required int textSize,
    @required double scaleFactor,
    @required bool withBottomMargin,
    @required bool withCounter,
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
      width: width,
      globalKey: globalKey,
      textController: textController,

      /// main
      isFormField: isFormField,
      initialValue: initialValue,
      hintText: Verse.bakeVerseToString(
        context: context,
        verse: hintVerse,
      ),
      autofocus: autofocus,
      focusNode: focusNode,
      counterIsOn: counterIsOn,
      autoValidate: autoValidate,

      /// box
      margins: margins,
      corners: corners,
      fieldColor: fieldColor,

      /// text
      textDirection: textDirection ?? UiProvider.getAppTextDir(context),
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
      wordSpacing: BldrsText.superVerseWordSpacing(_verseSizeValue),
      scrollPadding: _scrollPadding,
      textFont: BldrsText.superVerseFont(context, textWeight),

      /// functions
      onTap: onTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onSavedForForm: onSavedForForm,
      onEditingComplete: onEditingComplete,
      validator: validator,

      isObscured: isObscured,
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),

      textPadding: EdgeInsets.all(_textFieldPadding),
      errorTextColor: Colorz.red255,
      enabledBorderColor: Colorz.nothing,
      focusedBorderColor: Colorz.yellow80,
      // errorBorderColor: Colorz.red125,
      focusedErrorBorderColor: Colorz.yellow80,
    );
  }
  /// --------------------------------------------------------------------------
}
