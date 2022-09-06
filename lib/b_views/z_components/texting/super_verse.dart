import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';

enum VerseWeight {
  black,
  bold,
  regular,
  thin,
}

enum VerseCasing {
  non,
  upperCase,
  lowerCase,
  // Proper,
  // upperCamelCase,
  // lowerCamelCase,
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
    this.strikeThrough = false,
    this.highlight,
    this.highlightColor = Colorz.bloodTest,
    this.shadowColor,
    this.verseCasing,
    this.translate = true,
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
  final VerseCasing verseCasing;
  final bool translate;
  /// --------------------------------------------------------------------------
  static Widget dotVerse({String verse}) {
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
  // -----------------------------------------------------------------------------
  static Widget priceVerse({
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
      children: <Widget>[

        SuperVerse(
          verse: Numeric.formatNumToSeparatedKilos(number: price, fractions: 3),
          color: color,
          weight: isBold ? VerseWeight.black : VerseWeight.bold,
          size: 6,
          scaleFactor: scaleFactor,
          shadow: true,
          strikeThrough: strikethrough,
        ),

        if (currency != null)
          SuperVerse(
            verse: currency,
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
    final double _shadowXOffset = superVerseXOffset(weight, _verseSizeValue);
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
  static dynamic getTextAlign({
    @required bool centered,
  }) {
    return centered == true ? TextAlign.center : TextAlign.start;
  }
  // --------------------
  static double verseLabelHeight(int verseSize, double screenHeight) {
    return (verseSize == 0) ?
    screenHeight * Ratioz.fontSize0 * 1.42 // -- 8 -- A77A
        :
    (verseSize == 1) ?
    screenHeight * Ratioz.fontSize1 * 1.42 // -- 10 -- Nano
        :
    (verseSize == 2) ?
    screenHeight * Ratioz.fontSize2 * 1.42 // -- 12 -- Micro
        :
    (verseSize == 3) ?
    screenHeight * Ratioz.fontSize3 * 1.42 // -- 14 -- Mini
        :
    (verseSize == 4) ?
    screenHeight * Ratioz.fontSize4 * 1.42 // -- 16 -- Medium
        :
    (verseSize == 5) ?
    screenHeight * Ratioz.fontSize5 * 1.42 // -- 20 -- Macro
        :
    (verseSize == 6) ?
    screenHeight * Ratioz.fontSize6 * 1.42 // -- 24 -- Big
        :
    (verseSize == 7) ?
    screenHeight * Ratioz.fontSize7 * 1.42 // -- 28 -- Massive
        :
    (verseSize == 8) ?
    screenHeight * Ratioz.fontSize8 * 1.42 // -- 28 -- Gigantic
        :
    screenHeight * Ratioz.fontSize1 * 1.42;
  }
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
  // --------------------
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
  // --------------------
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
  // --------------------
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
  static double superVerseWordSpacing(double verseSize) {
    final double _verseWordSpacing =
    // weight == VerseWeight.thin ? verseSize * 0.1 :
    // weight == VerseWeight.regular ? verseSize * 0.1 :
    // weight == VerseWeight.bold ? verseSize * 0.1 :
    // weight == VerseWeight.black ? verseSize * 0.1 :
    verseSize * 0;
    return _verseWordSpacing;
  }
  // --------------------
  static double superVerseXOffset(VerseWeight weight, double verseSize) {
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
  // --------------------
  static double superVerseLabelCornerValue(
      BuildContext context,
      int size,
      ) {
    final double _screenHeight = Scale.superScreenHeight(context);
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
    final double _screenHeight = Scale.superScreenHeight(context);
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
  static double superVerseLabelMargin({
    @required BuildContext context,
    @required int verseSize,
    @required double scalingFactor,
    @required bool labelIsOn,
  }) {
    final double _sidePaddingValues = superVerseSidePaddingValues(context, verseSize);
    final double _sidePaddings = labelIsOn == false ? 0 : _sidePaddingValues;
    final double _superVerseLabelMargin = _sidePaddings * 0.25;
    return _superVerseLabelMargin;
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
  @override
  Widget build(BuildContext context) {

    if (verse == null){
      return const SizedBox();
    }

    else {

      final double verseSizeValue = superVerseSizeValue(context, size, scaleFactor);
      final double _labelHeight = superVerseRealHeight(
        context: context,
        size: size,
        sizeFactor: scaleFactor,
        hasLabelBox: labelColor != null,
      );

      final double _dotSize = verseSizeValue * 0.3;

      return SuperVerseBox(
        onTap: onTap,
        margin: margin,
        centered: centered,
        leadingDot: leadingDot,
        redDot: redDot,
        children: <Widget>[

          if (leadingDot == true)
            LeadingDot(
              dotSize: _dotSize,
              color: color,
            ),

          Verse(
            verse: verse,
            maxLines: maxLines,
            color: color,
            centered: centered,
            scaleFactor: scaleFactor,
            size: size,
            italic: italic,
            labelColor: labelColor,
            weight: weight,
            shadow: shadow,
            shadowColor: shadowColor,
            highlight: highlight,
            highlightColor: highlightColor,
            strikeThrough: strikeThrough,
            verseCasing: verseCasing,
            translate: translate,
          ),

          if (redDot == true)
            RedDot(
              labelHeight: _labelHeight,
              labelColor: labelColor,
              dotSize: _dotSize,
            ),

        ],
      );

    }

  }
  // -----------------------------------------------------------------------------
}

class SuperVerseBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperVerseBox({
    @required this.onTap,
    @required this.margin,
    @required this.centered,
    @required this.leadingDot,
    @required this.redDot,
    @required this.children,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final dynamic margin;
  final bool centered;
  final bool leadingDot;
  final bool redDot;
  final List<Widget> children;
  /// --------------------------------------------------------------------------
  static MainAxisAlignment _getMainAxisAlignment({
    @required bool centered,
  }){
    return centered == true ?
    MainAxisAlignment.center
        :
    MainAxisAlignment.start;
  }
  // --------------------
  static CrossAxisAlignment _getCrossAxisAlignment({
    @required bool redDot,
    @required bool leadingDot,
  }){
    return
      redDot == true ?
      CrossAxisAlignment.center
          :
      leadingDot == true ?
      CrossAxisAlignment.start
          :
      CrossAxisAlignment.center;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      key: const ValueKey<String>('SuperVerseBox'),
      onTap: onTap,
      child: Padding(
        padding: Scale.superMargins(margins: margin),
        child: Row(
          mainAxisAlignment: _getMainAxisAlignment(
            centered: centered,
          ),
          crossAxisAlignment: _getCrossAxisAlignment(
            leadingDot: leadingDot,
            redDot: redDot,
          ),
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

class LeadingDot extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LeadingDot({
    @required this.dotSize,
    @required this.color,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double dotSize;
  final Color color;
  /// --------------------------------------------------------------------------
  static Widget dot({
    @required double dotSize,
    @required Color color,
  }){
    return Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('the_leading_dot'),
      padding: EdgeInsets.all(dotSize),
      margin: EdgeInsets.only(top: dotSize),
      child: dot(
        dotSize: dotSize,
        color: color,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

class RedDot extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const RedDot({
    @required this.labelHeight,
    @required this.labelColor,
    @required this.dotSize,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double labelHeight;
  final Color labelColor;
  final double dotSize;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('the_red_dot'),
      height: labelHeight,
      margin: labelColor == null ?
      EdgeInsets.symmetric(horizontal: labelHeight * 0.2)
          :
      EdgeInsets.symmetric(
          horizontal: labelHeight * 0.05
      ),
      alignment: Alignment.topCenter,
      child: Padding(
        padding: labelColor == null ?
        EdgeInsets.only(top: labelHeight * 0.2)
            :
        EdgeInsets.only(top: labelHeight * 0.05),
        child: LeadingDot.dot(
          dotSize: dotSize,
          color: Colorz.red255,
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

class Verse extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Verse({
    @required this.verse,
    this.highlight,
    this.size = 2,
    this.labelColor,
    this.maxLines = 1,
    this.centered = true,
    this.color = Colorz.white255,
    this.shadow = false,
    this.italic = false,
    this.weight = VerseWeight.bold,
    this.scaleFactor = 1,
    this.strikeThrough = false,
    this.highlightColor = Colorz.bloodTest,
    this.shadowColor,
    this.verseCasing,
    this.translate,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final int size;
  final Color labelColor;
  final String verse;
  final ValueNotifier<dynamic> highlight;
  final int maxLines;
  final bool centered;
  final Color color;
  final bool shadow;
  final bool italic;
  final VerseWeight weight;
  final double scaleFactor;
  final bool strikeThrough;
  final Color highlightColor;
  final Color shadowColor;
  final VerseCasing verseCasing;
  final bool translate;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<TextSpan> _generateTextSpans({
    @required String verse,
    @required String highlighted,
    @required TextStyle defaultStyle,
    @required Color highlightColor,
  }){
    if (highlighted == null || highlighted.isEmpty || !verse.toLowerCase().contains(highlighted.trim().toLowerCase())) {
      return [ TextSpan(text: verse) ];
    }

    else {

      final Iterable<Match> matches = highlighted.toLowerCase().allMatches(verse.toLowerCase());
      int lastMatchEnd = 0;

      final List<TextSpan> children = <TextSpan>[];

      for (var i = 0; i < matches.length; i++) {
        final Match match = matches.elementAt(i);

        if (match.start != lastMatchEnd) {

          children.add(
              TextSpan(
                text: verse.substring(lastMatchEnd, match.start),
                style: defaultStyle,
              )
          );

        }

        children.add(
            TextSpan(
              text: verse.substring(match.start, match.end),
              style: defaultStyle.copyWith(backgroundColor: highlightColor),
            )
        );

        if (i == matches.length - 1 && match.end != verse.length) {
          children.add(
              TextSpan(
                text: verse.substring(match.end, verse.length),
                style: defaultStyle,
              )
          );
        }

        lastMatchEnd = match.end;
      }
      return children;

    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String convertVerseCase({
    @required String verse,
    @required VerseCasing verseCasing,
  }){

    switch (verseCasing){
      case VerseCasing.non:             return verse;                   break;
      case VerseCasing.lowerCase:       return verse.toLowerCase();     break;
      case VerseCasing.upperCase:       return verse.toUpperCase();     break;
    // case VerseCasing.Proper:          return properVerse(verse);      break;
    // case VerseCasing.upperCamelCase:  return upperCemelVerse(verse);  break;
    // case VerseCasing.lowerCamelCase:  return lowelCamelVerse(verse);  break;
      default: return verse;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String xFuckingSuperVerse({
    @required BuildContext context,
    @required String verse,
    @required VerseCasing verseCasing,
    @required bool translate,
  }){

    String _output = translate == true ? verse.trim() : '.$verse';

    if (translate == true){

      /// ADJUST VALUE
      if (TextCheck.isEmpty(_output) == false){

        /// IS PHID
        final bool _isPhid = TextCheck.checkVerseIsPhid(_output);
        final bool _isCurrency = TextCheck.checkVerseIsCurrency(_output);
        if (_isPhid == true || _isCurrency == true){

          final String _foundXPhrase = xPhrase(context, verse);

          /// X PHRASE NOT FOUND
          if (_foundXPhrase == null){
            _output = '?$_output';
          }

          /// X PHRASE FOUND
          else {
            _output = '.$_foundXPhrase';
          }

        }

        /// NOT NOT PHID
        else {

          /// IS TEMP
          final bool _isTemp = TextCheck.checkVerseIsTemp(_output);
          if (_isTemp == true){
            _output = TextMod.removeTextBeforeLastSpecialCharacter(_output, '#');
            _output = '##$_output';
          }

          /// NOT TEMP - NOT PHID
          else {
            _output = '>$_output';
          }

        }

      }

    }

    /// ADJUST CASING
    return convertVerseCase(verse: _output, verseCasing: verseCasing);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _sidePaddingValues = SuperVerse.superVerseSidePaddingValues(context, size);
    final double _sidePaddings = labelColor == null ? 0 : _sidePaddingValues;
    // --------------------
    final double _labelCornerValues = SuperVerse.superVerseLabelCornerValue(context, size);
    final double _labelCorner = labelColor == null ? 0 : _labelCornerValues;
    // --------------------
    final TextAlign _textAlign = SuperVerse.getTextAlign(centered: centered);
    // --------------------
    final TextStyle _style = SuperVerse.createStyle(
      context: context,
      color: color,
      weight: weight,
      italic: italic,
      size: size,
      shadowIsOn: shadow,
      scaleFactor: scaleFactor,
      strikeThrough: strikeThrough,
    );
    // --------------------
    final String _verse = xFuckingSuperVerse(
      context: context,
      verse: verse,
      verseCasing: verseCasing,
      translate: translate,
    );
    // --------------------
    return Flexible(
      key: const ValueKey<String>('a_verse'),
      child: Container(
        padding: EdgeInsets.only(
          right: _sidePaddings,
          left: _sidePaddings,
        ),
        margin: EdgeInsets.all(_sidePaddings * 0.25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_labelCorner)),
          color: labelColor,
        ),
        child:
        highlight == null ?
        Text(
          _verse,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          textAlign: _textAlign,
          textScaleFactor: 1,
          // textDirection: ,
          style: SuperVerse.createStyle(
            context: context,
            color: color,
            weight: weight,
            italic: italic,
            size: size,
            shadowIsOn: shadow,
            shadowColor: shadowColor,
            scaleFactor: scaleFactor,
            strikeThrough: strikeThrough,
          ),
        )
            :
        ValueListenableBuilder(
            valueListenable: highlight,
            builder: (_, dynamic _highlight, Widget child){

              String _highLightedText ='';

              if (_highlight is TextEditingValue){
                final TextEditingValue _t = _highlight;
                _highLightedText = _t.text;
              }
              else if (_highlight is String){
                _highLightedText = _highlight;
              }

              return RichText(
                maxLines: maxLines,
                textAlign: _textAlign,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                // textDirection: ,
                // textScaleFactor: 1,
                text: TextSpan(
                  style: _style,
                  children: _generateTextSpans(
                    verse: _verse,
                    highlighted: _highLightedText,
                    defaultStyle: _style,
                    highlightColor: highlightColor,
                  ),
                ),
              );


            }
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
