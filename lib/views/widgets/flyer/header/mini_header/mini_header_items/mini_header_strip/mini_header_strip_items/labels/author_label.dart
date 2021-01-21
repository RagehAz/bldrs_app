import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/numberers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'author_pic.dart';

class AuthorLabel extends StatelessWidget {
  final double flyerZoneWidth;
  final String authorPic;
  final String authorName;
  final String authorTitle;
  int followersCount;
  int bzGalleryCount;
  final bool bzPageIsOn;
  // final int bzConnects; // not used in here
  final int authorGalleryCount;
  bool labelIsOn;
  final String authorID;
  final Function tappingLabel;

  AuthorLabel({
    @required this.flyerZoneWidth,
    @required this.authorPic,
    @required this.authorName,
    @required this.authorTitle,
    @required this.followersCount,
    @required this.bzGalleryCount,
    @required this.bzPageIsOn,
    // @required this.bzConnects, // not used in here
    this.authorGalleryCount,
    this.labelIsOn = false,
    @required this.authorID,
    this.tappingLabel,
});



// tappingAuthorLabel (){
//     setState(() {
//       labelIsOn == true ? labelIsOn = false : labelIsOn = true;
//     });
// }


  @override
  Widget build(BuildContext context) {

    // === === === === === === === === === === === === === === === === === === ===
    double screenWidth = superScreenWidth(context);
    bool versesDesignMode = false;
    bool versesShadow = false;
    // === === === === === === === === === === === === === === === === === === ===
    double headerTextSidePadding = flyerZoneWidth * Ratioz.xxflyersGridSpacing;
    // === === === === === === === === === === === === === === === === === === ===
    double authorDataHeight =
    // flyerShowsAuthor == true ?
    (flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth)
    //     :
    // (flyerZoneWidth * ((Ratioz.xxflyerHeaderHeight* 0.3)-(2*Ratioz.xxflyerHeaderMainPadding)) )
    ;
    // === === === === === === === === === === === === === === === === === === ===
    double authorDataWidth = flyerZoneWidth * (Ratioz.xxflyerAuthorPicWidth+Ratioz.xxflyerAuthorNameWidth);
    // === === === === === === === === === === === === === === === === === === ===
    // --- FOLLOWERS COUNTER --- --- --- --- --- --- --- --- --- --- --- FOLLOWERS COUNTER
    String followersCounter =
    (authorGalleryCount == 0 && followersCount == 0) || (authorGalleryCount == null && followersCount == null) ? '' :
    bzPageIsOn == true ?
        '${separateKilos(authorGalleryCount)} flyers' :
        '${separateKilos(followersCount)} ${translate(context, 'Followers')} . ${separateKilos(bzGalleryCount)} flyers';
    // === === === === === === === === === === === === === === === === === === ===
    double authorImageCorners = flyerZoneWidth * Ratioz.xxflyerAuthorPicCorner;
    // === === === === === === === === === === === === === === === === === === ===

    return
      GestureDetector(
        onTap: bzPageIsOn == true ? () => tappingLabel(authorID) : null,
        child:
        Container(
            height: authorDataHeight,
            width: labelIsOn == true? authorDataWidth : authorDataHeight,
            margin: bzPageIsOn == true ? EdgeInsets.symmetric(horizontal : flyerZoneWidth * 0.01) : EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: bzPageIsOn == false ? Colorz.Nothing : Colorz.WhiteGlass,
                borderRadius: superBorderRadius(context, authorImageCorners, 0, authorImageCorners, authorImageCorners)
            ),

            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                // --- AUTHOR IMAGE
                Expanded(
                  flex: 15,
                  child: AuthorPic(
                    flyerZoneWidth: flyerZoneWidth,
                    authorPic: authorPic,
                  ),
                ),

                // --- AUTHOR LABEL : NAME, TITLE, FOLLOWERS COUNTER
                labelIsOn == false ? Container() :
                Expanded(
                  flex: 47,
                  child: Container(
                    width: flyerZoneWidth * Ratioz.xxflyerAuthorNameWidth,
                    padding: EdgeInsets.symmetric(horizontal: headerTextSidePadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      <Widget>[

                        // --- AUTHOR NAME
                        SuperVerse(
                          verse: authorName,
                          italic: false,
                          centered: false,
                          shadow: versesShadow,
                          designMode: versesDesignMode,
                          size: 2,
                          scaleFactor: flyerZoneWidth / screenWidth,
                          maxLines: 1,
                        ),

                            // --- AUTHOR TITLE
                        SuperVerse(
                          verse: authorTitle,
                          designMode: versesDesignMode,
                          size: 1,
                          weight: VerseWeight.regular,
                          shadow: versesShadow,
                          centered: false,
                          italic: true,
                          scaleFactor: flyerZoneWidth / screenWidth,
                          maxLines: 1,
                        ),

                        // --- FOLLOWERS COUNTER
                        SuperVerse(
                          verse: followersCounter,
                          italic: true,
                          centered: false,
                          shadow: versesShadow,
                          weight: VerseWeight.regular,
                          size: 0,
                          designMode: versesDesignMode,
                          scaleFactor: flyerZoneWidth / screenWidth,
                          maxLines: 1,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      );
  }
}
