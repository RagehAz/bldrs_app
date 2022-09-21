import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/fff_author_label.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/fff_bz_label.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class HeaderLabels extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderLabels({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.flyerShowsAuthor,
    @required this.headerIsExpanded,
    @required this.authorID,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel bzModel;
  final bool flyerShowsAuthor;
  final bool headerIsExpanded;
  final String authorID;
  // -----------------------------------------------------------------------------
  static double getHeaderLabelWidth(double flyerBoxWidth) {
    return flyerBoxWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
  }
  // --------------------
  static double getHeaderLabelHeight(double flyerBoxWidth){
    return flyerBoxWidth * (Ratioz.xxflyerHeaderMiniHeight - (2 * Ratioz.xxflyerHeaderMainPadding));
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double labelsWidth = getHeaderLabelWidth(flyerBoxWidth);
    final double labelsHeight = getHeaderLabelHeight(flyerBoxWidth);
    // --------------------
    return SizedBox(
        width: labelsWidth,
        height: labelsHeight,
        // color: Colorz.Bl,

        child: Column(
          mainAxisAlignment: flyerShowsAuthor == true ?
          MainAxisAlignment.spaceBetween
              :
          MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// BUSINESS LABEL : BZ.NAME & BZ.LOCALE
            BzLabel(
              flyerBoxWidth: flyerBoxWidth,
              bzModel: bzModel,
              headerIsExpanded: headerIsExpanded,
              flyerShowsAuthor: flyerShowsAuthor,
            ),

            /// AUTHOR LABEL : AUTHOR.IMAGE, AUTHOR.NAME, AUTHOR.TITLE, BZ.FOLLOWERS
            if (flyerShowsAuthor == true)
              AuthorLabel(
                flyerBoxWidth: flyerBoxWidth,
                authorID: authorID,
                bzModel: bzModel,
                showLabel: headerIsExpanded,
                authorGalleryCount: 0, // is not needed here
                labelIsOn: true,
                onTap: null,
              ),

          ],
        ));
    // --------------------
  }
// -----------------------------------------------------------------------------
}
