import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';

enum VerseWeight {
  black,
  bold,
  regular,
  thin,
}

/// TASK : need to study Text_theme.dart class and text sizes
class SuperVerse extends StatelessWidget {
  final String verse;
  final int size;
  final Color color;
  final VerseWeight weight;
  final bool italic;
  final bool shadow;
  final bool centered;
  final bool designMode;
  final double scaleFactor;
  final int maxLines;
  final double margin;
  // final bool softWrap;
  final Color labelColor;
  final Function onTap;
  final bool leadingDot;
  final bool redDot;
  final bool strikethrough;

  const SuperVerse({
    this.verse = 'Bldrs.net will shock planet Earth isa',
    this.size = 2,
    this.color = Colorz.White255,
    this.weight = VerseWeight.bold,
    this.italic = false,
    this.shadow = false,
    this.centered = true,
    this.designMode = false,
    this.scaleFactor = 1,
    this.maxLines = 1,
    this.margin,
    // this.softWrap = true,
    this.labelColor,
    this.onTap,
    this.leadingDot = false,
    this.redDot = false,
    this.strikethrough = false,
  });
// -----------------------------------------------------------------------------
  static Widget dotVerse({String verse}){
    return
      SuperVerse(
        verse: verse,
        size: 2,
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
            weight: VerseWeight.bold,
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
      bool designMode = false,
       bool strikeThrough = false,
    }){

      const double _verseHeight = 1.42; //1.48; // The sacred golden reverse engineered factor
      final Color _boxColor = designMode ? Colorz.BloodTest : Colorz.Nothing;
      final String _verseFont = superVerseFont(context, weight);
      final FontStyle _verseStyle = italic == true ? FontStyle.italic : FontStyle.normal;
      final double _scalingFactor = scaleFactor == null ? 1: scaleFactor;
      final double _verseSizeValue = superVerseSizeValue(context, size, _scalingFactor);
      final double _verseLetterSpacing = superVerseLetterSpacing(weight, _verseSizeValue);
      final double _verseWordSpacing = superVerseWordSpacing(_verseSizeValue);
      final FontWeight _verseWeight = superVerseWeight(weight);
      // --- SHADOWS -----------------------------------------------
      const double _shadowBlur = 0;
      const double _shadowYOffset = 0;
      final double _shadowXOffset = superVerseXOffset(weight, _verseSizeValue);
      final double _secondShadowXOffset = -0.35 * _shadowXOffset;
      final Color _leftShadow = Colorizer.isBlack(color) == true ? Colorz.White200 : Colorz.Black230;
      final Color _rightShadow = Colorizer.isBlack(color) == true ? Colorz.White80 : Colorz.White20;

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
  static dynamic getTextAlign(bool centered){
    return
    centered == true ? TextAlign.center : TextAlign.start;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // Color _boxColor = designMode ? Colorz.BloodTest : Colorz.Nothing;
    // const double verseHeight = 1.42; //1.48; // The sacred golden reverse engineered factor
    final double _scalingFactor = scaleFactor == null ? 1: scaleFactor;
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
    final double _margin = margin == null ? 0 : margin;
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
                flex: 1,//_maxLines >= 1 ? 1 : 0,
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
                    textAlign: getTextAlign(centered),
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
                      designMode: designMode,
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
                  child: _dot(_dotSize, Colorz.Red255),
                ),
            ),

          ],
        ),
      ),
    );
  }
}