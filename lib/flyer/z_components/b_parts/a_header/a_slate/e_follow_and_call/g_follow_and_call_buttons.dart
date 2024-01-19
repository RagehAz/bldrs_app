import 'package:bldrs/flyer/z_components/b_parts/a_header/a_slate/e_follow_and_call/gg_call_button.dart';
import 'package:bldrs/flyer/z_components/b_parts/a_header/a_slate/e_follow_and_call/gg_follow_button.dart';
import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class FollowAndCallButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FollowAndCallButtons({
    required this.flyerBoxWidth,
    required this.onFollowTap,
    required this.followIsOn,
    required this.onCallTap,
    required this.logoMinWidth,
    required this.followCallButtonsScaleTween,
    required this.logoSizeRatioTween,
    required this.tinyMode,
    this.showButtons = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Function onFollowTap;
  final Function onCallTap;
  final ValueNotifier<bool> followIsOn;
  final double logoMinWidth;
  final Animation<double>? followCallButtonsScaleTween;
  final Animation<double>? logoSizeRatioTween;
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

      final double _padding = FlyerDim.headerSlatePaddingValue(flyerBoxWidth);
      final double _slateHeight = FlyerDim.headerSlateHeight(flyerBoxWidth);

      return Container(
        width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth),
        height: _slateHeight * (logoSizeRatioTween?.value ?? 1),
        alignment: Alignment.topCenter,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[

            /// FAKE SPACE PADDING BETWEEN FOLLOW & GALLERY BUTTONS
            SizedBox(
              height: _padding,
            ),

            /// FOLLOW BUTTON
            FollowButton(
              flyerBoxWidth: flyerBoxWidth,
              onFollowTap: onFollowTap,
              isOn: followIsOn,
            ),

            /// FAKE SPACE PADDING BETWEEN FOLLOW & GALLERY BUTTONS
            SizedBox(
              height: _padding,
            ),

            /// CALL BUTTON
            CallButton(
              flyerBoxWidth: flyerBoxWidth,
              onCallTap: onCallTap,
            ),

          ],
        ),
      );
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
