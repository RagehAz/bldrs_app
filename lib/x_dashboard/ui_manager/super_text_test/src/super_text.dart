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
    /// SCALES
    this.boxWidth,
    this.boxHeight,
    this.lineHeight = 20,
    /// COLORS
    this.textColor = Colorz.white255,
    this.boxColor,
    /// WEIGHT
    this.weight,
    this.italic = false,
    this.shadow = false,
    this.centered = true,
    this.maxLines = 1,
    this.margin,
    // this.softWrap = true,
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
  // --------------------------------------------------------------------------
  /// TEXT
  final String text;
  /// SCALES
  final double boxWidth;
  final double boxHeight;
  final double lineHeight;
  /// COLORS
  final Color textColor;
  final Color boxColor;
  /// WEIGHT
  final FontWeight weight;
  final bool italic;
  final bool shadow;
  final bool centered;
  final int maxLines;
  final dynamic margin;
  // final bool softWrap;
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

      // final double verseSizeValue = superVerseSizeValue(context, size, scaleFactor);
      final double _labelHeight = boxHeight;
      final double _dotSize = boxHeight * 0.3;

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
              dotSize: _dotSize,
              color: textColor,
            ),

          TextBuilder(
            text: text,
            maxLines: maxLines,
            color: textColor,
            centered: centered,
            height: boxHeight,
            labelColor: boxColor,
            shadow: shadow,
            highlight: highlight,
            highlightColor: highlightColor,
            strikeThrough: strikeThrough,
            textDirection: textDirection,
            style: createTextStyle(
              lineHeight: lineHeight,
              color: textColor,
              fontWeight: weight,
              fontStyle: italic == true ? FontStyle.italic : FontStyle.normal,
            ),
          ),

          if (redDot == true)
            RedDot(
              labelHeight: _labelHeight,
              labelColor: boxColor,
              dotSize: _dotSize,
            ),

        ],
      );

    }

  }
  // -----------------------------------------------------------------------------
}
