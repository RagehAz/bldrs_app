import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/mini_follow_and_call_bts.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/follow_and_call_sub_part.dart';
import 'package:flutter/material.dart';

class FollowAndCallPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FollowAndCallPart({
    @required this.tinyMode,
    @required this.logoSizeRatioTween,
    @required this.flyerBoxWidth,
    @required this.followCallButtonsScaleTween,
    @required this.followIsOn,
    @required this.onCallTap,
    @required this.onFollowTap,
    @required this.logoMinWidth,
    this.showButtons = true,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool tinyMode;
  final Animation<double> logoSizeRatioTween;
  final double flyerBoxWidth;
  final Animation<double> followCallButtonsScaleTween;
  final ValueNotifier<bool> followIsOn; /// p
  final Function onCallTap;
  final Function onFollowTap;
  final double logoMinWidth;
  final bool showButtons;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

      return Container(
        width: OldFollowAndCallBTs.getBoxWidth(flyerBoxWidth: flyerBoxWidth) * followCallButtonsScaleTween.value,
        height: logoMinWidth * logoSizeRatioTween.value,
        alignment: Alignment.topCenter,
        // color: Colorz.BloodTest,
        child: tinyMode == true || showButtons == false?

        Container()
            :
        FollowAndCallBTs(
          flyerBoxWidth: flyerBoxWidth * followCallButtonsScaleTween.value,
          followIsOn: followIsOn,
          onCallTap: onCallTap,
          onFollowTap: onFollowTap,
          headerIsExpanded: false, /// KEEP THIS NOW
        ),

      );

  }
/// --------------------------------------------------------------------------
}
