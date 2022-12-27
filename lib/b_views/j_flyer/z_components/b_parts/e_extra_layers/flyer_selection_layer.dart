import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class FlyerSelectionLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerSelectionLayer({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(context, flyerBoxWidth);
    final BorderRadius _corners = FlyerDim.flyerCorners(context, flyerBoxWidth);
    final double _checkIconSize = FlyerDim.flyerBottomCornerValue(flyerBoxWidth) * 2;
    // --------------------
    return Stack(
      key: const ValueKey<String>('FlyerSelectionLayer'),
      children: <Widget>[

        /// BLACK COLOR OVERRIDE
          DreamBox(
            width: flyerBoxWidth,
            height: _flyerBoxHeight,
            color: Colorz.black150,
            corners: _corners,
          ),

        /// SELECTED TEXT
          Container(
            width: flyerBoxWidth,
            height: _flyerBoxHeight,
            alignment: Alignment.center,
            child: SuperVerse(
              verse: const Verse(
                text: 'phid_selected',
                casing: Casing.upperCase,
                translate: true,
              ),
              weight: VerseWeight.black,
              italic: true,
              scaleFactor: flyerBoxWidth / 100,
              shadow: true,
            ),
          ),

        /// CHECK ICON
          Container(
            width: flyerBoxWidth,
            height: _flyerBoxHeight,
            alignment: Aligners.superInverseBottomAlignment(context),
            decoration: BoxDecoration(
              border: Border.all(color: Colorz.white20,),
              borderRadius: _corners,
            ),
            child: DreamBox(
              height: _checkIconSize,
              width: _checkIconSize,
              corners: _checkIconSize / 2,
              color: Colorz.green255,
              icon: Iconz.check,
              iconSizeFactor: 0.4,
              iconColor: Colorz.white255,
            ),
          ),


      ],
    );

  }
  /// --------------------------------------------------------------------------
}
