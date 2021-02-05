import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/author_label.dart';
import 'package:flutter/material.dart';

import 'bz_label.dart';

class HeaderLabels extends StatelessWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final String bzName;
  final String bzCountry;
  final String bzProvince;
  final String bzArea;
  final dynamic aPic;
  final String aName;
  final String aTitle;
  final int followersCount;
  final int bzGalleryCount;
  final bool flyerShowsAuthor;
  final int bzConnects;
  final String authorID;

  HeaderLabels({
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.bzName,
    @required this.bzCountry,
    @required this.bzProvince,
    @required this.bzArea,
    @required this.aPic,
    @required this.aName,
    @required this.aTitle,
    @required this.followersCount,
    @required this.bzGalleryCount,
    @required this.flyerShowsAuthor,
    @required this.bzConnects,
    @required this.authorID,
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
            children: [

              // --- BUSINESS LABEL : BZ.NAME & BZ.LOCALE
              BzLabel(
                flyerZoneWidth: flyerZoneWidth,
                bzPageIsOn: bzPageIsOn,
                bzName: bzName,
                bzCountry: bzCountry,
                bzProvince: bzProvince,
                bzArea: bzArea,
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
                authorPic: aPic,
                authorName: aName,
                authorTitle: aTitle,
                followersCount: followersCount,
                bzPageIsOn: bzPageIsOn,
                bzGalleryCount: bzGalleryCount,
                // authorGalleryCount: 0, // is not needed here
                labelIsOn: true,
                authorID: authorID,
              ),
            ],
          )
      )
    ;
  }
}
