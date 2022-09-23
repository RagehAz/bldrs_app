import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_structure/b_header_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/d_bz_logo.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/fff_author_label.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/ffff_author_pic.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class HeaderTemplate extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderTemplate({
    @required this.flyerBoxWidth,
    this.opacity = 1,
    this.onTap,
    this.logo,
    this.authorImage,
    this.firstLine,
    this.secondLine,
    this.thirdLine,
    this.fourthLine,
    this.fifthLine,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double opacity;
  final Function onTap;
  final String logo;
  final String authorImage;
  final Verse firstLine;
  final Verse secondLine;
  final Verse thirdLine;
  final Verse fourthLine;
  final Verse fifthLine;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final bool flyerShowsAuthor = authorImage != null;
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    // --------------------
    final double _headerMainHeight = FlyerDim.headerBoxHeight(flyerBoxWidth);
    // --------------------
    /// B.DATA
    final double _businessDataHeight = flyerShowsAuthor == true ?
    _headerMainHeight * 0.4
        :
    _headerMainHeight * 0.7; /// 0.0475;
    // --------------------
    final double _businessDataWidth = flyerBoxWidth * (FlyerDim.xFlyerAuthorPicWidth + FlyerDim.xFlyerAuthorNameWidth);
    final double _headerTextSidePadding = flyerBoxWidth * 0.02;
    // --------------------
    final int _bzNameSize = flyerShowsAuthor == true ? 3 : 5;
    final int _bLocaleSize = flyerShowsAuthor == true ? 1 : 1;
    final int _maxLines = flyerShowsAuthor == true ? 1 : 2;
    // --------------------
    return Opacity(
      key: const ValueKey<String>('StaticHeader'),
      opacity: opacity,
      child: HeaderBox(
        onHeaderTap: onTap,
        headerBorders: FlyerDim.headerBoxCorners(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        ),
        flyerBoxWidth: flyerBoxWidth,
        headerColor: Colorz.black255,
        headerHeightTween: FlyerDim.headerBoxHeight(flyerBoxWidth),
        child: Row(
          children: <Widget>[

            BzLogo(
              width: FlyerDim.logoWidth(flyerBoxWidth),
              image: logo,
              tinyMode: FlyerDim.isTinyMode(context, flyerBoxWidth),
              corners: FlyerDim.logoCorners(context: context, flyerBoxWidth: flyerBoxWidth),
              zeroCornerIsOn: flyerShowsAuthor,
            ),

            SizedBox(
                width: FlyerDim.headerLabelsWidth(flyerBoxWidth),
                height: FlyerDim.headerLabelsHeight(flyerBoxWidth),
                // color: Colorz.Bl,

                child: Column(
                  mainAxisAlignment: flyerShowsAuthor == true ?
                  MainAxisAlignment.spaceBetween
                      :
                  MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// BUSINESS LABEL : BZ.NAME & BZ.LOCALE
                    SizedBox(
                      height: _businessDataHeight,
                      width: _businessDataWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          /// B.NAME
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: _headerTextSidePadding),
                              child: SuperVerse(
                                verse: firstLine,
                                centered: false,
                                size: _bzNameSize,
                                scaleFactor: (flyerBoxWidth / _screenWidth) * 0.9,
                                maxLines: _maxLines,
                              ),
                            ),
                          ),

                          /// B.LOCALE
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: _headerTextSidePadding),
                              child: SuperVerse(
                                verse: secondLine,
                                size: _bLocaleSize,
                                weight: VerseWeight.regular,
                                centered: false,
                                italic: true,
                                scaleFactor: (flyerBoxWidth / _screenWidth) * 0.9,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    /// AUTHOR LABEL : AUTHOR.IMAGE, AUTHOR.NAME, AUTHOR.TITLE, BZ.FOLLOWERS
                    if (flyerShowsAuthor == true)
                      Container(
                        height: AuthorLabel.getAuthorLabelBoxHeight(
                          flyerBoxWidth: flyerBoxWidth,
                        ),
                        width: AuthorLabel.getAuthorLabelBoxWidth(
                          flyerBoxWidth: flyerBoxWidth,
                          labelIsOn: flyerShowsAuthor,
                        ),
                        // margin: showLabel == true ? EdgeInsets.symmetric(horizontal : flyerBoxWidth * 0.01) : const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          // color: flyerShowsAuthor == false ? Colorz.nothing : Colorz.white20,
                          borderRadius: AuthorLabel.getAuthorImageBorders(
                            context: context,
                            flyerBoxWidth: flyerBoxWidth,
                          ),
                        ),

                        child: Row(
                          children: <Widget>[

                            /// AUTHOR IMAGE
                            AuthorPic(
                              width: flyerBoxWidth * FlyerDim.xFlyerAuthorPicWidth,
                              authorPic: authorImage,
                              // tinyBz:
                            ),

                            /// AUTHOR LABEL : NAME, TITLE, FOLLOWERS COUNTER
                            if (flyerShowsAuthor == true)
                              Container(
                                width: flyerBoxWidth * FlyerDim.xFlyerAuthorNameWidth,
                                padding: EdgeInsets.symmetric(horizontal: _headerTextSidePadding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    /// AUTHOR NAME
                                    SuperVerse(
                                      verse: thirdLine,
                                      centered: false,
                                      scaleFactor: flyerBoxWidth / _screenWidth,
                                    ),

                                    /// AUTHOR TITLE
                                    SuperVerse(
                                      verse: fourthLine,
                                      size: 1,
                                      weight: VerseWeight.regular,
                                      centered: false,
                                      italic: true,
                                      scaleFactor: flyerBoxWidth / _screenWidth,
                                    ),

                                    /// FOLLOWERS COUNTER
                                    SuperVerse(
                                      verse: fifthLine,
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

                  ],
                )),

          ],
        ),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
