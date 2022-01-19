import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/f_helpers/drafters/text_directionerz.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerLoading extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerLoading({
    @required this.flyerWidthFactor,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerWidthFactor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FlyerBox(
      flyerWidthFactor: flyerWidthFactor,
      stackWidgets: <Widget>[

        RotatedBox(
          quarterTurns: appIsLeftToRight(context) ? 2 : 0,
          child: LinearProgressIndicator(
            color: Colorz.white10,
            backgroundColor: Colorz.nothing,
            minHeight: FlyerBox.heightByWidthFactor(context: context, flyerWidthFactor: flyerWidthFactor),
          ),
        ),

      ],
    );

  }
}
