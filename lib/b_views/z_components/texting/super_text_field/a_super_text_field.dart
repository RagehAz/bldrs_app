import 'package:bldrs/b_views/z_components/texting/super_text_field/b_super_text_field_box.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_directionerz.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_lab/text_field_form_switcher.dart';
import 'package:flutter/material.dart';

class SuperTextField extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SuperTextField({
    @required this.width,

    /// main
    this.isFormField,
    this.textController,
    this.initialValue,
    this.hintText = '...',
    this.autofocus = false,
    this.focusNode,
    this.counterIsOn = false,

    /// box
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
    this.keyboardTextInputType = TextInputType.text,
    this.keyboardTextInputAction = TextInputAction.done,

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
  final bool isFormField;
  final TextEditingController textController;
  final String initialValue;
  final String hintText;
  final bool autofocus;
  final FocusNode focusNode;
  final bool counterIsOn;

  /// box
  final double width;
  final dynamic margins;
  final double corners;
  final Color fieldColor;

  /// keyboard
  final TextInputType keyboardTextInputType;
  final TextInputAction keyboardTextInputAction;

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
  /// should return error string or null if there is no error
  final String Function() validator;
  /// --------------------------------------------------------------------------
  @override
  _SuperTextFieldState createState() => _SuperTextFieldState();
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
    @required Color fieldColor,
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
      contentPadding: EdgeInsets.all(_textFieldPadding),

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
      fillColor: fieldColor,

      // helperText: 'helper',
      // errorText: 'there is some error here',
      // icon: WebsafeSvg.asset(Iconz.DvRageh, height: 20),
    );

    return _inputDecoration;
  }
// -----------------------------------------------------------------------------
}

class _SuperTextFieldState extends State<SuperTextField> {
  TextEditingController _controller;
  ScrollController _scrollController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _controller = _initializeTextController();

    _scrollController = widget.scrollController ?? ScrollController();
    _textLength = ValueNotifier(_controller.text.length);
    _errors = ValueNotifier<List<String>>(_initializeErrors());

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
    _textLength.dispose();
    _errors.dispose();
    _textDirection.dispose();
  }
// -----------------------------------------------------------------------------
  TextEditingController _initializeTextController(){
    final TextEditingController _controller = widget.textController ?? TextEditingController();
    if (widget.initialValue != null){
      _controller.text = widget.initialValue;
    }
    return _controller;
  }
// -----------------------------------------------------------------------------
  ValueNotifier<List<String>> _errors;
  String _lastValidatorError;
// ------------------------------------------------
  List<String> _initializeErrors(){
    final List<String> _list = <String>[];
    final String _initialError = widget.validator();
    if (_initialError != null){
      _list.add(_initialError);
    }
    return _list;
  }
// ------------------------------------------------
  void _validateInput(){

    final String _validatorError = widget.validator();

    /// WHEN THERE IS AN ERROR FROM VALIDATOR
    if (_validatorError != null){
      _lastValidatorError = _validatorError;
      if (_errors.value.contains(_validatorError) == false){
        _errors.value = <String>[_validatorError, ... _errors.value];
      }
    }
    /// WHEN NO ERROR FROM VALIDATOR
    else {
      _errors.value = _removeLastValidatorErrorIfExisted();
    }

  }
// ------------------------------------------------
  List<String> _removeLastValidatorErrorIfExisted(){

    final List<String> _list = <String>[..._errors.value];
    final int _index = _list.indexOf(_lastValidatorError);

    /// LAST ERROR NOT FOUND : REMOVED ALREADY
    if (_index == -1){

    }
    /// LAST ERROR IS FOUND
    else {
      _list.removeAt(_index);
    }

    return <String>[..._list];
  }
// ------------------------------------------------
  ValueNotifier<int> _textLength;
  void _updateTextLength(String val){

    if (val != null){
      _textLength.value = val.length;
    }

  }
// ------------------------------------------------
  void _updateMaxLengthError(int textLength){

    const String _error = 'Max Characters reached';
    final List<String> _list = <String>[..._errors.value];

    if (textLength > widget.maxLength){
      if (_errors.value.contains(_error) == false){
        _errors.value = <String>[..._list, _error];
      }
    }

    else {
      final int _index = _list.indexOf(_error);
      if (_index != -1){
        _list.removeAt(_index);
        _errors.value = _list;
      }
    }

  }
// ------------------------------------------------
  void _updateMaxLinesError(String text){

    const String _error = 'Max Lines reached';
    final List<String> _list = <String>[..._errors.value];
    final List<String> _rows = text.split('\n');

    if (_rows.length > widget.maxLines){
      if (_errors.value.contains(_error) == false){
        _errors.value = <String>[..._list, _error];
      }
    }

    else {
      final int _index = _list.indexOf(_error);
      if (_index != -1){
        _list.removeAt(_index);
        _errors.value = _list;
      }
    }

  }
// -----------------------------------------------------------------------------
  void _onTextChanged(String val) {

    if (val != null) {

      if (widget.counterIsOn == true){
        _updateTextLength(val);
        _updateMaxLengthError(_textLength.value);
        _updateMaxLinesError(val);
      }
      _validateInput();
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
  Color _getFieldColor(bool errorIsOn){
    return errorIsOn ? Colorz.red230 : widget.fieldColor;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperTextFieldBox(
      width: widget.width,
      margins: widget.margins,
      corners: widget.corners,
      child: ValueListenableBuilder(
        valueListenable: _errors,
        builder: (_, List<String> errors, Widget counter){

          final bool _errorIsOn = Mapper.canLoopList(errors);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              /// TEXT FIELD
              ValueListenableBuilder(
                  key: const ValueKey<String>('The_super_text_field'),
                  valueListenable: _textDirection,
                  builder: (_, TextDirection textDirection, Widget child){

                    final TextDirection _concludedTextDirection = concludeTextDirection(
                      context: context,
                      definedDirection: widget.textDirection,
                      detectedDirection: textDirection,
                    );

                    return TextFormFieldSwitcher(
                      /// main
                      isFormField: widget.isFormField,
                      controller: _controller,
                      hintText: widget.hintText,
                      autoFocus: widget.autofocus,
                      focusNode: widget.focusNode,
                      counterIsOn: widget.counterIsOn,

                      /// box
                      corners: widget.corners,

                      /// keyboard
                      textInputAction: widget.keyboardTextInputAction,
                      textInputType: widget.keyboardTextInputType,

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
                      fieldColor: _getFieldColor(_errorIsOn),

                      /// functions
                      onTap: widget.onTap,
                      onChanged: _onTextChanged,
                      onSubmitted: widget.onSubmitted,
                      onSavedForForm: widget.onSavedForForm,
                      onEditingComplete: widget.onEditingComplete,
                    );

                  }
              ),

              /// COUNTER & ERROR
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  /// ERROR
                  if (_errorIsOn == true)
                  Container(
                    width: widget.width - 110,
                    // color: Colorz.blue255,
                    padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        ...List.generate(errors.length, (index){
                          final String _error = errors[index];
                          return SuperVerse(
                            verse: _error,
                            color: Colorz.red255,
                            weight: VerseWeight.thin,
                            // size: 2,
                            maxLines: 3,
                            centered: false,
                            italic: true,
                            leadingDot: true,
                          );

                        })

                      ],

                    ),
                  ),

                  const SizedBox(),

                  /// COUNTER
                  if (widget.counterIsOn)
                    Container(
                      width: 110,
                      // height: 30,
                      // color: Colorz.black80,
                      alignment: superInverseCenterAlignment(context),
                      child: ValueListenableBuilder(
                        valueListenable: _textLength,
                        builder: (_, int textLength, Widget child){

                          return SuperVerse(
                            verse: '$textLength / ${widget.maxLength}',
                            weight: VerseWeight.thin,
                            // size: 2,
                            // scaleFactor: 1,
                            labelColor: _getFieldColor(_errorIsOn),
                          );

                        },
                      ),
                    ),

                ],
              ),
            ],
          );

        },
      ),
    );

  }
}
