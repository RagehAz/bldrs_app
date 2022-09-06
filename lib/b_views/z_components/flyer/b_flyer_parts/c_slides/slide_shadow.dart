import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SlideShadow extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideShadow({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _height = FlyerBox.height(context, flyerBoxWidth);

    return SizedBox(
      key: const ValueKey<String>('SlideShadow'),
      width: flyerBoxWidth,
      height: _height,
      // decoration: BoxDecoration(
      //   borderRadius: Borderers.superHeaderShadowCorners(context, flyerBoxWidth),
      // ),
      // alignment: Alignment.topCenter,
      child: WebsafeSvg.asset(
        Iconz.headerShadow,
        fit: BoxFit.cover,
        width: flyerBoxWidth,
        height: _height,
      ),
    );

  }
/// --------------------------------------------------------------------------
}
