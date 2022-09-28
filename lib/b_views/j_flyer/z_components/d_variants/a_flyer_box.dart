import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

/// VARS OPTIMIZED
class FlyerBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerBox({
    @required this.flyerBoxWidth,
    this.stackWidgets,
    this.boxColor = Colorz.white20,
    this.onTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  // --- NEAT AND CLEAN
  /// width factor * screenWidth = flyerWidth
  final double flyerBoxWidth;
  /// internal parts of the flyer
  final List<Widget> stackWidgets;
  final Color boxColor;
  final Function onTap;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _flyerBorders = FlyerDim.flyerCorners(context, flyerBoxWidth);
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(context, flyerBoxWidth);
    // --------------------
    return Center(
      key: const ValueKey<String>('flyer_box'),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: flyerBoxWidth,
          height: _flyerBoxHeight,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: _flyerBorders,
            // boxShadow: Shadower.flyerZoneShadow,
          ),
          child: ClipRRect(
            borderRadius: _flyerBorders,
            child: Stack(
              alignment: Alignment.topCenter,
              children: stackWidgets ?? <Widget>[],
            ),
          ),
        ),
      ),
    );
    // --------------------
    /// OLD : was working before optimization
    /*
        return SizedBox( /// to prevent forced center alignment
      width: flyerBoxWidth,
      height: _flyerZoneHeight,
      child: Center( /// to prevent flyer stretching out
        child: Container(
          key: const ValueKey<String>('flyer_box'),
          width: flyerBoxWidth,
          height: _flyerZoneHeight,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: _flyerBorders,
            // boxShadow: Shadowz.flyerZoneShadow(_flyerBoxWidth),
          ),
          child: ClipRRect( /// because I will not pass borders to all children
            borderRadius: _flyerBorders,
            child: Stack(
              alignment: Alignment.topCenter,
              children: stackWidgets ?? <Widget>[],
            ),
          ),
        ),
      ),
    );
     */
  }
  // -----------------------------------------------------------------------------
}
