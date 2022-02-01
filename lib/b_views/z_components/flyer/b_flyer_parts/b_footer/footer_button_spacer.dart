import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_button.dart';
import 'package:flutter/material.dart';

class FooterButtonSpacer extends StatelessWidget {

  const FooterButtonSpacer({
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    Key key
  }) : super(key: key);

  final double flyerBoxWidth;
  final bool tinyMode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      width: FooterButton.buttonMargin(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
          tinyMode: tinyMode
      ),

      height: FooterBox.boxHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: tinyMode,
      ),

    );
  }
}
