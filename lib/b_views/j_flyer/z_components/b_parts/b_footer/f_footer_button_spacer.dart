import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
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

      width: FooterButton.buttonMargin(
          flyerBoxWidth: flyerBoxWidth,
      ),

      height: FooterBox.collapsedHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      ),

    );

  }
/// --------------------------------------------------------------------------
}
