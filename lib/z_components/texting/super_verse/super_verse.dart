import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/colors/colorizer.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/components/texting/super_text/super_text.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

enum VerseWeight {
  black,
  bold,
  regular,
  thin,
}

class BldrsText extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsText({
    required this.verse,
    this.width,
    this.height,
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
    this.strikeThroughColor = Colorz.white255,
    this.highlight,
    this.highlightColor = Colorz.bloodTest,
    this.shadowColor,
    this.textDirection,
    this.appIsLTR,
    this.maxWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse? verse;
  final double? width;
  final double? height;
  final int size;
  final Color? color;
  final VerseWeight weight;
  final bool italic;
  final bool shadow;
  final bool centered;
  final double? scaleFactor;
  final int? maxLines;
  final dynamic margin;
  // final bool softWrap;
  final Color? labelColor;
  final Function? onTap;
  final bool leadingDot;
  final bool? redDot;
  final bool strikeThrough;
  final Color strikeThroughColor;
  final ValueNotifier<dynamic>? highlight;
  final Color highlightColor;
  final Color? shadowColor;
  final TextDirection? textDirection;
  final bool? appIsLTR;

  final double? maxWidth;
  // -----------------------------------------------------------------------------

  /// READY VERSES

  // --------------------
  static Widget verseDot({required Verse verse}) {
    return BldrsText(
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
    required Verse verse,
  }){
    return BldrsText(
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
    required BuildContext context,
    required double price,
    Color? color,
    double? scaleFactor,
    String? currency,
    bool strikethrough = false,
    bool isBold = true,
    bool isCentered = false
  }) {
    return Row(
      mainAxisAlignment: isCentered == true ? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        BldrsText(
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
          BldrsText(
            verse: Verse(
              id: currency,
              translate: true,
              casing: Casing.lowerCase,
            ),
            weight: isBold ? VerseWeight.black : VerseWeight.thin,
            color: color,
            italic: true,
            size: 3,
            margin: (scaleFactor??1) * 3,
            scaleFactor: scaleFactor,
          ),

      ],
    );
  }
  // --------------------
  static String? getCounterCaliber(int? x){
    return Numeric.formatNumToCounterCaliber(
      x: x,
      thousand: getWord('phid_thousand'),
      million: getWord('phid_million'),
    );
  }
  // -----------------------------------------------------------------------------

  /// SCALES

  // --------------------
  /// TESTED : ACCEPTED
  static double superVerseRealHeight({
    required BuildContext context,
    required int size,
    required double sizeFactor,
    required bool hasLabelBox,
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
      double? scalingFactor
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

    final double _scale = scalingFactor ?? 1;

    final double _verseSizeValue =
    (verseSize == 0) ? 8 * _scale
        :
    (verseSize == 1) ? 12 * _scale
        :
    (verseSize == 2) ? 16 * _scale
        :
    (verseSize == 3) ? 20 * _scale
        :
    (verseSize == 4) ? 24 * _scale
        :
    (verseSize == 5) ? 28 * _scale
        :
    (verseSize == 6) ? 32 * _scale
        :
    (verseSize == 7) ? 36 * _scale
        :
    (verseSize == 8) ? 40 * _scale
        :
    12 * _scale;

    return _verseSizeValue;
  }

  // -----------------------------------------------------------------------------

  /// STYLING

  // --------------------
  static TextStyle createStyle({
    required BuildContext context,
    Color color = Colorz.white255,
    VerseWeight weight = VerseWeight.black,
    bool italic = true,
    int size = 2,
    bool shadowIsOn = true,
    Color? shadowColor,
    double? scaleFactor = 1,
    bool strikeThrough = false,
  }) {
    const double _verseHeight = 1.438; //1.48; // The sacred golden reverse engineered factor
    const Color _boxColor = Colorz.nothing;
    final String _verseFont = superVerseFont(weight);
    final FontStyle _verseStyle = italic == true ? FontStyle.italic : FontStyle.normal;
    final double _scalingFactor = scaleFactor ?? 1;
    final double _verseSizeValue = superVerseSizeValue(context, size, _scalingFactor);
    final double _verseLetterSpacing = superVerseLetterSpacing(weight, _verseSizeValue);
    final double _verseWordSpacing = superVerseWordSpacing(
      verseSize: _verseSizeValue,
      weight: weight,
    );
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
        decorationStyle: TextDecorationStyle.solid,
        decorationColor: Colorz.red255,
        decorationThickness: 1,
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
    return BldrsText.createStyle(
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
  static FontWeight superVerseWeight(VerseWeight? weight) {
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
  static String superVerseFont(VerseWeight? weight) {
    final String _verseFont =
    weight == VerseWeight.thin ? Localizer.bodyFont()
        :
    weight == VerseWeight.regular ? Localizer.bodyFont()
        :
    weight == VerseWeight.bold ? Localizer.headlineFont()
        :
    weight == VerseWeight.black ? Localizer.headlineFont()
        :
    Localizer.bodyFont();
    return _verseFont;
  }
  // -----------------------------------------------------------------------------

  /// LETTER SPACING

  // --------------------
  /// TESTED : WORKS PERFECT
  static double superVerseLetterSpacing(VerseWeight? weight, double verseSizeValue) {
    final double _verseLetterSpacing =
    weight == VerseWeight.thin ? verseSizeValue * 0.035
        :
    weight == VerseWeight.regular ? verseSizeValue * 0.03
        :
    weight == VerseWeight.bold ? verseSizeValue * 0.025
        :
    weight == VerseWeight.black ? verseSizeValue * 0.03
        :
    verseSizeValue * 0;
    return _verseLetterSpacing;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double superVerseWordSpacing({
    required double verseSize,
    required VerseWeight weight,
  }) {
    final double _verseWordSpacing =
    weight == VerseWeight.thin ? verseSize * 0.0 :
    weight == VerseWeight.regular ? verseSize * 0.0 :
    weight == VerseWeight.bold ? verseSize * 0.0 :
    weight == VerseWeight.black ? verseSize * 0.0 :
    verseSize * 0;
    return _verseWordSpacing;
  }
  // -----------------------------------------------------------------------------

  /// SHADOW

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Shadow> verseShadows({
    required BuildContext context,
    required int size,
    required bool shadowIsOn,
    required Color? textColor,
    required double? scaleFactor,
    required VerseWeight weight,
    Color? shadowColor,
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
  static TextDirection detectTextDirection({
    required String? text,
    TextDirection? directionOverride,
  }){
    TextDirection _textDirection = TextDirection.ltr;

    if (text != null && directionOverride == null){

      if (TextCheck.textIsRTL(text) == true){
        _textDirection = TextDirection.rtl;
      }
      else {
        _textDirection = TextDirection.ltr;
      }

    }

    return directionOverride ?? _textDirection;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _verseSizeValue = superVerseSizeValue(context, size, scaleFactor);

    final String? _text = Verse.bakeVerseToString(verse: verse);

    return SuperText(
      maxWidth: maxWidth,
      text: _text,
      highlight: highlight,
      boxWidth: width,
      boxHeight: height,
      textHeight: _verseSizeValue * 1.42,
      maxLines: maxLines,
      margins: margin,
      wordSpacing: superVerseWordSpacing(
        verseSize: _verseSizeValue,
        weight: weight,
      ),
      letterSpacing: BldrsText.superVerseLetterSpacing(weight, _verseSizeValue),
      textColor: color,
      boxColor: labelColor,
      // highlightColor: highlightColor,
      weight: BldrsText.superVerseWeight(weight),
      font: superVerseFont(weight),
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

      /// STRIKETHROUGH
      line: strikeThrough == true ? TextDecoration.lineThrough : null,
      // lineStyle: TextDecorationStyle.solid, //
      lineColor: strikeThroughColor,
      lineThickness: _verseSizeValue * 1.42 * 0.1,
      leadingDot: leadingDot,
      redDot: redDot ?? false,
      centered: centered,
      textDirection: detectTextDirection(
        text: _text,
        directionOverride: textDirection,
      ),
      appIsLTR: appIsLTR ?? UiProvider.checkAppIsLeftToRight(),
      onTap: onTap,
      // onDoubleTap: onDoubleTap,
      // package: package,
    );

  }
  // -----------------------------------------------------------------------------
}
