import 'package:bldrs/b_views/z_components/balloons/balloons.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_shadow_path.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/c_balloon_components.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';

import 'package:flutter/material.dart';

class Balloona extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Balloona({
    @required this.balloonWidth,
    this.pic,
    this.loading,
    this.onTap,
    this.shadowIsOn = false,
    this.child,
    this.balloonColor = Colorz.white10,
    this.blackAndWhite = false,
    this.balloonType = BalloonType.circle,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double balloonWidth;
  final Function onTap;
  final dynamic pic;
  final BalloonType balloonType;
  final bool shadowIsOn;
  final Widget child;
  final bool loading;
  final Color balloonColor;
  final bool blackAndWhite;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final CustomClipper _clipper = Balloon.getBalloonClipPath(balloonType) ;

    return SizedBox(
      width: balloonWidth,
      height: balloonWidth,
      child: GestureDetector(
        onTap: onTap,
        child: shadowIsOn == true ?
        ClipShadowPath(
          clipper: _clipper,
          shadow: Shadower.basicOuterShadow,
          child: BalloonComponents(
            pic: pic,
            loading: loading,
            balloonColor: balloonColor,
            balloonWidth: balloonWidth,
            blackAndWhite: blackAndWhite,
            child: child,
          ),
        )
            :
        ClipPath(
          clipper: _clipper,
          child: BalloonComponents(
            pic: pic,
            loading: loading,
            balloonColor: balloonColor,
            balloonWidth: balloonWidth,
            blackAndWhite: blackAndWhite,
            child: child,
          ),
        ),

      ),
    );

  }
/// --------------------------------------------------------------------------
}
