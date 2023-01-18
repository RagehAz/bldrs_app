import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
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
    final double _followBTHeight = FlyerDim.followButtonHeight(flyerBoxWidth);
    final double _width = FlyerDim.followAndCallBoxWidth(flyerBoxWidth);
    final double _followIconSize = _followBTHeight * 0.5;
    // --------------------
    return GestureDetector(
      onTap: onFollowTap,
      child: ValueListenableBuilder(
        valueListenable: followIsOn,
        builder: (_, bool _followIsOn, Widget child){

          final Color _followIconColor = FlyerColors.followIconColor(
            followIsOn: _followIsOn,
          );

          return Container(
            height: _followBTHeight,
            width: _width,
            decoration: BoxDecoration(
              color: FlyerColors.followButtonColor(followIsOn: _followIsOn),
              // boxShadow: Shadower.superFollowBtShadow(_followBTHeight),
              borderRadius: FlyerDim.superFollowOrCallCorners(
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
                      height: _followIconSize,
                      width: _followIconSize,
                      child: WebsafeSvg.asset(Iconz.follow,
                          color: _followIconColor,
                          // package: Iconz.bldrsTheme,
                      ),
                    ),

                    /// FOLLOW TEXT
                      SuperVerse(
                        verse: Verse(
                          text: _followIsOn == true ? 'phid_following' : 'phid_follow',
                          translate: true,
                        ),
                        color: _followIconColor,
                        size: 0,
                        scaleFactor: FlyerDim.flyerFactorByFlyerWidth(context, flyerBoxWidth),
                      )

                  ],
                )

              ],
            ),
          );

        },

        /// BUTTON GRADIENT
        child: Container(
          height: _followBTHeight,
          width: _width,
          decoration: BoxDecoration(
            borderRadius: FlyerDim.superFollowOrCallCorners(
                context: context,
                flyerBoxWidth: flyerBoxWidth,
                gettingFollowCorner: true,
            ),
            gradient: FlyerColors.followButtonGradient,
          ),
        ),

      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
