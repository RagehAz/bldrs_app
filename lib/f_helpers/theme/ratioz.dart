


abstract class Ratioz {
  // -----------------------------------------------------------------------------
  /// FONT SIZES

  static const double fontSize0 = 0.013; // -- 8 -- A77A

  static const double fontSize1 = 0.016; // -- 10 -- Nano

  static const double fontSize2 = 0.022; // -- 12 -- Micro

  static const double fontSize3 = 0.028; // -- 14 -- Mini

  static const double fontSize4 = 0.034; // -- 16 -- Medium

  static const double fontSize5 = 0.040; // -- 20 -- Macro

  static const double fontSize6 = 0.046; // -- 24 -- Big

  static const double fontSize7 = 0.052; // -- 28 -- Massive

  static const double fontSize8 = 0.058; // -- 30 -- Gigantic

  // -----------------------------------------------------------------------------
  /// BLDRS APPBARS
  static const double appBarCorner = 18; // ORIGINALLY MediaQuery.of(context).size.height * 0.0215;
  static const double appBarButtonCorner = 13;
  static const double boxCorner8 = 8;
  static const double boxCorner12 = 12;
  static const double appBarMargin = 10;
  static const double appBarPadding = 5;
  static const double appBarButtonSize = 40;
  static const double appBarSmallHeight = appBarPadding * 2 + appBarButtonSize;
  static const double appBarBigHeight = appBarPadding * 3 + appBarButtonSize * 2;
  static const double keywordsBarHeight = 50;
  static const double bottomSheetCorner = appBarCorner + appBarMargin;

  /// flyer old default ratios to be deleted lamma attamen 3al application isa
  static const double mainButtonCornerRatioToScreenHeight = 0.02;

  /// PYRAMIDS
  static const double pyramidsHeight = 80 * 0.7;
  static const double pyramidsWidth = 273 * 0.7;

  /// FLYER
  // static const double rrFlyerHeight = 1;
  // static const double rrFlyerMainMargin = 0.01;
  // static const double rrFlyerTopCorners = 0.028;
  // static const double rrFlyerBottomCorners = 0.0566;
  //
  // static const double rrFlyerHeaderHeight = 0.142;
  // static const double rrFlyerProgressBarHeight = 0.0075;
  // static const double rrFlyerTitleTopMargin = rrFlyerHeaderHeight + rrFlyerProgressBarHeight;

  // -----------------------------------------------------------------------------
  /// flyer ratios multiplied by flyerBoxWidth
  static const double xxbzPageSpacing = 0.005;



  /// Business logo corners Ratio in respect to Container Width or Height
  static const double bzLogoCorner = 0.17152;

  // -----------------------------------------------------------------------------
  /// paddings
  static const double stratosphere = 70;
  static const double exosphere = appBarBigHeight + (appBarMargin * 2);
  static const double horizon = pyramidsHeight * 1.5;
  static const double grandHorizon = pyramidsHeight;
  // -----------------------------------------------------------------------------
  /// Durations
  static const Duration duration150ms = Duration(milliseconds: 150);
  static const Duration durationFading200 = Duration(milliseconds: 200);
  static const Duration durationFading210 = Duration(milliseconds: 210);
  static const Duration durationSliding400 = Duration(milliseconds: 400);
  static const Duration durationSliding410 = Duration(milliseconds: 410);
  static const Duration duration750ms = Duration(milliseconds: 750);
  static const Duration duration1000ms = Duration(milliseconds: 1000);
  // -----------------------------------------------------------------------------
  /// Blur
  static const double blur1 = 10;
  static const double blur2 = 15;
  static const double blur3 = 20;
  static const double blur4 = 30;
  // -----------------------------------------------------------------------------
  /// image ratioz
  /// 90% of slide's flyerZoneHeight is the boxFit limit to turn from fitWidth to fitHeight
  static const double slideFitWidthLimit = 90;
  // -----------------------------------------------------------------------------
}
