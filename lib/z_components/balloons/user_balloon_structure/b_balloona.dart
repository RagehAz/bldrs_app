import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/shadowers.dart';
import 'package:basics/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/z_components/balloons/balloons.dart';
import 'package:bldrs/z_components/balloons/clip_shadow_path.dart';
import 'package:bldrs/z_components/balloons/user_balloon_structure/c_balloon_components.dart';
import 'package:flutter/material.dart';

class Balloona extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Balloona({
    required this.size,
    this.pic,
    this.loading,
    this.onTap,
    this.shadowIsOn = false,
    this.child,
    this.balloonColor = Colorz.white10,
    this.blackAndWhite = false,
    this.balloonType = BalloonType.circle,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double size;
  final Function ?onTap;
  final dynamic pic;
  final BalloonType? balloonType;
  final bool shadowIsOn;
  final Widget? child;
  final bool? loading;
  final Color? balloonColor;
  final bool blackAndWhite;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final CustomClipper<Path>? _clipper = Balloon.getBalloonClipPath(balloonType) ;

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
          TapLayer(
            width: size,
            height: size,
            boxColor: Colors.transparent,
            onTap: onTap,
            splashColor: Colorz.white10,
          ),

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
