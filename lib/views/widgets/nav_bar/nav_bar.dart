import 'package:bldrs/ambassadors/database/dumz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
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
import 'package:bldrs/views/screens/s41_my_bz_screen.dart';
import 'package:bldrs/views/screens/s42_edit_bz_screen.dart';
import 'package:bldrs/views/screens/s30_chat_screen.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bar_button.dart';

enum BarType{
  min,
  max,
  minWithText,
  maxWithText,
}

class NavBar extends StatelessWidget {
  final BarType barType;

  NavBar({
    this.barType = BarType.maxWithText,
});
// ----------------------------------------------------------------------------
  /// --- MAIN CONTROLS
  double _circleWidth = 40;
  double _paddings = Ratioz.ddAppBarPadding * 1.5;
  double _textScaleFactor = 0.95;
  int _textSize = 0;
// ----------------------------------------------------------------------------
  double _calculateButtonWidth(){
    double _buttonWidth =_circleWidth + (_paddings * 0.5 * 2) + (_paddings * 0.5 * 2);
    return _buttonWidth;
}
// ----------------------------------------------------------------------------
  int _calculateNumberOfButtons(UserStatus userStatus){
    int _numberOfButtons = userIsAuthor(userStatus) ? 5 : 4;
    return _numberOfButtons;
  }
// ----------------------------------------------------------------------------
  double _calculateSpacings(BuildContext context, double buttonWidth, int numberOfButtons, int numberOfSpacings, double spacingFactor){
    double _spacings =
    barType == BarType.max || barType == BarType.maxWithText ?
    ((superScreenWidth(context) - (buttonWidth * numberOfButtons) ) / numberOfSpacings) * spacingFactor
        :
    _paddings * 0
    ;
    return _spacings;
  }
// ----------------------------------------------------------------------------
  double _calculateBoxWidth(BuildContext context, UserStatus userStatus){
    double _buttonWidth = _calculateButtonWidth();
    int _numberOfButtons = _calculateNumberOfButtons(userStatus);
    int _numberOfSpacings = _numberOfButtons - 1;
    double _spacingFactor = 0.5;
    double _spacings = _calculateSpacings(context, _buttonWidth, _numberOfButtons, _numberOfSpacings, _spacingFactor);

    double _boxWidth =
    barType == BarType.maxWithText || barType == BarType.max ?
    superScreenWidth(context)
        :
    ( _buttonWidth * _numberOfButtons ) + (_spacings * _numberOfSpacings) ;

    return _boxWidth;
  }
// ----------------------------------------------------------------------------
  double _calculateSpacerWidth(BuildContext context, UserStatus userStatus){
    double _buttonWidth = _calculateButtonWidth();
    int _numberOfButtons = _calculateNumberOfButtons(userStatus);
    int _numberOfSpacings = _numberOfButtons - 1;
    double _spacingFactor = 0.5;
    double _spacings = _calculateSpacings(context, _buttonWidth, _numberOfButtons, _numberOfSpacings, _spacingFactor);

    double _halfSpacer = _spacings * 0.5;

    return _halfSpacer;
  }
// ----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // -------------------------------------------------------------------------
    double _buttonCircleCorner = _circleWidth * 0.5;
    // -------------------------
    double _textBoxHeight =
    barType == BarType.maxWithText || barType == BarType.minWithText ?
    superVerseRealHeight(context, _textSize, _textScaleFactor, null) : 0;
    // -------------------------
    double _boxCorner = _buttonCircleCorner + _paddings;
    // -------------------------
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
    // -------------------------
    double _boxHeight =
        barType == BarType.maxWithText || barType == BarType.minWithText ?
        _circleWidth + ( _paddings * 2) + (_textBoxHeight)
            :
        _circleWidth + ( _paddings * 2);
    // -------------------------
    double _bottomOffset =
    barType == BarType.min || barType == BarType.minWithText ? _paddings :
    barType == BarType.max || barType == BarType.maxWithText ? 0 : 0;
    // -------------------------
    final _userID = (FirebaseAuth.instance.currentUser).uid;
    // -------------------------------------------------------------------------
    FlyersProvider prof = Provider.of<FlyersProvider>(context, listen: true);

    return StreamBuilder<UserModel>(
      stream: UserProvider(userID: _userID).userData,
      builder: (context, snapshot){

          UserModel userModel = snapshot.data;

          Widget _spacer = SizedBox(width: _calculateSpacerWidth(context, userModel?.userStatus),);
          Widget _halfSpacer = SizedBox(width: _calculateSpacerWidth(context, userModel?.userStatus) * 0.5,);

          double _buttonWidth = _calculateButtonWidth();
          double _boxWidth = _calculateBoxWidth(context, userModel?.userStatus);

          List<dynamic> _followedBzzIDs = userModel != null ? userModel?.followedBzzIDs : [];
          String _bzID = _followedBzzIDs.length > 0 ?  _followedBzzIDs[0] : '';
          String _bzLogo = prof.getBzByBzID(_bzID)?.bzLogo;

          print('NAAAAAAAAAAAAAMEEEEEEEEEEEEEEEEEEE ${userModel?.name}');

          return
            Positioned(
              bottom: _bottomOffset,
              child: Row(
                children: <Widget>[

                  Container(
                    width: _boxWidth,
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
                          blur: Ratioz.blur1,
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
                            if (userIsAuthor(userModel?.userStatus))
                            BarButton (
                              width: _buttonWidth,
                              text: 'business',
                              barType: barType,
                              icon: _bzLogo,
                              iconSizeFactor: 1,
                              onTap: ()=> goToNewScreen(context, MyBzScreen(
                                userModel: userModel,
                                switchPage: (){},
                              )
                              ),
                            ),

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
