import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/drawing/super_positioned.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/e_extra_layers/top_button/top_button.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class TopButtonFootprint extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TopButtonFootprint({
    required this.flyerBoxWidth,
    super.key
  });
  // -----------------------------
  final double flyerBoxWidth;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SuperPositioned(
      enAlignment: Alignment.bottomLeft,
      verticalOffset: FlyerDim.footerBoxHeight(
        flyerBoxWidth: flyerBoxWidth,
        infoButtonExpanded: false,
        showTopButton: false,
      ),
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      child: Disabler(
        isDisabled: true,
        child: Stack(
          children: <Widget>[

            /// BLACK
            TopButtonLabelStructure(
              flyerBoxWidth: flyerBoxWidth,
              width: FlyerDim.gtaButtonWidth(flyerBoxWidth: flyerBoxWidth),
              color: Colorz.black80,
              child: const SizedBox(),
            ),

            /// WHITE
            TopButtonLabelStructure(
              flyerBoxWidth: flyerBoxWidth,
              width: FlyerDim.gtaButtonWidth(flyerBoxWidth: flyerBoxWidth),
              color: Colorz.white20,
              child: const SizedBox(),
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
