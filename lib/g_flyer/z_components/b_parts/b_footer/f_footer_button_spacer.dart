import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class FooterButtonSpacer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterButtonSpacer({
    required this.flyerBoxWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: FlyerDim.footerButtonMarginValue(flyerBoxWidth),
      height: FlyerDim.footerBoxHeight(
        flyerBoxWidth: flyerBoxWidth,
        infoButtonExpanded: false,
        showTopButton: false,
      ),

    );

  }
/// --------------------------------------------------------------------------
}
