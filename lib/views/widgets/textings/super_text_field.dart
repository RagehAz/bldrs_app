import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/keyboarders.dart';
import 'package:bldrs/view_brains/drafters/text_directionz.dart';
import 'package:bldrs/view_brains/drafters/texters.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'super_verse.dart';

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

  SuperTextField({
    this.keyboardTextInputType = TextInputType.text,
    this.inputColor = Colorz.White,
    this.designMode = false,
    this.maxLines = 7,
    this.minLines = 1,
    this.inputSize = 2,
    this.inputWeight = VerseWeight.regular,
    this.margin,
    this.italic = false,
    this.labelColor = Colorz.WhiteAir,
    this.inputShadow = false,
    this.centered = false,
    this.hintText = '...',
    this.maxLength = 50,
    this.obscured = false,
    this.counterIsOn = true,
    this.width,
    this.height,
    this.onChanged,
    this.textController,
    this.fieldColor,
    this.hintColor = Colorz.WhiteSmoke,
    this.keyboardTextInputAction,
    this.onSaved,
    this.fieldIsFormField = false,
    this.initialValue,
    this.validator,
    this.textDirection,
  });

  @override
  _SuperTextFieldState createState() => _SuperTextFieldState();
}

class _SuperTextFieldState extends State<SuperTextField> {
// ---------------------------------------------------------------------------
@override
  void initState() {
  _textController = widget.textController;
    super.initState();
  }
// ---------------------------------------------------------------------------
  /// --- TEXT DIRECTION BLOCK
  /// USER LIKE THIS :-
  /// onChanged: (val){_changeTextDirection();},
  TextEditingController _textController = TextEditingController();
  TextDirection _textDirection;
  void _changeTextDirection(){
    setState(() {
      _textDirection = superTextDirectionSwitcher(_textController);
    });
    print('${_textController.text}, $_textDirection');
  }
// ---------------------------------------------------------------------------
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
    Color _leftShadow = widget.inputColor == Colorz.BlackBlack ? Colorz.WhitePlastic
        : Colorz.BlackBlack;

    Color _rightShadow = widget.inputColor == Colorz.BlackBlack ? Colorz.WhiteSmoke
        : Colorz.WhiteGlass;
    // --- ITALIC -----------------------------------------------
    FontStyle _verseStyle =
    widget.italic == true ? FontStyle.italic : FontStyle.normal;

    // --- VERSE BOX MARGIN -----------------------------------------------
    // double _margin = margin == null ? 0 : margin;

    // --- LABEL CORNERS -----------------------------------------------
    double _labelCornerValues = superVerseLabelCornerValue(context, _size);
    double _labelCorner = widget.labelColor == Colorz.Nothing ? 0 : _labelCornerValues;
    // --- LABEL PADDINGS -----------------------------------------------
    double _sidePaddingValues = superVerseSidePaddingValues(context, _size);
// ---------------------------------------------------------------------------
    double _sidePaddings =
    widget.labelColor == Colorz.Nothing ? 0 : _sidePaddingValues;
// ---------------------------------------------------------------------------
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
          shadows: [
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
// ---------------------------------------------------------------------------
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
// ---------------------------------------------------------------------------
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
// ---------------------------------------------------------------------------
    InputDecoration _inputDecoration = InputDecoration(
      hintText: widget.hintText,
      hintMaxLines: 1,
      hintStyle: superHintStyle(Colorz.WhiteSmoke, 0.8),
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.all(_sidePaddings),

      focusedBorder: superOutlineInputBorder(Colorz.YellowSmoke, _labelCorner),
      enabledBorder: superOutlineInputBorder(Colorz.Nothing, _labelCorner),

      errorStyle: superTextStyle(Colorz.BloodRed, 0.7),
      focusedErrorBorder: superOutlineInputBorder(Colorz.YellowSmoke, _labelCorner),

      errorBorder: superOutlineInputBorder(Colorz.BloodRedPlastic, _labelCorner),
      border: superOutlineInputBorder(Colorz.LinkedIn, _labelCorner),
      disabledBorder: superOutlineInputBorder(Colorz.Grey, _labelCorner),
      counter: widget.counterIsOn ? null : Offstage(),
      counterStyle: superTextStyle(Colorz.WhiteLingerie, 0.7),

      // SOME BULLSHIT
      isDense: true,
      isCollapsed: true,
      // semanticCounterText: 'semantic',
      focusColor: Colorz.Green,
      enabled: true,
      filled: true,
      fillColor: Colorz.WhiteAir,

      // helperText: 'helper',
      // errorText: 'there is some error here',
      // icon: WebsafeSvg.asset(Iconz.DvRageh, height: 20),
    );
// ---------------------------------------------------------------------------
    EdgeInsets _boxPadding = EdgeInsets.only(
        bottom: widget.counterIsOn == true ? _sidePaddings : 0);
// ---------------------------------------------------------------------------
    BoxDecoration _boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(_labelCorner)),
      color: widget.fieldColor,
    );
// ---------------------------------------------------------------------------
    TextAlign _textAlign = widget.centered == true ? TextAlign.center : TextAlign.start;
// ---------------------------------------------------------------------------
    void _onChanged(val){
      _changeTextDirection();
      widget.onChanged(val);
    }
// ---------------------------------------------------------------------------
    return

      widget.fieldIsFormField == true ?

          /// TEXT FORM FIELD -------------------------------
      Container(
        width: widget.width,
        padding: _boxPadding,
        margin: widget.margin,
        decoration: _boxDecoration,
        child: TextFormField(
          initialValue: widget.initialValue,
          controller: _textController,
          textInputAction: widget.keyboardTextInputAction,
          onSaved: (String koko) => widget.onSaved(koko),
          validator: widget.validator,
          onChanged: (val) => _onChanged(val),
          onTap: () {print('TextField is Changing');},
          keyboardType: widget.keyboardTextInputType,
          style: superTextStyle(widget.inputColor, 1),
          enabled: true, // THIS DISABLES THE ABILITY TO OPEN THE KEYBOARD
          minLines: widget.minLines,
          maxLines: widget.obscured == true ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          autocorrect: false, // NO IMPACT
          keyboardAppearance: Brightness.dark,
          textDirection: _concludedTextDirection,
          obscureText: widget.obscured,
          maxLengthEnforced: false,
          enableInteractiveSelection: true, // makes test selectable
          decoration: _inputDecoration,
          cursorColor: Colorz.Yellow,
          cursorRadius: Radius.circular(3),
          cursorWidth: 2,
          cursorHeight: null,
          textAlign: _textAlign,
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
          controller: _textController,
          onChanged: (val) => _onChanged(val),
          onTap: () {print('onTap is tapped');},
          keyboardType: widget.keyboardTextInputType,
          style: superTextStyle(widget.inputColor, 1),
          enabled: true, // THIS DISABLES THE ABILITY TO OPEN THE KEYBOARD
          minLines: widget.minLines,
          maxLines: widget.obscured == true ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          autocorrect: true, // -------------------------------------------NO IMPACT
          keyboardAppearance: Brightness.dark,
          textDirection: _concludedTextDirection,
          obscureText: widget.obscured,
          maxLengthEnforced: false,
          enableInteractiveSelection: true, // makes test selectable
          decoration: _inputDecoration,
          cursorColor: Colorz.Yellow,
          cursorRadius: Radius.circular(3),
          cursorWidth: 2,
          cursorHeight: null,
          textAlign: _textAlign,
        ),
      );

  }
}
