import 'package:bldrs/controllers/drafters/colorizers.dart' as Colorizer;
import 'package:bldrs/controllers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';

enum VerseWeight {
  black,
  bold,
  regular,
  thin,
}

/// TASK : need to study Text_theme.dart class and text sizes
class SuperVerse extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperVerse({
    this.verse = 'Bldrs.net will shock planet Earth isa',
    this.size = 2,
    this.color = Colorz.white255,
    this.weight = VerseWeight.bold,
    this.italic = false,
    this.shadow = false,
    this.centered = true,
    this.scaleFactor = 1,
    this.maxLines = 1,
    this.margin,
    // this.softWrap = true,
    this.labelColor,
    this.onTap,
    this.leadingDot = false,
    this.redDot = false,
    this.strikethrough = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final int size;
  final Color color;
  final VerseWeight weight;
  final bool italic;
  final bool shadow;
  final bool centered;
  final double scaleFactor;
  final int maxLines;
  final double margin;
  // final bool softWrap;
  final Color labelColor;
  final Function onTap;
  final bool leadingDot;
  final bool redDot;
  final bool strikethrough;
  /// --------------------------------------------------------------------------
  static Widget dotVerse({String verse}){
    return
      SuperVerse(
        verse: verse,
        scaleFactor: 0.9,
        leadingDot: true,
        maxLines: 10,
        italic: true,
        weight: VerseWeight.thin,
        centered: false,
      );
  }
// -----------------------------------------------------------------------------
//   static Widget headlineVerse(String verse){
//     return
//         SuperVerse();
//   }
// -----------------------------------------------------------------------------
  static Widget priceVerse({BuildContext context, Color color, double price, double scaleFactor, String currency, bool strikethrough = false}){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SuperVerse(
            verse: '${Numeric.separateKilos(number: price, fractions: 3)}',
            color: color,
            weight: VerseWeight.black,
            size: 6,
            scaleFactor: scaleFactor,
            shadow: true,
            strikethrough: strikethrough,
          ),

          SuperVerse(
            verse: '$currency',
            color: color,
            italic: true,
            size: 3,
            margin: scaleFactor * 3,
            scaleFactor: scaleFactor,
          ),

        ],
      );
  }
// -----------------------------------------------------------------------------
  Widget _dot(double _dotSize, Color _color){
    return Container(
      width: _dotSize,
      height: _dotSize,
      decoration: BoxDecoration(
          color: _color,
          shape: BoxShape.circle
      ),
    );
  }
// -----------------------------------------------------------------------------
     static TextStyle createStyle({
      @required BuildContext context,
      @required Color color,
      @required VerseWeight weight,
      @required bool italic,
      @required int size,
      @required bool shadow,
      double scaleFactor = 1,
       bool strikeThrough = false,
    }){

      const double _verseHeight = 1.42; //1.48; // The sacred golden reverse engineered factor
      const Color _boxColor = Colorz.nothing;
      final String _verseFont = superVerseFont(context, weight);
      final FontStyle _verseStyle = italic == true ? FontStyle.italic : FontStyle.normal;
      final double _scalingFactor = scaleFactor ?? 1;
      final double _verseSizeValue = superVerseSizeValue(context, size, _scalingFactor);
      final double _verseLetterSpacing = superVerseLetterSpacing(weight, _verseSizeValue);
      final double _verseWordSpacing = superVerseWordSpacing(_verseSizeValue);
      final FontWeight _verseWeight = superVerseWeight(weight);
      /// --- SHADOWS -----------------------------------------------
      // const double _shadowBlur = 0;
      const double _shadowYOffset = 0;
      final double _shadowXOffset = superVerseXOffset(weight, _verseSizeValue);
      final double _secondShadowXOffset = -0.35 * _shadowXOffset;
      final Color _leftShadow = Colorizer.isBlack(color) == true ? Colorz.white200 : Colorz.black230;
      final Color _rightShadow = Colorizer.isBlack(color) == true ? Colorz.white80 : Colorz.white20;

      return
        TextStyle(
            backgroundColor: _boxColor,
            textBaseline: TextBaseline.alphabetic,
            height: _verseHeight,
            color: color,
            fontFamily: _verseFont ,
            fontStyle: _verseStyle,
            letterSpacing: _verseLetterSpacing,
            wordSpacing: _verseWordSpacing,
            fontSize: _verseSizeValue,
            fontWeight: _verseWeight,
            decoration: strikeThrough == true ? TextDecoration.lineThrough : null,
            shadows: <Shadow>[
              if (shadow)
                Shadow(
                  color: _leftShadow,
                  offset: Offset(_shadowXOffset, _shadowYOffset),
                ),
              Shadow(
                color: _rightShadow,
                offset: Offset(_secondShadowXOffset, _shadowYOffset),
              )
            ]
        );

    }
// -----------------------------------------------------------------------------
//   static Size getSize({String verse, TextStyle style, int maxLines, bool centered = true}) {
//
//     int _maxLines = maxLines == null ? 1 : maxLines;
//
//     final TextPainter textPainter =
//     TextPainter(
//       text: TextSpan(text: verse, style: style, ),
//       maxLines: _maxLines,
//       textDirection: superTextDirectionSwitcher(verse),
//       ellipsis: true,
//       textAlign:
//     )
//       ..layout(minWidth: 0, maxWidth: double.infinity);
//     return textPainter.size;
//   }
// -----------------------------------------------------------------------------
  static dynamic getTextAlign({@required bool centered}){
    return
    centered == true ? TextAlign.center : TextAlign.start;
  }
// -----------------------------------------------------------------------------
  static double verseLabelHeight (int verseSize, double screenHeight){
    return
      (verseSize == 0) ? screenHeight * Ratioz.fontSize0 * 1.42 // -- 8 -- A77A
          :
      (verseSize == 1) ? screenHeight * Ratioz.fontSize1 * 1.42 // -- 10 -- Nano
          :
      (verseSize == 2) ? screenHeight * Ratioz.fontSize2 * 1.42 // -- 12 -- Micro
          :
      (verseSize == 3) ? screenHeight * Ratioz.fontSize3 * 1.42 // -- 14 -- Mini
          :
      (verseSize == 4) ? screenHeight * Ratioz.fontSize4 * 1.42 // -- 16 -- Medium
          :
      (verseSize == 5) ? screenHeight * Ratioz.fontSize5 * 1.42 // -- 20 -- Macro
          :
      (verseSize == 6) ? screenHeight * Ratioz.fontSize6 * 1.42 // -- 24 -- Big
          :
      (verseSize == 7) ? screenHeight * Ratioz.fontSize7 * 1.42 // -- 28 -- Massive
          :
      (verseSize == 8) ? screenHeight * Ratioz.fontSize8 * 1.42 // -- 28 -- Gigantic
          :
      screenHeight * Ratioz.fontSize1 * 1.42
    ;
  }
// -----------------------------------------------------------------------------
  static double superVerseSizeValue (BuildContext context, int verseSize, double scalingFactor){
    // double _screenHeight = Scale.superScreenHeight(context);

    // double _verseSizeValue =
    // (verseSize == 0) ? _screenHeight * Ratioz.fontSize0 * scalingFactor // -- 8 -- A77A
    //     :
    // (verseSize == 1) ? _screenHeight * Ratioz.fontSize1 * scalingFactor // -- 10 -- Nano
    //     :
    // (verseSize == 2) ? _screenHeight * Ratioz.fontSize2 * scalingFactor // -- 12 -- Micro
    //     :
    // (verseSize == 3) ? _screenHeight * Ratioz.fontSize3 * scalingFactor // -- 14 -- Mini
    //     :
    // (verseSize == 4) ? _screenHeight * Ratioz.fontSize4 * scalingFactor // -- 16 -- Medium
    //     :
    // (verseSize == 5) ? _screenHeight * Ratioz.fontSize5 * scalingFactor // -- 20 -- Macro
    //     :
    // (verseSize == 6) ? _screenHeight * Ratioz.fontSize6 * scalingFactor // -- 24 -- Big
    //     :
    // (verseSize == 7) ? _screenHeight * Ratioz.fontSize7 * scalingFactor // -- 28 -- Massive
    //     :
    // (verseSize == 8) ? _screenHeight * Ratioz.fontSize8 * scalingFactor // -- 28 -- Gigantic
    //     :
    // _screenHeight * Ratioz.fontSize1
    // ;

    final double _verseSizeValue =
    (verseSize == 0) ? 8 * scalingFactor
        :
    (verseSize == 1) ? 12 * scalingFactor
        :
    (verseSize == 2) ? 16 * scalingFactor
        :
    (verseSize == 3) ? 20 * scalingFactor
        :
    (verseSize == 4) ? 24 * scalingFactor
        :
    (verseSize == 5) ? 28 * scalingFactor
        :
    (verseSize == 6) ? 32 * scalingFactor
        :
    (verseSize == 7) ? 36 * scalingFactor
        :
    (verseSize == 8) ? 40 * scalingFactor
        :
    12 * scalingFactor
    ;

    return _verseSizeValue;
  }
// -----------------------------------------------------------------------------
  static FontWeight superVerseWeight(VerseWeight weight){
    final FontWeight _verseWeight =
    weight == VerseWeight.thin ? FontWeight.w100 :
    weight == VerseWeight.regular ? FontWeight.w600 :
    weight == VerseWeight.bold ? FontWeight.w100 :
    weight == VerseWeight.black ? FontWeight.w600 :
    FontWeight.w100;
    return _verseWeight;
  }
// -----------------------------------------------------------------------------
  static String superVerseFont(BuildContext context, VerseWeight weight){
    final String _verseFont =
    weight == VerseWeight.thin ? Wordz.bodyFont(context) :
    weight == VerseWeight.regular ? Wordz.bodyFont(context) :
    weight == VerseWeight.bold ? Wordz.headlineFont(context) :
    weight == VerseWeight.black ? Wordz.headlineFont(context) :
    Wordz.bodyFont(context);
    return _verseFont;
  }
// -----------------------------------------------------------------------------
  static double superVerseLetterSpacing(VerseWeight weight, double verseSizeValue){
    final double _verseLetterSpacing =
    weight == VerseWeight.thin ? verseSizeValue * 0.035 :
    weight == VerseWeight.regular ? verseSizeValue * 0.03 :
    weight == VerseWeight.bold ? verseSizeValue * 0.05 :
    weight == VerseWeight.black ? verseSizeValue * 0.07
        :
    verseSizeValue * 0
    ;
    return _verseLetterSpacing;
  }
// -----------------------------------------------------------------------------
  static double superVerseWordSpacing(double verseSize){
    final double _verseWordSpacing =
    // weight == VerseWeight.thin ? verseSize * 0.1 :
    // weight == VerseWeight.regular ? verseSize * 0.1 :
    // weight == VerseWeight.bold ? verseSize * 0.1 :
    // weight == VerseWeight.black ? verseSize * 0.1 :
    verseSize * 0
    ;
    return _verseWordSpacing;
  }
// -----------------------------------------------------------------------------
  static double superVerseXOffset(VerseWeight weight, double verseSize){
    final double _shadowXOffset =
    weight == VerseWeight.thin ? verseSize * -0.07 :
    weight == VerseWeight.regular ? verseSize * -0.09 :
    weight == VerseWeight.bold ? verseSize * -0.11 :
    weight == VerseWeight.black ? verseSize * -0.12:
    verseSize * -0.06;
    return _shadowXOffset;
  }
// -----------------------------------------------------------------------------
  static double superVerseLabelCornerValue(BuildContext context, int size,){
    final double _screenHeight = Scale.superScreenHeight(context);
    const double _labelCornerRatio = 0.4;
    final double _labelCornerValues =
    (size == 0) ? _screenHeight * Ratioz.fontSize0 * _labelCornerRatio// -- 8 -- A77A
        :
    (size == 1) ? _screenHeight * Ratioz.fontSize1 * _labelCornerRatio// -- 10 -- Nano
        :
    (size == 2) ? _screenHeight * Ratioz.fontSize2 * _labelCornerRatio// -- 12 -- Micro
        :
    (size == 3) ? _screenHeight * Ratioz.fontSize3 * _labelCornerRatio// -- 14 -- Mini
        :
    (size == 4) ? _screenHeight * Ratioz.fontSize4 * _labelCornerRatio// -- 16 -- Medium
        :
    (size == 5) ? _screenHeight * Ratioz.fontSize5 * _labelCornerRatio// -- 20 -- Macro
        :
    (size == 6) ? _screenHeight * Ratioz.fontSize6 * _labelCornerRatio// -- 24 -- Big
        :
    (size == 7) ? _screenHeight * Ratioz.fontSize7 * _labelCornerRatio// -- 28 -- Massive
        :
    (size == 8) ? _screenHeight * Ratioz.fontSize8 * _labelCornerRatio// -- 28 -- Gigantic
        :
    0 // -- 14 -- Medium as default
        ;
    return _labelCornerValues;
  }
// -----------------------------------------------------------------------------
  static double superVerseSidePaddingValues(BuildContext context, int size){
    final double _screenHeight = Scale.superScreenHeight(context);
    const double _sidePaddingRatio = 0.45;
    final double _sidePaddingValues =
    (size == 0) ? _screenHeight * Ratioz.fontSize0 * _sidePaddingRatio// -- 8 -- A77A
        :
    (size == 1) ? _screenHeight * Ratioz.fontSize1 * _sidePaddingRatio// -- 10 -- Nano
        :
    (size == 2) ? _screenHeight * Ratioz.fontSize2 * _sidePaddingRatio// -- 12 -- Micro
        :
    (size == 3) ? _screenHeight * Ratioz.fontSize3 * _sidePaddingRatio// -- 14 -- Mini
        :
    (size == 4) ? _screenHeight * Ratioz.fontSize4 * _sidePaddingRatio// -- 16 -- Medium
        :
    (size == 5) ? _screenHeight * Ratioz.fontSize5 * _sidePaddingRatio // -- 20 -- Macro
        :
    (size == 6) ? _screenHeight * Ratioz.fontSize6 * _sidePaddingRatio// -- 24 -- Big
        :
    (size == 7) ? _screenHeight * Ratioz.fontSize7 * _sidePaddingRatio// -- 28 -- Massive
        :
    (size == 8) ? _screenHeight * Ratioz.fontSize8 * _sidePaddingRatio// -- 28 -- Gigantic
        :
    0 //
        ;
    return _sidePaddingValues;
  }
// -----------------------------------------------------------------------------
  /// when SuperVerse has label color, it gets extra margin height, and is included in the final value of this function
  static double superVerseRealHeight(BuildContext context, int verseSize, double scalingFactor, Color labelColor){
    final double _sidePaddingValues = superVerseSidePaddingValues(context, verseSize);
    final double _sidePaddings = labelColor == null ? 0 : _sidePaddingValues;
    final double _verseHeight = (superVerseSizeValue(context, verseSize, scalingFactor) * 1.42) + (_sidePaddings * 0.25 * 0);
    return _verseHeight;
  }
// -----------------------------------------------------------------------------
  static double superVerseLabelMargin({
    @required BuildContext context,
    @required int verseSize,
    @required double scalingFactor,
    @required bool labelIsOn,
  }){
    final double _sidePaddingValues = superVerseSidePaddingValues(context, verseSize);
    final double _sidePaddings = labelIsOn == false ? 0 : _sidePaddingValues;
    final double _superVerseLabelMargin = _sidePaddings * 0.25;
    return _superVerseLabelMargin;
  }
// -----------------------------------------------------------------------------
  static TextStyle superVerseDefaultStyle(BuildContext context){
    return
      SuperVerse.createStyle(context: context, color: Colorz.white255, weight: VerseWeight.thin, italic: true, size: 2, shadow: true);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // const Color _boxColor = Colorz.Nothing;
    // const double verseHeight = 1.42; //1.48; // The sacred golden reverse engineered factor
    final double _scalingFactor = scaleFactor ?? 1;
    /// takes values from 0 to 8 in the entire app
    final double verseSizeValue = superVerseSizeValue(context, size, _scalingFactor);
    /// --- AVAILABLE FONT WEIGHTS -----------------------------------------------
    // FontWeight verseWeight = superVerseWeight(weight);
    /// --- AVAILABLE FONTS -----------------------------------------------
    // String verseFont = superVerseFont(context, weight);
    /// --- LETTER SPACING -----------------------------------------------
    // double verseLetterSpacing = superVerseLetterSpacing(weight, verseSizeValue);
    /// --- WORD SPACING -----------------------------------------------
    // double verseWordSpacing = superVerseWordSpacing(verseSizeValue);
    /// --- SHADOWS -----------------------------------------------
    // const double _shadowBlur = 0;
    // const double _shadowYOffset = 0;
    // double _shadowXOffset = superVerseXOffset(weight, verseSizeValue);
    // double _secondShadowXOffset = -0.35 * _shadowXOffset;
    // Color _leftShadow = color == Colorz.Black230 ? Colorz.White125 : Colorz.Black230;
    // Color _rightShadow = color == Colorz.Black230 ? Colorz.White80 : Colorz.White20;
    /// --- ITALIC -----------------------------------------------
    // FontStyle verseStyle = italic == true ? FontStyle.italic : FontStyle.normal;
    /// --- VERSE BOX MARGIN -----------------------------------------------
    final double _margin = margin ?? 0;
    /// --- LABEL -----------------------------------------------
    final double _labelCornerValues = superVerseLabelCornerValue(context, size);
    final double _labelCorner = labelColor == null ? 0 : _labelCornerValues;
    final double _sidePaddingValues = superVerseSidePaddingValues(context, size);
    final double _sidePaddings = labelColor == null ? 0 : _sidePaddingValues;
    final double _labelHeight = superVerseRealHeight(context, size, scaleFactor, labelColor);
    // --- DOTS -----------------------------------------------
    final double _dotSize = verseSizeValue * 0.3;
    // --- RED DOT -----------------------------------------------


    return
      verse == null ? Container() :
      GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(_margin),
          child: Row(
            mainAxisAlignment: centered == true ? MainAxisAlignment.center : MainAxisAlignment.start,
            crossAxisAlignment: redDot == true ? CrossAxisAlignment.center : leadingDot == true ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              if (leadingDot == true)
                Container(
                  // color: Colorz.BloodTest,
                  padding: EdgeInsets.all(_dotSize),
                  margin: EdgeInsets.only(top: _dotSize),
                  child: _dot(_dotSize, color),
                ),

              Flexible(
                child: Container(
                  padding: EdgeInsets.only(right: _sidePaddings, left: _sidePaddings),
                  margin: EdgeInsets.all(_sidePaddings * 0.25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(_labelCorner)),
                      color: labelColor
                  ),
                  child: Text(
                    verse,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: maxLines,
                    textAlign: getTextAlign(centered: centered),
                    textScaleFactor: 1,
                    style:
                    createStyle(
                      context: context,
                      color: color,
                      weight: weight,
                      italic: italic,
                      size: size,
                      shadow: shadow,
                      scaleFactor: scaleFactor,
                      strikeThrough: strikethrough,
                    ),

                  // TextStyle(
                  //     fontWeight: verseWeight,
                  //     shadows: <Shadow>[
                  //       if (shadow)
                  //         Shadow(
                  //           blurRadius: _shadowBlur,
                  //           color: _leftShadow,
                  //           offset: Offset(_shadowXOffset, _shadowYOffset),
                  //         ),
                  //       Shadow(
                  //         blurRadius: _shadowBlur,
                  //         color: _rightShadow,
                  //         offset: Offset(_secondShadowXOffset, _shadowYOffset),
                  //       ),
                  //     ]
                  // ),
                ),
              ),
            ),

            if (redDot == true)
            Container(
              height: _labelHeight,
                margin:
                labelColor == null ?
                EdgeInsets.symmetric(horizontal: _labelHeight * 0.2) :
                EdgeInsets.symmetric(horizontal: _labelHeight * 0.05),
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:
                  labelColor == null ?
                  EdgeInsets.only(top: _labelHeight * 0.2) :
                  EdgeInsets.only(top: _labelHeight * 0.05) ,
                  child: _dot(_dotSize, Colorz.red255),
                ),
            ),

          ],
        ),
      ),
    );
  }
}
