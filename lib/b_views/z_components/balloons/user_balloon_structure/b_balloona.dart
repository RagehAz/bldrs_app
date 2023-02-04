import 'package:bldrs/b_views/z_components/balloons/balloons.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_shadow_path.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/c_balloon_components.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class Balloona extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Balloona({
    @required this.size,
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
  final double size;
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

    final CustomClipper _clipper = Balloon.getBalloonClipPath(BalloonType.speaking); //balloonType) ;

    return ClipShadowPath(
      clipper: _clipper,
      shadow: Shadower.basicOuterShadow,
      shadowIsOn: shadowIsOn,
      child: Stack(
        children: <Widget>[

          /// ICON LAYER
          BalloonComponents(
            pic: pic,
            loading: loading,
            balloonColor: balloonColor,
            balloonWidth: size,
            blackAndWhite: blackAndWhite,
            child: child,
          ),

          /// TAP LAYER
          SizedBox(
            width: size,
            height: size,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                splashColor: Colorz.white10,
              ),
            ),
          ),

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
