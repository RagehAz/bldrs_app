import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_follow_and_call_bts.dart';
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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool tinyMode;
  final Animation<double> logoSizeRatioTween;
  final double flyerBoxWidth;
  final Animation<double> followCallButtonsScaleTween;
  final bool followIsOn;
  final Function onCallTap;
  final Function onFollowTap;
  final double logoMinWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

      return Container(
        width: FollowAndCallBTs.getBoxWidth(flyerBoxWidth: flyerBoxWidth) * followCallButtonsScaleTween.value,
        height: logoMinWidth * logoSizeRatioTween.value,
        alignment: Alignment.topCenter,
        // color: Colorz.BloodTest,
        child: tinyMode == true ?

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

}
