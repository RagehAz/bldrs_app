import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class FooterButtonSpacer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterButtonSpacer({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(

      width: FlyerDim.footerButtonMarginValue(flyerBoxWidth),
      height: FlyerDim.footerBoxHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        infoButtonExpanded: false,
        hasLink: false,
      ),

    );

  }
/// --------------------------------------------------------------------------
}
