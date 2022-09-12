import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BzLabel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzLabel({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.headerIsExpanded,
    @required this.flyerShowsAuthor,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final double flyerBoxWidth;
  final bool headerIsExpanded;
  final bool flyerShowsAuthor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    // const bool versesShadow = false;
    // --------------------
    final double _headerMainHeight = FlyerBox.headerStripHeight(
        headerIsExpanded: headerIsExpanded,
        flyerBoxWidth: flyerBoxWidth
    );
    // --------------------
    /// B.DATA
    final double _businessDataHeight = flyerShowsAuthor == true ?
    _headerMainHeight * 0.4
        :
    _headerMainHeight * 0.7; //0.0475;
    // --------------------
    final double _businessDataWidth = flyerBoxWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
    final double _headerTextSidePadding = flyerBoxWidth * 0.02;
    // --------------------
    /// B.LOCALE
    final Verse _businessLocale = ZoneModel.translateZoneString(
      context: context,
      zoneModel: bzModel.zone,
    );
    // --------------------
    final int _bzNameSize = flyerShowsAuthor == true ? 3 : 5;
    final int _bLocaleSize = flyerShowsAuthor == true ? 1 : 1;
    final int _maxLines = flyerShowsAuthor == true ? 1 : 2;
    // --------------------
    return SizedBox(
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
                verse: Verse(
                  text: bzModel?.name,
                  translate: false,
                ),
                centered: false,
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
                scaleFactor: (flyerBoxWidth / _screenWidth) * 0.9,
              ),
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
