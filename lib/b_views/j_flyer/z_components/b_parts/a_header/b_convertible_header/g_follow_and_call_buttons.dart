import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/gg_call_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/gg_follow_button.dart';
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
        width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth: flyerBoxWidth),
        height: logoMinWidth * logoSizeRatioTween.value,
        alignment: Alignment.topCenter,
        // color: Colorz.BloodTest,
        child: SizedBox(
          height: FlyerDim.followAndCallBoxHeight(
            flyerBoxWidth: flyerBoxWidth,
            headerIsExpanded: false,
          ),
          width: FlyerDim.followAndCallBoxWidth(
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
                height: FlyerDim.followAndCallPaddingValue(
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
