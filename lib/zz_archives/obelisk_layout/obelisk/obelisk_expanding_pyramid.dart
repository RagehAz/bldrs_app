import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/layers/blur_layer.dart';
import 'package:bldrs/zz_archives/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:provider/provider.dart';
import 'package:basics/helpers/space/scale.dart';

class ObeliskExpandingPyramid extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ObeliskExpandingPyramid({
    super.key
  });
  // --------------------
  static Duration getExpansionDuration({
    required bool expanded,
  }){
    return expanded == true ? const Duration(milliseconds: 250) : const Duration(milliseconds: 700);
  }
  // --------------------
  static Curve getExpansionCurve({
    required bool expanded,
  }){
    return expanded == true ?  Curves.easeOutQuart : Curves.easeInOutQuart;
  }
  // --------------------
  static Curve getOpacityCurve({
    required bool expanded,
  }){
    return expanded == true ?  Curves.easeOut : Curves.easeIn;
  }
  // --------------------
  static double getBackgroundPyramidOpacity({
    required bool expanded,
  }){
    return expanded == true ? 1 : 0;
  }
  // --------------------
  static double getExpansionScale({
    required bool expanded,
    required bool isWideScreen,
  }){

    /// WIDE SCREEN
    if (isWideScreen == true){
      return expanded == true ? 9 : 1;
    }

    /// NARROW SCREEN
    else {
      final double _maxScale = 8.0 * Scale.screenWidth(getMainContext()) * 0.0022;
      return expanded == true ? _maxScale : 1;
    }

  }
  // --------------------
  static Matrix4 getTransformation({
    required bool isWideScreen,
  }){

    if (isWideScreen == true){
      return Matrix4.rotationZ(Numeric.degreeToRadian(-45.0 + 90)!);
    }

    else {
      return Matrix4.rotationZ(Numeric.degreeToRadian(-48.177)!);
    }

  }
  // --------------------
  static EdgeInsets padding = const EdgeInsets.only(right: 17 * 0.7);
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isWideScreen = Obelisk.isWideScreenObelisk(context);

    if (_isWideScreen == true){
      return Positioned(
        bottom: 100.0 * 5 * -1,
        right: 500,
        child: Padding(
          padding: padding,
          child: Selector<UiProvider, bool>(
            selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
            builder: (_, bool expanded, Widget? child) {

              final Duration _expansionDuration = getExpansionDuration(expanded: expanded);
              final Curve _expansionCurve = getExpansionCurve(expanded: expanded);
              final Curve _opacityCurve = getOpacityCurve(expanded: expanded);
              final double _pyramidOpacity = getBackgroundPyramidOpacity(expanded: expanded);
              final double _expansionScale = getExpansionScale(
                  expanded: expanded,
                  isWideScreen: true,
              );

              return AnimatedScale(
                scale: _expansionScale,
                duration: _expansionDuration,
                curve: _expansionCurve,
                alignment: Alignment.bottomLeft,
                child: AnimatedOpacity(
                    duration: _expansionDuration,
                    curve: _opacityCurve,
                    opacity: _pyramidOpacity,
                    child: child
                ),
              );

            },

            child: Transform(
              transform: getTransformation(isWideScreen: true),
              alignment: Alignment.bottomRight,
              child: const TheExpandingPyramidItself(),
            ),

          ),
        ),
      );
    }

    else {

      return Positioned(
        bottom: Pyramids.verticalPositionFix,
        right: 0,
        child: Padding(
          padding: padding,
          child: Selector<UiProvider, bool>(
            selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
            builder: (_, bool expanded, Widget? child) {

              final Duration _expansionDuration = getExpansionDuration(expanded: expanded);
              final Curve _expansionCurve = getExpansionCurve(expanded: expanded);
              final Curve _opacityCurve = getOpacityCurve(expanded: expanded);
              final double _pyramidOpacity = getBackgroundPyramidOpacity(expanded: expanded);
              final double _expansionScale = getExpansionScale(
                expanded: expanded,
                isWideScreen: false,
              );

              return AnimatedScale(
                scale: _expansionScale,
                duration: _expansionDuration,
                curve: _expansionCurve,
                alignment: Alignment.bottomRight,
                child: AnimatedOpacity(
                    duration: _expansionDuration,
                    curve: _opacityCurve,
                    opacity: _pyramidOpacity,
                    child: child
                ),
              );
              },

            child: Transform(
              transform: getTransformation(isWideScreen: _isWideScreen),
              alignment: Alignment.bottomRight,
              child: const TheExpandingPyramidItself(),
            ),

          ),
        ),
      );
    }
    
  }
  /// --------------------------------------------------------------------------
}

class TheExpandingPyramidItself extends StatelessWidget {

  const TheExpandingPyramidItself({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[

        /// WHITE LAYER
        Container(
          width: 95.4267 * 0.7,
          height: 99.57 * 0.7,
          color: Colorz.white20,
        ),

        /// BLACK LAYER
        const BlurLayer(
          width: 95.4267 * 0.7,
          height: 99.57 * 0.7,
          blur: 1,
          color: Colorz.black125,
          blurIsOn: true,
        ),

      ],
    );

  }

}
