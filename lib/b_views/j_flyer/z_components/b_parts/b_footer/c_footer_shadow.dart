import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

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
      child: SuperImage(
        width: flyerBoxWidth,
        height: _height,
        pic: Iconz.footerShadow,
        corners: FlyerDim.footerBoxCorners(context: context, flyerBoxWidth: flyerBoxWidth),
        boxFit: BoxFit.fitWidth,
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
