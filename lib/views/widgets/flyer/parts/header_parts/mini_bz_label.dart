import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/views/widgets/flyer/super_flyer.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class BzLabel extends StatelessWidget {
  final SuperFlyer superFlyer;
  // final double flyerZoneWidth;
  // final TinyBz tinyBz;
  // final bool bzPageIsOn;
  // final bool flyerShowsAuthor;

  BzLabel({
    this.superFlyer,
    // @required this.flyerZoneWidth,
    // @required this.tinyBz,
    // @required this.bzPageIsOn,
    // @required this.flyerShowsAuthor,
});

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    double screenWidth = Scale.superScreenWidth(context);
    bool versesDesignMode = false;
    bool versesShadow = false;
// -----------------------------------------------------------------------------
    double headerMainHeight = Scale.superHeaderStripHeight(superFlyer.bzPageIsOn, superFlyer.flyerZoneWidth);
    // --- B.DATA
    double businessDataHeight = superFlyer.flyerShowsAuthor == true ? headerMainHeight * 0.4 : headerMainHeight * 0.7; //0.0475;
    double businessDataWidth = superFlyer.flyerZoneWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
    double headerTextSidePadding = superFlyer.flyerZoneWidth * 0.02;
    // --- B.LOCALE
    String businessLocale = TextGenerator.zoneStringer(context: context, zone: superFlyer.bzZone,);
// -----------------------------------------------------------------------------
    int bzNameSize = superFlyer.flyerShowsAuthor == true ? 3 : 5;
    int bLocaleSize = superFlyer.flyerShowsAuthor == true ? 1 : 1;
    int _maxLines = superFlyer.flyerShowsAuthor == true ? 1 : 2;
// -----------------------------------------------------------------------------

    return Container(
      height: businessDataHeight,
      width: businessDataWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[

          // -- B.NAME
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: headerTextSidePadding),
              child: SuperVerse(
                verse: superFlyer.bzName,
                color: Colorz.White255,
                italic: false,
                centered: false,
                shadow: versesShadow,
                designMode: versesDesignMode,
                weight: VerseWeight.bold ,
                size: bzNameSize,
                scaleFactor: (superFlyer.flyerZoneWidth / screenWidth) * 0.9,
                maxLines: _maxLines,

              ),
            ),
          ),

          // --- B.LOCALE
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: headerTextSidePadding),
              child: SuperVerse(
                verse: businessLocale,
                size: bLocaleSize,
                weight: VerseWeight.regular ,
                designMode: versesDesignMode,
                shadow: versesShadow,
                centered: false,
                italic: true,
                color: Colorz.White255,
                scaleFactor: (superFlyer.flyerZoneWidth / screenWidth)*0.9,
                maxLines: 1,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
