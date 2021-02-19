import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/screens/s12_saved_flyers_screen.dart';
import 'package:bldrs/views/screens/s13_news_screen.dart';
import 'package:bldrs/views/screens/s14_more_screen.dart';
import 'package:bldrs/views/screens/s15_user_profile_screen.dart';
import 'package:bldrs/views/screens/s30_chat_screen.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/xxx_LABORATORY/dashboard/s01_dashboard.dart';
import 'package:flutter/material.dart';

class PyramidsMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double _buttonWidth = 40;
    double _buttonCircleCorner = _buttonWidth * 0.5;

    SizedBox _spacer = SizedBox(
      width: _buttonWidth,
      height: _buttonWidth * 0.1,
    );

    return Positioned(
      right: Ratioz.ddAppBarMargin,
      bottom: Ratioz.ddPyramidsHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          // --- TEMP : DASHBOARD
          DreamBox(
            width: _buttonWidth,
            height: _buttonWidth,
            icon: Iconz.DashBoard,
            iconSizeFactor: 0.65,
            corners: _buttonCircleCorner,
            bubble: true,
            boxFunction: () => goToNewScreen(context, DashBoard()),
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

          _spacer,

          // --- CHAT BUTTON
          UserBalloon(
            balloonWidth: _buttonWidth,
            userStatus: UserStatus.PlanningUser,
            // userPic: null,
            balloonColor: Colorz.White,
            onTap: (){
              print('go to Chat Screen');
              goToNewScreen(context, ChatScreen());
            },
            loading: false,
          ),

          _spacer,

          DreamBox(
            width: _buttonWidth,
            height: _buttonWidth,
            icon: Iconz.SavedFlyers,
            iconSizeFactor: 0.7,
            bubble: true,
            color: Colorz.BlackLingerie,
            corners: _buttonCircleCorner,
            boxFunction: ()=> goToNewScreen(context, SavedFlyersScreen()),
          ),

          _spacer,

          DreamBox(
            width: _buttonWidth,
            height: _buttonWidth,
            icon: Iconz.News,
            iconSizeFactor: 0.45,
            bubble: true,
            color: Colorz.BlackLingerie,
            corners: _buttonCircleCorner,
            boxFunction: ()=> goToNewScreen(context, NewsScreen()),
          ),

          _spacer,

          DreamBox(
            width: _buttonWidth,
            height: _buttonWidth,
            icon: Iconz.More,
            iconSizeFactor: 0.45,
            bubble: true,
            color: Colorz.BlackLingerie,
            corners: _buttonCircleCorner,
            boxFunction: ()=> goToNewScreen(context, MoreScreen()),
          ),

        ],
      ),
    );
  }
}