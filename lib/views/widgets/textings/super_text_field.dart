import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/keyboarders.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
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
  TextEditingController textController;
  final Color fieldColor;
  final Color hintColor;
  final TextInputAction keyboardTextInputAction;
  final Function onSaved;
  final bool fieldIsFormField;
  final String initialValue;
  final Function validator;
  TextDirection textDirection;

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
    @required this.hintText,
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
TextDirection textDirection;

  void switchTextDirection(String val){
    if(val.length <= 1){ // only the first character defines the text direction
      if(textIsEnglish(val) == true){
        setState(() {textDirection = TextDirection.ltr;});
      } else if
      (textIsEnglish(val) == false){
        setState(() {textDirection = TextDirection.rtl;});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    // Color verseColor = inputColor;
    Color boxColor = widget.designMode ? Colorz.BloodTest : Colorz.Nothing;
    double verseHeight = 1.42; //1.48; // The sacred golden reverse engineered factor
    double scalingFactor = 1; //scaleFactor == null ? 1: scaleFactor;

    // int _maxLines =  maxLines;

    // --- AVAILABLE FONT SIZES -----------------------------------------------
    int size = widget.inputSize;
    // takes values from 0 to 8 in the entire app
    double verseSize = superVerseSizeValue(context, size, scalingFactor);
    // --- AVAILABLE FONT WEIGHTS -----------------------------------------------
    VerseWeight weight = widget.inputWeight;
    FontWeight verseWeight = superVerseWeight(weight);

    // --- AVAILABLE FONTS -----------------------------------------------
    String verseFont = superVerseFont(context, weight);
    // --- LETTER SPACING -----------------------------------------------
    double verseLetterSpacing = superVerseLetterSpacing(weight, verseSize);
    // --- WORD SPACING -----------------------------------------------
    double verseWordSpacing = superVerseWordSpacing(verseSize);
    // --- SHADOWS -----------------------------------------------
    bool shadow = widget.inputShadow;
    double shadowBlur = 0;
    double shadowYOffset = 0;
    double shadowXOffset = superVerseXOffset(weight, verseSize);
    double secondShadowXOffset = -0.35 * shadowXOffset;
    Color leftShadow = widget.inputColor == Colorz.BlackBlack ? Colorz.WhitePlastic
        : Colorz.BlackBlack;

    Color rightShadow = widget.inputColor == Colorz.BlackBlack ? Colorz.WhiteSmoke
        : Colorz.WhiteGlass;

    // --- ITALIC -----------------------------------------------
    FontStyle verseStyle =
    widget.italic == true ? FontStyle.italic : FontStyle.normal;

    // --- VERSE BOX MARGIN -----------------------------------------------
    // double _margin = margin == null ? 0 : margin;

    // --- LABEL CORNERS -----------------------------------------------
    double labelCornerValues = superVerseLabelCornerValue(context, size);
    double labelCorner = widget.labelColor == Colorz.Nothing ? 0 : labelCornerValues;
    // --- LABEL PADDINGS -----------------------------------------------
    double sidePaddingValues = superVerseSidePaddingValues(context, size);
// ---------------------------------------------------------------------------
    double sidePaddings =
    widget.labelColor == Colorz.Nothing ? 0 : sidePaddingValues;
// ---------------------------------------------------------------------------
    TextStyle superTextStyle(Color textColor, double sizeFactor) {
      return TextStyle(
          backgroundColor: boxColor,
          textBaseline: TextBaseline.alphabetic,
          height: verseHeight,
          color: textColor,
          fontFamily: verseFont,
          fontStyle: verseStyle,
          letterSpacing: verseLetterSpacing,
          wordSpacing: verseWordSpacing,
          fontSize: verseSize * sizeFactor,
          fontWeight: verseWeight,
          shadows: [
            if (shadow)
              Shadow(
                blurRadius: shadowBlur,
                color: leftShadow,
                offset: Offset(shadowXOffset, shadowYOffset),
              ),
            Shadow(
              blurRadius: shadowBlur,
              color: rightShadow,
              offset: Offset(secondShadowXOffset, shadowYOffset),
            )
          ]
      );
    }
// ---------------------------------------------------------------------------
    TextStyle superHintStyle(Color textColor, double sizeFactor) {
      return TextStyle(
        backgroundColor: boxColor,
        textBaseline: TextBaseline.alphabetic,
        height: verseHeight,
        color: widget.hintColor,
        fontFamily: verseFont,
        fontStyle: verseStyle,
        letterSpacing: verseLetterSpacing,
        wordSpacing: verseWordSpacing,
        fontSize: verseSize * sizeFactor,
        fontWeight: superVerseWeight(VerseWeight.thin),
        shadows: [],
      );
    }
// ---------------------------------------------------------------------------
TextDirection concludedTextDirection =
    widget.textDirection != null ? widget.textDirection :
    widget.textDirection == null && textDirection == null? superTextDirection(context) :
    textDirection;

    return

      widget.fieldIsFormField == true ?

          // TEXT FORM FIELD
      Container(
        width: widget.width,
        // height: widget.height,
        padding: EdgeInsets.only(bottom: widget.counterIsOn == true ? sidePaddings : 0),
        margin: widget.margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(labelCorner)),
          color: widget.fieldColor,
        ),
        child: TextFormField(
          initialValue: widget.initialValue,
          textInputAction: widget.keyboardTextInputAction,
          onSaved: (String koko) => widget.onSaved(koko),
          validator: widget.validator,
          controller: widget.textController,
          onChanged: (val){
            widget.onChanged(val);
            if(widget.textDirection == null) {switchTextDirection(val);}
              },
          onTap: () {
            print('onTap is tapped');
          },
          keyboardType: widget.keyboardTextInputType,
          style: superTextStyle(widget.inputColor, 1),
          enabled: true, // THIS DISABLES THE ABILITY TO OPEN THE KEYBOARD
          minLines: widget.minLines,
          maxLines: widget.obscured == true ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          autocorrect: true, // -------------------------------------------NO IMPACT
          // scrollPadding: EdgeInsets.all(50),
          keyboardAppearance: Brightness.dark,
          textDirection: concludedTextDirection,
          obscureText: widget.obscured,
          // obscuringCharacter: '*',
          maxLengthEnforced: false,
          enableInteractiveSelection: true, // makes test selectable

          decoration: InputDecoration(
            hintText: widget.hintText,
            hintMaxLines: 1,
            hintStyle: superHintStyle(Colorz.WhiteSmoke, 0.8),
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.all(sidePaddings),

            focusedBorder: superOutlineInputBorder(Colorz.YellowSmoke, labelCorner),
            enabledBorder: superOutlineInputBorder(Colorz.Nothing, labelCorner),

            errorStyle: superTextStyle(Colorz.BloodRed, 0.7),
            focusedErrorBorder: superOutlineInputBorder(Colorz.YellowSmoke, labelCorner),

            errorBorder: superOutlineInputBorder(Colorz.BloodRedPlastic, labelCorner),
            border: superOutlineInputBorder(Colorz.LinkedIn, labelCorner),
            disabledBorder: superOutlineInputBorder(Colorz.Grey, labelCorner),
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
          ),

          // buildCounter:
          //     (_, {currentLength, maxLength, isFocused}) =>
          //         Padding(
          //           padding: const EdgeInsets.only(left: 16.0),
          //           child: Container(
          //               alignment: Alignment.centerLeft,
          //               child: Text(currentLength.toString() + "/" + maxLength.toString())),
          //         ),

          cursorColor: Colorz.Yellow,
          cursorRadius: Radius.circular(3),
          cursorWidth: 2,
          cursorHeight: null,

          textAlign: widget.centered == true ? TextAlign.center : TextAlign.start,
          /*
        ---  if keyboard lang is ltr ? ltr : rtl
        On native iOS the current keyboard language can be gotten from
        UITextInputMode
        and listened to with
        UITextInputCurrentInputModeDidChangeNotification.
        On native Android you can use
        getCurrentInputMethodSubtype
        to get the keyboard language, but I'm not seeing a way to listen
        to keyboard language changes.
         */
        ),
      )

          :

          // TEXT FIELD
      Container(
        width: widget.width,
        // height: widget.height,
        padding: EdgeInsets.only(
            bottom: widget.counterIsOn == true ? sidePaddings : 0),
        margin: widget.margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(labelCorner)),
          color: widget.fieldColor,
        ),
        child: TextField(

          controller: widget.textController,
          onChanged: (val){
            widget.onChanged(val);
            switchTextDirection(val);
          },
          onTap: () {
            print('onTap is tapped');
          },
          keyboardType: widget.keyboardTextInputType,
          style: superTextStyle(widget.inputColor, 1),
          enabled: true, // THIS DISABLES THE ABILITY TO OPEN THE KEYBOARD
          minLines: widget.minLines,
          maxLines: widget.obscured == true ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          autocorrect: true, // -------------------------------------------NO IMPACT
          // scrollPadding: EdgeInsets.all(50),
          keyboardAppearance: Brightness.dark,
          textDirection: concludedTextDirection,
          obscureText: widget.obscured,
          // obscuringCharacter: '*',
          maxLengthEnforced: false,
          enableInteractiveSelection: true, // makes test selectable

          decoration: InputDecoration(
            hintText: widget.hintText,
            hintMaxLines: 1,
            hintStyle: superHintStyle(Colorz.WhiteSmoke, 0.8),
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.all(sidePaddings),

            focusedBorder: superOutlineInputBorder(Colorz.YellowSmoke, labelCorner),
            enabledBorder: superOutlineInputBorder(Colorz.Nothing, labelCorner),

            errorStyle: superTextStyle(Colorz.BloodRed, 0.7),
            focusedErrorBorder: superOutlineInputBorder(Colorz.BloodRed, labelCorner),

            errorBorder: superOutlineInputBorder(Colorz.Facebook, labelCorner),
            border: superOutlineInputBorder(Colorz.LinkedIn, labelCorner),
            disabledBorder: superOutlineInputBorder(Colorz.Grey, labelCorner),
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
          ),

          // buildCounter:
          //     (_, {currentLength, maxLength, isFocused}) =>
          //         Padding(
          //           padding: const EdgeInsets.only(left: 16.0),
          //           child: Container(
          //               alignment: Alignment.centerLeft,
          //               child: Text(currentLength.toString() + "/" + maxLength.toString())),
          //         ),

          cursorColor: Colorz.Yellow,
          cursorRadius: Radius.circular(3),
          cursorWidth: 2,
          cursorHeight: null,

          textAlign: widget.centered == true ? TextAlign.center : TextAlign.start,
          /*
        ---  if keyboard lang is ltr ? ltr : rtl
        On native iOS the current keyboard language can be gotten from
        UITextInputMode
        and listened to with
        UITextInputCurrentInputModeDidChangeNotification.
        On native Android you can use
        getCurrentInputMethodSubtype
        to get the keyboard language, but I'm not seeing a way to listen
        to keyboard language changes.
         */
        ),
      );

  }
}
