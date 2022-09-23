import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
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
    return Align(
      key: const ValueKey<String>('FooterShadow'),
      alignment: Alignment.bottomCenter,
      child: WebsafeSvg.asset(
        Iconz.footerShadow,
        fit: BoxFit.fitWidth,
        width: flyerBoxWidth,
        height: FlyerDim.footerBoxHeight(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
          infoButtonExpanded: false,
        ),
        alignment: Alignment.bottomCenter,
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
