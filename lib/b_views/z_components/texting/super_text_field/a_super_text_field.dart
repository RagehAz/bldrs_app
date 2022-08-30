import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/b_super_text_field_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/text_field_form_switcher.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuperTextField extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SuperTextField({
    @required this.appBarType,
    @required this.globalKey,
    @required this.width,
    @required this.textController,
    @required this.titleVerse,

    /// main
    this.isFormField,
    this.initialValue,
    this.hintVerse = '...',
    this.autofocus = false,
    this.focusNode,
    this.counterIsOn = false,
    this.autoValidate = false,

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
    this.textSizeFactor = 1,
    this.textShadow = false,

    /// functions
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onSavedForForm,
    this.onEditingComplete,
    this.validator,

    this.isFloatingField = false,
    this.canObscure,
    Key key,
  }) : super(key: key);
  // --------------------------------------------------------------------------
  /// main
  final String titleVerse;
  final bool isFormField;
  final TextEditingController textController;
  final String initialValue;
  final String hintVerse;
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

  final bool isFloatingField;
  final bool canObscure;
  final GlobalKey globalKey;
  final AppBarType appBarType;
  /// --------------------------------------------------------------------------
  @override
  _SuperTextFieldState createState() => _SuperTextFieldState();
// --------------------------------------------------------------------------
  /// TESTED : ACCEPTED
  static double getFieldHeight({
    @required BuildContext context,
    @required int minLines,
    @required int textSize,
    @required double scaleFactor,
    @required bool withBottomMargin,
    @required bool withCounter,
}){

    final _textHeight = SuperVerse.superVerseRealHeight(
      context: context,
      size: textSize,
      sizeFactor: scaleFactor,
      hasLabelBox: false,
    );

    /// INNER FIELD PADDING
    final double _textFieldPadding = SuperVerse.superVerseSidePaddingValues(context, textSize);

    /// UNDER TEXT FIELD BOX MARGIN : THAT WE CAN NOT REMOVE
    final double _bottomMargin = withBottomMargin == true ? 7 : 0;

    final double _counterPaddingValue = withCounter ? 2.5 : 0;
    final double _counterHeight = withCounter ? SuperVerse.superVerseRealHeight(
      context: context,
      size: 2,
      sizeFactor: 1,
      hasLabelBox: true,
    ) : 0;

    final double _totalCounterBoxHeight = _counterHeight + (2 * _counterPaddingValue);


    final double _concludedHeight = (_textFieldPadding * 2) + (minLines * _textHeight) + _bottomMargin + _totalCounterBoxHeight;

    return _concludedHeight;
  }
// -----------------------------------------------------------------------------
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
        shadowIsOn: false,
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
      // italic: true,
      size: textSize,
      scaleFactor: textSizeFactor,
      shadowIsOn: false,
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
  static Widget textFieldCounter({
    @required int currentLength,
    @required int maxLength,
    @required Color fieldColor,
}){
    return SuperVerse(
      verse:  '$currentLength / $maxLength',
      weight: VerseWeight.thin,
      // size: 2,
      // scaleFactor: 1,
      labelColor: currentLength > maxLength ? Colorz.red125 : fieldColor,
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
    @required bool counterIsOn,
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
      errorMaxLines: 3,
      // errorText: 'initial state error text',

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

      counter: counterIsOn == true ? null : const Offstage(),
      // counterText: 'a77aaaa ',

      // counterText: '${widget.textController?.text?.length} / ${widget.maxLength}',
      // counterStyle: superTextStyle(Colorz.white200, 0.7),

      // SOME BULLSHIT
      isDense: true,
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
// -----------------------------------------------------------------------------
  TextEditingController _controller;
  ScrollController _scrollController;
  FocusNode _focusNode;
  ValueNotifier<String> _textValue;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _controller = _initializeTextController();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus == true){
        if (widget.globalKey != null){
          final RenderObject object = widget.globalKey.currentContext?.findRenderObject();
          object?.showOnScreen();
        }
      }
    });

    _scrollController = widget.scrollController ?? ScrollController();
    // _textLength = ValueNotifier(_controller.text.length);
    // _errors = ValueNotifier<List<String>>(_initializeErrors());

    final TextDirection _initialTextDirection = TextDir.superTextDirectionSwitcher(
      val: widget.textController?.text,
      context: context,
    );

    _textDirection = ValueNotifier(_initialTextDirection);

  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose(){

    if (widget.textController == null){
      _controller.dispose();
    }

    if (widget.scrollController == null){
      _scrollController.dispose();
    }

    if (widget.focusNode == null){
      _focusNode.dispose();
    }

    _textValue.dispose();

    _textDirection.dispose();

    super.dispose();
  }
// -----------------------------------------------------------------------------
  TextEditingController _initializeTextController(){

    final TextEditingController _controller = widget.textController ??
        TextEditingController(text: widget.initialValue ?? '');

    _textValue = ValueNotifier(_controller.text);
    _controller.addListener(() {

      setNotifier(
          notifier: _textValue,
          mounted: mounted,
          value: _controller.text,
      );

    });

    return _controller;
  }
// -----------------------------------------------------------------------------
  /*
//   ValueNotifier<List<String>> _errors;
//   String _lastValidatorError;
// ------------------------------------------------
//   List<String> _initializeErrors(){
//     // final List<String> _list = <String>[];
//     // final String _initialError = widget.validator();
//     // if (_initialError != null){
//     //   _list.add(_initialError);
//     // }
//     return <String>[];
//   }
// ------------------------------------------------
//   void _validateInput(){
//
//     const String _validatorError = null;
//
//     /// WHEN THERE IS AN ERROR FROM VALIDATOR
//     if (_validatorError != null){
//       _lastValidatorError = _validatorError;
//       if (_errors.value.contains(_validatorError) == false){
//         _errors.value = <String>[_validatorError, ... _errors.value];
//       }
//     }
//     /// WHEN NO ERROR FROM VALIDATOR
//     else {
//       _errors.value = _removeLastValidatorErrorIfExisted();
//     }
//
//   }
// ------------------------------------------------
//   List<String> _removeLastValidatorErrorIfExisted(){
//
//     final List<String> _list = <String>[..._errors.value];
//     final int _index = _list.indexOf(_lastValidatorError);
//
//     /// LAST ERROR NOT FOUND : REMOVED ALREADY
//     if (_index == -1){
//
//     }
//     /// LAST ERROR IS FOUND
//     else {
//       _list.removeAt(_index);
//     }
//
//     return <String>[..._list];
//   }
// ------------------------------------------------
//   ValueNotifier<int> _textLength;
//   void _updateTextLength(String val){
//
//     if (val != null){
//       _textLength.value = val.length;
//     }
//
//   }
// ------------------------------------------------
//   void _updateMaxLengthError(int textLength){
//
//     const String _error = 'Max Characters reached';
//     final List<String> _list = <String>[..._errors.value];
//
//     if (textLength > widget.maxLength){
//       if (_errors.value.contains(_error) == false){
//         _errors.value = <String>[..._list, _error];
//       }
//     }
//
//     else {
//       final int _index = _list.indexOf(_error);
//       if (_index != -1){
//         _list.removeAt(_index);
//         _errors.value = _list;
//       }
//     }
//
//   }
// ------------------------------------------------
//   void _updateMaxLinesError(String text){
//
//     const String _error = 'Max Lines reached';
//     final List<String> _list = <String>[..._errors.value];
//     final List<String> _rows = text.split('\n');
//
//     if (_rows.length > widget.maxLines){
//       if (_errors.value.contains(_error) == false){
//         _errors.value = <String>[..._list, _error];
//       }
//     }
//
//     else {
//       final int _index = _list.indexOf(_error);
//       if (_index != -1){
//         _list.removeAt(_index);
//         _errors.value = _list;
//       }
//     }
//
//   }
   */
// -----------------------------------------------------------------------------
  void _onTextChanged(String val) {

    if (val != null) {

      if (widget.counterIsOn == true){
        // _updateTextLength(val);
        // _updateMaxLengthError(_textLength.value);
        // _updateMaxLinesError(val);
      }
      // _validateInput();
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
    _textDirection.value = TextDir.superTextDirectionSwitcher(
      val: val,
      context: context,
    );
  }
// -----------------------------------------------------------------------------
  String _validator(String val){

    if (widget.validator == null){
      return null;
    }
    else {
      return widget.validator();
    }

  }
// -----------------------------------------------------------------------------
  void _onTap(BuildContext context){

    // FocusManager.instance.rootScope.requestFocus();

    if (widget.globalKey != null){
      final RenderObject object = widget.globalKey.currentContext?.findRenderObject();
      object?.showOnScreen();
    }

    if (widget.isFloatingField != null){

      final bool _keyboardIs = Keyboard.keyboardIsOn(context);
      blog('tapping keyboard : $_keyboardIs : _controller : ${_controller.hashCode} : widget.isFloatingField : ${widget.isFloatingField}');

      final KeyboardModel model = KeyboardModel(
        titleVerse: widget.titleVerse,
        hintVerse: widget.hintVerse,
        controller: _controller,
        minLines: widget.minLines ?? 1,
        maxLines: widget.maxLines ?? 1,
        maxLength: widget.maxLength ?? 100,
        textInputAction: widget.textInputAction,
        textInputType: widget.textInputType,
        focusNode: _focusNode,
        canObscure: widget.canObscure,
        counterIsOn: widget.counterIsOn,
        isFormField: widget.isFormField,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        onSavedForForm: widget.onSavedForForm,
        onSubmitted: widget.onSubmitted,
        isFloatingField: widget.isFloatingField,
      );

      // FocusManager.instance.primaryFocus?.unfocus();
      // FocusManager.instance.primaryFocus?.requestFocus();

      final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

      _uiProvider.setKeyboard(
        model: model,
        notify: false,
        invoker: 'SuperTextField : _onTap()',
      );
      _uiProvider.setKeyboardIsOn(
          setTo: true,
          notify: true,
      );

    }

    if (widget.onTap != null){
      widget.onTap();
    }

  }
// -----------------------------------------------------------------------------
  bool _checkCanObscure(bool proObscured){
    bool _can = false;
    if (widget.canObscure == true){
      _can = proObscured;
    }
    return _can;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('rebuilding field : ${widget.titleVerse} : ${widget.textController.hashCode}');

    /// NORMAL TEXT FIELD
    // if (widget.isFloatingField == false){
      return SuperTextFieldBox(
        width: widget.width,
        margins: widget.margins,
        corners: widget.corners,
        child: ValueListenableBuilder(
            key: const ValueKey<String>('The_super_text_field'),
            valueListenable: _textDirection,
            builder: (_, TextDirection textDirection, Widget child){

              final TextDirection _concludedTextDirection = TextDir.concludeTextDirection(
                context: context,
                definedDirection: widget.textDirection,
                detectedDirection: textDirection,
              );

              return Selector<UiProvider, bool>(
                selector: (_, UiProvider uiPro) => uiPro.textFieldsObscured,
                shouldRebuild: (bool oldVal, bool newVal){
                  return oldVal != newVal;
                },
                builder: (_, bool _isObscured, Widget child){

                  return TextFormFieldSwitcher(
                    appBarType: widget.appBarType,
                    /// main
                    isFormField: widget.isFormField,
                    controller: _controller,
                    hintText: widget.hintVerse,
                    autoFocus: widget.autofocus,
                    focusNode: _focusNode,
                    counterIsOn: widget.counterIsOn,
                    autoValidate: widget.autoValidate,

                    /// box
                    corners: widget.corners,

                    /// keyboard
                    textInputAction: widget.textInputAction,
                    textInputType: widget.textInputType,

                    /// text
                    textDirection: _concludedTextDirection,
                    obscured: _checkCanObscure(_isObscured),
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
                    fieldColor: widget.fieldColor,

                    /// functions
                    onTap: () => _onTap(context),
                    onChanged: _onTextChanged,
                    onSubmitted: widget.onSubmitted,
                    onSavedForForm: widget.onSavedForForm,
                    onEditingComplete: widget.onEditingComplete,
                    validator: _validator,
                    readOnly: widget.isFloatingField,
                    // readOnly: widget.isFloatingField,
                  );

                },
              );

            }
        ),
      );
    }

    /// FLOATING TEXT FIELD
    // else {
    //   return GestureDetector(
    //     onTap: () => _onTap(context),
    //     child: Container(
    //       width: widget.width,
    //       // height: SuperTextField.getFieldHeight(
    //       //   context: context,
    //       //   minLines: widget.minLines ?? 1,
    //       //   scaleFactor: widget.textSizeFactor,
    //       //   textSize: widget.textSize,
    //       //   withBottomMargin: false,
    //       //   withCounter: widget.counterIsOn,
    //       // ),
    //       decoration: BoxDecoration(
    //         color: widget.fieldColor,
    //         borderRadius: Borderers.superBorderAll(context, widget.corners)
    //       ),
    //       margin: widget.margins,
    //       child: ValueListenableBuilder(
    //         valueListenable: _textValue,
    //         builder: (_, String value, Widget child){
    //
    //           final bool _textIsEmpty = value.isEmpty;
    //           final String _value = _textIsEmpty == true ? widget.hintVerse ?? '' : value;
    //
    //           if (widget.canObscure == true){
    //             return Selector<UiProvider, bool>(
    //                 selector: (_, UiProvider uiPro) => uiPro.textFieldsObscured,
    //                 builder: (_, bool obscured, Widget child){
    //
    //                   final String _text = obscured == true ?
    //                   TextMod.obscureText(
    //                     text: _value,
    //                   )
    //                       :
    //                   _value;
    //
    //                   blog('text is : $_text');
    //
    //                   return SuperVerse(
    //                     verse: _text,
    //                     size: widget.textSize,
    //                     centered: widget.centered,
    //                     margin: const EdgeInsets.all(7),
    //                     maxLines: widget.maxLines,
    //                     color: widget.textColor,
    //                     weight: widget.textWeight,
    //                     italic: widget.textItalic,
    //                     shadow: widget.textShadow,
    //                     scaleFactor: widget.textSizeFactor,
    //                   );
    //
    //                 });
    //           }
    //
    //           else {
    //             return SuperVerse(
    //             verse: _value,
    //             size: widget.textSize,
    //             centered: widget.centered,
    //             margin: const EdgeInsets.all(7),
    //             maxLines: widget.maxLines,
    //             color: _textIsEmpty == true ? Colorz.grey80 : widget.textColor,
    //             weight: _textIsEmpty == true ? VerseWeight.thin : widget.textWeight,
    //             italic: widget.textItalic,
    //             shadow: widget.textShadow,
    //             scaleFactor: widget.textSizeFactor,
    //           );
    //           }
    //
    //         },
    //       ),
    //     ),
    //   );
    // }

  // }
}
