import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';

// --- THE HORIZON IS JUST A BOTTOM PADDING AT THE BOTTOM OF ANY SCROLLABLE SCREEN
class PyramidsHorizon extends StatelessWidget {
  final double heightFactor;

  PyramidsHorizon({
    this.heightFactor = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Ratioz.ddPyramidsHeight * 0.4 * heightFactor,
    );
  }
}
