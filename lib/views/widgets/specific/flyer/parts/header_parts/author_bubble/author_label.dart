import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AuthorLabel extends StatelessWidget {
  final double flyerBoxWidth;
  final TinyUser tinyAuthor;
  final TinyBz tinyBz;
  final bool showLabel;
  final int authorGalleryCount;
  final bool labelIsOn;
  final Function onTap;

  const AuthorLabel({
    @required this.flyerBoxWidth,
    @required this.tinyAuthor,
    @required this.tinyBz,
    @required this.showLabel,
    @required this.authorGalleryCount,
    this.labelIsOn = false,
    @required this.onTap,
});

// tappingAuthorLabel (){
//     setState(() {
//       labelIsOn == true ? labelIsOn = false : labelIsOn = true;
//     });
// }

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    const bool _versesDesignMode = false;
    const bool _versesShadow = false;
// -----------------------------------------------------------------------------
    final double _headerTextSidePadding = flyerBoxWidth * Ratioz.xxflyersGridSpacing;
// -----------------------------------------------------------------------------
    final double _authorDataHeight =
    // flyerShowsAuthor == true ?
    (flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth)
    //     :
    // (flyerBoxWidth * ((Ratioz.xxflyerHeaderHeight* 0.3)-(2*Ratioz.xxflyerHeaderMainPadding)) )
    ;
// -----------------------------------------------------------------------------
    final double _authorDataWidth = flyerBoxWidth * (Ratioz.xxflyerAuthorPicWidth+Ratioz.xxflyerAuthorNameWidth);
// -----------------------------------------------------------------------------
    /// --- FOLLOWERS COUNTER
    final int _followersCount = tinyBz.bzTotalFollowers;
    final int _bzGalleryCount = tinyBz.bzTotalFlyers;

    final String _galleryCountCalibrated = Numeric.counterCaliber(context, _bzGalleryCount);
    final String _followersCounter =
    (authorGalleryCount == 0 && _followersCount == 0) || (authorGalleryCount == null && _followersCount == null) ? '' :
    showLabel == true ?
        '${Numeric.separateKilos(number: authorGalleryCount)} ${Wordz.flyers(context)}' :
        '${Numeric.counterCaliber(context, _followersCount)} ${Wordz.followers(context)} . $_galleryCountCalibrated ${Wordz.flyers(context)}';
// -----------------------------------------------------------------------------
    final double _authorImageCorners = flyerBoxWidth * Ratioz.xxflyerAuthorPicCorner;
// -----------------------------------------------------------------------------

    return
      GestureDetector(
        onTap: showLabel == true ? ()=> onTap(tinyAuthor.userID) : null,
        child:
        Container(
            height: _authorDataHeight,
            width: labelIsOn == true? _authorDataWidth : _authorDataHeight,
            // margin: showLabel == true ? EdgeInsets.symmetric(horizontal : flyerBoxWidth * 0.01) : const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: showLabel == false ? Colorz.Nothing : Colorz.White20,
                borderRadius: Borderers.superBorderOnly(
                    context: context,
                    enTopLeft: _authorImageCorners,
                    enBottomLeft: 0,
                    enBottomRight: _authorImageCorners,
                    enTopRight: _authorImageCorners
                ),
            ),

            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                /// AUTHOR IMAGE
                AuthorPic(
                  width: flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth,
                  authorPic: tinyAuthor?.pic,
                  // tinyBz:
                ),

                /// AUTHOR LABEL : NAME, TITLE, FOLLOWERS COUNTER
                if (labelIsOn == true)
                Container(
                  width: flyerBoxWidth * Ratioz.xxflyerAuthorNameWidth,
                  padding: EdgeInsets.symmetric(horizontal: _headerTextSidePadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    <Widget>[

                      /// AUTHOR NAME
                      SuperVerse(
                        verse: tinyAuthor?.name,
                        italic: false,
                        centered: false,
                        shadow: _versesShadow,
                        designMode: _versesDesignMode,
                        size: 2,
                        scaleFactor: flyerBoxWidth / _screenWidth,
                        maxLines: 1,
                      ),

                          /// AUTHOR TITLE
                      SuperVerse(
                        verse: tinyAuthor?.title,
                        designMode: _versesDesignMode,
                        size: 1,
                        weight: VerseWeight.regular,
                        shadow: _versesShadow,
                        centered: false,
                        italic: true,
                        scaleFactor: flyerBoxWidth / _screenWidth,
                        maxLines: 1,
                      ),

                      /// FOLLOWERS COUNTER
                      SuperVerse(
                        verse: _followersCounter,
                        italic: true,
                        centered: false,
                        shadow: _versesShadow,
                        weight: VerseWeight.regular,
                        size: 0,
                        designMode: _versesDesignMode,
                        scaleFactor: flyerBoxWidth / _screenWidth,
                        maxLines: 1,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
      );
  }
}

class AuthorPic extends StatelessWidget {
  final bool isAddAuthorButton;

  final double width;
  final dynamic authorPic;
  final TinyBz tinyBz;

  AuthorPic({
    this.isAddAuthorButton = false,

    this.width,
    this.authorPic,
    this.tinyBz,
  });
// -----------------------------------------------------------------------------
  void _tapAddAuthor(BuildContext context){

    print('should go to add new author screen');

    // Nav.goToNewScreen(context, AddAuthorScreen(tinyBz: tinyBz));
  }
// -----------------------------------------------------------------------------
  static double getCornerValue(double flyerBoxWidth){
    return
      flyerBoxWidth * Ratioz.xxflyerAuthorPicCorner;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    double _authorImageHeight = width;
    double _authorImageCorners = getCornerValue(width / Ratioz.xxflyerAuthorPicWidth);
// -----------------------------------------------------------------------------
    BorderRadius _authorPicBorders = Borderers.superBorderOnly(
        context: context,
        enTopLeft: _authorImageCorners,
        enBottomLeft: 0,
        enBottomRight: _authorImageCorners,
        enTopRight: _authorImageCorners
    );
// -----------------------------------------------------------------------------
    return
      Center(
        child: Container(
          height: _authorImageHeight,
          width: width,
          decoration: BoxDecoration(
              color: Colorz.White10,
              borderRadius: _authorPicBorders,
              image:
              authorPic == null ? null
                  :
              ObjectChecker.objectIsJPGorPNG(authorPic)?
              DecorationImage(
                  image: AssetImage(authorPic),
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
                  width: width,
                  height: _authorImageHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      DreamBox(
                        width: width * 0.35,
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
              Imagers.superImageWidget(authorPic)
          ),

        ),
      );
  }
}
