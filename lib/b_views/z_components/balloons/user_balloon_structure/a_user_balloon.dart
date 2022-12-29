import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/balloons/balloons.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/b_balloona.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class UserBalloon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserBalloon({
    @required this.userModel,
    @required this.size,
    @required this.loading,
    this.blackAndWhite = false,
    this.onTap,
    this.balloonColor,
    this.child,
    this.shadowIsOn = true,
    this.showEditButton = false,
    this.balloonTypeOverride,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final double size;
  final bool blackAndWhite;
  final Function onTap;
  final bool loading;
  final Color balloonColor;
  final Widget child;
  final bool shadowIsOn;
  final bool showEditButton;
  final BalloonType balloonTypeOverride;
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
              balloonType: balloonTypeOverride ?? Balloon.concludeBalloonByNeedType(userModel?.need?.needType),
              pic: userModel?.picPath,
              shadowIsOn: shadowIsOn,
              loading: loading,
              balloonColor: balloonColor,
              blackAndWhite: blackAndWhite,
              child: child
          ),

          /// IS AUTHOR ICON
          if (UserModel.checkUserIsAuthor(userModel) == true)
            Align(
              alignment: Aligners.superInverseBottomAlignment(context),
              child: DreamBox(
                height: size * 0.4,
                width: size * 0.4,
                icon: Iconz.bz,
                iconSizeFactor: 0.8,
                bubble: false,
                color: Colorz.black125,
                corners: size * 0.2,
              ),
            ),

          /// EDIT BUTTON
          if (showEditButton == true)
            Align(
              alignment: Aligners.superInverseTopAlignment(context),
              child: DreamBox(
                height: size * 0.4,
                width: size * 0.5,
                verse: const Verse(
                  text: 'phid_edit',
                  translate: true,
                ),
                verseScaleFactor: 0.5,
                color: Colorz.red255,
                onTap: onTap,
              ),
            ),

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
