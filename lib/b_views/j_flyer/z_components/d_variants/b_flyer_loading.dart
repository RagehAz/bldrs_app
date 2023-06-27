import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class FlyerLoading extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerLoading({
    required this.flyerBoxWidth,
    required this.animate,
    this.loadingColor = Colorz.white10,
    this.boxColor = Colorz.white20,
    this.direction = Axis.horizontal,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Color loadingColor;
  final Color boxColor;
  final bool animate;
  final Axis direction;
  /// --------------------------------------------------------------------------
  int _getRotation(BuildContext context){

    /// LEFT => RIGHT
    if (UiProvider.checkAppIsLeftToRight() == true){

      if (direction == Axis.horizontal){
        /// THING GOES RIGHT TO LEFT
        return 2;
      }
      else {
        ///
        return 3;
      }

    }

    /// RIGHT => LEFT
    else {

      if (direction == Axis.horizontal){
        /// THING GOES LEFT TO RIGHT
        return 0;
      }
      else {
        return 3;
      }

    }

  }
  @override
  Widget build(BuildContext context) {

    if (flyerBoxWidth == null || flyerBoxWidth == 0){
      return const SizedBox();
    }

    else {

      /// NOTE : DO NOT REMOVE THE STACK : IT CENTERS THE FLYER BOX IN FLYERS GRID
      return Stack(
        children: <Widget>[

          FlyerBox(
            flyerBoxWidth: flyerBoxWidth,
            boxColor: boxColor,
            stackWidgets: <Widget>[

              if (animate == true)
                RotatedBox(
                  quarterTurns: _getRotation(context),
                  child: LinearProgressIndicator(
                    color: loadingColor,
                    backgroundColor: Colorz.nothing,
                    minHeight: FlyerDim.flyerHeightByFlyerWidth(
                      flyerBoxWidth: flyerBoxWidth,
                    ),
                  ),
                ),

            ],
          ),

        ],
      );

    }

  }
/// --------------------------------------------------------------------------
}
