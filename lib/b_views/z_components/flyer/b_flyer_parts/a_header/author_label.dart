import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AuthorLabel extends StatelessWidget {
  /// --------------------------------------------------------------------------
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
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final String authorID;
  final BzModel bzModel;
  final bool showLabel;
  final int authorGalleryCount;
  final bool labelIsOn;
  final ValueChanged<String> onTap;
  /// --------------------------------------------------------------------------
  static double getAuthorLabelBoxHeight({
    @required double flyerBoxWidth
  }){
    // flyerShowsAuthor == true ?
    return flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth;
    //     :
    // (flyerBoxWidth * ((Ratioz.xxflyerHeaderHeight* 0.3)-(2*Ratioz.xxflyerHeaderMainPadding)) )
  }
  // --------------------
  static double getAuthorLabelBoxWidth({
    @required double flyerBoxWidth,
    @required bool labelIsOn,
  }){
    final double _authorLabelBoxHeight = getAuthorLabelBoxHeight(
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _authorDataWidth = flyerBoxWidth *
        (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);

    return labelIsOn == true ? _authorDataWidth : _authorLabelBoxHeight;

  }
  // --------------------
  static double getAuthorImageCorners({
    @required double flyerBoxWidth,
  }){
    return flyerBoxWidth * Ratioz.xxflyerAuthorPicCorner;
  }
  // --------------------
  static BorderRadius getAuthorImageBorders({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _authorImageCorners = getAuthorImageCorners(
      flyerBoxWidth: flyerBoxWidth,
    );

    return Borderers.superBorderOnly(
        context: context,
        enTopLeft: _authorImageCorners,
        enBottomLeft: 0,
        enBottomRight: _authorImageCorners,
        enTopRight: _authorImageCorners
    );

  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    // const bool _versesShadow = false;
// -----------------------------------------------------------------------------
    final double _headerTextSidePadding = flyerBoxWidth * Ratioz.xxflyersGridSpacing;
    // --------------------
    final double _authorLabelBoxHeight = getAuthorLabelBoxHeight(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    final double _authorLabelBoxWidth = getAuthorLabelBoxWidth(
      flyerBoxWidth: flyerBoxWidth,
      labelIsOn: labelIsOn,
    );
    // --------------------
    /// --- FOLLOWERS COUNTER
    const int _followersCount = 0;
    final int _bzGalleryCount = bzModel?.flyersIDs?.length;
    // --------------------
    final String _galleryCountCalibrated = Numeric.formatNumToCounterCaliber(context, _bzGalleryCount);
    final String _followersCounter =
    (authorGalleryCount == 0 && _followersCount == 0)
        ||
        (authorGalleryCount == null && _followersCount == null)
        ?
    ''
        :
    showLabel == true ?
    '${Numeric.formatNumToSeparatedKilos(number: authorGalleryCount)} '
        '${xPhrase( context, 'phid_flyers')}'
        :
    '${Numeric.formatNumToCounterCaliber(context, _followersCount)} '
        '${xPhrase( context, 'phid_followers')} . '
        '$_galleryCountCalibrated '
        '${xPhrase( context, 'phid_flyers')}';
    // --------------------
    /*
        // final double _authorImageCorners = getAuthorImageCorners(
        //   flyerBoxWidth: flyerBoxWidth,
        // );
     */
    // --------------------
    final AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(
      bz: bzModel,
      authorID: authorID,
    );
    // --------------------
    return GestureDetector(
      onTap: showLabel == true ? () => onTap(authorID) : null,
      child: Container(
        height: _authorLabelBoxHeight,
        width: _authorLabelBoxWidth,
        // margin: showLabel == true ? EdgeInsets.symmetric(horizontal : flyerBoxWidth * 0.01) : const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: showLabel == false ? Colorz.nothing : Colorz.white20,
          borderRadius: getAuthorImageBorders(
            context: context,
            flyerBoxWidth: flyerBoxWidth,
          ),
        ),

        child: Row(
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
                  children: <Widget>[

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
    // --------------------
  }
/// --------------------------------------------------------------------------
}

class AuthorPic extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorPic({
    this.width,
    this.authorPic,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final dynamic authorPic;
  /// --------------------------------------------------------------------------
  static double getCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * Ratioz.xxflyerAuthorPicCorner;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _authorImageHeight = width;
    final double _authorImageCorners =
    getCornerValue(width / Ratioz.xxflyerAuthorPicWidth);
// -----------------------------------------------------------------------------
    final BorderRadius _authorPicBorders = Borderers.superBorderOnly(
        context: context,
        enTopLeft: _authorImageCorners,
        enBottomLeft: 0,
        enBottomRight: _authorImageCorners,
        enTopRight: _authorImageCorners);
// -----------------------------------------------------------------------------
    return Center(
      child: Container(
        height: _authorImageHeight,
        width: width,
        decoration: BoxDecoration(
            color: Colorz.white10,
            borderRadius: _authorPicBorders,
            image: authorPic == null ?
            null
                :
            ObjectCheck.objectIsJPGorPNG(authorPic) ?
            DecorationImage(image: AssetImage(authorPic), fit: BoxFit.cover)
                :
            null
        ),
        child: ClipRRect(
          borderRadius: _authorPicBorders,
          child: SuperImage(
              width: width,
              height: width,
              pic: authorPic
          ),

        ),

      ),
    );
  }
  // -----------------------------------------------------------------------------
}
