import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/flyer_affiliate_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/d_static_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/animators/widgets/widget_fader.dart';

class SmallFlyer extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SmallFlyer({
    required this.flyerModel,
    required this.flyerBoxWidth,
    required this.onTap,
    this.flyerShadowIsOn = true,
    this.bluerLayerIsOn = true,
    this.slideShadowIsOn = true,
    this.canAnimateMatrix = true,
    this.canUseFilter = true,
    this.optionsButtonIsOn = false,
    this.slideIndex = 0,
    super.key
  });
  // -----------------------------------------------------------------------------
  final FlyerModel? flyerModel;
  final double flyerBoxWidth;
  final Function? onTap;
  final bool flyerShadowIsOn;
  final bool bluerLayerIsOn;
  final bool slideShadowIsOn;
  final bool canAnimateMatrix;
  final bool canUseFilter;
  final bool optionsButtonIsOn;
  final int slideIndex;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    ///  FLYER IS NULL
    if (flyerModel == null) {
      return FlyerBox(
        key: const ValueKey<String>('DummyListSmallFlyer'),
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    /// FLYER IS VIEWABLE
    else {
      return WidgetFader(
        fadeType: FadeType.fadeIn,
        duration: const Duration(milliseconds: 200),
        child: FlyerBox(
          key: const ValueKey<String>('SmallFlyer'),
          flyerBoxWidth: flyerBoxWidth,
          shadowIsOn: flyerShadowIsOn,
          onTap: onTap,
          stackWidgets: <Widget>[
            /// STATIC SINGLE SLIDE
            if (Mapper.checkCanLoopList(flyerModel?.slides) == true)
              SingleSlide(
                flyerBoxWidth: flyerBoxWidth,
                flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(
                  flyerBoxWidth: flyerBoxWidth,
                ),
                slideModel: flyerModel!.slides![slideIndex],
                tinyMode: false,
                onSlideNextTap: null,
                onSlideBackTap: null,
                onDoubleTap: null,
                blurLayerIsOn: bluerLayerIsOn,
                canTapSlide: false,
                slideShadowIsOn: slideShadowIsOn,
                // canAnimateMatrix: canAnimateMatrix,
                canUseFilter: canUseFilter,
                canPinch: false,
              ),

            /// STATIC HEADER
            StaticHeader(
              flyerBoxWidth: flyerBoxWidth,
              bzModel: flyerModel?.bzModel,
              authorID: flyerModel?.authorID,
              flyerShowsAuthor: flyerModel?.showsAuthor,
              bzImageLogo: flyerModel?.bzLogoImage,
              authorImage: flyerModel?.authorImage,
              // showHeaderLabels: false,
              // onTap: null,
              // flightDirection: FlightDirection.non,
            ),

            /// STATIC FOOTER
            StaticFooter(
              flyerBoxWidth: flyerBoxWidth,
              flyerID: flyerModel?.id,
              optionsButtonIsOn: optionsButtonIsOn,
            ),

            /// AFFILIATE BUTTON
            FlyerAffiliateButton(
              flyerBoxWidth: flyerBoxWidth,
              flyerModel: flyerModel,
              inStack: true,
            ),

          ],
        ),
      );
    }
  }
// -----------------------------------------------------------------------------
}
