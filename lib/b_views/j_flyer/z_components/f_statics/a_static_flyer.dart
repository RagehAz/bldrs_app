import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/f_full_screen_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/d_static_footer.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class StaticFlyer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticFlyer({
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _tweenValue = _bakeTweenValue(context:  context);

    if (flyerModel == null){

      return FlyerLoading(
        flyerBoxWidth: flyerBoxWidth,
      );

    }

    else {

      return FlyerBox(
        key: const ValueKey<String>('StaticFlyer'),
        flyerBoxWidth: flyerBoxWidth,
        onTap: onFlyerTap,
        stackWidgets: <Widget>[

          if (flyerModel != null)
            SingleSlide(
              flyerBoxWidth: flyerBoxWidth,
              flyerBoxHeight: FlyerBox.height(context, flyerBoxWidth),
              slideModel: flyerModel.slides[0],
              tinyMode: false,
              onSlideNextTap: null,
              onSlideBackTap: null,
              onDoubleTap: null,
            ),

          StaticHeader(
            flyerBoxWidth: flyerBoxWidth,
            bzModel: bzModel,
            authorID: flyerModel?.authorID,
            flyerShowsAuthor: flyerModel?.showsAuthor,
            flightTweenValue: _tweenValue,
            flightDirection: flightDirection,
            // onTap: ,
          ),

          StaticFooter(
            flyerBoxWidth: flyerBoxWidth,
            isSaved: true,
            onMoreTap: onMoreTap,
            flightTweenValue: _tweenValue,
          ),

          if (FlyerBox.isFullScreen(context, flyerBoxWidth) == true)
            WidgetFader(
              fadeType: FadeType.fadeIn,
              duration: const Duration(milliseconds: 150),
              child: FullScreenFlyer(
                heroTag: heroTag,
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
