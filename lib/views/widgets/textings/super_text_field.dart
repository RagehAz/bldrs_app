import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SuperTextField extends StatefulWidget {
  final TextInputType keyboardTextInputType;
  final Color inputColor;
  final bool designMode;
  final int maxLines;
  final int minLines;
  final int inputSize;
  final VerseWeight inputWeight;
  final EdgeInsets margin;
  final bool italic;
  final Color labelColor;
  final bool inputShadow;
  final bool centered;
  final String hintText;
  final int maxLength;
  final bool obscured;
  final bool counterIsOn;
  final double width;
  final double height;
  final Function onChanged;
  final TextEditingController textController;
  final Color fieldColor;
  final Color hintColor;
  final TextInputAction keyboardTextInputAction;
  final Function onSaved;
  final bool fieldIsFormField;
  final String initialValue;
  final Function validator;
  final TextDirection textDirection;
  final Key key;
  final Function onTap;
  final double corners;
  final Function onSubmitted;
  final bool autofocus;
  final Function onMaxLinesReached;

  SuperTextField({
    this.keyboardTextInputType = TextInputType.text,
    this.inputColor = Colorz.White255,
    this.designMode = false,
    this.maxLines = 7,
    this.minLines = 1,
    this.inputSize = 2,
    this.inputWeight = VerseWeight.regular,
    this.margin,
    this.italic = false,
    this.labelColor = Colorz.White10,
    this.inputShadow = false,
    this.centered = false,
    this.hintText = '...',
    this.maxLength = 50,
    this.obscured = false,
    this.counterIsOn = true,
    this.width,
    this.height,
    this.onChanged,
    @required this.textController,
    this.fieldColor,
    this.hintColor = Colorz.White80,
    this.keyboardTextInputAction,
    this.onSaved,
    this.fieldIsFormField = false,
    this.initialValue,
    this.validator,
    this.textDirection,
    this.key,
    this.onTap,
    this.corners,
    this.onSubmitted,
    this.autofocus,
    this.onMaxLinesReached,
  });

  @override
  _SuperTextFieldState createState() => _SuperTextFieldState();
}

class _SuperTextFieldState extends State<SuperTextField> {
// -----------------------------------------------------------------------------
@override
  void initState() {
    super.initState();

  // widget.textController = widget.textController ;
  _textDirection = superTextDirectionSwitcher(widget.textController?.text);
  }

  // @override
  // void dispose(){
  //   _innerController.dispose();
  // super.dispose();
  // }

// -----------------------------------------------------------------------------
  /// --- TEXT DIRECTION BLOCK
  /// USER LIKE THIS :-
  /// onChanged: (val){_changeTextDirection();},
  TextDirection _textDirection;
  void _changeTextDirection(String val){
    setState(() {
      _textDirection = superTextDirectionSwitcher(val);
    });
    // print('$val, $_textDirection');
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    Color _boxColor = widget.designMode ? Colorz.BloodTest : Colorz.Nothing;
    double _verseHeight = 1.42; //1.48; // The sacred golden reverse engineered factor
    double _scalingFactor = 1; //scaleFactor == null ? 1: scaleFactor;
    // --- AVAILABLE FONT SIZES -----------------------------------------------
    int _size = widget.inputSize;
    // takes values from 0 to 8 in the entire app
    double _verseSize = superVerseSizeValue(context, _size, _scalingFactor);
    // --- AVAILABLE FONT WEIGHTS -----------------------------------------------
    VerseWeight _weight = widget.inputWeight;
    FontWeight _verseWeight = superVerseWeight(_weight);
    // --- AVAILABLE FONTS -----------------------------------------------
    String _verseFont = superVerseFont(context, _weight);
    // --- LETTER SPACING -----------------------------------------------
    double _verseLetterSpacing = superVerseLetterSpacing(_weight, _verseSize);
    // --- WORD SPACING -----------------------------------------------
    double _verseWordSpacing = superVerseWordSpacing(_verseSize);
    // --- SHADOWS -----------------------------------------------
    bool _shadow = widget.inputShadow;
    double _shadowBlur = 0;
    double _shadowYOffset = 0;
    double _shadowXOffset = superVerseXOffset(_weight, _verseSize);
    double _secondShadowXOffset = -0.35 * _shadowXOffset;
    Color _leftShadow = widget.inputColor == Colorz.Black230 ? Colorz.White125
        : Colorz.Black230;

    Color _rightShadow = widget.inputColor == Colorz.Black230 ? Colorz.White80
        : Colorz.White20;
    // --- ITALIC -----------------------------------------------
    FontStyle _verseStyle =
    widget.italic == true ? FontStyle.italic : FontStyle.normal;

    // --- VERSE BOX MARGIN -----------------------------------------------
    // double _margin = margin == null ? 0 : margin;

    // --- LABEL CORNERS -----------------------------------------------
    double _labelCornerValues = superVerseLabelCornerValue(context, _size);
    double _labelCorner = widget.labelColor == Colorz.Nothing ? 0 :
    widget.corners == null ? _labelCornerValues :
    widget.corners;
    // --- LABEL PADDINGS -----------------------------------------------
    double _sidePaddingValues = superVerseSidePaddingValues(context, _size);
// -----------------------------------------------------------------------------
    double _sidePaddings =
    widget.labelColor == Colorz.Nothing ? 0 : _sidePaddingValues;
// -----------------------------------------------------------------------------
    TextStyle superTextStyle(Color textColor, double sizeFactor) {
      return TextStyle(
          backgroundColor: _boxColor,
          textBaseline: TextBaseline.alphabetic,
          height: _verseHeight,
          color: textColor,
          fontFamily: _verseFont,
          fontStyle: _verseStyle,
          letterSpacing: _verseLetterSpacing,
          wordSpacing: _verseWordSpacing,
          fontSize: _verseSize * sizeFactor,
          fontWeight: _verseWeight,
          shadows: <Shadow>[
            if (_shadow)
              Shadow(
                blurRadius: _shadowBlur,
                color: _leftShadow,
                offset: Offset(_shadowXOffset, _shadowYOffset),
              ),
            Shadow(
              blurRadius: _shadowBlur,
              color: _rightShadow,
              offset: Offset(_secondShadowXOffset, _shadowYOffset),
            )
          ]
      );
    }
// -----------------------------------------------------------------------------
    TextStyle superHintStyle(Color _textColor, double _sizeFactor) {
      return TextStyle(
        backgroundColor: _boxColor,
        textBaseline: TextBaseline.alphabetic,
        height: _verseHeight,
        color: widget.hintColor,
        fontFamily: _verseFont,
        fontStyle: _verseStyle,
        letterSpacing: _verseLetterSpacing,
        wordSpacing: _verseWordSpacing,
        fontSize: _verseSize * _sizeFactor,
        fontWeight: superVerseWeight(VerseWeight.thin),
        shadows: [],
      );
    }
// -----------------------------------------------------------------------------
    TextDirection _concludedTextDirection =
    /// when widget.textDirection is already defined, it overrides all
    widget.textDirection != null ? widget.textDirection :
    /// when it is not defined outside, and _textDirection hadn't changed yet we
    /// use default superTextDirection that detects current app language
    widget.textDirection == null && _textDirection == null? superTextDirection(context) :
    /// so otherwise we use _textDirection that auto detects current input
    /// language
    // textIsEnglish(widget.textController.text) == true ? TextDirection.ltr :
    // textIsEnglish(widget.textController.text) == false ? TextDirection.rtl :
    _textDirection;
// -----------------------------------------------------------------------------
    InputDecoration _inputDecoration =

    InputDecoration(
      hintText: widget.hintText,
      hintMaxLines: 1,
      hintStyle: superHintStyle(Colorz.White80, 0.8),
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.all(_sidePaddings),

      focusedBorder: Borderers.superOutlineInputBorder(Colorz.Yellow80, _labelCorner),
      enabledBorder: Borderers.superOutlineInputBorder(Colorz.Nothing, _labelCorner),

      errorStyle: superTextStyle(Colorz.Red255, 0.7),
      focusedErrorBorder: Borderers.superOutlineInputBorder(Colorz.Yellow80, _labelCorner),

      errorBorder: Borderers.superOutlineInputBorder(Colorz.Red125, _labelCorner),
      border: Borderers.superOutlineInputBorder(Colorz.LinkedIn, _labelCorner),
      disabledBorder: Borderers.superOutlineInputBorder(Colorz.Grey225, _labelCorner),
      counterText: '${widget.textController?.text?.length} / ${widget.maxLength}',
      counter: widget.counterIsOn ? null : Offstage(),
      counterStyle: superTextStyle(Colorz.White200, 0.7),

      // SOME BULLSHIT
      isDense: true,
      isCollapsed: true,
      // semanticCounterText: 'semantic',
      focusColor: Colorz.Green255,
      enabled: true,
      filled: true,
      fillColor: Colorz.White10,

      // helperText: 'helper',
      // errorText: 'there is some error here',
      // icon: WebsafeSvg.asset(Iconz.DvRageh, height: 20),
    );
// -----------------------------------------------------------------------------
    EdgeInsets _boxPadding = EdgeInsets.only(
        bottom: widget.counterIsOn == true ? _sidePaddings * 0 : 0);
// -----------------------------------------------------------------------------
    BoxDecoration _boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(_labelCorner)),
      color: widget.fieldColor,
    );
// -----------------------------------------------------------------------------
    TextAlign _textAlign = widget.centered == true ? TextAlign.center : TextAlign.start;
// -----------------------------------------------------------------------------
    int _maxLines = widget.obscured == true ? 1 : widget.maxLines;
// -----------------------------------------------------------------------------
    void _onChanged(val){

      if (val != null){
        _changeTextDirection(val);

        if (widget.onChanged != null){
          widget.onChanged(val);
        }

      }

    }
// -----------------------------------------------------------------------------

    MaxLengthEnforcement _maxLengthEnforced = widget.counterIsOn == true ? MaxLengthEnforcement.enforced : MaxLengthEnforcement.none;

    return

      widget.fieldIsFormField == true ?

      /// TEXT FORM FIELD -------------------------------
      Container(
        width: widget.width,
        padding: _boxPadding,
        margin: widget.margin,
        decoration: _boxDecoration,
        child: TextFormField(
          key: widget.key,
          // initialValue: widget.initialValue,
          controller: widget.textController,
          textInputAction: widget.keyboardTextInputAction,
          // onSaved: (String koko) => widget.onSaved(koko),
          validator: widget.validator,
          onChanged: (val) => _onChanged(val),
          // focusNode: ,
          onFieldSubmitted: (val) => widget.onSubmitted(val),
          onTap: (){
            // double _keyboardHeight;
            //
            // if (_keyboard.isOpen){
            //   setState(() {
            //     _keyboardHeight = _keyboard.keyboardHeight;
            //   });
            // } else {
            //   return;
            // }
            // print('superScreenHeight(context) : ${superScreenHeight(context)}');
            // print('_keyboardHeight : ${_keyboardHeight}');
            // widget.onTap(_keyboardHeight);
            // print('source keyboard height is ${_keyboard.keyboardHeight}');
          },
          keyboardType: widget.keyboardTextInputType,
          style: superTextStyle(widget.inputColor, 1),
          enabled: true, // THIS DISABLES THE ABILITY TO OPEN THE KEYBOARD
          minLines: widget.minLines,
          maxLines: _maxLines,
          maxLength: widget.maxLength,
          autocorrect: false, // NO IMPACT
          keyboardAppearance: Brightness.dark,
          textDirection: _concludedTextDirection,
          obscureText: widget.obscured,
          maxLengthEnforcement: _maxLengthEnforced,
          enableInteractiveSelection: true, // makes test selectable
          decoration: _inputDecoration,
          cursorColor: Colorz.Yellow255,
          cursorRadius: Radius.circular(3),
          cursorWidth: 2,
          cursorHeight: null,
          textAlign: _textAlign,
          autofocus: widget.autofocus == null ? false : widget.autofocus,
        ),
      )

          :

      /// TEXT FIELD -------------------------------
      Container(
        width: widget.width,
        padding: _boxPadding,
        margin: widget.margin,
        decoration: _boxDecoration,
        child: TextField(
          key: widget.key,
          controller: widget.textController,
          onChanged: (val) => _onChanged(val),
          // onTap: () => widget.onTap(_keyboard),
          keyboardType: widget.keyboardTextInputType,
          style: superTextStyle(widget.inputColor, 1),
          enabled: true, // THIS DISABLES THE ABILITY TO OPEN THE KEYBOARD
          minLines: widget.minLines,
          maxLines: _maxLines,
          maxLength: widget.maxLength,
          autocorrect: true, // -------------------------------------------NO IMPACT
          keyboardAppearance: Brightness.dark,
          textDirection: _concludedTextDirection,
          obscureText: widget.obscured,
          maxLengthEnforcement: _maxLengthEnforced,
          enableInteractiveSelection: true, // makes test selectable
          decoration: _inputDecoration,
          cursorColor: Colorz.Yellow255,
          cursorRadius: Radius.circular(3),
          cursorWidth: 2,
          cursorHeight: null,
          textAlign: _textAlign,
          autofocus: widget.autofocus == null ? false : widget.autofocus,
          onSubmitted: (val) => widget.onSubmitted(val),
        ),
      );

  }
}
