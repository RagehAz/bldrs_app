import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/flyer_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/static_flyer/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/static_flyer/d_static_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:widget_fader/widget_fader.dart';

class SmallFlyer extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SmallFlyer({
    @required this.flyerID,
    @required this.flyerBoxWidth,
    @required this.renderFlyer,
    @required this.onTap,
    this.flyerModel,
    this.onFlyerNotFound,
    this.flyerShadowIsOn = true,
    this.bluerLayerIsOn = true,
    this.slideShadowIsOn = true,
    this.canAnimateMatrix = true,
    this.canUseFilter = true,
    this.bigFlyerBuilder,
    this.onMoreTap,
    this.slideIndex = 0,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String flyerID;
  final FlyerModel flyerModel;
  final double flyerBoxWidth;
  final Function onFlyerNotFound;
  final RenderFlyer renderFlyer;
  final Function(FlyerModel flyer) onTap;
  final bool flyerShadowIsOn;
  final bool bluerLayerIsOn;
  final bool slideShadowIsOn;
  final bool canAnimateMatrix;
  final bool canUseFilter;
  final Widget Function(FlyerModel flyer) bigFlyerBuilder;
  final Function(FlyerModel flyer) onMoreTap;
  final int slideIndex;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FlyerBuilder(
      flyerID: flyerID,
      flyerModel: flyerModel,
      onFlyerNotFound: onFlyerNotFound,
      flyerBoxWidth: flyerBoxWidth,
      renderFlyer: renderFlyer,
      builder: (FlyerModel flyer) {

        ///  FLYER IS NULL
        if (flyer == null) {
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
              onTap: onTap == null ? null : () => onTap(flyer),
              stackWidgets: <Widget>[

                /// STATIC SINGLE SLIDE
                if (Mapper.checkCanLoopList(flyer.slides) == true)
                  SingleSlide(
                    flyerBoxWidth: flyerBoxWidth,
                    flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(
                      flyerBoxWidth: flyerBoxWidth,
                      forceMaxHeight: false,
                    ),
                    slideModel: flyer.slides[slideIndex],
                    tinyMode: false,
                    onSlideNextTap: null,
                    onSlideBackTap: null,
                    onDoubleTap: null,
                    blurLayerIsOn: bluerLayerIsOn,
                    canTapSlide: false,
                    slideShadowIsOn: slideShadowIsOn,
                    canAnimateMatrix: canAnimateMatrix,
                    canUseFilter: canUseFilter,
                    canPinch: false,
                  ),

                /// STATIC HEADER
                StaticHeader(
                  flyerBoxWidth: flyerBoxWidth,
                  bzModel: flyer.bzModel,
                  authorID: flyer.authorID,
                  flyerShowsAuthor: flyer.showsAuthor,
                  flightTweenValue: 0,
                  bzImageLogo: flyer.bzLogoImage,
                  authorImage: flyer.authorImage,
                  // showHeaderLabels: false,
                  // onTap: null,
                  // flightDirection: FlightDirection.non,
                ),

                /// STATIC FOOTER
                StaticFooter(
                  flyerBoxWidth: flyerBoxWidth,
                  flyerID: flyer.id,
                  flightTweenValue: 0,
                  onMoreTap: onMoreTap == null ? null : () => onMoreTap(flyer),
                ),

                /// BIG FLYER
                if (bigFlyerBuilder != null)
                  bigFlyerBuilder(flyer),

              ],
            ),
          );

        }
      },
    );

  }
// -----------------------------------------------------------------------------
}
