import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/user_balloon_structure/b_balloona.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

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
    this.showEditButton = false,
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
  final bool showEditButton;
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

          /// IS AUTHOR ICON
          if (UserModel.userIsAuthor(userModel) == true)
          Align(
            alignment: superInverseBottomAlignment(context),
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
            alignment: superInverseTopAlignment(context),
            child: DreamBox(
              height: size * 0.4,
              verse: superPhrase(context, 'phid_edit'),
              verseScaleFactor: 0.7,
              color: Colorz.red255,
            ),
          ),

        ],
      ),
    );

  }
}
