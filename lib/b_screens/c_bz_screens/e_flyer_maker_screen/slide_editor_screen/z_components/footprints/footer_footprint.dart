import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:bldrs/flyer/z_components/b_parts/template_flyer/d_footer_template.dart';
import 'package:flutter/material.dart';

class FooterFootprint extends StatelessWidget {
  // --------------------------------------------------------------------------
  const FooterFootprint({
    required this.flyerBoxWidth,
    required this.showAnimationPanel,
    required this.showColorPanel,
    super.key
  });
  // --------------------
  final ValueNotifier<bool> showAnimationPanel;
  final ValueNotifier<bool> showColorPanel;
  final double flyerBoxWidth;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: showAnimationPanel,
      builder: (_, bool _showAnimationPanel, Widget? childA) {

        return ValueListenableBuilder(
          valueListenable: showColorPanel,
          builder: (_, bool _showColorPanel, Widget? childB) {

            if (_showColorPanel == true || _showAnimationPanel == true){
              return const SizedBox();
            }

            else {
              return childA!;
            }
            },
        );
        },

      child:  Disabler(
        isDisabled: true,
        child: Stack(
          children: <Widget>[

            /// BLACK
            FooterTemplate(
              flyerBoxWidth: flyerBoxWidth,
              buttonColor: Colorz.black80,
            ),

            /// WHITE
            FooterTemplate(
              flyerBoxWidth: flyerBoxWidth,
              buttonColor: Colorz.white20,
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
