import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/a_left_spacer/static_slate_spacer.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/d_labels/ffff_author_pic.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/b_header_box.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:flutter/material.dart';

class HeaderTemplate extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderTemplate({
    required this.flyerBoxWidth,
    this.opacity = 1,
    this.onTap,
    this.logo,
    this.authorImage,
    this.firstLine,
    this.secondLine,
    this.thirdLine,
    this.fourthLine,
    this.fifthLine,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double opacity;
  final Function? onTap;
  final String? logo;
  final String? authorImage;
  final Verse? firstLine;
  final Verse? secondLine;
  final Verse? thirdLine;
  final Verse? fourthLine;
  final Verse? fifthLine;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final bool flyerShowsAuthor = authorImage == null;
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _headerTextSidePadding = flyerBoxWidth * 0.02;
    // --------------------
    /*
    final double _versesScaleFactor = FlyerVerses.bzLabelVersesScaleFactor(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
     */

    final bool _tinyMode = FlyerDim.isTinyMode(
      flyerBoxWidth: flyerBoxWidth,
      gridWidth: _screenWidth,
      gridHeight: Scale.screenHeight(getMainContext()),
    );

    // --------------------
    return Opacity(
      key: const ValueKey<String>('StaticHeader'),
      opacity: opacity,
      child: HeaderBox(
        flyerBoxWidth: flyerBoxWidth,
        onHeaderTap: onTap,
        headerBorders: FlyerDim.headerSlateCorners(
          flyerBoxWidth: flyerBoxWidth,
        ),
        headerColor: Colorz.black255,
        headerHeightTween: FlyerDim.headerSlateHeight(flyerBoxWidth),
        child: Row(
          children: <Widget>[

            /// LEFT SPACER
            StaticHeaderSlateSpacer(
              flyerBoxWidth: flyerBoxWidth,
            ),

            /// BZ LOGO
            BzLogo(
              width: FlyerDim.logoWidth(flyerBoxWidth),
              image: logo,
              isVerified: false,
              corners: FlyerDim.logoCornersByFlyerBoxWidth(
                context: context,
                flyerBoxWidth: flyerBoxWidth,
                zeroCornerIsOn: flyerShowsAuthor,
              ),
              zeroCornerIsOn: flyerShowsAuthor && _tinyMode == false,
            ),

            /// HEADER LABELS
            SizedBox(
                width: FlyerDim.headerLabelsWidth(flyerBoxWidth),
                height: FlyerDim.headerLabelsHeight(flyerBoxWidth),
                child: Column(
                  mainAxisAlignment: flyerShowsAuthor == true ?
                  MainAxisAlignment.spaceBetween
                      :
                  MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// BUSINESS LABEL : BZ.NAME & BZ.LOCALE
                    SizedBox(
                      height: FlyerDim.bzLabelHeight(
                          flyerBoxWidth: flyerBoxWidth,
                          flyerShowsAuthor: flyerShowsAuthor,
                      ),
                      // width: FlyerDim.headerLabelsWidth(flyerBoxWidth),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // children: const <Widget>[
                          //
                          // /// B.NAME
                          // Expanded(
                          //   child: Padding(
                          //     padding: EdgeInsets.symmetric(horizontal: _headerTextSidePadding),
                          //     child: SuperVerse(
                          //       verse: firstLine,
                          //       centered: false,
                          //       size: FlyerVerses.bzLabelNameSize(
                          //           flyerShowsAuthor: flyerShowsAuthor
                          //       ),
                          //       scaleFactor: _versesScaleFactor,
                          //       maxLines: FlyerVerses.bzLabelNameMaxLines(
                          //         flyerShowsAuthor: flyerShowsAuthor,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          //
                          // /// B.LOCALE
                          // Expanded(
                          //   child: Padding(
                          //     padding: EdgeInsets.symmetric(horizontal: _headerTextSidePadding),
                          //     child: SuperVerse(
                          //       verse: secondLine,
                          //       size: FlyerVerses.bzLabelLocaleSize(
                          //           flyerShowsAuthor: flyerShowsAuthor,
                          //       ),
                          //       weight: VerseWeight.regular,
                          //       centered: false,
                          //       italic: true,
                          //       scaleFactor: _versesScaleFactor,
                          //     ),
                          //   ),
                          // ),
                        //
                        // ],
                      ),
                    ),

                    /// AUTHOR LABEL : AUTHOR.IMAGE, AUTHOR.NAME, AUTHOR.TITLE, BZ.FOLLOWERS
                    if (flyerShowsAuthor == true)
                      Container(
                        height: FlyerDim.authorLabelBoxHeight(
                          flyerBoxWidth: flyerBoxWidth,
                        ),
                        width: FlyerDim.authorLabelBoxWidth(
                          flyerBoxWidth: flyerBoxWidth,
                          onlyShowAuthorImage: flyerShowsAuthor,
                        ),
                        // margin: showLabel == true ? EdgeInsets.symmetric(horizontal : flyerBoxWidth * 0.01) : const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          // color: flyerShowsAuthor == false ? Colorz.nothing : Colorz.white20,
                          borderRadius: FlyerDim.authorPicCornersByFlyerBoxWidth(
                            context: context,
                            flyerBoxWidth: flyerBoxWidth,
                          ),
                        ),

                        child: Row(
                          children: <Widget>[

                            /// AUTHOR IMAGE
                            AuthorPic(
                              size: FlyerDim.authorPicSizeBFlyerBoxWidth(flyerBoxWidth),
                              authorPic: authorImage,
                              // tinyBz:
                            ),

                            /// AUTHOR LABEL : NAME, TITLE, FOLLOWERS COUNTER
                            if (flyerShowsAuthor == true)
                              Container(
                                width: FlyerDim.authorLabelVersesWidth(flyerBoxWidth),
                                padding: EdgeInsets.symmetric(horizontal: _headerTextSidePadding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    /// AUTHOR NAME
                                    BldrsText(
                                      verse: thirdLine,
                                      centered: false,
                                      scaleFactor: flyerBoxWidth / _screenWidth,
                                    ),

                                    /// AUTHOR TITLE
                                    BldrsText(
                                      verse: fourthLine,
                                      size: 1,
                                      weight: VerseWeight.regular,
                                      centered: false,
                                      italic: true,
                                      scaleFactor: flyerBoxWidth / _screenWidth,
                                    ),

                                    /// FOLLOWERS COUNTER
                                    BldrsText(
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

            /// FOLLOW AND CALL BUTTONS
            Container(
              width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth),
              height: FlyerDim.logoWidth(flyerBoxWidth),
              alignment: Alignment.topCenter,
              // margin: EdgeInsets.symmetric(horizontal: _paddings),
              // color: Colorz.BloodTest,
              child: SizedBox(
                height: FlyerDim.followAndCallBoxHeight(flyerBoxWidth),
                width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// FOLLOW BUTTON
                  Container(
                  height: FlyerDim.followButtonHeight(flyerBoxWidth),
                  width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth),
                  decoration: BoxDecoration(
                    color: Colorz.white10,
                    borderRadius: FlyerDim.superFollowOrCallCorners(
                      context: context,
                      flyerBoxWidth: flyerBoxWidth,
                      gettingFollowCorner: true,
                    ),
                  ),

                ),

                    /// FAKE SPACE PADDING BETWEEN FOLLOW & GALLERY BUTTONS
                    SizedBox(
                      height: FlyerDim.headerSlatePaddingValue(flyerBoxWidth),
                    ),

                    /// CALL BUTTON
                    Container(
                      height: FlyerDim.callButtonHeight(flyerBoxWidth),
                      width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth),
                      decoration: BoxDecoration(
                        color: Colorz.white10,
                        borderRadius: FlyerDim.superFollowOrCallCorners(
                            context: context,
                            flyerBoxWidth: flyerBoxWidth,
                            gettingFollowCorner: false
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),

            /// LEFT SPACER
            StaticHeaderSlateSpacer(
              flyerBoxWidth: flyerBoxWidth,
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
