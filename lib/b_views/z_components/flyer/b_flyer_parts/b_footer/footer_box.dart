import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_button.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FooterBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterBox({
    @required this.flyerBoxWidth,
    @required this.footerPageController,
    @required this.pageViewChildren,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final PageController footerPageController;
  final List<Widget> pageViewChildren;
  /// --------------------------------------------------------------------------
  static double boxCornersValue(double flyerBoxWidth) {
    return flyerBoxWidth * Ratioz.xxflyerBottomCorners;
  }
// -----------------------------------------------------------------------------
  static BorderRadius corners({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _bottomCorner = boxCornersValue(flyerBoxWidth);

    return Borderers.superBorderOnly(
      context: context,
      enBottomLeft: _bottomCorner,
      enBottomRight: _bottomCorner,
      enTopLeft: 0,
      enTopRight: 0,
    );

  }
// -----------------------------------------------------------------------------
  static double boxHeight({
    BuildContext context,
    double flyerBoxWidth,
    bool tinyMode,
  }) {

    final double _footerBTMargins = FooterButton.buttonMargin(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );

    final double _footerBTRadius = FooterButton.buttonRadius(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );

    final double _flyerFooterHeight =
        (2 * _footerBTMargins) + (2 * _footerBTRadius);

    return _flyerFooterHeight;
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    final double _flyerFooterHeight = boxHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    return Align(
      alignment: Alignment.bottomCenter,

      /// --- FLYER FOOTER BOX
      child: SizedBox(
        width: flyerBoxWidth,
        height: _flyerFooterHeight,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: footerPageController,
          children: pageViewChildren,
        ),
      ),
    );
  }
}
