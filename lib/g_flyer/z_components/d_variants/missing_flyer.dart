import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:flutter/material.dart';

class MissingFlyer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MissingFlyer({
    required this.flyerBoxWidth,
    required this.onTap,
    required this.flyerID,
    super.key
  });
  // --------------------
  final double flyerBoxWidth;
  final String? flyerID;
  final Function(String? flyerID)? onTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TapLayer(
      width: flyerBoxWidth,
      height: FlyerDim.flyerHeightByFlyerWidth(flyerBoxWidth: flyerBoxWidth),
      corners: FlyerDim.flyerCorners(flyerBoxWidth),
      boxColor: Colorz.white20,
      onTap: onTap == null ? null : () => onTap!.call(flyerID),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Align(
            child: BldrsText(
              verse: getVerse('phid_flyer_not_found'),
              margin: flyerBoxWidth * 0.1,
              scaleFactor: flyerBoxWidth * 0.008,
              maxLines: 4,
              color: Colorz.white125,
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
