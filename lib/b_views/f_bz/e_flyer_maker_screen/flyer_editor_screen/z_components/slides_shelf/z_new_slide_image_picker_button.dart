import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/components/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class NewSlideImagePickerButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NewSlideImagePickerButton({
    required this.onTap,
    required this.icon,
    required this.line,
    required this.isTopBox,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function onTap;
  final String icon;
  final Verse line;
  final bool isTopBox;
  /// --------------------------------------------------------------------------
  /*
  BorderRadius getBorders({
    required BuildContext context,
    required bool isTopBox,
  }){

    const double _spacing = 30;
    final double _topFlyerCorners = FlyerDim.flyerTopCornerValue(DraftShelfSlide.flyerBoxWidth);
    final double _bottomFlyerCorners = FlyerDim.flyerBottomCornerValue(DraftShelfSlide.flyerBoxWidth);
    final double _topCorners = _topFlyerCorners - _spacing;

    final BorderRadius _upperBoxCorners = Borderers.cornerOnly(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enTopLeft: _topCorners,
      enTopRight: _topCorners,
      enBottomRight: _topCorners,
      enBottomLeft: _topCorners,
    );

    final BorderRadius _bottomBoxCorners = Borderers.cornerOnly(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enTopLeft: _topCorners,
      enTopRight: _topCorners,
      enBottomRight: _bottomFlyerCorners - _spacing,
      enBottomLeft: _bottomFlyerCorners - _spacing,
    );

    return isTopBox == true ? _upperBoxCorners : _bottomBoxCorners;
  }
  */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _flyerBoxWidth = DraftShelfSlide.flyerBoxWidth;
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: _flyerBoxWidth,
    );
    const double _spacing = 15;
    const double _buttonWidth = _flyerBoxWidth - (_spacing * 2);
    final double _buttonHeight = (_flyerBoxHeight - (_spacing * 3)) * 0.5;
    // --------------------
    return TapLayer(
      width: _buttonWidth,
      height: _buttonHeight,
      onTap: onTap,
      corners: Borderers.constantCornersAll15,
      boxColor: Colorz.white10,
      splashColor: Colorz.yellow125,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// PLUS ICON
          BldrsBox(
            height: _buttonHeight * 0.5,
            width: _buttonHeight * 0.5,
            icon: icon,
            iconColor: Colorz.white50,
            bubble: false,
            iconSizeFactor: 0.7,
          ),

          SizedBox(
            height: _buttonHeight * 0.05,
          ),

          SizedBox(
            width: _buttonWidth,
            child: BldrsText(
              verse: line,
              color: Colorz.white50,
              maxLines: 2,
              scaleFactor: .85,
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
