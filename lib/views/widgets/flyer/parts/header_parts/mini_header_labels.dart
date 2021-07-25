import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/author_label.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_bz_label.dart';
import 'package:bldrs/views/widgets/flyer/super_flyer.dart';
import 'package:flutter/material.dart';

class HeaderLabels extends StatelessWidget {
  final SuperFlyer superFlyer;
  // final double flyerZoneWidth;
  // final bool bzPageIsOn;
  // final bool flyerShowsAuthor;
  // final TinyBz tinyBz;
  // final TinyUser tinyAuthor;

  HeaderLabels({
    @required this.superFlyer,
    // @required this.flyerZoneWidth,
    // @required this.bzPageIsOn,
    // @required this.flyerShowsAuthor,
    // @required this.tinyBz,
    // @required this.tinyAuthor,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    bool miniMode = Scale.superFlyerMiniMode(context, superFlyer.flyerZoneWidth);
// -----------------------------------------------------------------------------
    double labelsWidth = superFlyer.flyerZoneWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
    double labelsHeight = superFlyer.flyerZoneWidth * (Ratioz.xxflyerHeaderMiniHeight - (2*Ratioz.xxflyerHeaderMainPadding));
// -----------------------------------------------------------------------------
    return
      miniMode == true || superFlyer.bzPageIsOn == true ? Container() :
      Container(
          width: labelsWidth,
          height: labelsHeight,
          child: Column(
            mainAxisAlignment: superFlyer.flyerShowsAuthor == true ? MainAxisAlignment.end : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // --- BUSINESS LABEL : BZ.NAME & BZ.LOCALE
              BzLabel(
                superFlyer: superFlyer,
                // flyerZoneWidth: superFlyer.flyerZoneWidth,
                // bzPageIsOn: superFlyer.bzPageIsOn,
                // tinyBz: tinyBz,
                // flyerShowsAuthor: flyerShowsAuthor,
              ),

              // -- middle expander ,, will delete i don't like it
              superFlyer.flyerShowsAuthor == true ?
              Expanded(
                child: Container(),
              ) : Container(),

              // --- AUTHOR LABEL : AUTHOR.IMAGE, AUTHOR.NAME, AUTHOR.TITLE, BZ.FOLLOWERS
              superFlyer.flyerShowsAuthor == false ? Container() :
              AuthorLabel(
                superFlyer: superFlyer  ,
                // flyerZoneWidth: flyerZoneWidth,
                // tinyAuthor: tinyAuthor,
                // tinyBz: tinyBz,
                showLabel: superFlyer.bzPageIsOn,
                authorGalleryCount: 0, // is not needed here
                labelIsOn: true,
              ),
            ],
          )
      )
    ;
  }
}
