import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/d_progress_bar/strips.dart';
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
        width: Strips.boxWidth(flyerBoxWidth),
        height: Strips.boxHeight(flyerBoxWidth),
        margin: Strips.boxMargins(flyerBoxWidth: flyerBoxWidth, margins: margins),
        padding: EdgeInsets.symmetric(horizontal: Strips.stripsOneSideMargin(flyerBoxWidth)),
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
}
