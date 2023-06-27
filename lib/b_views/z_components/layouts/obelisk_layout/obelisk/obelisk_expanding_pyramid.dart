import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:provider/provider.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class ObeliskExpandingPyramid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskExpandingPyramid({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    if (_isLandScape == true){
      return Positioned(
        bottom: 100.0 * 5 * -1,
        right: 500,
        child: Padding(
          padding: const EdgeInsets.only(right: 17 * 0.7),
          child: Selector<UiProvider, bool>(
            selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
            builder: (_, bool expanded, Widget? child) {

              return AnimatedScale(
                scale: expanded == true ? 9 : 1,
                duration: expanded == true ? const Duration(milliseconds: 250) : const Duration(milliseconds: 700),
                curve: expanded == true ?  Curves.easeOutQuart : Curves.easeInOutQuart,
                alignment: Alignment.bottomLeft,
                child: AnimatedOpacity(
                    duration: expanded == true ? const Duration(milliseconds: 250) : const Duration(milliseconds: 700),
                    curve: expanded == true ?  Curves.easeOut : Curves.easeIn,
                    opacity: expanded == true ? 1 : 0,
                    child: child
                ),
              );

            },

            child: Transform(
              transform: Matrix4.rotationZ(Numeric.degreeToRadian(-45.0 + 90)),
              alignment: Alignment.bottomRight,
              child: const BlurLayer(
                    width: 95.4267 * 0.7,
                    height: 99.57 * 0.7,
                    blur: 1,
                    color: Colorz.black125,
                    blurIsOn: true,
                  ),
            ),

          ),
        ),
      );
    }

    else {

      final double _maxScale = 8.0 * Scale.screenWidth(context) * 0.0022;

      return Positioned(
        bottom: Pyramids.verticalPositionFix,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.only(right: 17 * 0.7),
          child: Selector<UiProvider, bool>(
            selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
            builder: (_, bool expanded, Widget? child) {

              return AnimatedScale(
                scale: expanded == true ? _maxScale : 1,
                duration: expanded == true ? const Duration(milliseconds: 250) : const Duration(milliseconds: 700),
                curve: expanded == true ?  Curves.easeOutQuart : Curves.easeInOutQuart,
                alignment: Alignment.bottomRight,
                child: AnimatedOpacity(
                    duration: expanded == true ? const Duration(milliseconds: 250) : const Duration(milliseconds: 700),
                    curve: expanded == true ?  Curves.easeOut : Curves.easeIn,
                    opacity: expanded == true ? 1 : 0,
                    child: child
                ),
              );

            },

            child: Transform(
              transform: Matrix4.rotationZ(Numeric.degreeToRadian(-48.177)),
              alignment: Alignment.bottomRight,
              child: const BlurLayer(
                    width: 95.4267 * 0.7,
                    height: 99.57 * 0.7,
                    blur: 1,
                    color: Colorz.black125,
                    blurIsOn: true,
                  ),
            ),

          ),
        ),
      );
    }


  }
  /// --------------------------------------------------------------------------
}
