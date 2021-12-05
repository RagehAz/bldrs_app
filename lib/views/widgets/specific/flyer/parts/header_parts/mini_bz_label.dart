import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class BzLabel extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;

  const BzLabel({
    @required this.flyerBoxWidth,
    this.superFlyer,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    // const bool versesShadow = false;
// -----------------------------------------------------------------------------
    final double _headerMainHeight = FlyerBox.headerStripHeight(bzPageIsOn: superFlyer.nav.bzPageIsOn, flyerBoxWidth: flyerBoxWidth);
    /// B.DATA
    final double _businessDataHeight = superFlyer.flyerShowsAuthor == true ? _headerMainHeight * 0.4 : _headerMainHeight * 0.7; //0.0475;
    final double _businessDataWidth = flyerBoxWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
    final double _headerTextSidePadding = flyerBoxWidth * 0.02;
    /// B.LOCALE
    final String _businessLocale = TextGen.countryStringer(
      context: context,
      zone: superFlyer.bz.zone,
      country: superFlyer.bzCountry,
      city: superFlyer.bzCity,
    );
// -----------------------------------------------------------------------------
    final int _bzNameSize = superFlyer.flyerShowsAuthor == true ? 3 : 5;
    final int _bLocaleSize = superFlyer.flyerShowsAuthor == true ? 1 : 1;
    final int _maxLines = superFlyer.flyerShowsAuthor == true ? 1 : 2;
// -----------------------------------------------------------------------------

    return Container(
      height: _businessDataHeight,
      width: _businessDataWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// B.NAME
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _headerTextSidePadding),
              child: SuperVerse(
                verse: superFlyer.bz.name,
                centered: false ,
                size: _bzNameSize,
                scaleFactor: (flyerBoxWidth / _screenWidth) * 0.9,
                maxLines: _maxLines,

              ),
            ),
          ),

          /// B.LOCALE
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _headerTextSidePadding),
              child: SuperVerse(
                verse: _businessLocale,
                size: _bLocaleSize,
                weight: VerseWeight.regular,
                centered: false,
                italic: true,
                scaleFactor: (flyerBoxWidth / _screenWidth)*0.9,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
