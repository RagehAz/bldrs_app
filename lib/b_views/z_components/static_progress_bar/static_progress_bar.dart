import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/d_progress_box.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_strips.dart';
import 'package:animators/animators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class StaticProgressBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticProgressBar({
    @required this.numberOfSlides,
    @required this.index,
    @required this.opacity,
    @required this.flyerBoxWidth,
    @required this.swipeDirection,
    this.loading = true,
    this.margins,
    this.stripThicknessFactor = 1,
    this.stripsColors,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final int numberOfSlides;
  final int index;
  final double opacity;
  final double flyerBoxWidth;
  final bool loading;
  final SwipeDirection swipeDirection;
  final EdgeInsets margins;
  final double stripThicknessFactor;
  final List<Color> stripsColors;
  /// --------------------------------------------------------------------------
  static bool canBuildStrips(int numberOfStrips) {
    bool _canBuild = false;

    if (numberOfStrips != null) {
      if (numberOfStrips > 0) {
        _canBuild = true;
      }
    }

    return _canBuild;
  }
  // --------------------------------------------------------------------------
  static double getBoxHeight({
    @required double flyerBoxWidth,
    @required double stripThicknessFactor,
  }){
    final double _thickness = FlyerDim.progressStripThickness(flyerBoxWidth);
    return _thickness * stripThicknessFactor;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (loading == true || numberOfSlides == null){

      final double _thickness = FlyerDim.progressStripThickness(flyerBoxWidth);

      return _Box(
        flyerBoxWidth: flyerBoxWidth,
        opacity: opacity,
        child: ProgressBox(
            flyerBoxWidth: flyerBoxWidth,
            margins: margins,
            stripsStack: <Widget>[

              Container(
                width: FlyerDim.progressStripsTotalLength(flyerBoxWidth),
                height: _thickness * stripThicknessFactor,
                decoration: BoxDecoration(
                  color: FlyerColors.progressStripOffColor,
                  borderRadius: FlyerDim.progressStripCorners(
                    context: context,
                    flyerBoxWidth: flyerBoxWidth,
                  ),
                ),
                child: LinearProgressIndicator(
                  backgroundColor: Colorz.nothing,
                  minHeight: _thickness * stripThicknessFactor,
                  valueColor: const AlwaysStoppedAnimation(FlyerColors.progressStripFadedColor),
                ),
              ),

            ]
        ),
      );
    }

    else if (canBuildStrips(numberOfSlides) == true){
      return _Box(
          flyerBoxWidth: flyerBoxWidth,
          opacity: opacity,
          child: Transform.scale(
            scaleY: stripThicknessFactor,
            alignment: Alignment.bottomCenter,
            child: StaticStrips(
              flyerBoxWidth: flyerBoxWidth,
              numberOfStrips: numberOfSlides,
              slideIndex: index,
              swipeDirection: swipeDirection,
              margins: margins,
              stripsColors: stripsColors,
            ),
          ),
      );
    }

    else {
      return const SizedBox();
    }

  }
  /// --------------------------------------------------------------------------
}

class _Box extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _Box({
    @required this.opacity,
    @required this.flyerBoxWidth,
    @required this.child,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double opacity;
  final double flyerBoxWidth;
  final Widget child;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: flyerBoxWidth,
      child: Opacity(
        opacity: opacity ?? 1,
        child: child,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
