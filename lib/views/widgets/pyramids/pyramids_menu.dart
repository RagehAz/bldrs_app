import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/colorizers.dart';
import 'package:bldrs/view_brains/drafters/iconizers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/screens/s12_saved_flyers_screen.dart';
import 'package:bldrs/views/screens/s14_more_screen.dart';
import 'package:bldrs/views/screens/s15_user_profile_screen.dart';
import 'package:bldrs/views/screens/s30_chat_screen.dart';
import 'package:bldrs/views/screens/s40_create_bz_screen.dart';
import 'package:bldrs/views/widgets/buttons/balloons/clip_shadow_path.dart';
import 'package:bldrs/views/widgets/buttons/balloons/path_constructing_user.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class PyramidsMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double _buttonWidth = 45;
    double _buttonCircleCorner = _buttonWidth * 0.5;


    BorderRadius _boxBorders = superBorderAll(context, _buttonCircleCorner + 5);

    SizedBox _spacer = SizedBox(
      width: _buttonWidth * 0.4,
      height: _buttonWidth * 0.1,
    );

    double _paddings = Ratioz.ddAppBarPadding * 1.5;

    double _boxWidth = ( _buttonWidth * 5 ) + ( _spacer.width * 4) + ( _paddings * 2);
    double _boxHeight = _buttonWidth + ( _paddings * 2);

    return Positioned(
      // right: 0,//Ratioz.ddAppBarMargin - 5,
      bottom: 0,//Ratioz.ddPyramidsHeight,
      child: Container(
        width: _boxWidth,
        height: _boxHeight,
        // padding: EdgeInsets.all(_paddings),
        margin: EdgeInsets.all(_paddings),
        decoration: BoxDecoration(
          color: Colorz.WhiteGlass,
          borderRadius: _boxBorders,
          boxShadow: Shadowz.appBarShadow,
        ),
        child: Stack(
          children: <Widget>[

            // --- BLUR LAYER
            BlurLayer(
              width: _boxWidth,
              height: _boxHeight,
              blur: 5,
              borders: _boxBorders,
            ),

            // --- BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                // --- SAVED FLYERS
                DreamBox(
                  width: _buttonWidth,
                  height: _buttonWidth,
                  icon: Iconz.SavedFlyers,
                  iconSizeFactor: 0.7,
                  bubble: true,
                  color: Colorz.Nothing,
                  corners: _buttonCircleCorner,
                  boxFunction: ()=> goToNewScreen(context, SavedFlyersScreen()),
                ),

                _spacer,

                // --- CHAT BUTTON
                UserBalloon(
                  balloonWidth: _buttonWidth,
                  userStatus: UserStatus.PlanningUser,
                  // userPic: null,
                  balloonColor: Colorz.Nothing,
                  onTap: (){
                    print('go to Chat Screen');
                    goToNewScreen(context, ChatScreen());
                  },
                  loading: false,
                  child: SuperVerse(verse: Wordz.ask(context),),
                ),

                _spacer,

                // --- MORE
                DreamBox(
                  width: _buttonWidth,
                  height: _buttonWidth,
                  icon: Iconz.More,
                  iconSizeFactor: 0.45,
                  bubble: true,
                  color: Colorz.Nothing,
                  corners: _buttonCircleCorner,
                  boxFunction: ()=> goToNewScreen(context, MoreScreen()),
                ),

                _spacer,

                // --- ADD BZ ACCOUNT
                DreamBox(
                  width: _buttonWidth,
                  height: _buttonWidth,
                  icon: Iconz.Bz,
                  iconSizeFactor: 0.65,
                  bubble: true,
                  color: Colorz.Nothing,
                  corners: _buttonCircleCorner,
                  boxFunction: ()=> goToNewScreen(context, CreateBzScreen()),
                ),

                _spacer,

                // --- USER PROFILE
                UserBalloon(
                  balloonWidth: _buttonWidth,
                  userStatus: UserStatus.SearchingUser,
                  // userPic: null,
                  onTap: (){
                    print('go to Chat Screen');
                    goToNewScreen(context, UserProfileScreen());
                  },
                  loading: false,
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}

// // --- TEMP : DASHBOARD
// DreamBox(
//   width: _buttonWidth,
//   height: _buttonWidth,
//   icon: Iconz.DashBoard,
//   iconSizeFactor: 0.65,
//   corners: _buttonCircleCorner,
//   bubble: true,
//   boxFunction: () => goToNewScreen(context, DashBoard()),
// ),
//
// _spacer,
