

import 'dart:ui';

import 'package:flutter/material.dart';

TextStyle createTextStyle({
  /// SIZE
  @required double lineHeight,
  /// DUNNO
  bool inherit = true,
  String debugLabel,
  Locale locale,
  String package,
  /// FONT
  String fontFamily,
  List<FontFeature> fontFeatures,
  List<String> fontFamilyFallback,
  /// COLOR
  Color color = const Color.fromARGB(255, 0, 0, 0),
  Color backgroundColor,
  /// WEIGHT
  FontWeight fontWeight = FontWeight.w100,
  /// SPACING
  double letterSpacing,
  double wordSpacing,
  /// STYLE
  FontStyle fontStyle,
  TextBaseline textBaseline,
  List<Shadow> shadows,
  TextOverflow overflow,
  /// DECORATION
  Color decorationColor,
  TextDecorationStyle decorationStyle,
  TextDecoration decoration,
  double decorationThickness,
  /// PAINTS
  Paint foreground,
  Paint background,

  // ui.TextLeadingDistribution leadingDistribution,
}) {

  const double _height = 1.44;
  final double _fontSize = lineHeight / _height;

  return TextStyle(
    /// DUNNO
    inherit: inherit,
    debugLabel: debugLabel,
    locale: locale,
    package: package,
    /// FONT
    fontFamily: fontFamily,
    fontFeatures: fontFeatures,
    fontFamilyFallback: fontFamilyFallback,
    /// COLOR
    color: color,
    backgroundColor: backgroundColor,
    /// SIZE
    height: _height,
    fontSize: _fontSize,
    /// WEIGHT
    fontWeight: fontWeight,
    /// SPACING
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    /// STYLE
    fontStyle: fontStyle,
    textBaseline: textBaseline,
    shadows: shadows,
    overflow: overflow,
    /// DECORATION
    decorationColor: decorationColor,
    decoration: decoration,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
    /// PAINTS
    foreground: foreground,
    background: background,

    // leadingDistribution: TextLeadingDistribution.even,
  );

}
