import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/user_balloon_structure/b_balloona.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;

class UserBalloon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserBalloon({
    @required this.userModel,
    @required this.size,
    @required this.loading,
    this.balloonType,
    this.blackAndWhite = false,
    this.onTap,
    this.balloonColor,
    this.child,
    this.shadowIsOn = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserStatus balloonType;
  final UserModel userModel;
  final double size;
  final bool blackAndWhite;
  final Function onTap;
  final bool loading;
  final Color balloonColor;
  final Widget child;
  final bool shadowIsOn;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          /// USER BALLOON
          Balloona(
              balloonWidth: size,
              onTap: onTap,
              userStatus: balloonType ?? UserStatus.normal,
              pic: userModel?.pic,
              shadowIsOn: shadowIsOn,
              loading: loading,
              balloonColor: balloonColor,
              blackAndWhite: blackAndWhite,
              child: child
          ),

          /// --- IS AUTHOR ICON
          if (canLoopList(userModel.myBzzIDs) == true)
          Align(
            alignment: superInverseBottomAlignment(context),
            child: DreamBox(
              height: size * 0.4,
              width: size * 0.4,
              icon: Iconz.bz,
              bubble: false,
            ),
          ),

        ],
      ),
    );

  }
}
