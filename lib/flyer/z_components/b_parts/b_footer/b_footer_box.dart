import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class FooterBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterBox({
    required this.flyerBoxWidth,
    required this.footerPageController,
    required this.footerPageViewChildren,
    required this.infoButtonExpanded,
    required this.showTopButton,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final PageController footerPageController;
  final List<Widget> footerPageViewChildren;
  final ValueNotifier<bool?> infoButtonExpanded;
  final bool showTopButton;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Align(
      key: const ValueKey<String>('FooterBox'),
      alignment: Alignment.bottomCenter,

      /// --- FLYER FOOTER BOX
      child: ValueListenableBuilder<bool?>(
        valueListenable: infoButtonExpanded,
        builder: (_,bool? infoButtonExpanded, Widget? childrenInPageView){

          return AnimatedContainer(
            width: flyerBoxWidth,
            height: FlyerDim.footerBoxHeight(
              flyerBoxWidth: flyerBoxWidth,
              infoButtonExpanded: infoButtonExpanded ?? false,
              showTopButton: showTopButton,
            ) ,
            duration: const Duration(milliseconds: 150),
            child: childrenInPageView,
          );

        },
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: footerPageController,
          children: footerPageViewChildren,
        ),
      ),

    );

  }
  /// --------------------------------------------------------------------------
}
