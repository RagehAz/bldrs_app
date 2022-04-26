import 'package:bldrs/b_views/z_components/texting/super_text_field/b_super_text_field_box.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/text_directionerz.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_lab/text_field_form_switcher.dart';
import 'package:flutter/material.dart';

class NewTextField extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NewTextField({
    /// main
    this.fieldKey,
    this.textController,
    this.hintText = '...',
    this.autofocus = false,
    this.focusNode,
    this.counterIsOn = false,

    /// box
    this.width,
    this.height,
    this.margins,
    this.corners = Ratioz.boxCorner12,
    this.fieldColor = Colorz.white10,

    /// text
    this.textDirection,
    this.obscured = false,
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
    this.textSizeFactor = 1,
    this.textShadow = false,

    /// functions
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onSavedForForm,
    this.onEditingComplete,
    this.validator,

    Key key,
  }) : super(key: key);
  // --------------------------------------------------------------------------
  /// main
  final Key fieldKey;
  final TextEditingController textController;
  final String hintText;
  final bool autofocus;
  final FocusNode focusNode;
  final bool counterIsOn;

  /// box
  final double width;
  final double height;
  final dynamic margins;
  final double corners;
  final Color fieldColor;

  /// keyboard
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  /// text
  final TextDirection textDirection;
  final bool obscured;
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
  final double textSizeFactor;
  final bool textShadow;

  /// functions
  final Function onTap;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onSavedForForm;
  final Function onEditingComplete;
  final ValueChanged<String> validator;
  /// --------------------------------------------------------------------------
  @override
  _NewTextFieldState createState() => _NewTextFieldState();
/// --------------------------------------------------------------------------
  static TextStyle createHintStyle({
    @required BuildContext context,
    @required int textSize,
    @required double textSizeFactor,
    @required bool textItalic,
  }) {

    return SuperVerse.createStyle(
        context: context,
        color: Colorz.white80,
        weight: VerseWeight.thin,
        italic: textItalic,
        size: textSize,
        scaleFactor: textSizeFactor * 0.8,
        shadow: false,
    );

  }
// -----------------------------------------------------------------------------
  static TextStyle createErrorStyle({
    @required BuildContext context,
    @required int textSize,
    @required double textSizeFactor,
    @required bool textItalic,
  }){
    return SuperVerse.createStyle(
      context: context,
      color: Colorz.red255,
      weight: VerseWeight.thin,
      italic: textItalic,
      size: textSize,
      scaleFactor: textSizeFactor * 0.6,
      shadow: false,
    );
  }
// -----------------------------------------------------------------------------
  static OutlineInputBorder createOutlineBorder({
    @required Color borderColor,
    @required double corners,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(corners),
      borderSide: BorderSide(
        color: borderColor,
        width: 0.5,
      ),
      gapPadding: 0,
    );
  }
// -----------------------------------------------------------------------------
  static InputDecoration createDecoration({
    @required BuildContext context,
    @required int textSize,
    @required double textSizeFactor,
    @required String hintText,
    @required bool textItalic,
    @required double corners,
}){

    final double _textFieldPadding = SuperVerse.superVerseSidePaddingValues(context, textSize);

    final InputDecoration _inputDecoration = InputDecoration(
      hintText: hintText,
      hintMaxLines: 1,
      hintStyle: createHintStyle(
          context: context,
          textSize: textSize,
          textSizeFactor: textSizeFactor,
          textItalic: textItalic,
      ),
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.symmetric(horizontal: _textFieldPadding),

      focusedBorder: createOutlineBorder(
          borderColor: Colorz.yellow80,
          corners: corners,
      ),
      enabledBorder: createOutlineBorder(
          borderColor: Colorz.nothing,
          corners: corners,
      ),

      errorStyle: createErrorStyle(
        context: context,
        textSize: textSize,
        textItalic: textItalic,
        textSizeFactor: textSizeFactor,
      ),
      focusedErrorBorder: createOutlineBorder(
        borderColor: Colorz.yellow80,
        corners: corners,
      ),

      errorBorder: createOutlineBorder(
        borderColor: Colorz.red125,
        corners: corners,
      ),
      border: createOutlineBorder(
          borderColor: Colorz.linkedIn,
          corners: corners
      ),
      disabledBorder: createOutlineBorder(
          borderColor: Colorz.grey255,
          corners: corners,
      ),

      counter: const Offstage(),
      // counterText: '${widget.textController?.text?.length} / ${widget.maxLength}',
      // counterStyle: superTextStyle(Colorz.white200, 0.7),

      // SOME BULLSHIT
      isDense: false,
      // isCollapsed: false,
      // semanticCounterText: 'semantic',
      focusColor: Colorz.green255,
      filled: true,
      fillColor: Colorz.white10,

      // helperText: 'helper',
      // errorText: 'there is some error here',
      // icon: WebsafeSvg.asset(Iconz.DvRageh, height: 20),
    );

    return _inputDecoration;
  }
// -----------------------------------------------------------------------------
}

class _NewTextFieldState extends State<NewTextField> {
  TextEditingController _controller;
  ScrollController _scrollController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _controller = widget.textController ?? TextEditingController();
    _scrollController = widget.scrollController ?? ScrollController();

    final TextDirection _initialTextDirection = superTextDirectionSwitcher(
      val: widget.textController?.text,
      context: context,
    );

    _textDirection = ValueNotifier(_initialTextDirection);

  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
// -----------------------------------------------------------------------------
  void _onTextChanged(String val) {

    if (val != null) {
      _changeTextDirection(val);

      if (widget.onChanged != null) {
        widget.onChanged(val);
      }
    }
  }
// -----------------------------------------------------------------------------
  /// --- TEXT DIRECTION BLOCK
  ValueNotifier<TextDirection> _textDirection;
  void _changeTextDirection(String val) {
    /// USE LIKE THIS :-
    /// onChanged: (val){_changeTextDirection();},
    _textDirection.value = superTextDirectionSwitcher(
      val: val,
      context: context,
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperTextFieldBox(
      width: widget.width,
      height: widget.height,
      margins: widget.margins,
      corners: widget.corners,
      fieldColor: widget.fieldColor,
      child: ValueListenableBuilder(
          valueListenable: _textDirection,
          builder: (_, TextDirection textDirection, Widget child){

            final TextDirection _concludedTextDirection = concludeTextDirection(
              context: context,
              definedDirection: widget.textDirection,
              detectedDirection: textDirection,
            );


            return TextFormFieldSwitcher(
              /// main
              fieldKey: widget.fieldKey,
              controller: _controller,
              hintText: widget.hintText,
              autoFocus: widget.autofocus,
              focusNode: widget.focusNode,
              counterIsOn: widget.counterIsOn,

              /// box
              corners: widget.corners,

              /// keyboard
              textInputAction: widget.textInputAction,
              textInputType: widget.textInputType,

              /// text
              textDirection: _concludedTextDirection,
              obscured: widget.obscured,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              scrollController: _scrollController,

              /// styling
              centered: widget.centered,
              textShadow: widget.textShadow,
              textWeight: widget.textWeight,
              textSize: widget.textSize,
              textSizeFactor: widget.textSizeFactor,
              textItalic: widget.textItalic,
              textColor: widget.textColor,

              /// functions
              onTap: widget.onTap,
              onChanged: _onTextChanged,
              onSubmitted: widget.onSubmitted,
              onSavedForForm: widget.onSavedForForm,
              onEditingComplete: widget.onEditingComplete,
              validator: widget.validator,
            );

          }
          ),
    );

  }
}
