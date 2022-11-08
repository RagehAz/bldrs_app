import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/e_follow_and_call/gg_call_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/e_follow_and_call/gg_follow_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
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
        width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth),
        height: logoMinWidth * logoSizeRatioTween.value,
        alignment: Alignment.topCenter,
        // color: Colorz.bloodTest,
        child: SizedBox(
          height: FlyerDim.followAndCallBoxHeight(flyerBoxWidth),
          width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
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
                height: FlyerDim.headerSlatePaddingValue(flyerBoxWidth),
              ),

              /// CALL BUTTON
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
