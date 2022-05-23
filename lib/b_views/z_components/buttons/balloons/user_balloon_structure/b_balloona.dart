import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/clip_shadow_path.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/user_balloon_structure/c_balloon_components.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class Balloona extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Balloona({
    @required this.balloonWidth,
    @required this.pic,
    @required this.loading,
    this.onTap,
    this.shadowIsOn = false,
    this.child,
    this.balloonColor = Colorz.white10,
    this.blackAndWhite = false,
    this.userStatus = UserStatus.normal,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double balloonWidth;
  final Function onTap;
  final dynamic pic;
  final UserStatus userStatus;
  final bool shadowIsOn;
  final Widget child;
  final bool loading;
  final Color balloonColor;
  final bool blackAndWhite;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final CustomClipper _clipper = Iconizer.userBalloon(userStatus);

    return SizedBox(
      width: balloonWidth,
      height: balloonWidth,
      child: GestureDetector(
        onTap: onTap,
        child: shadowIsOn == true ?
        ClipShadowPath(
          clipper: _clipper,
          shadow: Shadowz.basicOuterShadow,
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
}