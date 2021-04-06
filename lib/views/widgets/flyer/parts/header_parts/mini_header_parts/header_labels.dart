import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/author_label.dart';
import 'package:flutter/material.dart';
import 'bz_label.dart';

class HeaderLabels extends StatelessWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final bool flyerShowsAuthor;
  final TinyBz tinyBz;
  final TinyUser tinyAuthor;

  HeaderLabels({
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.flyerShowsAuthor,
    @required this.tinyBz,
    @required this.tinyAuthor,
  });

  @override
  Widget build(BuildContext context) {
    // === === === === === === === === === === === === === === === === === === ===
    bool miniMode = superFlyerMiniMode(context, flyerZoneWidth);
    // === === === === === === === === === === === === === === === === === === ===
    double labelsWidth = flyerZoneWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
    double labelsHeight = flyerZoneWidth * (Ratioz.xxflyerHeaderMiniHeight - (2*Ratioz.xxflyerHeaderMainPadding));
    // === === === === === === === === === === === === === === === === === === ===
    return
      miniMode == true || bzPageIsOn == true ? Container() :
      Container(
          width: labelsWidth,
          height: labelsHeight,
          child: Column(
            mainAxisAlignment: flyerShowsAuthor == true ? MainAxisAlignment.end : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // --- BUSINESS LABEL : BZ.NAME & BZ.LOCALE
              BzLabel(
                flyerZoneWidth: flyerZoneWidth,
                bzPageIsOn: bzPageIsOn,
                tinyBz: tinyBz,
                flyerShowsAuthor: flyerShowsAuthor,
              ),

              // -- middle expander ,, will delete i don't like it
              flyerShowsAuthor == true ?
              Expanded(
                child: Container(),
              ) : Container(),

              // --- AUTHOR LABEL : AUTHOR.IMAGE, AUTHOR.NAME, AUTHOR.TITLE, BZ.FOLLOWERS
              flyerShowsAuthor == false ? Container() :
              AuthorLabel(
                flyerZoneWidth: flyerZoneWidth,
                tinyAuthor: tinyAuthor,
                tinyBz: tinyBz,
                showLabel: bzPageIsOn,
                // authorGalleryCount: 0, // is not needed here
                labelIsOn: true,
              ),
            ],
          )
      )
    ;
  }
}
