class Ratioz {
// -------------------------------------------------------------------------
// FONT SIZES

static const double fontSize0 = 0.013; // -- 8 -- A77A

static const double fontSize1 = 0.016; // -- 10 -- Nano

static const double fontSize2 = 0.022; // -- 12 -- Micro

static const double fontSize3 = 0.028; // -- 14 -- Mini

static const double fontSize4 = 0.034; // -- 16 -- Medium

static const double fontSize5 = 0.040; // -- 20 -- Macro

static const double fontSize6 = 0.046; // -- 24 -- Big

static const double fontSize7 = 0.052; // -- 28 -- Massive

static const double fontSize8 = 0.058; // -- 30 -- Gigantic

// -------------------------------------------------------------------------
// BLDRS APPBARS
static const double ddAppBarCorner = 18; // ORIGINALLY MediaQuery.of(context).size.height * 0.0215;
static const double ddAppBarButtonCorner = 13;
static const double ddBoxCorner8 = 8;
static const double ddBoxCorner12 = 12;
static const double ddAppBarMargin = 10;
static const double ddAppBarPadding = 5;
static const double ddAppBarHeight = 50;
static const double ddBottomSheetCorner = ddAppBarCorner + ddAppBarMargin;

// flyer old default ratios to be deleted lamma attamen 3al application isa
static const double rrButtonCorner = 0.02; // ratio of any button's corner value from screen height
static const double rrTextFieldCorner = 0.0221675; // same as upperFlyerCornerValue
static const double rrIconsInButtons = 0.0615764; // height of icon's Container which was 50pt x 50pt in Adobe Xd

// PYRAMIDS
static const double ddPyramidsHeight = 80 * 0.7;
static const double ddPyramidsWidth = 273 * 0.7;

// FLYER
static const double rrFlyerHeight = 1;
static const double rrFlyerMainMargin = 0.01;
static const double rrFlyerTopCorners = 0.028;
static const double rrFlyerBottomCorners = 0.0566;

static const double rrFlyerHeaderHeight = 0.142;
static const double rrFlyerProgressBarHeight = 0.0075;
static const double rrFlyerTitleTopMargin = rrFlyerHeaderHeight + rrFlyerProgressBarHeight;

// -------------------------------------------------------------------------
// flyer ratios multiplied by FlyerZoneWidth
static const double xxflyerZoneHeight = 1.74;
static const double xxflyerTopCorners = 0.05;
static const double xxflyerBottomCorners = 0.11;
static const double xxflyerMainMargins = 0.019;
static const double xxflyerHeaderMiniHeight = 0.27;
static const double xxflyerHeaderMaxHeight = 1.3;
static const double xxauthorImageCorners = 0.029;
static const double xxfollowCallWidth = 0.113;
static const double xxfollowCallSpacing = 0.005;
static const double xxfollowBTHeight = 0.1;
static const double xxCallBTHeight = 0.15;

static const double xxfooterBTMargins = 0.026;

// -- HEADER WIDTH OF EACH COMPONENT IN RESPECT TO FlyerZoneWidth
static const double xxflyerHeaderMainPadding = 0.006;
static const double xxflyerLogoWidth = 0.26;
static const double xxflyerAuthorPicWidth = 0.15;
static const double xxflyerAuthorPicCorner = Ratioz.xxflyerHeaderMiniHeight * 0.1083;
static const double xxflyerAuthorNameWidth = 0.47;
static const double xxflyerFollowBtWidth = 0.11;

static const double xxflyersGridSpacing = 0.02;
// Business logo corners Ratio in respect to Container Width or Height
static const double bzLogoCorner = 0.17152;

// -------------------------------------------------------------------------
// paddings
static const double stratosphere = 70;
static const double horizon = ddPyramidsHeight * 0.4;
static const double grandHorizon = ddPyramidsHeight;
// -------------------------------------------------------------------------
// Durations
static const Duration slidingDuration = Duration(milliseconds: 400);
static const Duration fadingDuration = Duration(milliseconds: 150);
static const Duration slidingAndFadingDuration = Duration(milliseconds: 750);
// -------------------------------------------------------------------------
// Blur
static const double blur1 = 10;
static const double blur2 = 15;
static const double blur3 = 20;
// -------------------------------------------------------------------------

}
