import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';

enum VerseWeight {
  black,
  bold,
  regular,
  thin,
}

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
  final Function labelTap;
  final bool leadingDot;
  final bool redDot;

  SuperVerse({
    this.verse = 'Bldrs.net will shock planet Earth isa',
    this.size = 2,
    this.color = Colorz.White,
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
    this.labelTap,
    this.leadingDot = false,
    this.redDot = false,
  });

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

  @override
  Widget build(BuildContext context) {

    String _verse = verse;
    Color _verseColor = color;
    Color _boxColor = designMode ? Colorz.BloodTest : Colorz.Nothing;
    double _verseHeight = 1.42; //1.48; // The sacred golden reverse engineered factor
    double _scalingFactor = scaleFactor == null ? 1: scaleFactor;
    int _maxLines =  maxLines;
    // takes values from 0 to 8 in the entire app
    double _verseSizeValue = superVerseSizeValue(context, size, _scalingFactor);
    // --- AVAILABLE FONT WEIGHTS -----------------------------------------------
    FontWeight _verseWeight = superVerseWeight(weight);
    // --- AVAILABLE FONTS -----------------------------------------------
    String _verseFont = superVerseFont(context, weight);
    // --- LETTER SPACING -----------------------------------------------
    double _verseLetterSpacing = superVerseLetterSpacing(weight, _verseSizeValue);
    // --- WORD SPACING -----------------------------------------------
    double _verseWordSpacing = superVerseWordSpacing(_verseSizeValue);
    // --- SHADOWS -----------------------------------------------
    double _shadowBlur = 0;
    double _shadowYOffset = 0;
    double _shadowXOffset = superVerseXOffset(weight, _verseSizeValue);
    double _secondShadowXOffset = -0.35 * _shadowXOffset;
    Color _leftShadow = color == Colorz.BlackBlack ? Colorz.WhitePlastic : Colorz.BlackBlack;
    Color _rightShadow = color == Colorz.BlackBlack ? Colorz.WhiteSmoke : Colorz.WhiteGlass;
    // --- ITALIC -----------------------------------------------
    FontStyle _verseStyle = italic == true ? FontStyle.italic : FontStyle.normal;
    // --- VERSE BOX MARGIN -----------------------------------------------
    double _margin = margin == null ? 0 : margin;
    // --- LABEL -----------------------------------------------
    double _labelCornerValues = superVerseLabelCornerValue(context, size);
    double _labelCorner = labelColor == null ? 0 : _labelCornerValues;
    double _sidePaddingValues = superVerseSidePaddingValues(context, size);
    double _sidePaddings = labelColor == null ? 0 : _sidePaddingValues;
    double _labelHeight = superVerseRealHeight(context, size, scaleFactor, labelColor);
    // --- DOTS -----------------------------------------------
    double _dotSize = _verseSizeValue * 0.3;
    // --- RED DOT -----------------------------------------------


    return GestureDetector(
      onTap: labelTap,
      child: Padding(
        padding: EdgeInsets.all(_margin),
        child: Row(
          mainAxisAlignment: centered == true ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: redDot == true ? CrossAxisAlignment.center : CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            leadingDot == false ? Container() :
                Padding(
                  padding: EdgeInsets.all(_dotSize),
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
                  _verse == null ? '...' : _verse,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  maxLines: _maxLines,
                  textAlign: centered == true ?
                  TextAlign.center
                      :
                  TextAlign.start,
                  textScaleFactor: 1,
                  style: TextStyle(
                      backgroundColor: _boxColor,
                      textBaseline: TextBaseline.alphabetic,
                      height: _verseHeight,
                      color: _verseColor,
                      fontFamily: _verseFont ,
                      fontStyle: _verseStyle,
                      letterSpacing: _verseLetterSpacing,
                      wordSpacing: _verseWordSpacing,
                      fontSize: _verseSizeValue,
                      fontWeight: _verseWeight,
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
                  ),
                ),
              ),
            ),

            redDot == false ? Container() :
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
                  child: _dot(_dotSize, Colorz.BloodRed),
                ),
            ),

          ],
        ),
      ),
    );
  }
}