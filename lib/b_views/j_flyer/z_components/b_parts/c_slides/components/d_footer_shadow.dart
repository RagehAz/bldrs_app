import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:super_image/super_image.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FooterShadow extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterShadow({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
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
    );
    // --------------------
    return Positioned(
      bottom: -0.4,
      child: IgnorePointer(
        child: SuperImageBox(
          width: flyerBoxWidth,
          height: _height,
          corners: FlyerDim.footerBoxCorners(context: context, flyerBoxWidth: flyerBoxWidth),
          boxFit: BoxFit.fitWidth,
          child: WebsafeSvg.asset(
            Iconz.footerShadow,
            fit: BoxFit.fitWidth,
            // package: Iconz.bldrsTheme,
          ),
        ),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
