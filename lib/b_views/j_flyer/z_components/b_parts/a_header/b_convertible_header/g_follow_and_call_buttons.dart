import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/gg_call_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/gg_follow_button.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FollowAndCallButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FollowAndCallButtons({
    @required this.flyerBoxWidth,
    @required this.onFollowTap,
    @required this.followIsOn,
    @required this.onCallTap,
    @required this.logoMinWidth,
    @required this.followCallButtonsScaleTween,
    @required this.logoSizeRatioTween,
    @required this.tinyMode,
    this.showButtons = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Function onFollowTap;
  final Function onCallTap;
  final ValueNotifier<bool> followIsOn;
  final double logoMinWidth;
  final Animation<double> followCallButtonsScaleTween;
  final Animation<double> logoSizeRatioTween;
  final bool showButtons;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  static double getPaddings({double flyerBoxWidth}) {
    return flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
  }
  // --------------------
  static double getBoxHeight({
    @required double flyerBoxWidth,
    @required bool headerIsExpanded,
  }) {
    final double _headerMainHeight = FlyerBox.headerStripHeight(
      headerIsExpanded: headerIsExpanded,
      flyerBoxWidth: flyerBoxWidth,
    );
    final double _headerMainPadding = flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
    final double _followGalleryHeight = _headerMainHeight - (2 * _headerMainPadding);
    return _followGalleryHeight;
  }
  // --------------------
  static double getBoxWidth({double flyerBoxWidth}) {
    return (flyerBoxWidth * Ratioz.xxflyerFollowBtWidth) - 1;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (tinyMode == true || showButtons == false){
      return const SizedBox();
    }
    // --------------------
    else {

      return Container(
        width: getBoxWidth(flyerBoxWidth: flyerBoxWidth),
        height: logoMinWidth * logoSizeRatioTween.value,
        alignment: Alignment.topCenter,
        // color: Colorz.BloodTest,
        child: SizedBox(
          height: getBoxHeight(
            flyerBoxWidth: flyerBoxWidth,
            headerIsExpanded: false,
          ),
          width: getBoxWidth(
            flyerBoxWidth: flyerBoxWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// FOLLOW BUTTON
              FollowButton(
                flyerBoxWidth: flyerBoxWidth,
                onFollowTap: onFollowTap,
                tappingUnfollow: () {},
                followIsOn: followIsOn,
              ),

              /// FAKE SPACE PADDING BETWEEN FOLLOW & GALLERY BUTTONS
              SizedBox(
                height: getPaddings(
                  flyerBoxWidth: flyerBoxWidth,
                ),
              ),

              /// Call BUTTON
              CallButton(
                flyerBoxWidth: flyerBoxWidth,
                onCallTap: onCallTap,
              ),

            ],
          ),
        ),
      );
    }
    // --------------------
  }
// -----------------------------------------------------------------------------
}
