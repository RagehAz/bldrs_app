import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FollowButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FollowButton({
    @required this.flyerBoxWidth,
    @required this.onFollowTap,
    @required this.tappingUnfollow,
    @required this.followIsOn,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Function onFollowTap;
  final Function tappingUnfollow;
  final ValueNotifier<bool> followIsOn;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double screenWidth = Scale.superScreenWidth(context);
    final double followBTHeight = flyerBoxWidth * Ratioz.xxfollowBTHeight;
    final double followBTWidth = flyerBoxWidth * Ratioz.xxfollowCallWidth;
    const String followIcon = Iconz.follow;
    final double followIconHeight = followBTHeight * 0.5;
    final double followIconWidth = followIconHeight;
    // --------------------
    return GestureDetector(
      onTap: onFollowTap,
      child: ValueListenableBuilder(
        valueListenable: followIsOn,
        builder: (_, bool _followIsOn, Widget child){

          final Color followTextColor = _followIsOn == true ? Colorz.black230 : Colorz.white255;
          final Color followBTColor = _followIsOn == true ? Colorz.yellow255 : Colorz.white20;

          return Container(
            height: followBTHeight,
            width: followBTWidth,
            decoration: BoxDecoration(
              color: followBTColor,
              boxShadow: Shadower.superFollowBtShadow(followBTHeight),
              borderRadius: Borderers.superFollowOrCallCorners(
                  context: context,
                  flyerBoxWidth: flyerBoxWidth,
                  gettingFollowCorner: true,
              ),
            ),

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
                      height: followIconHeight,
                      width: followIconWidth,
                      child: WebsafeSvg.asset(followIcon,
                          color: _followIsOn == true ?
                          Colorz.black230
                              :
                          Colorz.white255
                      ),
                    ),

                    /// FOLLOW TEXT
                    if (_followIsOn == false)
                      SuperVerse(
                        verse: const Verse(
                          text: 'phid_follow',
                          translate: true,
                        ),
                        color: followTextColor,
                        size: 0,
                        scaleFactor: flyerBoxWidth / screenWidth,
                      )

                  ],
                )

              ],
            ),
          );

        },

        /// BUTTON GRADIENT
        child: Container(
          height: followBTHeight,
          width: followBTWidth,
          decoration: BoxDecoration(
            borderRadius: Borderers.superFollowOrCallCorners(
                context: context,
                flyerBoxWidth: flyerBoxWidth,
                gettingFollowCorner: true),
            gradient: Colorizer.superFollowBTGradient(),
          ),
        ),

      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
