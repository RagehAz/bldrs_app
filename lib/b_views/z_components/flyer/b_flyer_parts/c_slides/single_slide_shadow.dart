import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/colorizers.dart' as Colorizer;
import 'package:flutter/material.dart';

class SingleSlideShadow extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SingleSlideShadow({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: flyerBoxWidth,
      height: flyerBoxWidth * 0.6,
      decoration: BoxDecoration(
        borderRadius: Borderers.superHeaderShadowCorners(context, flyerBoxWidth),
        gradient: Colorizer.superSlideGradient(),

        /// TASK : can optimize this by adding svg instead
      ),
    );
  }
}
