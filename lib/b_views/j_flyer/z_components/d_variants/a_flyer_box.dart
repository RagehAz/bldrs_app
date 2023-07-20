import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

/// VARS OPTIMIZED
class FlyerBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerBox({
    required this.flyerBoxWidth,
    this.stackWidgets,
    this.boxColor = Colorz.white20,
    this.onTap,
    this.shadowIsOn = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  // --- NEAT AND CLEAN
  /// width factor * screenWidth = flyerWidth
  final double flyerBoxWidth;
  /// internal parts of the flyer
  final List<Widget>? stackWidgets;
  final Color? boxColor;
  final void Function()? onTap;
  final bool shadowIsOn;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _flyerBorders = FlyerDim.flyerCorners(flyerBoxWidth);
    // --------------------
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    return Center(
      key: const ValueKey<String>('flyerBoxWidget'),
      child: TapLayer(
        onTap: onTap,
        splashColor: boxColor?.withOpacity(0.2),
        corners: _flyerBorders,
        width: flyerBoxWidth,
        height: _flyerBoxHeight,
        boxColor: boxColor,
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: FlyerDim.flyerCorners(flyerBoxWidth),
          child: Stack(
            alignment: Alignment.topCenter,
            children: stackWidgets ?? <Widget>[],
          ),
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
