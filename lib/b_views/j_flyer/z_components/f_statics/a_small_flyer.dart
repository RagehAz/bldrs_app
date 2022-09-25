import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_flyer_full_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/f_big_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/d_static_footer.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class SmallFlyer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SmallFlyer({
    @required this.bzModel,
    @required this.flyerModel,
    @required this.flyerBoxWidth,
    @required this.heroTag,
    this.onFlyerTap,
    this.onMoreTap,
    this.flightTweenValue = 0,
    this.flightDirection = FlightDirection.non,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final Function onFlyerTap;
  final Function onMoreTap;
  final double flightTweenValue;
  final FlightDirection flightDirection;
  final String heroTag;
  /// --------------------------------------------------------------------------
  double _bakeTweenValue({
    @required BuildContext context,
  }){
    double _opacity = 1;

    if (flightDirection == FlightDirection.non){
      final bool _isFullScreen = flyerBoxWidth == Scale.superScreenWidth(context);
      _opacity = _isFullScreen == true ? 1 : 0;
    }
    else {
      _opacity = flightTweenValue;
    }

    return _opacity;
  }
  // --------------------
  Future<void> _openFullScreenFlyer({
    @required BuildContext context,
    @required bool flyerIsBigNow,
  }) async {

    if (flyerIsBigNow == false){

      // flyerModel.blogFlyer(methodName: '_openFullScreenFlyer');

      unawaited(recordFlyerView(
        context: context,
        index: 0,
        flyerModel: flyerModel,
      ));

      await context.pushTransparentRoute(
          FlyerScreen(
            key: const ValueKey<String>('Flyer_Full_Screen'),
            flyerModel: flyerModel,
            bzModel: bzModel,
            flyerBoxWidth: flyerBoxWidth,
            heroTag: heroTag,
          )
      );

    }

  }
  // --------------------
  FadeType _getFadeType({
    @required bool flyerIsBigNow,
  }){
    return flyerIsBigNow == true ? FadeType.fadeOut : FadeType.stillAtMax;
  }
  // --------------------
  Duration _getFadeDuration({
    @required bool flyerIsBigNow,
  }){
    return flyerIsBigNow == true ? const Duration(milliseconds: 200) : const Duration(milliseconds: 500);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (flyerModel == null){

      return FlyerLoading(
        flyerBoxWidth: flyerBoxWidth,
      );

    }

    else {

      final double _tweenValue = _bakeTweenValue(context:  context);

      final bool _flyerIsBigNow = FlyerDim.checkFlyerIsFullScreen(context, flyerBoxWidth) == true
          && flightDirection == FlightDirection.non
          && _tweenValue == 1;

      final FadeType _fadeType = _getFadeType(flyerIsBigNow: _flyerIsBigNow);
      final Duration _duration = _getFadeDuration(flyerIsBigNow: _flyerIsBigNow);

      return FlyerBox(
        key: const ValueKey<String>('StaticFlyer'),
        flyerBoxWidth: flyerBoxWidth,
        onTap: () => _openFullScreenFlyer(
          context: context,
          flyerIsBigNow: _flyerIsBigNow,
        ),
        stackWidgets: <Widget>[

          /// STATIC SINGLE SLIDE
          WidgetFader(
            fadeType: _fadeType,
            duration: _duration,
              child: SingleSlide(
                flyerBoxWidth: flyerBoxWidth,
                flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(context, flyerBoxWidth),
                slideModel: flyerModel.slides[0],
                tinyMode: false,
                onSlideNextTap: null,
                onSlideBackTap: null,
                onDoubleTap: null,
              ),
            ),

          /// STATIC HEADER
          WidgetFader(
            fadeType: _fadeType,
            duration: _duration,
            child: StaticHeader(
              flyerBoxWidth: flyerBoxWidth,
              bzModel: bzModel,
              authorID: flyerModel?.authorID,
              flyerShowsAuthor: flyerModel?.showsAuthor,
              flightTweenValue: _tweenValue,
              flightDirection: flightDirection,
              // onTap: ,
            ),
          ),

          /// STATIC FOOTER
          WidgetFader(
            fadeType: _fadeType,
            duration: _duration,
            child: StaticFooter(
              flyerBoxWidth: flyerBoxWidth,
              isSaved: true,
              onMoreTap: onMoreTap,
              flightTweenValue: _tweenValue,
            ),
          ),

          if (_flyerIsBigNow == true)
            WidgetFader(
              fadeType: FadeType.fadeIn,
              duration: const Duration(milliseconds: 100),
              child: BigFlyer(
                heroPath: heroTag,
                flyerBoxWidth: flyerBoxWidth,
                flyerModel: flyerModel,
                bzModel: bzModel,
              ),
            ),

        ],
      );

    }

  }
  /// --------------------------------------------------------------------------
}
