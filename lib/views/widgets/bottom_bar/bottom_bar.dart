import 'package:bldrs/ambassadors/database/dumz.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/colorizers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/drafters/texters.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/screens/s12_saved_flyers_screen.dart';
import 'package:bldrs/views/screens/s14_more_screen.dart';
import 'package:bldrs/views/screens/s15_profile_screen.dart';
import 'package:bldrs/views/screens/s17_bz_screen.dart';
import 'package:bldrs/views/screens/s17_edit_bz_screen.dart';
import 'package:bldrs/views/screens/s30_chat_screen.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bar_button.dart';

enum BarType{
  min,
  max,
  minWithText,
  maxWithText,
}

class BottomBar extends StatelessWidget {
  final BarType barType;

  BottomBar({
    this.barType = BarType.maxWithText,
});

  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserModel>(context);
    bool _userIsAuthor = userIsAuthor(_user.userStatus);
    // --- MAIN CONTROLS
    double _circleWidth = 40;
    double _paddings = Ratioz.ddAppBarPadding * 1.5;
    double _textScaleFactor = 0.95;
    int _textSize = 0;
    double _spacingFactor = 0.5;
    int _numberOfButtons = _userIsAuthor ? 5 : 4;
    // -------------------------
    int _numberOfSpacings = _numberOfButtons - 1 ;
    double _buttonCircleCorner = _circleWidth * 0.5;
    double _textBoxHeight =
    barType == BarType.maxWithText || barType == BarType.minWithText ?
    superVerseRealHeight(context, _textSize, _textScaleFactor, null)
        :
    0
    ;
    double _textBoxWidth = superScreenWidth(context) / _numberOfButtons ;

    double _boxCorner = _buttonCircleCorner + _paddings;
    BorderRadius _boxBorders =
    barType == BarType.min ?
    superBorderRadius(context, _boxCorner, _boxCorner, _boxCorner, _boxCorner)
        :
    barType == BarType.max  || barType == BarType.maxWithText?
    superBorderRadius(context, _boxCorner, 0, 0, _boxCorner)
        :
    superBorderRadius(context, _boxCorner, _boxCorner * 0.5, _boxCorner * 0.5, _boxCorner)
    ;
    // -------------------------


    double _buttonHeight = _circleWidth + ( 2 * _paddings ) + _textBoxHeight;
    double _buttonWidth = _circleWidth + (_paddings * 0.5 * 2) + (_paddings * 0.5 * 2);
    // -------------------------

    Color _designModeColor = Colorz.BloodTest;
    bool _designMode = false;

    double _spacings =
    barType == BarType.max || barType == BarType.maxWithText ?
        ((superScreenWidth(context) - (_buttonWidth * _numberOfButtons) ) / _numberOfSpacings) * _spacingFactor
        :
    _paddings * 0
    ;

    SizedBox _halfSpacer = SizedBox(
      width: _spacings * 0.5,
    );


    // -------------------------
    double _boxWidth =
    barType == BarType.maxWithText || barType == BarType.max ?
    superScreenWidth(context)
        :
    ( _buttonWidth * _numberOfButtons ) + (_spacings * _numberOfSpacings) ;
    // -------------------------
    double _boxHeight =
        barType == BarType.maxWithText || barType == BarType.minWithText ?
        _circleWidth + ( _paddings * 2) + (_textBoxHeight)
            :
        _circleWidth + ( _paddings * 2);
    // -------------------------
    SizedBox _spacer = SizedBox(
      width: _spacings,
      // height: _circleWidth * 0.1,
    );


    double _bottomOffset =
    barType == BarType.min || barType == BarType.minWithText ? _paddings :
    barType == BarType.max || barType == BarType.maxWithText ? 0 : 0;

    return StreamBuilder<UserModel>(
      stream: UserProvider(userID: _user.userID).userData,
      builder: (context, snapshot){
          UserModel userModel = snapshot.data;
          return
            Positioned(
              bottom: _bottomOffset,
              child: Row(
                children: <Widget>[

                  Container(
                    // width: _boxWidth,
                    height: _boxHeight,
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
                          blur: 10,
                          borders: _boxBorders,
                        ),

                        // --- BUTTONS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            _halfSpacer,

                            // --- SAVED FLYERS
                            BarButton(
                              width: _buttonWidth,
                              text: 'Choices',
                              icon: Iconz.SaveOn,
                              iconSizeFactor: 0.7,
                              barType: barType,
                              onTap: () => goToNewScreen(context, SavedFlyersScreen()),
                            ),

                            _spacer,

                            // --- ASK
                            BarButton(
                              width: _buttonWidth,
                              text: Wordz.ask(context),
                              icon: Iconz.SaveOn,
                              iconSizeFactor: 0.7,
                              barType: barType,
                              onTap: () => goToNewScreen(context, ChatScreen()),
                              clipperWidget : UserBalloon(
                                balloonWidth: _circleWidth,
                                balloonType: UserStatus.PlanningTalking,
                                // userPic: null,
                                balloonColor: Colorz.Nothing,
                                loading: false,
                                child: SuperVerse(
                                  verse: Wordz.ask(context),
                                  size: 1,
                                  shadow: true,
                                ),
                              ),
                            ),

                            _spacer,

                            // --- MORE
                            BarButton(
                              width: _buttonWidth,
                              text: Wordz.more(context),
                              icon: Iconz.More,
                              iconSizeFactor: 0.45,
                              barType: barType,
                              onTap: (){
                                print('fish');
                                goToNewScreen(context, MoreScreen());
                              },
                            ),

                            _spacer,


                            // --- BZ PAGE
                            _userIsAuthor ?
                            BarButton(
                              width: _buttonWidth,
                              text: 'business',
                              barType: barType,
                              onTap: ()=> goToNewScreen(context, MyBzScreen(
                                userModel: userModel,
                                switchPage: (){},
                              )),
                              clipperWidget:
                              BzLogo(
                                width: _circleWidth,
                                image: Dumz.XXeklego_logo,
                                margins: EdgeInsets.all(0),
                                zeroCornerIsOn: false,
                                corners: superBorderAll(context, _buttonCircleCorner),
                                onTap: ()=> goToNewScreen(context, MyBzScreen(
                                  userModel: userModel,
                                  switchPage: (){},
                                )),
                                blackAndWhite: false,
                              ),
                            ) : Container(),

                            _spacer,

                            // --- PROFILE
                            BarButton(
                                width: _buttonWidth,
                                text: Wordz.profile(context),
                                icon: Iconz.SaveOn,
                                iconSizeFactor: 0.7,
                                barType: barType,
                                onTap: () => goToNewScreen(context, UserProfileScreen()),
                                clipperWidget : UserBalloon(
                                  balloonWidth: _circleWidth,
                                  loading: false,
                                )
                            ),

                            _halfSpacer,

                          ],
                        ),

                      ],
                    ),
                  )

                ],
              ),
            );
      },
    );
  }
}



// // --- TEMP : DASHBOARD
// DreamBox(
//   width: _circleWidth,
//   height: _circleWidth,
//   icon: Iconz.DashBoard,
//   iconSizeFactor: 0.65,
//   corners: _buttonCircleCorner,
//   bubble: true,
//   boxFunction: () => goToNewScreen(context, DashBoard()),
// ),
//
// _spacer,
