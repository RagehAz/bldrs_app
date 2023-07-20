import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FooterShadow extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterShadow({
    required this.flyerBoxWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _height = FlyerDim.footerBoxHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      infoButtonExpanded: false,
      hasLink: false,
    );
    // --------------------
    return Positioned(
      bottom: -0.4,
      child: IgnorePointer(
        child: WebsafeSvg.asset(
          Iconz.footerShadow,
          fit: BoxFit.fitWidth,
          width: flyerBoxWidth,
          height: _height,
        ),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
