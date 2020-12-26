import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class BzLabel extends StatelessWidget {
  final double flyerZoneWidth;
  final String bzName;
  final String bzCity;
  final String bzCountry;
  final bool bzPageIsOn;
  final bool flyerShowsAuthor;

  BzLabel({
    @required this.flyerZoneWidth,
    @required this.bzName,
    @required this.bzCity,
    @required this.bzCountry,
    @required this.bzPageIsOn,
    @required this.flyerShowsAuthor,
});

  @override
  Widget build(BuildContext context) {

    // === === === === === === === === === === === === === === === === === === ===
    double screenWidth = superScreenWidth(context);
    bool versesDesignMode = false;
    bool versesShadow = false;
    // === === === === === === === === === === === === === === === === === === ===
    double headerMainHeight = superHeaderStripHeight(bzPageIsOn, flyerZoneWidth);
    // --- B.DATA --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- B.DATA
    double businessDataHeight = flyerShowsAuthor == true ? headerMainHeight * 0.4 : headerMainHeight * 0.7; //0.0475;
    double businessDataWidth = flyerZoneWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
    double headerTextSidePadding = flyerZoneWidth * 0.02;
    // --- B.LOCALE --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- B.LOCALE
    String businessLocale = localeStringer(context, bzCity, bzCountry);
    // === === === === === === === === === === === === === === === === === === ===
    int bzNameSize = flyerShowsAuthor == true ? 3 : 5;
    int bLocaleSize = flyerShowsAuthor == true ? 1 : 1;
    int _maxLines = flyerShowsAuthor == true ? 1 : 2;
    // === === === === === === === === === === === === === === === === === === ===

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
                verse: bzName,
                color: Colorz.White,
                italic: false,
                centered: false,
                shadow: versesShadow,
                designMode: versesDesignMode,
                weight: VerseWeight.bold ,
                size: bzNameSize,
                scaleFactor: (flyerZoneWidth / screenWidth) * 0.9,
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
                color: Colorz.White,
                scaleFactor: (flyerZoneWidth / screenWidth)*0.9,
                maxLines: 1,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
