import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FooterBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterBox({
    @required this.flyerBoxWidth,
    @required this.footerPageController,
    @required this.footerPageViewChildren,
    @required this.infoButtonExpanded,
    @required this.reviewButtonIsExpanded,
    @required this.tinyMode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final PageController footerPageController;
  final List<Widget> footerPageViewChildren;
  final ValueNotifier<bool> infoButtonExpanded;
  final ValueNotifier<bool> reviewButtonIsExpanded;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  static double boxCornersValue(double flyerBoxWidth) {
    return flyerBoxWidth * Ratioz.xxflyerBottomCorners;
  }
  // --------------------
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
  // --------------------
  static double collapsedHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
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
  // --------------------
  static double expandedInfoHeight({
    @required double flyerBoxWidth,
  }){
    return flyerBoxWidth;
  }
  // --------------------
  static double expandedReviewHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _headerHeight = FlyerBox.headerBoxHeight(flyerBoxWidth: flyerBoxWidth);
    final double _flyerBox = FlyerBox.height(context, flyerBoxWidth);

    final double _expandedReviewHeight = _flyerBox - _headerHeight;

    return _expandedReviewHeight;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    return Align(
      key: const ValueKey<String>('FooterBox'),
      alignment: Alignment.bottomCenter,

      /// --- FLYER FOOTER BOX
      child: ValueListenableBuilder(
        valueListenable: reviewButtonIsExpanded,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: footerPageController,
          children: footerPageViewChildren,
        ),
        builder: (_, bool reviewButtonIsExpanded, Widget footerChildrenWidget){

          return ValueListenableBuilder<bool>(
            valueListenable: infoButtonExpanded,
            builder: (_,bool infoButtonExpanded, Widget x){
              // -------------------------------------------------------
              final double _footerHeight =
              infoButtonExpanded == true ?
              expandedInfoHeight(
                flyerBoxWidth: flyerBoxWidth,
              )
                  :
              reviewButtonIsExpanded == true ?
              expandedReviewHeight(
                  context: context,
                  flyerBoxWidth: flyerBoxWidth
              )
                  :
              collapsedHeight(
                context: context,
                flyerBoxWidth: flyerBoxWidth,
                tinyMode: tinyMode,
              );
              // -------------------------------------------------------
              return AnimatedContainer(
                width: flyerBoxWidth,
                height: _footerHeight,
                duration: const Duration(milliseconds: 150),
                // color: Colorz.bloodTest,
                child: footerChildrenWidget,
              );

            },
          );

        },
      ),

    );

  }
  /// --------------------------------------------------------------------------
}
