import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:flutter/material.dart';

class ProgressBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ProgressBox({
    @required this.flyerBoxWidth,
    @required this.stripsStack,
    this.margins,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final List<Widget> stripsStack;
  final EdgeInsets margins;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Aligners.superTopAlignment(context),
      child: Container(
        width: FlyerDim.progressBarBoxWidth(flyerBoxWidth),
        height: FlyerDim.progressBarBoxHeight(flyerBoxWidth),
        margin: FlyerDim.progressBarBoxMargins(flyerBoxWidth: flyerBoxWidth, margins: margins),
        padding: EdgeInsets.symmetric(horizontal: FlyerDim.progressBarPaddingValue(flyerBoxWidth)),
        alignment: Alignment.center,
        // color: Colorz.bloodTest,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[

            Stack(
              alignment: Aligners.superCenterAlignment(context),
              children: stripsStack,
            ),

          ],
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}
