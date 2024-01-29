import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/components/drawing/super_positioned.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/c_slides/a_single_slide.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/e_extra_layers/top_button/top_button.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/static_flyer/b_static_header.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/static_flyer/d_static_footer.dart';
import 'package:bldrs/g_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/g_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/loading/loading.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class SmallFlyer extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SmallFlyer({
    required this.flyerModel,
    required this.flyerBoxWidth,
    required this.onTap,
    required this.showTopButton,
    this.flyerShadowIsOn = true,
    this.slideShadowIsOn = true,
    this.canAnimateMatrix = true,
    this.optionsButtonIsOn = false,
    this.slideIndex = 0,
    this.isRendering = false,
    super.key
  });
  // -----------------------------------------------------------------------------
  final FlyerModel? flyerModel;
  final double flyerBoxWidth;
  final void Function()? onTap;
  final bool flyerShadowIsOn;
  final bool slideShadowIsOn;
  final bool canAnimateMatrix;
  final bool optionsButtonIsOn;
  final int slideIndex;
  final bool isRendering;
  final bool showTopButton;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    ///  FLYER IS NULL
    if (flyerModel == null) {
      return FlyerBox(
        key: const ValueKey<String>('DummyListSmallFlyer'),
        flyerBoxWidth: flyerBoxWidth
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
            if (Lister.checkCanLoop(flyerModel?.slides) == true)
              SingleSlide(
                flyerBoxWidth: flyerBoxWidth,
                flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(
                  flyerBoxWidth: flyerBoxWidth,
                ),
                slideModel: flyerModel!.slides![slideIndex],
                slidePicType: SlidePicType.small,
                loading: false,
                tinyMode: false,
                onSlideNextTap: null,
                onSlideBackTap: null,
                onDoubleTap: null,
                canTapSlide: false,
                slideShadowIsOn: slideShadowIsOn,
                // canAnimateMatrix: canAnimateMatrix,
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
            if (showTopButton == true)
            TopButton(
              flyerBoxWidth: flyerBoxWidth,
              flyerModel: flyerModel,
              inStack: true,
            ),

            if (isRendering == true)
            FlyerLoading(
              flyerBoxWidth: flyerBoxWidth,
              animate: true,
              direction: Axis.vertical,
            ),

            if (isRendering == true)
            RenderingIndicator(
              flyerBoxWidth: flyerBoxWidth,
            ),

          ],
        ),
      );
    }
  }
// -----------------------------------------------------------------------------
}


class RenderingIndicator extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const RenderingIndicator({
    required this.flyerBoxWidth,
    super.key
  });
  // -----------------------------------------------------------------------------
  final double flyerBoxWidth;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _margin = FlyerDim.infoButtonCollapsedMarginValue(
        flyerBoxWidth: flyerBoxWidth,
      );

    final double _height = FlyerDim.infoButtonHeight(
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: false,
      isExpanded: false,
    );

    return SuperPositioned(
      enAlignment: Alignment.bottomLeft,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      horizontalOffset: _margin,
      verticalOffset: _margin,
      child: Row(
        children: <Widget>[

          LoadingBlackHole(
            size: _height,
            rpm: 500,
          ),

          WidgetFader(
            fadeType: FadeType.repeatAndReverse,
            duration: const Duration(milliseconds: 500),
            child: BldrsText(
              verse: const Verse(
                id: 'phid_loading',
                translate: true,
                casing: Casing.upperCase,
              ),
              height: _height,
              size: 1,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              italic: true,
            ),
          ),

        ],
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
