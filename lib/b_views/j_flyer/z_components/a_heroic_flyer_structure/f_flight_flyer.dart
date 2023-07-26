import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/widgets/drawing/super_positioned.dart';
import 'package:basics/super_image/super_image.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/e_slide_headline.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/flyer_affiliate_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FlightFlyer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlightFlyer({
    required this.renderedFlyer,
    required this.flyerBoxWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel? renderedFlyer;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BorderRadius flyerBorders = FlyerDim.flyerCorners(flyerBoxWidth);
    final double flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
    );
    final SlideModel? slideModel = renderedFlyer?.slides?.first;
    final double footerHeight = FlyerDim.footerBoxHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      infoButtonExpanded: false,
      hasLink: false,
    );
    final double headlineTopMargin = flyerBoxWidth * 0.3;
    final double lengthFactor = SlideHeadline.getTextSizeFactorByLength(slideModel?.headline);
    final double aspectRatio = FlyerDim.flyerAspectRatio();
    final EdgeInsets _saveButtonPadding = FlyerDim.footerButtonEnRightMargin(
      buttonNumber: 1,
      context: context,
      flightTweenValue: 1,
      flyerBoxWidth: flyerBoxWidth,
    );

    return Material(
      borderRadius: flyerBorders,
      type: MaterialType.transparency,
      child: Center(
        key: const ValueKey<String>('LightFlightFlyer_'),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Container(
            width: flyerBoxWidth,
            height: flyerBoxHeight,
            alignment: Alignment.center,
            // decoration: BoxDecoration(
            //   borderRadius: flyerBorders,
            // ),
            child: ClipRRect(
              borderRadius: flyerBorders,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[

                  /// SLIDE
                  SizedBox(
                    width: flyerBoxWidth,
                    height: flyerBoxHeight,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[

                        AspectRatio(
                          aspectRatio: aspectRatio,
                          child: Container(
                            width: flyerBoxWidth,
                            height: flyerBoxHeight,
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              color: slideModel?.midColor,
                            ),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: <Widget>[

                                /// BACKGROUND
                                SuperImage(
                                  width: flyerBoxWidth,
                                  height: flyerBoxHeight,
                                  pic: slideModel?.backImage,
                                  loading: false,
                                ),

                                /// IMAGE
                                SuperFilteredImage(
                                  width: flyerBoxWidth,
                                  height: flyerBoxHeight,
                                  pic: slideModel?.frontImage,
                                  boxFit: slideModel?.picFit ?? BoxFit.cover,
                                  corners: flyerBorders,
                                  loading: false,
                                ),

                                /// SHADOW UNDER PAGE HEADER & OVER PAGE PICTURE
                                SizedBox(
                                  key: const ValueKey<String>('SlideShadow'),
                                  width: flyerBoxWidth,
                                  height: flyerBoxHeight,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: Borderers.superHeaderShadowCorners(context, flyerBoxWidth),
                                  // ),
                                  // alignment: Alignment.topCenter,
                                  child: WebsafeSvg.asset(
                                    Iconz.headerShadow,
                                    fit: BoxFit.cover,
                                    width: flyerBoxWidth,
                                    height: flyerBoxHeight,
                                    // package: Iconz.bldrsTheme,
                                  ),
                                ),

                                /// BOTTOM SHADOW
                                Positioned(
                                  bottom: -0.4,
                                  child: Container(
                                    width: flyerBoxWidth,
                                    height: footerHeight,
                                    // corners: FlyerDim.footerBoxCorners(context: context, flyerBoxWidth: flyerBoxWidth),
                                    // boxFit: BoxFit.fitWidth,
                                    alignment: Alignment.center,
                                    child: WebsafeSvg.asset(
                                      Iconz.footerShadow,
                                      fit: BoxFit.fitWidth,
                                      width: flyerBoxWidth,
                                      height: footerHeight,
                                      // package: Iconz.bldrsTheme,
                                    ),
                                  ),
                                ),

                                /// HEADLINE
                                Container(
                                  width: flyerBoxWidth,
                                  height: flyerBoxWidth * 0.5,
                                  // color: Colorz.bloodTest,
                                  margin: EdgeInsets.only(top: headlineTopMargin),
                                  alignment: Alignment.topCenter,
                                  padding: EdgeInsets.symmetric(horizontal: flyerBoxWidth * 0.03),
                                  child: BldrsText(
                                    width: flyerBoxWidth,
                                    verse: Verse.plain(slideModel?.headline),
                                    shadow: true,
                                    // size: headlineSize,
                                    scaleFactor: flyerBoxWidth * 0.0032 * lengthFactor,
                                    labelColor: Colorz.black50,
                                    maxLines: 5,
                                    // centered: true,
                                    margin: EdgeInsets.zero,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  /// STATIC HEADER
                  StaticHeader(
                    flyerBoxWidth: flyerBoxWidth,
                    bzModel: renderedFlyer?.bzModel,
                    bzImageLogo: renderedFlyer?.bzLogoImage,
                    authorID: renderedFlyer?.authorID,
                    flyerShowsAuthor: renderedFlyer?.showsAuthor,
                  ),

                  /// STATIC FOOTER
                  SuperPositioned(
                    key: const ValueKey<String>('flight_footer'),
                    appIsLTR: UiProvider.checkAppIsLeftToRight(),
                    enAlignment: Alignment.bottomRight,
                    horizontalOffset: _saveButtonPadding.right,
                    verticalOffset: _saveButtonPadding.bottom,
                    child: Selector<UsersProvider, UserModel?>(
                      selector: (_, UsersProvider userProvider) => userProvider.myUserModel,
                      builder: (_, UserModel? userModel, Widget? child) {
                        return FooterButton(
                          flyerBoxWidth: flyerBoxWidth,
                          icon: Iconz.save,
                          phid: 'phid_save',
                          isOn: UserModel.checkFlyerIsSaved(
                            userModel: userModel,
                            flyerID: renderedFlyer?.id,
                          ),
                          onTap: null,
                          count: null,
                          canTap: false,
                        );
                        },
                    ),
                  ),

                  /// AFFILIATE BUTTON
                  FlyerAffiliateButton(
                    flyerBoxWidth: flyerBoxWidth,
                    flyerModel: renderedFlyer,
                    inStack: true,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
