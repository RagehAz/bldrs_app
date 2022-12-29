import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'super_text_helpers.dart';

enum VerseWeight {
  black,
  bold,
  regular,
  thin,
}


/// TASK : need to study Text_theme.dart class and text sizes
class SuperText extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperText({
    @required this.text,
    this.width,
    this.height,
    this.color = Colorz.white255,
    this.weight = VerseWeight.bold,
    this.italic = false,
    this.shadow = false,
    this.centered = true,
    this.maxLines = 1,
    this.margin,
    // this.softWrap = true,
    this.labelColor,
    this.onTap,
    this.onDoubleTap,
    this.leadingDot = false,
    this.redDot = false,
    this.strikeThrough = false,
    this.highlight,
    this.highlightColor = Colorz.bloodTest,
    this.shadowColor,
    this.textDirection = TextDirection.ltr,
    this.style,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String text;
  final double width;
  final Color color;
  final VerseWeight weight;
  final bool italic;
  final bool shadow;
  final bool centered;
  final double height;
  final int maxLines;
  final dynamic margin;
  // final bool softWrap;
  final Color labelColor;
  final Function onTap;
  final Function onDoubleTap;
  final bool leadingDot;
  final bool redDot;
  final bool strikeThrough;
  final ValueNotifier<dynamic> highlight;
  final Color highlightColor;
  final Color shadowColor;
  final TextDirection textDirection;
  final TextStyle style;
  // -----------------------------------------------------------------------------

  /// READY VERSES

  // --------------------
  /*
  static Widget verseDot({
    String verse,
  }) {
    return SuperText(
      text: verse,
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
    @required String verse,
  }){
    return SuperText(
      text: verse,
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
    @required String price,
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

        SuperText(
          text: price,
          color: color,
          weight: isBold ? VerseWeight.black : VerseWeight.bold,
          size: 6,
          scaleFactor: scaleFactor,
          shadow: true,
          strikeThrough: strikethrough,
        ),

        if (currency != null)
          SuperText(
            text: currency,
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

   */
  // -----------------------------------------------------------------------------

  /// SCALES

  // --------------------
  /*
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
  static double superVerseLabelCornerValue(double size){
    return size * 0.5;
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

   */
  // --------------------
  /*
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

   */
  // -----------------------------------------------------------------------------

  /// STYLING

  // --------------------
  static TextStyle createStyle({
    @required BuildContext context,
    String font,
    double height = 1,
    Color color = Colorz.white255,
    VerseWeight weight = VerseWeight.black,
    bool italic = true,
    double fontSize,
    bool shadowIsOn = true,
    Color shadowColor,
    bool strikeThrough = false,
    List<Shadow> shadows = const <Shadow>[],
    double letterSpacing,
    double wordSpacing,
  }) {

    const Color _boxColor = Colorz.nothing;
    final FontStyle _verseStyle = italic == true ? FontStyle.italic : FontStyle.normal;
    final FontWeight _verseWeight = superVerseWeight(weight);

    return TextStyle(
        backgroundColor: _boxColor,
        textBaseline: TextBaseline.alphabetic,
        height: height,
        color: color,
        fontFamily: font,
        fontStyle: _verseStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        fontSize: fontSize,
        fontWeight: _verseWeight,
        decoration: strikeThrough == true ? TextDecoration.lineThrough : null,
        // decorationStyle: TextDecorationStyle.wavy,
        decorationColor: Colorz.red255,
        shadows: shadows
    );

  }
  // --------------------
  static TextStyle superVerseDefaultStyle(BuildContext context) {
    return SuperText.createStyle(
      context: context,
      // color: Colorz.white255,
      weight: VerseWeight.thin,
      // italic: true,
      // size: 2,
      // shadow: true
    );
  }
  // -----------------------------------------------------------------------------

  /// ALIGNMENT

  // --------------------
  static dynamic getTextAlign({
    @required bool centered,
  }) {
    return centered == true ? TextAlign.center : TextAlign.start;
  }
  // -----------------------------------------------------------------------------

  /// WEIGHT

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
  // -----------------------------------------------------------------------------

  /// LETTER SPACING

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
  // -----------------------------------------------------------------------------

  /// SHADOW

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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (text == null){
      return const SizedBox();
    }

    else {

      // final double verseSizeValue = superVerseSizeValue(context, size, scaleFactor);
      final double _labelHeight = height;
      final double _dotSize = height * 0.3;

      return _SuperVerseBox(
        width: width,
        onTap: onTap,
        margin: margin,
        centered: centered,
        leadingDot: leadingDot,
        redDot: redDot,
        onDoubleTap: onDoubleTap,
        children: <Widget>[

          if (leadingDot == true)
            _LeadingDot(
              dotSize: _dotSize,
              color: color,
            ),

          _TheVerse(
            text: text,
            maxLines: maxLines,
            color: color,
            centered: centered,
            height: height,
            style: style,
            italic: italic,
            labelColor: labelColor,
            weight: weight,
            shadow: shadow,
            shadowColor: shadowColor,
            highlight: highlight,
            highlightColor: highlightColor,
            strikeThrough: strikeThrough,
            textDirection: textDirection,
          ),

          if (redDot == true)
            _RedDot(
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

class _SuperVerseBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _SuperVerseBox({
    @required this.onTap,
    @required this.margin,
    @required this.centered,
    @required this.leadingDot,
    @required this.redDot,
    @required this.children,
    @required this.onDoubleTap,
    @required this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final dynamic margin;
  final bool centered;
  final bool leadingDot;
  final bool redDot;
  final List<Widget> children;
  final Function onDoubleTap;
  final double width;
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
      onDoubleTap: onDoubleTap,
      child: Container(
        width: width,
        margin: superMargins(margin: margin),
        child: Row(
          mainAxisAlignment: _getMainAxisAlignment(centered: centered,),
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

class _LeadingDot extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _LeadingDot({
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

class _RedDot extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _RedDot({
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
        child: _LeadingDot.dot(
          dotSize: dotSize,
          color: Colorz.red255,
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

class _TheVerse extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _TheVerse({
    @required this.text,
    this.style,
    this.highlight,
    this.height,
    this.labelColor,
    this.maxLines = 1,
    this.centered = true,
    this.color = Colorz.white255,
    this.shadow = false,
    this.italic = false,
    this.weight = VerseWeight.bold,
    this.strikeThrough = false,
    this.highlightColor = Colorz.bloodTest,
    this.shadowColor,
    this.textDirection = TextDirection.ltr,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String text;
  final TextStyle style;
  final double height;
  final Color labelColor;
  final ValueNotifier<dynamic> highlight;
  final int maxLines;
  final bool centered;
  final Color color;
  final bool shadow;
  final bool italic;
  final VerseWeight weight;
  final bool strikeThrough;
  final Color highlightColor;
  final Color shadowColor;
  final TextDirection textDirection;
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// VERSE IS NULL
    if (stringIsEmpty(text) == true){
      return const SizedBox();
    }

    /// VERSE HAS VALUE
    else {
      // --------------------
      final double _sidePaddingValues = height * 0.5;
      final double _sidePaddings = labelColor == null ? 0 : _sidePaddingValues;
      // --------------------
      final double _labelCornerValues = height * 0.5;
      final double _labelCorner = labelColor == null ? 0 : _labelCornerValues;
      // --------------------
      final TextAlign _textAlign = SuperText.getTextAlign(centered: centered);
      // --------------------
      // final TextStyle _style = SuperText.createStyle(
      //   context: context,
      //   color: color,
      //   weight: weight,
      //   italic: italic,
      //   size: size,
      //   shadowIsOn: shadow,
      //   height: hei,
      //   strikeThrough: strikeThrough,
      // );
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
            text,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            textAlign: _textAlign,
            textScaleFactor: 1,
            textDirection: textDirection,
            // locale: Localizer.getSupportedLocales()[1],
            style: style,
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
                  textDirection: textDirection,
                  // textScaleFactor: 1,
                  text: TextSpan(
                    style: style,
                    children: _generateTextSpans(
                      verse: text,
                      highlighted: _highLightedText,
                      defaultStyle: style,
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

  }
  // -----------------------------------------------------------------------------
}
