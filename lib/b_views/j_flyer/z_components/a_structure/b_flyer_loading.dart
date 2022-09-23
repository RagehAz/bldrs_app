import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerLoading extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerLoading({
    @required this.flyerBoxWidth,
    this.loadingColor = Colorz.white10,
    this.boxColor = Colorz.white20,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Color loadingColor;
  final Color boxColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// NOTE : DO NOT REMOVE THE STACK : IT CENTERS THE FLYER BOX IN FLYERS GRID
    return Stack(
      children: <Widget>[

        FlyerBox(
          flyerBoxWidth: flyerBoxWidth,
          boxColor: boxColor,
          stackWidgets: <Widget>[

            RotatedBox(
              quarterTurns: TextDir.appIsLeftToRight(context) ? 2 : 0,
              child: LinearProgressIndicator(
                color: loadingColor,
                backgroundColor: Colorz.nothing,
                minHeight: FlyerDim.flyerHeightByFlyerWidth(context, flyerBoxWidth),
              ),
            ),

          ],
        ),

      ],
    );

  }
/// --------------------------------------------------------------------------
}
