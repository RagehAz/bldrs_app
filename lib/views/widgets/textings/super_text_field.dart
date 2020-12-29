import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
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
  final double margin;
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

  SuperTextField({
    this.keyboardTextInputType = TextInputType.text,
    this.inputColor = Colorz.White,
    this.designMode = false,
    this.maxLines = 7,
    this.minLines = 1,
    this.inputSize = 2,
    this.inputWeight = VerseWeight.regular,
    this.margin = 0,
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
  });

  @override
  _SuperTextFieldState createState() => _SuperTextFieldState();
}

class _SuperTextFieldState extends State<SuperTextField> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    // Color verseColor = inputColor;
    Color boxColor = widget.designMode ? Colorz.BloodTest : Colorz.Nothing;
    double verseHeight =
        1.42; //1.48; // The sacred golden reverse engineered factor
    double scalingFactor = 1; //scaleFactor == null ? 1: scaleFactor;

    // int _maxLines =  maxLines;

    // --- AVAILABLE FONT SIZES -----------------------------------------------
    int size = widget.inputSize;
    // takes values from 0 to 8 in the entire app
    double verseSize = (size == 0)
        ? screenHeight * Ratioz.fontSize0 * scalingFactor // -- 8 -- A77A
        : (size == 1)
            ? screenHeight * Ratioz.fontSize1 * scalingFactor // -- 10 -- Nano
            : (size == 2)
                ? screenHeight *
                    Ratioz.fontSize2 *
                    scalingFactor // -- 12 -- Micro
                : (size == 3)
                    ? screenHeight *
                        Ratioz.fontSize3 *
                        scalingFactor // -- 14 -- Mini
                    : (size == 4)
                        ? screenHeight *
                            Ratioz.fontSize4 *
                            scalingFactor // -- 16 -- Medium
                        : (size == 5)
                            ? screenHeight *
                                Ratioz.fontSize5 *
                                scalingFactor // -- 20 -- Macro
                            : (size == 6)
                                ? screenHeight *
                                    Ratioz.fontSize6 *
                                    scalingFactor // -- 24 -- Big
                                : (size == 7)
                                    ? screenHeight *
                                        Ratioz.fontSize7 *
                                        scalingFactor // -- 28 -- Massive
                                    : (size == 8)
                                        ? screenHeight *
                                            Ratioz.fontSize8 *
                                            scalingFactor // -- 28 -- Gigantic
                                        : screenHeight * Ratioz.fontSize1;

    // --- AVAILABLE FONT WEIGHTS -----------------------------------------------
    VerseWeight weight = widget.inputWeight;
    FontWeight verseWeight = weight == VerseWeight.thin
        ? FontWeight.w100
        : weight == VerseWeight.regular
            ? FontWeight.w600
            : weight == VerseWeight.bold
                ? FontWeight.w100
                : weight == VerseWeight.black
                    ? FontWeight.w600
                    : FontWeight.w100;

    // --- AVAILABLE FONTS -----------------------------------------------
    String verseFont = weight == VerseWeight.thin
        ? getTranslated(context, 'Body_Font')
        : weight == VerseWeight.regular
            ? getTranslated(context, 'Body_Font')
            : weight == VerseWeight.bold
                ? getTranslated(context, 'Headline_Font')
                : weight == VerseWeight.black
                    ? getTranslated(context, 'Headline_Font')
                    : getTranslated(context, 'Body_Font');

    // --- LETTER SPACING -----------------------------------------------
    double verseLetterSpacing = weight == VerseWeight.thin
        ? verseSize * 0.035
        : weight == VerseWeight.regular
            ? verseSize * 0.09
            : weight == VerseWeight.bold
                ? verseSize * 0.05
                : weight == VerseWeight.black
                    ? verseSize * 0.12
                    : verseSize * 0;

    // --- WORD SPACING -----------------------------------------------
    double verseWordSpacing =
        // weight == VerseWeight.thin ? verseSize * 0.1 :
        // weight == VerseWeight.regular ? verseSize * 0.1 :
        // weight == VerseWeight.bold ? verseSize * 0.1 :
        // weight == VerseWeight.black ? verseSize * 0.1 :
        verseSize * 0;

    // --- SHADOWS -----------------------------------------------
    bool shadow = widget.inputShadow;
    double shadowBlur = 0;
    double shadowYOffset = 0;
    double shadowXOffset = weight == VerseWeight.thin
        ? verseSize * -0.07
        : weight == VerseWeight.regular
            ? verseSize * -0.09
            : weight == VerseWeight.bold
                ? verseSize * -0.11
                : weight == VerseWeight.black
                    ? verseSize * -0.12
                    : verseSize * -0.06;
    double secondShadowXOffset = -0.35 * shadowXOffset;
    Color leftShadow = widget.inputColor == Colorz.BlackBlack
        ? Colorz.WhitePlastic
        : Colorz.BlackBlack;
    Color rightShadow = widget.inputColor == Colorz.BlackBlack
        ? Colorz.WhiteSmoke
        : Colorz.WhiteGlass;

    // --- ITALIC -----------------------------------------------
    FontStyle verseStyle =
        widget.italic == true ? FontStyle.italic : FontStyle.normal;

    // --- VERSE BOX MARGIN -----------------------------------------------
    // double _margin = margin == null ? 0 : margin;

    // --- LABEL CORNERS -----------------------------------------------
    double labelCornerRatio = 0.6;
    double labelCornerValues = (size == 0)
            ? screenHeight * Ratioz.fontSize0 * labelCornerRatio // -- 8 -- A77A
            : (size == 1)
                ? screenHeight *
                    Ratioz.fontSize1 *
                    labelCornerRatio // -- 10 -- Nano
                : (size == 2)
                    ? screenHeight *
                        Ratioz.fontSize2 *
                        labelCornerRatio // -- 12 -- Micro
                    : (size == 3)
                        ? screenHeight *
                            Ratioz.fontSize3 *
                            labelCornerRatio // -- 14 -- Mini
                        : (size == 4)
                            ? screenHeight *
                                Ratioz.fontSize4 *
                                labelCornerRatio // -- 16 -- Medium
                            : (size == 5)
                                ? screenHeight *
                                    Ratioz.fontSize5 *
                                    labelCornerRatio // -- 20 -- Macro
                                : (size == 6)
                                    ? screenHeight *
                                        Ratioz.fontSize6 *
                                        labelCornerRatio // -- 24 -- Big
                                    : (size == 7)
                                        ? screenHeight *
                                            Ratioz.fontSize7 *
                                            labelCornerRatio // -- 28 -- Massive
                                        : (size == 8)
                                            ? screenHeight *
                                                Ratioz.fontSize8 *
                                                labelCornerRatio // -- 28 -- Gigantic
                                            : 0 // -- 14 -- Medium as default
        ;
    double labelCorner =
        widget.labelColor == Colorz.Nothing ? 0 : labelCornerValues;

    // --- LABEL PADDINGS -----------------------------------------------
    double sidePaddingRatio = 0.45;
    double sidePaddingValues = (size == 0)
            ? screenHeight * Ratioz.fontSize0 * sidePaddingRatio // -- 8 -- A77A
            : (size == 1)
                ? screenHeight *
                    Ratioz.fontSize1 *
                    sidePaddingRatio // -- 10 -- Nano
                : (size == 2)
                    ? screenHeight *
                        Ratioz.fontSize2 *
                        sidePaddingRatio // -- 12 -- Micro
                    : (size == 3)
                        ? screenHeight *
                            Ratioz.fontSize3 *
                            sidePaddingRatio // -- 14 -- Mini
                        : (size == 4)
                            ? screenHeight *
                                Ratioz.fontSize4 *
                                sidePaddingRatio // -- 16 -- Medium
                            : (size == 5)
                                ? screenHeight *
                                    Ratioz.fontSize5 *
                                    sidePaddingRatio // -- 20 -- Macro
                                : (size == 6)
                                    ? screenHeight *
                                        Ratioz.fontSize6 *
                                        sidePaddingRatio // -- 24 -- Big
                                    : (size == 7)
                                        ? screenHeight *
                                            Ratioz.fontSize7 *
                                            sidePaddingRatio // -- 28 -- Massive
                                        : (size == 8)
                                            ? screenHeight *
                                                Ratioz.fontSize8 *
                                                sidePaddingRatio // -- 28 -- Gigantic
                                            : 0 //
        ;

    double sidePaddings =
        widget.labelColor == Colorz.Nothing ? 0 : sidePaddingValues;

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
          ]);
    }

    OutlineInputBorder superOutlineInputBorder(Color borderColor) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(labelCorner),
        borderSide: BorderSide(
          color: borderColor,
          width: 0.5,
        ),
        gapPadding: 0,
      );
    }

    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.only(
          bottom: widget.counterIsOn == true ? sidePaddings : 0),
      // margin: EdgeInsets.only(bottom: sidePaddings ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(labelCorner)),
        // color: Colorz.WhiteAir,
      ),
      child: TextField(
        controller: widget.textController,
        onChanged: widget.onChanged,
        onTap: () {
          print('onTap is tapped');
        },
        keyboardType: widget.keyboardTextInputType,
        style: superTextStyle(widget.inputColor, 1),
        enabled: true, // THIS DISABLES THE ABILITY TO OPEN THE KEYBOARD
        minLines: widget.minLines,
        maxLines: widget.obscured == true ? 1 : widget.maxLines,
        maxLength: widget.maxLength,
        autocorrect:
            false, // -------------------------------------------NO IMPACT
        // scrollPadding: EdgeInsets.all(50),
        keyboardAppearance: Brightness.dark,
        textDirection: superTextDirection(context),
        obscureText: widget.obscured,
        // obscuringCharacter: '*',
        maxLengthEnforced: false,
        enableInteractiveSelection: true, // makes test selectable

        decoration: InputDecoration(
          hintText: widget.hintText,
          hintMaxLines: 3,
          hintStyle: superTextStyle(Colorz.WhiteSmoke, 0.8),
          alignLabelWithHint: false,
          contentPadding: EdgeInsets.all(sidePaddings),

          focusedBorder: superOutlineInputBorder(Colorz.YellowSmoke),
          enabledBorder: superOutlineInputBorder(Colorz.Nothing),

          errorStyle: superTextStyle(Colorz.BloodRed, 0.7),
          focusedErrorBorder: superOutlineInputBorder(Colorz.BloodRed),

          errorBorder: superOutlineInputBorder(Colorz.Facebook),
          border: superOutlineInputBorder(Colorz.LinkedIn),
          disabledBorder: superOutlineInputBorder(Colorz.Grey),
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
        cursorWidth: 3,
        cursorHeight: null,
        textAlign: TextAlign.start,
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
