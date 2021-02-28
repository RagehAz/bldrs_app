import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'scalers.dart';
// === === === === === === === === === === === === === === === === === === ===
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
// === === === === === === === === === === === === === === === === === === ===
double superVerseSizeValue (BuildContext context, int verseSize, double scalingFactor){
  double screenHeight = superScreenHeight(context);
  double verseSizeValue =
  (verseSize == 0) ? screenHeight * Ratioz.fontSize0 * scalingFactor // -- 8 -- A77A
      :
  (verseSize == 1) ? screenHeight * Ratioz.fontSize1 * scalingFactor // -- 10 -- Nano
      :
  (verseSize == 2) ? screenHeight * Ratioz.fontSize2 * scalingFactor // -- 12 -- Micro
      :
  (verseSize == 3) ? screenHeight * Ratioz.fontSize3 * scalingFactor // -- 14 -- Mini
      :
  (verseSize == 4) ? screenHeight * Ratioz.fontSize4 * scalingFactor // -- 16 -- Medium
      :
  (verseSize == 5) ? screenHeight * Ratioz.fontSize5 * scalingFactor // -- 20 -- Macro
      :
  (verseSize == 6) ? screenHeight * Ratioz.fontSize6 * scalingFactor // -- 24 -- Big
      :
  (verseSize == 7) ? screenHeight * Ratioz.fontSize7 * scalingFactor // -- 28 -- Massive
      :
  (verseSize == 8) ? screenHeight * Ratioz.fontSize8 * scalingFactor // -- 28 -- Gigantic
      :
  screenHeight * Ratioz.fontSize1
  ;
  return verseSizeValue;
}
// === === === === === === === === === === === === === === === === === === ===
FontWeight superVerseWeight(VerseWeight weight){
  FontWeight verseWeight =
  weight == VerseWeight.thin ? FontWeight.w100 :
  weight == VerseWeight.regular ? FontWeight.w600 :
  weight == VerseWeight.bold ? FontWeight.w100 :
  weight == VerseWeight.black ? FontWeight.w600 :
  FontWeight.w100;
  return verseWeight;
}
// === === === === === === === === === === === === === === === === === === ===
String superVerseFont(BuildContext context, VerseWeight weight){
  String verseFont =
  weight == VerseWeight.thin ? Wordz.bodyFont(context) :
  weight == VerseWeight.regular ? Wordz.bodyFont(context) :
  weight == VerseWeight.bold ? Wordz.headlineFont(context) :
  weight == VerseWeight.black ? Wordz.headlineFont(context) :
  Wordz.bodyFont(context);
  return verseFont;
}
// === === === === === === === === === === === === === === === === === === ===
double superVerseLetterSpacing(VerseWeight weight, double verseSizeValue){
  double verseLetterSpacing =
  weight == VerseWeight.thin ? verseSizeValue * 0.035 :
  weight == VerseWeight.regular ? verseSizeValue * 0.09 :
  weight == VerseWeight.bold ? verseSizeValue * 0.05 :
  weight == VerseWeight.black ? verseSizeValue * 0.12
      :
  verseSizeValue * 0
  ;
  return verseLetterSpacing;
}
// === === === === === === === === === === === === === === === === === === ===
double superVerseWordSpacing(double verseSize){
  double verseWordSpacing =
  // weight == VerseWeight.thin ? verseSize * 0.1 :
  // weight == VerseWeight.regular ? verseSize * 0.1 :
  // weight == VerseWeight.bold ? verseSize * 0.1 :
  // weight == VerseWeight.black ? verseSize * 0.1 :
  verseSize * 0
  ;
  return verseWordSpacing;
}
// === === === === === === === === === === === === === === === === === === ===
double superVerseXOffset(VerseWeight weight, double verseSize){
  double shadowXOffset =
  weight == VerseWeight.thin ? verseSize * -0.07 :
  weight == VerseWeight.regular ? verseSize * -0.09 :
  weight == VerseWeight.bold ? verseSize * -0.11 :
  weight == VerseWeight.black ? verseSize * -0.12:
  verseSize * -0.06;
  return shadowXOffset;
}
// === === === === === === === === === === === === === === === === === === ===
double superVerseLabelCornerValue(BuildContext context, int size,){
  double screenHeight = superScreenHeight(context);
  double labelCornerRatio = 0.4;
  double labelCornerValues =
  (size == 0) ? screenHeight * Ratioz.fontSize0 * labelCornerRatio// -- 8 -- A77A
      :
  (size == 1) ? screenHeight * Ratioz.fontSize1 * labelCornerRatio// -- 10 -- Nano
      :
  (size == 2) ? screenHeight * Ratioz.fontSize2 * labelCornerRatio// -- 12 -- Micro
      :
  (size == 3) ? screenHeight * Ratioz.fontSize3 * labelCornerRatio// -- 14 -- Mini
      :
  (size == 4) ? screenHeight * Ratioz.fontSize4 * labelCornerRatio// -- 16 -- Medium
      :
  (size == 5) ? screenHeight * Ratioz.fontSize5 * labelCornerRatio// -- 20 -- Macro
      :
  (size == 6) ? screenHeight * Ratioz.fontSize6 * labelCornerRatio// -- 24 -- Big
      :
  (size == 7) ? screenHeight * Ratioz.fontSize7 * labelCornerRatio// -- 28 -- Massive
      :
  (size == 8) ? screenHeight * Ratioz.fontSize8 * labelCornerRatio// -- 28 -- Gigantic
      :
  0 // -- 14 -- Medium as default
      ;
  return labelCornerValues;
}
// === === === === === === === === === === === === === === === === === === ===
double superVerseSidePaddingValues(BuildContext context, int size){
  double screenHeight = superScreenHeight(context);
  double sidePaddingRatio = 0.45;
  double sidePaddingValues =
  (size == 0) ? screenHeight * Ratioz.fontSize0 * sidePaddingRatio// -- 8 -- A77A
      :
  (size == 1) ? screenHeight * Ratioz.fontSize1 * sidePaddingRatio// -- 10 -- Nano
      :
  (size == 2) ? screenHeight * Ratioz.fontSize2 * sidePaddingRatio// -- 12 -- Micro
      :
  (size == 3) ? screenHeight * Ratioz.fontSize3 * sidePaddingRatio// -- 14 -- Mini
      :
  (size == 4) ? screenHeight * Ratioz.fontSize4 * sidePaddingRatio// -- 16 -- Medium
      :
  (size == 5) ? screenHeight * Ratioz.fontSize5 * sidePaddingRatio // -- 20 -- Macro
      :
  (size == 6) ? screenHeight * Ratioz.fontSize6 * sidePaddingRatio// -- 24 -- Big
      :
  (size == 7) ? screenHeight * Ratioz.fontSize7 * sidePaddingRatio// -- 28 -- Massive
      :
  (size == 8) ? screenHeight * Ratioz.fontSize8 * sidePaddingRatio// -- 28 -- Gigantic
      :
  0 //
      ;
  return sidePaddingValues;
}
// === === === === === === === === === === === === === === === === === === ===
/// when SuperVerse has label color, it gets extra margin height, and is included in the final value of this function
double superVerseRealHeight(BuildContext context, int verseSize, double scalingFactor, Color labelColor){
  double sidePaddingValues = superVerseSidePaddingValues(context, verseSize);
  double sidePaddings = labelColor == null ? 0 : sidePaddingValues;
  double verseHeight = (superVerseSizeValue(context, verseSize, scalingFactor) * 1.42) + (sidePaddings * 0.25);
  return verseHeight;
}
// === === === === === === === === === === === === === === === === === === ===
