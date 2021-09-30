import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'scalers.dart';
// -----------------------------------------------------------------------------
double verseLabelHeight (int verseSize, double screenHeight){
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
double superVerseSizeValue (BuildContext context, int verseSize, double scalingFactor){
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

  double _verseSizeValue =
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
FontWeight superVerseWeight(VerseWeight weight){
  FontWeight _verseWeight =
  weight == VerseWeight.thin ? FontWeight.w100 :
  weight == VerseWeight.regular ? FontWeight.w600 :
  weight == VerseWeight.bold ? FontWeight.w100 :
  weight == VerseWeight.black ? FontWeight.w600 :
  FontWeight.w100;
  return _verseWeight;
}
// -----------------------------------------------------------------------------
String superVerseFont(BuildContext context, VerseWeight weight){
  String _verseFont =
  weight == VerseWeight.thin ? Wordz.bodyFont(context) :
  weight == VerseWeight.regular ? Wordz.bodyFont(context) :
  weight == VerseWeight.bold ? Wordz.headlineFont(context) :
  weight == VerseWeight.black ? Wordz.headlineFont(context) :
  Wordz.bodyFont(context);
  return _verseFont;
}
// -----------------------------------------------------------------------------
double superVerseLetterSpacing(VerseWeight weight, double verseSizeValue){
  double _verseLetterSpacing =
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
double superVerseWordSpacing(double verseSize){
  double _verseWordSpacing =
  // weight == VerseWeight.thin ? verseSize * 0.1 :
  // weight == VerseWeight.regular ? verseSize * 0.1 :
  // weight == VerseWeight.bold ? verseSize * 0.1 :
  // weight == VerseWeight.black ? verseSize * 0.1 :
  verseSize * 0
  ;
  return _verseWordSpacing;
}
// -----------------------------------------------------------------------------
double superVerseXOffset(VerseWeight weight, double verseSize){
  double _shadowXOffset =
  weight == VerseWeight.thin ? verseSize * -0.07 :
  weight == VerseWeight.regular ? verseSize * -0.09 :
  weight == VerseWeight.bold ? verseSize * -0.11 :
  weight == VerseWeight.black ? verseSize * -0.12:
  verseSize * -0.06;
  return _shadowXOffset;
}
// -----------------------------------------------------------------------------
double superVerseLabelCornerValue(BuildContext context, int size,){
  double _screenHeight = Scale.superScreenHeight(context);
  double _labelCornerRatio = 0.4;
  double _labelCornerValues =
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
double superVerseSidePaddingValues(BuildContext context, int size){
  double _screenHeight = Scale.superScreenHeight(context);
  double _sidePaddingRatio = 0.45;
  double _sidePaddingValues =
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
double superVerseRealHeight(BuildContext context, int verseSize, double scalingFactor, Color labelColor){
  double _sidePaddingValues = superVerseSidePaddingValues(context, verseSize);
  double _sidePaddings = labelColor == null ? 0 : _sidePaddingValues;
  double _verseHeight = (superVerseSizeValue(context, verseSize, scalingFactor) * 1.42) + (_sidePaddings * 0.25 * 0);
  return _verseHeight;
}
// -----------------------------------------------------------------------------
double superVerseLabelMargin(BuildContext context, int verseSize, double scalingFactor, bool labelIsOn){
  double _sidePaddingValues = superVerseSidePaddingValues(context, verseSize);
  double _sidePaddings = labelIsOn == false ? 0 : _sidePaddingValues;
  double _superVerseLabelMargin = _sidePaddings * 0.25;
  return _superVerseLabelMargin;
}
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
TextStyle superVerseDefaultStyle(BuildContext context){
  return
      SuperVerse.createStyle(context: context, color: Colorz.White255, weight: VerseWeight.thin, italic: true, size: 2, shadow: true);
}
// -----------------------------------------------------------------------------
