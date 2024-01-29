import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class ProgressBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ProgressBox({
    required this.flyerBoxWidth,
    required this.stripsStack,
    this.margins,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final List<Widget> stripsStack;
  final EdgeInsets? margins;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: BldrsAligners.superTopAlignment(context),
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
              alignment: BldrsAligners.superCenterAlignment(context),
              children: stripsStack,
            ),

          ],
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}
