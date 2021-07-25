import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/views/screens/f_3_add_author_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/super_flyer.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AuthorLabel extends StatelessWidget {
  final SuperFlyer superFlyer;

  final double flyerZoneWidth;
  final TinyUser tinyAuthor;
  final TinyBz tinyBz;
  final bool showLabel;
  final int authorGalleryCount;
  final bool labelIsOn;
  final Function tappingLabel;

  AuthorLabel({
    this.superFlyer,

    this.flyerZoneWidth,
    this.tinyAuthor,
    this.tinyBz,
    this.showLabel,
    this.authorGalleryCount,
    this.labelIsOn = false,
    this.tappingLabel,
});

// tappingAuthorLabel (){
//     setState(() {
//       labelIsOn == true ? labelIsOn = false : labelIsOn = true;
//     });
// }

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    double _screenWidth = Scale.superScreenWidth(context);
    const bool _versesDesignMode = false;
    const bool _versesShadow = false;
// -----------------------------------------------------------------------------
    double _headerTextSidePadding = superFlyer.flyerZoneWidth * Ratioz.xxflyersGridSpacing;
// -----------------------------------------------------------------------------
    double _authorDataHeight =
    // flyerShowsAuthor == true ?
    (superFlyer.flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth)
    //     :
    // (flyerZoneWidth * ((Ratioz.xxflyerHeaderHeight* 0.3)-(2*Ratioz.xxflyerHeaderMainPadding)) )
    ;
// -----------------------------------------------------------------------------
    double _authorDataWidth = superFlyer.flyerZoneWidth * (Ratioz.xxflyerAuthorPicWidth+Ratioz.xxflyerAuthorNameWidth);
// -----------------------------------------------------------------------------
    // --- FOLLOWERS COUNTER --- --- --- --- --- --- --- --- --- --- --- FOLLOWERS COUNTER
    int _followersCount = superFlyer.bzTotalFollowers;
    int _bzGalleryCount = superFlyer.bzTotalFlyers;
    String _followersCounter =
    (authorGalleryCount == 0 && _followersCount == 0) || (authorGalleryCount == null && _followersCount == null) ? '' :
    showLabel == true ?
        '${Numberers.separateKilos(authorGalleryCount)} ${Wordz.flyers(context)}' :
        '${Numberers.counterCaliber(context, _followersCount)} ${Wordz.followers(context)} . ${Numberers.counterCaliber(context, _bzGalleryCount)} ${Wordz.flyers(context)}';
// -----------------------------------------------------------------------------
    double _authorImageCorners = superFlyer.flyerZoneWidth * Ratioz.xxflyerAuthorPicCorner;
// -----------------------------------------------------------------------------

    return
      GestureDetector(
        onTap: showLabel == true ? ()=> tappingLabel(superFlyer.authorID) : null,
        child:
        Container(
            height: _authorDataHeight,
            width: labelIsOn == true? _authorDataWidth : _authorDataHeight,
            margin: showLabel == true ? EdgeInsets.symmetric(horizontal : superFlyer.flyerZoneWidth * 0.01) : const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: showLabel == false ? Colorz.Nothing : Colorz.White20,
                borderRadius: Borderers.superBorderOnly(
                    context: context,
                    enTopLeft: _authorImageCorners,
                    enBottomLeft: 0,
                    enBottomRight: _authorImageCorners,
                    enTopRight: _authorImageCorners)
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
                    superFlyer: superFlyer,
                    // flyerZoneWidth: superFlyer.flyerZoneWidth,
                    // authorPic: superFlyer.flyerTinyAuthor.pic,
                    // tinyBz:
                  ),
                ),

                // --- AUTHOR LABEL : NAME, TITLE, FOLLOWERS COUNTER
                labelIsOn == false ? Container() :
                Expanded(
                  flex: 47,
                  child: Container(
                    width: superFlyer.flyerZoneWidth * Ratioz.xxflyerAuthorNameWidth,
                    padding: EdgeInsets.symmetric(horizontal: _headerTextSidePadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      <Widget>[

                        // --- AUTHOR NAME
                        SuperVerse(
                          verse: superFlyer?.flyerTinyAuthor?.name,
                          italic: false,
                          centered: false,
                          shadow: _versesShadow,
                          designMode: _versesDesignMode,
                          size: 2,
                          scaleFactor: superFlyer.flyerZoneWidth / _screenWidth,
                          maxLines: 1,
                        ),

                            // --- AUTHOR TITLE
                        SuperVerse(
                          verse: superFlyer?.flyerTinyAuthor?.title,
                          designMode: _versesDesignMode,
                          size: 1,
                          weight: VerseWeight.regular,
                          shadow: _versesShadow,
                          centered: false,
                          italic: true,
                          scaleFactor: superFlyer.flyerZoneWidth / _screenWidth,
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
                          scaleFactor: superFlyer.flyerZoneWidth / _screenWidth,
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
  final SuperFlyer superFlyer;
  final bool isAddAuthorButton;

  final double flyerZoneWidth;
  final dynamic authorPic;
  final TinyBz tinyBz;

  AuthorPic({
    this.superFlyer,
    this.isAddAuthorButton = false,

    this.flyerZoneWidth,
    this.authorPic,
    this.tinyBz,
  });

  void _tapAddAuthor(BuildContext context){

    print('should go to add new author screen');

    // Nav.goToNewScreen(context, AddAuthorScreen(tinyBz: tinyBz));
  }

  @override
  Widget build(BuildContext context) {

    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
    double _authorImageWidth = superFlyer.flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth;
    double _authorImageHeight = _authorImageWidth;
    double _authorImageCorners = superFlyer.flyerZoneWidth * Ratioz.xxflyerAuthorPicCorner;
    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
    BorderRadius _authorPicBorders = Borderers.superBorderOnly(
        context: context,
        enTopLeft: _authorImageCorners,
        enBottomLeft: 0,
        enBottomRight: _authorImageCorners,
        enTopRight: _authorImageCorners);
    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
    return
      Container(
        height: _authorImageHeight,
        width: _authorImageWidth,
        decoration: BoxDecoration(
            color: Colorz.White10,
            borderRadius: _authorPicBorders,
            image:
            superFlyer.flyerTinyAuthor?.pic == null ? null
                :
            ObjectChecker.objectIsJPGorPNG(superFlyer.flyerTinyAuthor?.pic)?
            DecorationImage(
                image: AssetImage(superFlyer.flyerTinyAuthor?.pic),
                fit: BoxFit.cover
            ) : null
        ),

        child:
        ClipRRect(
            borderRadius: _authorPicBorders,
            child:
            isAddAuthorButton == true ?
                GestureDetector(
                  onTap: () => _tapAddAuthor(context),
                  child: Container(
                    width: _authorImageWidth,
                    height: _authorImageHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        DreamBox(
                          width: _authorImageWidth * 0.35,
                          height: _authorImageHeight * 0.35,
                          icon: Iconz.Plus,
                          iconSizeFactor: 1,
                          bubble: false,
                          onTap: () => _tapAddAuthor(context),
                        ),

                        SuperVerse(
                          verse: 'Add new Author',
                          size: 0,
                          maxLines: 2,
                        ),

                      ],
                    ),
                  ),
                )
                :
            Imagers.superImageWidget(superFlyer.flyerTinyAuthor?.pic)
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

