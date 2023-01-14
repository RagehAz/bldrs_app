import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/static_flyer/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/static_flyer/d_static_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class StaticFlyer extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const StaticFlyer({
    @required this.flyerModel,
    @required this.flyerBoxWidth,
    this.slideIndex = 0,
    this.flyerShadowIsOn = true,
    this.bluerLayerIsOn = true,
    this.slideShadowIsOn = true,
    this.canAnimateMatrix = true,
    this.canUseFilter = true,
    this.canPinch = false,
    Key key
  }) : super(key: key);
  // --------------------
  final FlyerModel flyerModel;
  final double flyerBoxWidth;
  final bool flyerShadowIsOn;
  final int slideIndex;
  final bool bluerLayerIsOn;
  final bool slideShadowIsOn;
  final bool canAnimateMatrix;
  final bool canUseFilter;
  final bool canPinch;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FlyerBox(
      key: const ValueKey<String>('StaticFlyer'),
      flyerBoxWidth: flyerBoxWidth,
      shadowIsOn: flyerShadowIsOn,
      stackWidgets: <Widget>[

        /// STATIC SINGLE SLIDE
        if (Mapper.checkCanLoopList(flyerModel?.slides) == true)
        SingleSlide(
          flyerBoxWidth: flyerBoxWidth,
          flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(
            flyerBoxWidth: flyerBoxWidth,
            forceMaxHeight: false,
          ),
          slideModel: flyerModel.slides[slideIndex],
          tinyMode: false,
          onSlideNextTap: null,
          onSlideBackTap: null,
          onDoubleTap: null,
          blurLayerIsOn: bluerLayerIsOn,
          canTapSlide: false,
          slideShadowIsOn: slideShadowIsOn,
          canAnimateMatrix: canAnimateMatrix,
          canUseFilter: canUseFilter,
          canPinch: canPinch,
        ),

        /// STATIC HEADER
        StaticHeader(
          flyerBoxWidth: flyerBoxWidth,
          bzModel: flyerModel?.bzModel,
          authorID: flyerModel?.authorID,
          flyerShowsAuthor: flyerModel?.showsAuthor,
          flightTweenValue: 0,
        ),

        /// STATIC FOOTER
        StaticFooter(
          flyerBoxWidth: flyerBoxWidth,
          isSaved: true,
          flightTweenValue: 0,
          // showHeaderLabels: false,
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
