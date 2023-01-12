import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/d_static_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:mapper/mapper.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:flutter/material.dart';

class StaticFlyerStarter extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const StaticFlyerStarter({
    @required this.flyerModel,
    @required this.flyerBoxWidth,
    this.slideIndex = 0,
    this.flyerShadowIsOn = false,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final double flyerBoxWidth;
  final bool flyerShadowIsOn;
  final int slideIndex;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: BzProtocols.fetchBz(context: context, bzID: flyerModel?.bzID),
        builder: (_, AsyncSnapshot<BzModel> snap){

        final BzModel bzModel = snap.data;

        if (Streamer.connectionIsLoading(snap) == true){
          return FlyerBox(
            flyerBoxWidth: flyerBoxWidth,
          );
        }
        else {
          return FlyerBox(
            key: const ValueKey<String>('StaticFlyer'),
            flyerBoxWidth: flyerBoxWidth,
            shadowIsOn: flyerShadowIsOn,
            stackWidgets: <Widget>[

              /// STATIC SINGLE SLIDE
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
                canTapSlide: false,
                blurLayerIsOn: true,
                slideShadowIsOn: true,
                canAnimateMatrix: true,
                canUseFilter: true,
                canPinch: false,
              ),

              /// STATIC HEADER
              StaticHeader(
                flyerBoxWidth: flyerBoxWidth,
                bzModel: bzModel,
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

        }
    );

  }
  // -----------------------------------------------------------------------------
}

class StaticFlyer extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const StaticFlyer({
    @required this.flyerModel,
    @required this.bzModel,
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
  final BzModel bzModel;
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
          bzModel: bzModel,
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
