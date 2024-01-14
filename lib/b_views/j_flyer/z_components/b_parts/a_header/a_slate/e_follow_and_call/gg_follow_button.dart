// ignore_for_file: unused_element

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FollowButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FollowButton({
    required this.flyerBoxWidth,
    required this.onFollowTap,
    this.isOn,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Function? onFollowTap;
  final ValueNotifier<bool>? isOn;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // --------------------
    final double _followBTHeight = FlyerDim.followButtonHeight(flyerBoxWidth);
    final double _width = FlyerDim.followAndCallBoxWidth(flyerBoxWidth);
    // --------------------

    if (isOn == null){
      return _TheButtonItself(
        onTap: onFollowTap,
        followBTHeight: _followBTHeight,
        flyerBoxWidth: flyerBoxWidth,
        width: _width,
        followIsOn: false,
        child: _ButtonGradient(
          width: _width,
          flyerBoxWidth: flyerBoxWidth,
          followBTHeight: _followBTHeight,
        ),
      );
    }

    else {
      return ValueListenableBuilder(
        valueListenable: isOn!,
        builder: (_, bool _followIsOn, Widget? child){

          return _TheButtonItself(
            onTap: onFollowTap,
            followBTHeight: _followBTHeight,
            flyerBoxWidth: flyerBoxWidth,
            width: _width,
            followIsOn: _followIsOn,
            child: child!,
          );

          },

        /// BUTTON GRADIENT
        child: _ButtonGradient(
          width: _width,
          flyerBoxWidth: flyerBoxWidth,
          followBTHeight: _followBTHeight,
        ),

      );
    }
    // --------------------
  }
/// --------------------------------------------------------------------------
}

class _TheButtonItself extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _TheButtonItself({
    required this.width,
    required this.followBTHeight,
    required this.flyerBoxWidth,
    required this.followIsOn,
    required this.child,
    required this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double followBTHeight;
  final double width;
  final double flyerBoxWidth;
  final bool followIsOn;
  final Widget child;
  final Function? onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _followIconSize = followBTHeight * 0.5;
    final Color _followIconColor = FlyerColors.followIconColor(
      followIsOn: followIsOn,
    );
    // --------------------
    final BorderRadius _corners = FlyerDim.superFollowOrCallCorners(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      gettingFollowCorner: true,
    );
    // --------------------
    return TapLayer(
      height: followBTHeight,
      width: width,
      corners: _corners,
      splashColor: followIsOn == true ? Colorz.red255 : Colorz.yellow255,
      onTap: onTap,
      boxColor: FlyerColors.followButtonColor(followIsOn: followIsOn),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          /// BUTTON GRADIENT
          child,

          /// FOLLOW BUTTON CONTENTS
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              /// FOLLOW ICON
              SizedBox(
                height: _followIconSize,
                width: _followIconSize,
                child: WebsafeSvg.asset(
                  Iconz.follow,
                  colorFilter: ColorFilter.mode(_followIconColor, BlendMode.srcIn),
                  width: _followIconSize,
                  height: _followIconSize,
                  // package: Iconz.bldrsTheme,
                ),
              ),

              /// FOLLOW TEXT
              BldrsText(
                width: width,
                verse: Verse(
                  id: followIsOn == true ? 'phid_following' : 'phid_follow',
                  translate: true,
                ),
                color: _followIconColor,
                size: 0,
                scaleFactor: flyerBoxWidth * 0.003,
              )

            ],
          ),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}

class _ButtonGradient extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _ButtonGradient({
    required this.width,
    required this.followBTHeight,
    required this.flyerBoxWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double followBTHeight;
  final double width;
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Container(
          height: followBTHeight,
          width: width,
          decoration: BoxDecoration(
            borderRadius: FlyerDim.superFollowOrCallCorners(
                context: context,
                flyerBoxWidth: flyerBoxWidth,
                gettingFollowCorner: true,
            ),
            gradient: FlyerColors.followButtonGradient,
          ),
        );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
