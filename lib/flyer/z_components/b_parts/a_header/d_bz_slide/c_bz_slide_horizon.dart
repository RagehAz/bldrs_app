import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class BzSlideHorizon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzSlideHorizon({
    required this.flyerBoxWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('max_header_bottom_padding'),
      width: flyerBoxWidth,
      height: FlyerDim.bzSlideHorizon(flyerBoxWidth),
      margin: FlyerDim.bzSlideTileMargins(flyerBoxWidth),
      decoration: BoxDecoration(
        color: FlyerColors.bzSlideTileColor,
        borderRadius: FlyerDim.footerBoxCorners(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}
