import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class StaticHeaderSlateSpacer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticHeaderSlateSpacer({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _spacing = FlyerDim.headerSlatePaddingValue(flyerBoxWidth);

    return SizedBox(
      key: const ValueKey<String>('StaticHeaderSlateSpacer'),
      width: _spacing,
      height: _spacing,
    );

  }
  /// --------------------------------------------------------------------------
}
