import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:colorizer/colorizer.dart';
import 'package:flutter/material.dart';
import 'package:numeric/numeric.dart';
import 'package:scale/scale.dart';
import 'package:super_text/super_text.dart';
export 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';

enum VerseWeight {
  black,
  bold,
  regular,
  thin,
}

class SuperVerse extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperVerse({
    @required this.verse,
    this.width,
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
    this.strikeThrough = false,
    this.highlight,
    this.highlightColor = Colorz.bloodTest,
    this.shadowColor,
    this.textDirection,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse verse;
  final double width;
  final int size;
  final Color color;
  final VerseWeight weight;
  final bool italic;
  final bool shadow;
  final bool centered;
  final double scaleFactor;
  final int maxLines;
  final dynamic margin;
  // final bool softWrap;
  final Color labelColor;
  final Function onTap;
  final bool leadingDot;
  final bool redDot;
  final bool strikeThrough;
  final ValueNotifier<dynamic> highlight;
  final Color highlightColor;
  final Color shadowColor;
  final TextDirection textDirection;
  // -----------------------------------------------------------------------------

  /// READY VERSES

  // --------------------
  static Widget verseDot({Verse verse}) {
    return SuperVerse(
      verse: verse,
      scaleFactor: 0.9,
      leadingDot: true,
      maxLines: 10,
      italic: true,
      weight: VerseWeight.thin,
      centered: false,
    );
  }
  // --------------------
  static Widget verseInfo({
    @required Verse verse,
  }){
    return SuperVerse(
      verse: verse,
      // scaleFactor: 1,
      italic: true,
      weight: VerseWeight.thin,
      centered: false,
      size: 1,
    );
  }
  // --------------------
  static Widget versePrice({
    @required BuildContext context,
    @required double price,
    Color color,
    double scaleFactor,
    String currency,
    bool strikethrough = false,
    bool isBold = true,
    bool isCentered = false
  }) {
    return Row(
      mainAxisAlignment: isCentered == true ? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        SuperVerse(
          verse: Verse(
            id: Numeric.formatNumToSeparatedKilos(number: price, fractions: 3),
            translate: false,
            casing: Casing.upperCase,
          ),
          color: color,
          weight: isBold ? VerseWeight.black : VerseWeight.bold,
          size: 6,
          scaleFactor: scaleFactor,
          shadow: true,
          strikeThrough: strikethrough,
        ),

        if (currency != null)
          SuperVerse(
            verse: Verse(
              id: currency,
              translate: true,
              casing: Casing.lowerCase,
            ),
            weight: isBold ? VerseWeight.black : VerseWeight.thin,
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

  /// SCALES

  // --------------------
  /// TESTED : ACCEPTED
  static double superVerseRealHeight({
    @required BuildContext context,
    @required int size,
    @required double sizeFactor,
    @required bool hasLabelBox,
  }) {
    /// when SuperVerse has label color, it gets extra margin height, and is included in the final value of this function
    final double _sidePaddingValues = superVerseSidePaddingValues(context, size);
    final double _sidePaddings = hasLabelBox == false ? 0 : _sidePaddingValues;
    final double _verseHeight =
        (superVerseSizeValue(context, size, sizeFactor) * 1.438)
            +
            (_sidePaddings * 0.25 * 0);

    return _verseHeight;
  }
  // --------------------
  static double superVerseLabelCornerValue(
      BuildContext context,
      int size,
      ) {
    final double _screenHeight = Scale.screenHeight(context);
    const double _labelCornerRatio = 0.4;
    final double _labelCornerValues =
    (size == 0) ?
    _screenHeight * Ratioz.fontSize0 * _labelCornerRatio // -- 8 -- A77A
        :
    (size == 1) ?
    _screenHeight * Ratioz.fontSize1 * _labelCornerRatio // -- 10 -- Nano
        :
    (size == 2) ?
    _screenHeight * Ratioz.fontSize2 * _labelCornerRatio // -- 12 -- Micro
        :
    (size == 3) ?
    _screenHeight * Ratioz.fontSize3 * _labelCornerRatio // -- 14 -- Mini
        :
    (size == 4) ?
    _screenHeight * Ratioz.fontSize4 * _labelCornerRatio // -- 16 -- Medium
        :
    (size == 5) ?
    _screenHeight * Ratioz.fontSize5 * _labelCornerRatio // -- 20 -- Macro
        :
    (size == 6) ?
    _screenHeight * Ratioz.fontSize6 * _labelCornerRatio // -- 24 -- Big
        :
    (size == 7) ?
    _screenHeight * Ratioz.fontSize7 * _labelCornerRatio // -- 28 -- Massive
        :
    (size == 8) ?
    _screenHeight * Ratioz.fontSize8 * _labelCornerRatio // -- 28 -- Gigantic
        :
    0 // -- 14 -- Medium as default
        ;
    return _labelCornerValues;
  }
  // --------------------
  static double superVerseSidePaddingValues(BuildContext context, int size) {
    final double _screenHeight = Scale.screenHeight(context);
    const double _sidePaddingRatio = 0.45;
    final double _sidePaddingValues = (size == 0) ?
    _screenHeight * Ratioz.fontSize0 * _sidePaddingRatio // -- 8 -- A77A
        :
    (size == 1) ?
    _screenHeight * Ratioz.fontSize1 * _sidePaddingRatio // -- 10 -- Nano
        :
    (size == 2) ?
    _screenHeight * Ratioz.fontSize2 * _sidePaddingRatio // -- 12 -- Micro
        :
    (size == 3) ?
    _screenHeight * Ratioz.fontSize3 * _sidePaddingRatio // -- 14 -- Mini
        :
    (size == 4) ?
    _screenHeight * Ratioz.fontSize4 * _sidePaddingRatio // -- 16 -- Medium
        :
    (size == 5) ?
    _screenHeight * Ratioz.fontSize5 * _sidePaddingRatio // -- 20 -- Macro
        :
    (size == 6) ?
    _screenHeight * Ratioz.fontSize6 * _sidePaddingRatio // -- 24 -- Big
        :
    (size == 7) ?
    _screenHeight * Ratioz.fontSize7 * _sidePaddingRatio // -- 28 -- Massive
        :
    (size == 8) ?
    _screenHeight * Ratioz.fontSize8 * _sidePaddingRatio // -- 28 -- Gigantic
        : 0 //
        ;
    return _sidePaddingValues;
  }
  // -----------------------------------------------------------------------------

  /// SIZING

  // --------------------
  static double superVerseSizeValue(
      BuildContext context,
      int verseSize,
      double scalingFactor
      ) {
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
    12 * scalingFactor;

    return _verseSizeValue;
  }

  // -----------------------------------------------------------------------------

  /// STYLING

  // --------------------
  static TextStyle createStyle({
    @required BuildContext context,
    Color color = Colorz.white255,
    VerseWeight weight = VerseWeight.black,
    bool italic = true,
    int size = 2,
    bool shadowIsOn = true,
    Color shadowColor,
    double scaleFactor = 1,
    bool strikeThrough = false,
  }) {
    const double _verseHeight = 1.438; //1.48; // The sacred golden reverse engineered factor
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
    final double _shadowXOffset = _superVerseXOffset(weight, _verseSizeValue);
    final double _secondShadowXOffset = -0.35 * _shadowXOffset;

    final Color _defaultLeftShadow = Colorizer.checkColorIsBlack(color) == true ? Colorz.white200 : Colorz.black230;

    final Color _leftShadow = shadowColor ?? _defaultLeftShadow;
    final Color _rightShadow = Colorizer.checkColorIsBlack(color) == true ? Colorz.white80 : Colorz.white20;

    return TextStyle(
        backgroundColor: _boxColor,
        textBaseline: TextBaseline.alphabetic,

        height: _verseHeight,
        color: color,
        fontFamily: _verseFont,
        fontStyle: _verseStyle,
        letterSpacing: _verseLetterSpacing,
        wordSpacing: _verseWordSpacing,
        fontSize: _verseSizeValue,
        fontWeight: _verseWeight,
        decoration: strikeThrough == true ? TextDecoration.lineThrough : null,
        // decorationStyle: TextDecorationStyle.wavy,
        decorationColor: Colorz.red255,
        shadows: <Shadow>[

          if (shadowIsOn == true)
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
  // --------------------
  static TextStyle superVerseDefaultStyle(BuildContext context) {
    return SuperVerse.createStyle(
      context: context,
      // color: Colorz.white255,
      weight: VerseWeight.thin,
      // italic: true,
      // size: 2,
      // shadow: true
    );
  }
  // -----------------------------------------------------------------------------

  /// WEIGHT

  // --------------------
  /// TESTED : WORKS PERFECT
  static FontWeight superVerseWeight(VerseWeight weight) {
    final FontWeight _verseWeight =
    weight == VerseWeight.thin ? FontWeight.w100
        :
    weight == VerseWeight.regular ? FontWeight.w600
        :
    weight == VerseWeight.bold ? FontWeight.w100
        :
    weight == VerseWeight.black ? FontWeight.w600
        :
    FontWeight.w100;
    return _verseWeight;
  }
  // -----------------------------------------------------------------------------

  /// FONT

  // --------------------
  /// TESTED : WORKS PERFECT
  static String superVerseFont(BuildContext context, VerseWeight weight) {
    final String _verseFont =
    weight == VerseWeight.thin ? Words.bodyFont(context)
        :
    weight == VerseWeight.regular ? Words.bodyFont(context)
        :
    weight == VerseWeight.bold ? Words.headlineFont(context)
        :
    weight == VerseWeight.black ? Words.headlineFont(context)
        :
    Words.bodyFont(context);
    return _verseFont;
  }
  // -----------------------------------------------------------------------------

  /// LETTER SPACING

  // --------------------
  /// TESTED : WORKS PERFECT
  static double superVerseLetterSpacing(VerseWeight weight, double verseSizeValue) {
    final double _verseLetterSpacing =
    weight == VerseWeight.thin ? verseSizeValue * 0.035
        :
    weight == VerseWeight.regular ? verseSizeValue * 0.03
        :
    weight == VerseWeight.bold ? verseSizeValue * 0.05
        :
    weight == VerseWeight.black ? verseSizeValue * 0.07
        :
    verseSizeValue * 0;
    return _verseLetterSpacing;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double superVerseWordSpacing(double verseSize) {
    final double _verseWordSpacing =
    // weight == VerseWeight.thin ? verseSize * 0.1 :
    // weight == VerseWeight.regular ? verseSize * 0.1 :
    // weight == VerseWeight.bold ? verseSize * 0.1 :
    // weight == VerseWeight.black ? verseSize * 0.1 :
    verseSize * 0;
    return _verseWordSpacing;
  }
  // -----------------------------------------------------------------------------

  /// SHADOW

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Shadow> verseShadows({
    @required BuildContext context,
    @required int size,
    @required bool shadowIsOn,
    @required Color textColor,
    @required double scaleFactor,
    @required VerseWeight weight,
    Color shadowColor,
  }){

    if (shadowIsOn == true){

      final double _verseSizeValue = superVerseSizeValue(context, size, scaleFactor);
      const double _shadowYOffset = 0;
      final double _shadowXOffset = _superVerseXOffset(weight, _verseSizeValue);
      final double _secondShadowXOffset = -0.35 * _shadowXOffset;

      final Color _defaultLeftShadow = Colorizer.checkColorIsBlack(textColor) == true ?
      Colorz.white200
          :
      Colorz.black230;

      final Color _leftShadow = shadowColor ?? _defaultLeftShadow;

      final Color _rightShadow = Colorizer.checkColorIsBlack(textColor) == true ?
      Colorz.white80
          :
      Colorz.white20;

      return  <Shadow>[

          if (shadowIsOn == true)
            Shadow(
              color: _leftShadow,
              offset: Offset(_shadowXOffset, _shadowYOffset),
            ),

          Shadow(
            color: _rightShadow,
            offset: Offset(_secondShadowXOffset, _shadowYOffset),
          )

        ];
    }

    else {
      return [];
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double _superVerseXOffset(VerseWeight weight, double verseSize) {
    final double _shadowXOffset =
    weight == VerseWeight.thin ? verseSize * -0.07
        :
    weight == VerseWeight.regular ? verseSize * -0.09
        :
    weight == VerseWeight.bold ? verseSize * -0.11
        :
    weight == VerseWeight.black ? verseSize * -0.12
        :
    verseSize * -0.06;
    return _shadowXOffset;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _verseSizeValue = superVerseSizeValue(context, size, scaleFactor);

    return SuperText(
      text: Verse.bakeVerseToString(
        context: context,
        verse: verse,
      ),
      highlight: highlight,
      boxWidth: width,
      // boxHeight: boxHeight,
      textHeight: _verseSizeValue * 1.42,
      maxLines: maxLines,
      margins: margin,
      wordSpacing: superVerseWordSpacing(_verseSizeValue),
      letterSpacing: SuperVerse.superVerseLetterSpacing(weight, _verseSizeValue),
      textColor: color,
      boxColor: labelColor,
      // highlightColor: highlightColor,
      weight: SuperVerse.superVerseWeight(weight),
      font: superVerseFont(context, weight),
      italic: italic,
      shadows: verseShadows(
        context: context,
        size: size,
        scaleFactor: scaleFactor,
        shadowIsOn: shadow,
        textColor: color,
        weight: weight,
        shadowColor: shadowColor,
      ),
      // line: line,
      // lineStyle: lineStyle,
      // lineColor: lineColor,
      // lineThickness: lineThickness,
      leadingDot: leadingDot,
      redDot: redDot,
      centered: centered,
      textDirection: textDirection ?? UiProvider.getAppTextDir(context),
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),
      onTap: onTap,
      // onDoubleTap: onDoubleTap,
      // package: package,
    );

  }
  // -----------------------------------------------------------------------------
}
