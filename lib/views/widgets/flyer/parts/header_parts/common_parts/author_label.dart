import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/file_formatters.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AuthorLabel extends StatelessWidget {
  final double flyerZoneWidth;
  final dynamic authorPic;
  final String authorName;
  final String authorTitle;
  final int followersCount;
  final int bzGalleryCount;
  final bool bzPageIsOn;
  final int authorGalleryCount;
  final bool labelIsOn;
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
    double _screenWidth = superScreenWidth(context);
    bool _versesDesignMode = false;
    bool _versesShadow = false;
    // === === === === === === === === === === === === === === === === === === ===
    double _headerTextSidePadding = flyerZoneWidth * Ratioz.xxflyersGridSpacing;
    // === === === === === === === === === === === === === === === === === === ===
    double _authorDataHeight =
    // flyerShowsAuthor == true ?
    (flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth)
    //     :
    // (flyerZoneWidth * ((Ratioz.xxflyerHeaderHeight* 0.3)-(2*Ratioz.xxflyerHeaderMainPadding)) )
    ;
    // === === === === === === === === === === === === === === === === === === ===
    double _authorDataWidth = flyerZoneWidth * (Ratioz.xxflyerAuthorPicWidth+Ratioz.xxflyerAuthorNameWidth);
    // === === === === === === === === === === === === === === === === === === ===
    // --- FOLLOWERS COUNTER --- --- --- --- --- --- --- --- --- --- --- FOLLOWERS COUNTER
    String _followersCounter =
    (authorGalleryCount == 0 && followersCount == 0) || (authorGalleryCount == null && followersCount == null) ? '' :
    bzPageIsOn == true ?
        '${separateKilos(authorGalleryCount)} ${Wordz.flyers(context)}' :
        '${counterCaliber(context, followersCount)} ${Wordz.followers(context)} . ${counterCaliber(context, bzGalleryCount)} ${Wordz.flyers(context)}';
    // === === === === === === === === === === === === === === === === === === ===
    double _authorImageCorners = flyerZoneWidth * Ratioz.xxflyerAuthorPicCorner;
    // === === === === === === === === === === === === === === === === === === ===

    return
      GestureDetector(
        onTap: bzPageIsOn == true ? ()=> tappingLabel(authorID) : null,
        child:
        Container(
            height: _authorDataHeight,
            width: labelIsOn == true? _authorDataWidth : _authorDataHeight,
            margin: bzPageIsOn == true ? EdgeInsets.symmetric(horizontal : flyerZoneWidth * 0.01) : EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: bzPageIsOn == false ? Colorz.Nothing : Colorz.WhiteGlass,
                borderRadius: superBorderRadius(context, _authorImageCorners, 0, _authorImageCorners, _authorImageCorners)
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
                    padding: EdgeInsets.symmetric(horizontal: _headerTextSidePadding),
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
                          shadow: _versesShadow,
                          designMode: _versesDesignMode,
                          size: 2,
                          scaleFactor: flyerZoneWidth / _screenWidth,
                          maxLines: 1,
                        ),

                            // --- AUTHOR TITLE
                        SuperVerse(
                          verse: authorTitle,
                          designMode: _versesDesignMode,
                          size: 1,
                          weight: VerseWeight.regular,
                          shadow: _versesShadow,
                          centered: false,
                          italic: true,
                          scaleFactor: flyerZoneWidth / _screenWidth,
                          maxLines: 1,
                        ),

                        // --- FOLLOWERS COUNTER
                        SuperVerse(
                          verse: _followersCounter,
                          italic: true,
                          centered: false,
                          shadow: _versesShadow,
                          weight: VerseWeight.regular,
                          size: 0,
                          designMode: _versesDesignMode,
                          scaleFactor: flyerZoneWidth / _screenWidth,
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

class AuthorPic extends StatelessWidget {
  final double flyerZoneWidth;
  final dynamic authorPic;

  AuthorPic({
    @required this.flyerZoneWidth,
    @required this.authorPic,
  });

  @override
  Widget build(BuildContext context) {

    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
    double _authorImageWidth = flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth;
    double _authorImageHeight = _authorImageWidth;
    double _authorImageCorners = flyerZoneWidth * Ratioz.xxflyerAuthorPicCorner;
    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
    BorderRadius _authorPicBorders = superBorderRadius(context, _authorImageCorners, 0, _authorImageCorners, _authorImageCorners);

    return
      Container(
        height: _authorImageHeight,
        width: _authorImageWidth,
        decoration: BoxDecoration(
            color: Colorz.WhiteAir,
            borderRadius: _authorPicBorders,
            image:
            authorPic == null ? null
                :
            objectIsJPGorPNG(authorPic)?
            DecorationImage(
                image: AssetImage(authorPic),
                fit: BoxFit.cover
            ) : null
        ),

        child:
        ClipRRect(
            borderRadius: _authorPicBorders,
            child: superImageWidget(authorPic)
        ),

        // objectIsFile(authorPic) ?
        // ClipRRect(
        //   borderRadius: _authorPicBorders,
        //   child: Image.file(
        //     authorPic,
        //     fit: BoxFit.cover,
        //     width: _authorImageWidth,
        //     height: _authorImageHeight,
        //     // colorBlendMode: BlendMode.overlay,
        //     // color: Colorz.WhiteAir,
        //   ),
        // )
        //     :
        // Container(),
      );
  }
}
