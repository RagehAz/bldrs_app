import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class SlideColoredBackgroundWidget extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SlideColoredBackgroundWidget({
    required this.color,
    this.width = 1000,
    super.key
  });
  // -----------------------------
  final Color color;
  final double width;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _height = FlyerDim.flyerHeightByFlyerWidth(flyerBoxWidth: width);
    // --------------------
    return Container(
      width: width,
      height: _height,
      color: color,
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
