import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/author_bubble/author_label.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_bz_label.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class HeaderLabels extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderLabels({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.bzCountry,
    @required this.bzCity,
    @required this.flyerShowsAuthor,
    @required this.headerIsExpanded,
    @required this.authorID,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel bzModel;
  final CountryModel bzCountry;
  final CityModel bzCity;
  final bool flyerShowsAuthor;
  final bool headerIsExpanded;
  final String authorID;
  /// --------------------------------------------------------------------------
  static double getHeaderLabelWidth(double flyerBoxWidth) {
    return flyerBoxWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final bool _tinyMode = OldFlyerBox.isTinyMode(context, flyerBoxWidth);
// -----------------------------------------------------------------------------
    final double labelsWidth = getHeaderLabelWidth(flyerBoxWidth);
    final double labelsHeight = flyerBoxWidth * (Ratioz.xxflyerHeaderMiniHeight - (2 * Ratioz.xxflyerHeaderMainPadding));
// -----------------------------------------------------------------------------
    return _tinyMode == true ?
    Container()
        :
    SizedBox(
        width: labelsWidth,
        height: labelsHeight,
        // color: Colorz.Bl,

        child: Column(
          mainAxisAlignment: flyerShowsAuthor == true ?
          MainAxisAlignment.end
              :
          MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// BUSINESS LABEL : BZ.NAME & BZ.LOCALE
            BzLabel(
              flyerBoxWidth: flyerBoxWidth,
              bzModel: bzModel,
              bzCountry: bzCountry,
              bzCity: bzCity,
              headerIsExpanded: headerIsExpanded,
              flyerShowsAuthor: flyerShowsAuthor,
            ),

            /// middle expander ,, will delete i don't like it
            if (flyerShowsAuthor == false)
              const Expander(),

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
  }
}
