import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/ui_manager/super_text_test/src/create_style_method.dart';
import 'package:flutter/material.dart';
import 'leading_dot.dart';
import 'red_dot.dart';
import 'super_text_box.dart';
import 'text_builder.dart';

class SuperText extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SuperText({
    /// TEXT
    @required this.text,
    this.highlight,
    /// SCALES
    this.boxWidth,
    this.boxHeight,
    this.lineHeight = 20,
    this.maxLines = 1,
    this.margin,
    this.lineThickness = 0.5,
    /// COLORS
    this.textColor = Colorz.white255,
    this.boxColor,
    this.highlightColor = Colorz.bloodTest,
    this.lineColor,
    /// WEIGHT
    this.weight,
    /// STYLE
    this.font,
    this.italic = false,
    this.shadows,
    this.line,
    this.lineStyle = TextDecorationStyle.solid,
    /// DOTS
    this.leadingDot = false,
    this.redDot = false,
    /// DIRECTION
    this.centered = true,
    this.textDirection = TextDirection.ltr,
    /// GESTURES
    this.onTap,
    this.onDoubleTap,
    /// KEY
    Key key,
  }) : super(key: key);
  // --------------------------------------------------------------------------
  /// TEXT
  final String text;
  final ValueNotifier<dynamic> highlight;
  /// SCALES
  final double boxWidth;
  final double boxHeight;
  final double lineHeight;
  final int maxLines;
  final dynamic margin;
  final double lineThickness;
  /// COLORS
  final Color textColor;
  final Color boxColor;
  final Color highlightColor;
  final Color lineColor;
  /// WEIGHT
  final FontWeight weight;
  /// STYLE
  final String font;
  final bool italic;
  final List<Shadow> shadows;
  final TextDecoration line;
  final TextDecorationStyle lineStyle;
  /// DOTS
  final bool leadingDot;
  final bool redDot;
  /// DIRECTION
  final bool centered;
  final TextDirection textDirection;
  /// GESTURES
  final Function onTap;
  final Function onDoubleTap;
  // -----------------------------------------------------------------------------

  /// ALIGNMENT

  // --------------------
  static TextAlign getTextAlign({
    @required bool centered,
  }) {
    return centered == true ? TextAlign.center : TextAlign.start;
  }
    // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (text == null){
      return const SizedBox();
    }

    else {

      return SuperTextBox(
        width: boxWidth,
        onTap: onTap,
        margin: margin,
        centered: centered,
        leadingDot: leadingDot,
        redDot: redDot,
        onDoubleTap: onDoubleTap,
        children: <Widget>[

          if (leadingDot == true)
            LeadingDot(
              lineHeight: lineHeight,
              color: textColor,
            ),

          TextBuilder(
            text: text,
            maxLines: maxLines,
            centered: centered,
            height: boxHeight,
            labelColor: boxColor,
            highlight: highlight,
            highlightColor: highlightColor,
            textDirection: textDirection,
            style: createTextStyle(
              /// DUNNO
              // inherit: inherit,
              // debugLabel: debugLabel,
              // locale: locale,
              // package: package,
              /// FONT
              fontFamily: font,
              // fontFeatures: fontFeatures,
              // fontFamilyFallback: fontFamilyFallback,
              /// COLOR
              color: textColor,
              // backgroundColor: backgroundColor, /// NO NEED
              /// SIZE
              lineHeight: lineHeight,
              /// WEIGHT
              fontWeight: weight,
              /// SPACING
              // letterSpacing: letterSpacing,
              // wordSpacing: wordSpacing,
              /// STYLE
              fontStyle: italic == true ? FontStyle.italic : FontStyle.normal,
              // textBaseline: textBaseline,
              shadows: shadows,
              // overflow: overflow,
              /// DECORATION
              decorationColor: lineColor,
              decoration: line,
              decorationStyle: lineStyle,
              decorationThickness: lineThickness,
              /// PAINTS
              // foreground: foreground,
              // background: background,
            ),
          ),

          if (redDot == true)
            RedDot(
              lineHeight: lineHeight,
              labelColor: boxColor,
            ),

        ],
      );

    }

  }
  // -----------------------------------------------------------------------------
}
