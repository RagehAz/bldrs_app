import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/controllers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/images/super_image.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AuthorLabel extends StatelessWidget {
  final double flyerBoxWidth;
  final String authorID;
  final BzModel bzModel;
  final bool showLabel;
  final int authorGalleryCount;
  final bool labelIsOn;
  final ValueChanged<String> onTap;

  const AuthorLabel({
    @required this.flyerBoxWidth,
    @required this.authorID,
    @required this.bzModel,
    @required this.showLabel,
    @required this.authorGalleryCount,
    @required this.onTap,
    this.labelIsOn = false,
    Key key,
  }) : super(key: key);

// tappingAuthorLabel (){
//     setState(() {
//       labelIsOn == true ? labelIsOn = false : labelIsOn = true;
//     });
// }

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    // const bool _versesShadow = false;
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
    final int _followersCount = bzModel.totalFollowers;
    final int _bzGalleryCount = bzModel.totalFlyers;

    final String _galleryCountCalibrated = Numeric.counterCaliber(context, _bzGalleryCount);
    final String _followersCounter =
    (authorGalleryCount == 0 && _followersCount == 0) || (authorGalleryCount == null && _followersCount == null) ? '' :
    showLabel == true ?
        '${Numeric.separateKilos(number: authorGalleryCount)} ${Wordz.flyers(context)}' :
        '${Numeric.counterCaliber(context, _followersCount)} ${Wordz.followers(context)} . $_galleryCountCalibrated ${Wordz.flyers(context)}';
// -----------------------------------------------------------------------------
    final double _authorImageCorners = flyerBoxWidth * Ratioz.xxflyerAuthorPicCorner;
// -----------------------------------------------------------------------------
    final AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(bzModel, authorID);

    return
      GestureDetector(
        onTap: showLabel == true ? ()=> onTap(authorID) : null,
        child:
        Container(
            height: _authorDataHeight,
            width: labelIsOn == true? _authorDataWidth : _authorDataHeight,
            // margin: showLabel == true ? EdgeInsets.symmetric(horizontal : flyerBoxWidth * 0.01) : const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: showLabel == false ? Colorz.nothing : Colorz.white20,
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
              children: <Widget>[

                /// AUTHOR IMAGE
                AuthorPic(
                  width: flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth,
                  authorPic: _author?.pic,
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
                        verse: _author?.name,
                        centered: false,
                        scaleFactor: flyerBoxWidth / _screenWidth,
                      ),

                          /// AUTHOR TITLE
                      SuperVerse(
                        verse: _author?.title,
                        size: 1,
                        weight: VerseWeight.regular,
                        centered: false,
                        italic: true,
                        scaleFactor: flyerBoxWidth / _screenWidth,
                      ),

                      /// FOLLOWERS COUNTER
                      SuperVerse(
                        verse: _followersCounter,
                        italic: true,
                        centered: false,
                        weight: VerseWeight.regular,
                        size: 0,
                        scaleFactor: flyerBoxWidth / _screenWidth,
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

  const AuthorPic({
    this.isAddAuthorButton = false,
    this.width,
    this.authorPic,
    Key key,
  }) : super(key: key);
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
    final double _authorImageHeight = width;
    final double _authorImageCorners = getCornerValue(width / Ratioz.xxflyerAuthorPicWidth);
// -----------------------------------------------------------------------------
    final BorderRadius _authorPicBorders = Borderers.superBorderOnly(
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
              color: Colorz.white10,
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
                    children: <Widget>[
                      DreamBox(
                        width: width * 0.35,
                        height: _authorImageHeight * 0.35,
                        icon: Iconz.plus,
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
              SuperImage(authorPic)
          ),

        ),
      );
  }
}
