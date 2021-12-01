import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SuperTextField extends StatefulWidget {
  final TextInputType keyboardTextInputType;
  final Color inputColor;
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
  final ValueChanged<String> validator;
  final TextDirection textDirection;
  final Function onTap;
  final double corners;
  final Function onSubmitted;
  final bool autofocus;
  final Function onMaxLinesReached;

  const SuperTextField({
    this.keyboardTextInputType = TextInputType.text,
    this.inputColor = Colorz.white255,
    this.maxLines = 7,
    this.minLines = 1,
    this.inputSize = 2,
    this.inputWeight = VerseWeight.regular,
    this.margin,
    this.italic = false,
    this.labelColor = Colorz.white10,
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
    this.hintColor = Colorz.white80,
    this.keyboardTextInputAction,
    this.onSaved,
    this.fieldIsFormField = false,
    this.initialValue,
    this.validator,
    this.textDirection,
    this.onTap,
    this.corners,
    this.onSubmitted,
    this.autofocus,
    this.onMaxLinesReached,
    Key key,
  }) : super(key: key);

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

    const Color _boxColor = Colorz.nothing;
    const double _verseHeight = 1.42; //1.48; // The sacred golden reverse engineered factor
    const double _scalingFactor = 1; //scaleFactor == null ? 1: scaleFactor;
    /// --- AVAILABLE FONT SIZES -----------------------------------------------
    final int _size = widget.inputSize;
    /// takes values from 0 to 8 in the entire app
    final double _verseSize = SuperVerse.superVerseSizeValue(context, _size, _scalingFactor);
    /// --- AVAILABLE FONT WEIGHTS -----------------------------------------------
    final VerseWeight _weight = widget.inputWeight;
    final FontWeight _verseWeight = SuperVerse.superVerseWeight(_weight);
    /// --- AVAILABLE FONTS -----------------------------------------------
    final String _verseFont = SuperVerse.superVerseFont(context, _weight);
    /// --- LETTER SPACING -----------------------------------------------
    final double _verseLetterSpacing = SuperVerse.superVerseLetterSpacing(_weight, _verseSize);
    /// --- WORD SPACING -----------------------------------------------
    final double _verseWordSpacing = SuperVerse.superVerseWordSpacing(_verseSize);
    /// --- SHADOWS -----------------------------------------------
    final bool _shadow = widget.inputShadow;
    const double _shadowBlur = 0;
    const double _shadowYOffset = 0;
    final double _shadowXOffset = SuperVerse.superVerseXOffset(_weight, _verseSize);
    final double _secondShadowXOffset = -0.35 * _shadowXOffset;
    final Color _leftShadow = widget.inputColor == Colorz.black230 ? Colorz.white125
        : Colorz.black230;

    final Color _rightShadow = widget.inputColor == Colorz.black230 ? Colorz.white80
        : Colorz.white20;
    /// --- ITALIC -----------------------------------------------
    final FontStyle _verseStyle =
    widget.italic == true ? FontStyle.italic : FontStyle.normal;

    /// --- VERSE BOX MARGIN -----------------------------------------------
    // double _margin = margin == null ? 0 : margin;

    /// --- LABEL CORNERS -----------------------------------------------
    final double _labelCornerValues = SuperVerse.superVerseLabelCornerValue(context, _size);
    final double _labelCorner = widget.labelColor == Colorz.nothing ? 0 :
    widget.corners == null ? _labelCornerValues :
    widget.corners;
    /// --- LABEL PADDINGS -----------------------------------------------
    final double _sidePaddingValues = SuperVerse.superVerseSidePaddingValues(context, _size);
// -----------------------------------------------------------------------------
    final double _sidePaddings =
    widget.labelColor == Colorz.nothing ? 0 : _sidePaddingValues;
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
        fontWeight: SuperVerse.superVerseWeight(VerseWeight.thin),
        shadows: const [],
      );
    }
// -----------------------------------------------------------------------------
    final TextDirection _concludedTextDirection =
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
    final InputDecoration _inputDecoration =

    InputDecoration(
      hintText: widget.hintText,
      hintMaxLines: 1,
      hintStyle: superHintStyle(Colorz.white80, 0.8),
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.all(_sidePaddings),

      focusedBorder: Borderers.superOutlineInputBorder(Colorz.yellow80, _labelCorner),
      enabledBorder: Borderers.superOutlineInputBorder(Colorz.nothing, _labelCorner),

      errorStyle: superTextStyle(Colorz.red255, 0.6),
      focusedErrorBorder: Borderers.superOutlineInputBorder(Colorz.yellow80, _labelCorner),

      errorBorder: Borderers.superOutlineInputBorder(Colorz.red125, _labelCorner),
      border: Borderers.superOutlineInputBorder(Colorz.linkedIn, _labelCorner),
      disabledBorder: Borderers.superOutlineInputBorder(Colorz.grey225, _labelCorner),
      counterText: '${widget.textController?.text?.length} / ${widget.maxLength}',
      counter: widget.counterIsOn ? null : const Offstage(),
      counterStyle: superTextStyle(Colorz.white200, 0.7),

      // SOME BULLSHIT
      isDense: true,
      isCollapsed: true,
      // semanticCounterText: 'semantic',
      focusColor: Colorz.green255,
      enabled: true,
      filled: true,
      fillColor: Colorz.white10,

      // helperText: 'helper',
      // errorText: 'there is some error here',
      // icon: WebsafeSvg.asset(Iconz.DvRageh, height: 20),
    );
// -----------------------------------------------------------------------------
    final EdgeInsets _boxPadding = EdgeInsets.only(
        bottom: widget.counterIsOn == true ? _sidePaddings * 0 : 0);
// -----------------------------------------------------------------------------
    final BoxDecoration _boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(_labelCorner)),
      color: widget.fieldColor,
    );
// -----------------------------------------------------------------------------
    final TextAlign _textAlign = widget.centered == true ? TextAlign.center : TextAlign.start;
// -----------------------------------------------------------------------------
    final int _maxLines = widget.obscured == true ? 1 : widget.maxLines;
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

    final MaxLengthEnforcement _maxLengthEnforced = widget.counterIsOn == true ? MaxLengthEnforcement.enforced : MaxLengthEnforcement.none;

    return

      widget.fieldIsFormField == true ?

      /// TEXT FORM FIELD -------------------------------
      Container(
        width: widget.width,
        height: widget.height,
        padding: _boxPadding,
        margin: widget.margin,
        decoration: _boxDecoration,
        alignment: Alignment.topCenter,
        child: TextFormField(
          key: widget.key,

          // initialValue: widget.initialValue,
          controller: widget.textController,
          textInputAction: widget.keyboardTextInputAction,
          // onSaved: (String koko) => widget.onSaved(koko),
          validator: widget.validator,
          onChanged: (val) => _onChanged(val),
          // focusNode: ,
          onFieldSubmitted: widget.onSubmitted == null ? null : (val) => widget.onSubmitted(val),
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
          cursorColor: Colorz.yellow255,
          cursorRadius: const Radius.circular(3),
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
          cursorColor: Colorz.yellow255,
          cursorRadius: const Radius.circular(3),
          cursorWidth: 2,
          cursorHeight: null,
          textAlign: _textAlign,
          autofocus: widget.autofocus == null ? false : widget.autofocus,
          onSubmitted: (val){

            if (widget.onSubmitted != null){
              widget.onSubmitted(val);
            }

          },
        ),
      );

  }
}
