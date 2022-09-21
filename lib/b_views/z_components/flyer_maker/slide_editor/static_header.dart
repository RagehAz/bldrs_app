import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/fff_author_label.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/d_bz_logo.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_structure/b_header_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/ff_header_labels.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/ffff_author_pic.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class StaticHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticHeader({
    @required this.flyerBoxWidth,
    this.opacity = 1,
    // @required this.bzModel,
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
  // final BzModel bzModel;
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
    final double _headerMainHeight = FlyerBox.headerStripHeight(
        headerIsExpanded: false,
        flyerBoxWidth: flyerBoxWidth
    );
    // --------------------
    /// B.DATA
    final double _businessDataHeight = flyerShowsAuthor == true ?
    _headerMainHeight * 0.4
        :
    _headerMainHeight * 0.7; /// 0.0475;
    // --------------------
    final double _businessDataWidth = flyerBoxWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
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
        tinyMode: false,
        onHeaderTap: onTap,
        headerBorders: FlyerBox.superHeaderCorners(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
          bzPageIsOn: false,
        ),
        flyerBoxWidth: flyerBoxWidth,
        headerColor: Colorz.black255,
        headerHeightTween: FlyerBox.headerBoxHeight(flyerBoxWidth: flyerBoxWidth),
        stackChildren: <Widget>[

          Row(
            children: <Widget>[

              BzLogo(
                width: FlyerBox.logoWidth(bzPageIsOn: false, flyerBoxWidth: flyerBoxWidth),
                image: logo,
                tinyMode: FlyerBox.isTinyMode(context, flyerBoxWidth),
                corners: FlyerBox.superLogoCorner(context: context, flyerBoxWidth: flyerBoxWidth),
                zeroCornerIsOn: flyerShowsAuthor,
              ),

              SizedBox(
                  width: HeaderLabels.getHeaderLabelWidth(flyerBoxWidth),
                  height: HeaderLabels.getHeaderLabelHeight(flyerBoxWidth),
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
                            color: flyerShowsAuthor == false ? Colorz.nothing : Colorz.white20,
                            borderRadius: AuthorLabel.getAuthorImageBorders(
                              context: context,
                              flyerBoxWidth: flyerBoxWidth,
                            ),
                          ),

                          child: Row(
                            children: <Widget>[

                              /// AUTHOR IMAGE
                              AuthorPic(
                                width: flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth,
                                authorPic: authorImage,
                                // tinyBz:
                              ),

                              /// AUTHOR LABEL : NAME, TITLE, FOLLOWERS COUNTER
                              if (flyerShowsAuthor == true)
                                Container(
                                  width: flyerBoxWidth * Ratioz.xxflyerAuthorNameWidth,
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


        ],
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}

class NewStaticHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NewStaticHeader({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.authorID,
    @required this.flyerShowsAuthor,
    this.opacity = 1,
    this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double opacity;
  final BzModel bzModel;
  final String authorID;
  final Function onTap;
  final bool flyerShowsAuthor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Opacity(
      key: const ValueKey<String>('StaticHeader'),
      opacity: opacity,
      child: HeaderBox(
        tinyMode: false,
        onHeaderTap: onTap,
        headerBorders: FlyerBox.superHeaderCorners(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
          bzPageIsOn: false,
        ),
        flyerBoxWidth: flyerBoxWidth,
        headerColor: Colorz.black255,
        headerHeightTween: FlyerBox.headerBoxHeight(flyerBoxWidth: flyerBoxWidth),
        stackChildren: <Widget>[

          Row(
            children: <Widget>[

              BzLogo(
                width: FlyerBox.logoWidth(bzPageIsOn: false, flyerBoxWidth: flyerBoxWidth),
                image: bzModel.logo,
                tinyMode: FlyerBox.isTinyMode(context, flyerBoxWidth),
                corners: FlyerBox.superLogoCorner(context: context, flyerBoxWidth: flyerBoxWidth),
                zeroCornerIsOn: flyerShowsAuthor,
              ),

              HeaderLabels(
                flyerBoxWidth: flyerBoxWidth,
                authorID: authorID,
                bzModel: bzModel,
                headerIsExpanded: false,
                flyerShowsAuthor: flyerShowsAuthor,
              ),

            ],
          ),


        ],
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
