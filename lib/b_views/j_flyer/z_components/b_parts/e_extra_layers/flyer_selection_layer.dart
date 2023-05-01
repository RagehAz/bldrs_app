import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class FlyerSelectionLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerSelectionLayer({
    @required this.flyerBoxWidth,
    @required this.isSelected,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool isSelected;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (isSelected == false){
      return const SizedBox();
    }
    else {
      // --------------------
      final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        forceMaxHeight: false,
      );
      final BorderRadius _corners = FlyerDim.flyerCorners(context, flyerBoxWidth);
      final double _checkIconSize = FlyerDim.flyerBottomCornerValue(flyerBoxWidth) * 2;
      // --------------------
      return Stack(
        key: const ValueKey<String>('FlyerSelectionLayer'),
        children: <Widget>[

          /// BLACK COLOR OVERRIDE
          BldrsBox(
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
            child: BldrsText(
              verse: const Verse(
                id: 'phid_selected',
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
            alignment: BldrsAligners.superInverseBottomAlignment(context),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colorz.white20,
              ),
              borderRadius: _corners,
            ),
            child: BldrsBox(
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
      // --------------------
    }

  }
  /// --------------------------------------------------------------------------
}
