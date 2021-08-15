import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/author_bubble/author_label.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_bz_label.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:flutter/material.dart';

class HeaderLabels extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneWidth;

  HeaderLabels({
    @required this.superFlyer,
    @required this.flyerZoneWidth,
  });

  static double getHeaderLabelWidth(double flyerZoneWidth){
    return flyerZoneWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
  }

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    bool _tinyMode = Scale.superFlyerTinyMode(context, flyerZoneWidth);
// -----------------------------------------------------------------------------
    double labelsWidth = getHeaderLabelWidth(flyerZoneWidth);
    double labelsHeight = flyerZoneWidth * (Ratioz.xxflyerHeaderMiniHeight - (2*Ratioz.xxflyerHeaderMainPadding));
// -----------------------------------------------------------------------------
    return
      _tinyMode == true ? Container() :
      Container(
          width: labelsWidth,
          height: labelsHeight,
          // color: Colorz.Bl,
          child: Column(
            mainAxisAlignment: superFlyer.flyerShowsAuthor == true ? MainAxisAlignment.end : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// BUSINESS LABEL : BZ.NAME & BZ.LOCALE
              BzLabel(
                superFlyer: superFlyer,
                flyerZoneWidth: flyerZoneWidth,
              ),

              /// middle expander ,, will delete i don't like it
              superFlyer.flyerShowsAuthor == true ?
              Expanded(
                child: Container(),
              ) : Container(),

              /// AUTHOR LABEL : AUTHOR.IMAGE, AUTHOR.NAME, AUTHOR.TITLE, BZ.FOLLOWERS
              if (superFlyer.flyerShowsAuthor == true)
              AuthorLabel(
                flyerZoneWidth: flyerZoneWidth,
                tinyAuthor: superFlyer.flyerTinyAuthor,
                tinyBz: SuperFlyer.getTinyBzFromSuperFlyer(superFlyer),
                showLabel: superFlyer.nav.bzPageIsOn,
                authorGalleryCount: 0, // is not needed here
                labelIsOn: true,
                onTap: null,
              ),

            ],
          )
      )
    ;
  }
}
