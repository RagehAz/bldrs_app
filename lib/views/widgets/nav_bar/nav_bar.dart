import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/users/user_streamer.dart';
import 'package:bldrs/views/screens/d_0_more_screen.dart';
import 'package:bldrs/views/screens/g_0_profile_screen.dart';
import 'package:bldrs/views/screens/f_0_my_bz_screen.dart';
import 'package:bldrs/views/screens/g_1_notifications_screen.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show Sky;
import 'package:bldrs/views/widgets/nav_bar/bar_button.dart';
import 'package:bldrs/views/widgets/nav_bar/bzz_button.dart';
import 'package:flutter/material.dart';

enum BarType{
  min,
  max,
  minWithText,
  maxWithText,
}

class NavBar extends StatelessWidget {
  final BarType barType;
  final Sky sky;
  final List<TinyBz> myTinyBzz;

  NavBar({
    this.barType,
    this.sky = Sky.Night,
    this.myTinyBzz,
});
// -----------------------------------------------------------------------------
  /// --- MAIN CONTROLS
  static const double _circleWidth = Ratioz.appBarButtonSize;
  static const double _paddings = Scale.navbarPaddings;
// -----------------------------------------------------------------------------
  static const double _buttonWidth = Scale.navBarButtonWidth;
// -----------------------------------------------------------------------------
  double _myBzzListSlideHeight(BuildContext context){
    double _wantedHeight = (Scale.superScreenWidth(context) * 0.3 * myTinyBzz.length);
    double _maxHeight = Scale.superScreenHeight(context) * 0.5;
    double _finalHeight;
    if(_wantedHeight >= _maxHeight){
      _finalHeight = _maxHeight;
    } else {
      _finalHeight = _wantedHeight;
    }
    return _finalHeight;
  }
// -----------------------------------------------------------------------------
  void _multiBzzSlider(BuildContext context, UserModel userModel){

    double _sliderHeight = _myBzzListSlideHeight(context);
    // double _sliderHeightRatio = _sliderHeight / Scale.superScreenHeight(context);
    double _bzButtonWidth = Scale.superScreenWidth(context) - BottomDialog.draggerZoneHeight(draggable: true) * 2;

    // int _titleSize = 2;
    // double _titleMargin = 5;
    // double _titleZoneHeight = superVerseRealHeight(context, _titleSize, 1, null) + (_titleMargin * 2);

    double _bzzButtonsZoneHeight = BottomDialog.dialogClearHeight(context: context, overridingDialogHeight: _sliderHeight, titleIsOn: true, draggable: true);

    BottomDialog.showBottomDialog(
            context: context,
            draggable: true,
            height: _sliderHeight,
            title: 'My Business accounts',
            child: Container(
              // height: 100,
              child: NotificationListener(
                onNotification: (ScrollUpdateNotification details){

                  bool _canPageUp = Scrollers.canPageUp(details: details, height: _bzzButtonsZoneHeight,);

                  if(_canPageUp){
                    Nav.goBackToHomeScreen(context);
                  }

                  return true;
                },
                child: Container(
                  height: _bzzButtonsZoneHeight,
                  child: Scroller(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(_paddings),
                      physics: const BouncingScrollPhysics(),
                      // controller: _myBzzListController,
                      itemCount: myTinyBzz.length,
                      itemBuilder: (context, index){
                        TinyBz _tinyBz = myTinyBzz[index];
                        return Align(
                          alignment: Aligners.superCenterAlignment(context),
                          child: DreamBox(
                            height: 60,
                            width: _bzButtonWidth,
                            margins: const EdgeInsets.all(Ratioz.appBarPadding),
                            icon: _tinyBz.bzLogo,
                            verse: _tinyBz.bzName,
                            secondLine: TextGenerator.bzTypeSingleStringer(context, _tinyBz.bzType),
                            iconSizeFactor: 1,
                            verseScaleFactor: 0.7,
                            bubble: true,
                            color: Colorz.Nothing,
                            verseCentered: false,
                            onTap: () async {
                              print('${_tinyBz.bzID}');

                              Nav.goToNewScreen(context,
                                  MyBzScreen(
                                    userModel: userModel,
                                    tinyBz: _tinyBz,
                                  ));

                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _screenWidth = Scale.superScreenWidth(context);
    double _buttonCircleCorner = Scale.buttonCircleCorner;
    BarType _barType = barType == null ? BarType.min : barType;
    BorderRadius _boxCorners = Scale.navBarCorners(context: context, barType: _barType);
    double _boxHeight = Scale.navBarHeight(context: context, barType: _barType);
    double _bottomOffset = Scale.navBarBottomOffset(barType: _barType);
// -----------------------------------------------------------------------------
    /// TASK : IOS back button needs revision
    bool _deviceIsIOS = false;//DeviceChecker.deviceIsIOS();
// -----------------------------------------------------------------------------
    Widget _expander = _deviceIsIOS ? Expanded(child: Container(),) : Container();
// -----------------------------------------------------------------------------
    return

       userStreamBuilder(
           context: context,
           listen: false,
           builder: (context, UserModel userModel){

             double _spacerWidth = Scale.navBarSpacerWidth(context, userModel);
             Widget _spacer = SizedBox(width: _spacerWidth,);
             Widget _halfSpacer = SizedBox(width: _spacerWidth * 0.5,);

             double _boxWidth = Scale.navBarWidth(context: context, userModel: userModel);

             List<String> _userBzzIDs = TinyBz.getBzzIDsFromTinyBzz(myTinyBzz);

             // List<dynamic> _followedBzzIDs = userModel != null ? userModel?.followedBzzIDs : [];
             // String _bzID = _followedBzzIDs.length > 0 ?  _followedBzzIDs[0] : '';
             // String _bzLogo = prof.getBzByBzID(_bzID)?.bzLogo;

                 return

               Positioned(
                 bottom: _bottomOffset,
                 child: Container(
                   width: _screenWidth,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[

                       /// ios back button
                       if (_deviceIsIOS)
                         DreamBox(
                           height: _circleWidth,
                           width: _circleWidth,
                           color: sky == Sky.Black ? Colorz.Yellow50 : Colorz.White20,
                           corners: _buttonCircleCorner,
                           margins: const EdgeInsets.all(Ratioz.appBarPadding),
                           icon: Iconizer.superBackIcon(context),
                           blur : Ratioz.blur1,
                           onTap: () => Nav.goBack(context),
                         ),

                       _expander,

                       /// navBar widgets
                       Container(
                         width: _boxWidth,
                         height: _boxHeight,
                         decoration: BoxDecoration(
                           color: Colorz.Black230,
                           borderRadius: _boxCorners,
                           boxShadow: Shadowz.appBarShadow,
                         ),
                         child: Stack(
                           children: <Widget>[

                             // --- BLUR LAYER
                             BlurLayer(
                               width: _boxWidth,
                               height: _boxHeight,
                               blur: Ratioz.blur1,
                               borders: _boxCorners,
                             ),

                             // --- BUTTONS
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[

                                 _halfSpacer,

                                 /// --- SAVED FLYERS
                                 BarButton(
                                   width: _buttonWidth,
                                   text: 'Choices',
                                   icon: Iconz.SaveOn,
                                   iconSizeFactor: 0.7,
                                   barType: _barType,
                                   onTap: () => Nav.goToRoute(context, Routez.SavedFlyers),
                                 ),


                                 _spacer,

                                 /// --- MORE
                                 BarButton(
                                   width: _buttonWidth,
                                   text: Wordz.more(context),
                                   icon: Iconz.More,
                                   iconSizeFactor: 0.45,
                                   barType: _barType,
                                   onTap: (){
                                     print('fish');
                                     Nav.goToNewScreen(context, MoreScreen(userModel: userModel));
                                     },
                                 ),

                                 _spacer,

                                 /// --- BZZ BUTTON
                                  if (UserModel.userIsAuthor(userModel))
                                 BzzButton(
                                   width: _buttonWidth,
                                   circleWidth: _circleWidth,
                                   barType: _barType,
                                   bzzIDs: _userBzzIDs,
                                   onTap: (){
                                     print('fish');

                                     if (_userBzzIDs.length == 1){
                                       Nav.goToNewScreen(context, MyBzScreen(
                                         userModel: userModel,
                                         tinyBz: myTinyBzz[0],
                                       ));
                                     } else {
                                       _multiBzzSlider(context, userModel);
                                     }


                                   },
                                 ),

                                 _spacer,

                                 /// ---  NEWS
                                 BarButton(
                                   width: _buttonWidth,
                                   text: Wordz.news(context),
                                   icon: Iconz.News,
                                   iconSizeFactor: 0.45,
                                   barType: _barType,
                                   onTap: () {
                                     Nav.goToNewScreen(context, NotificationsScreen());
                                   },
                                 ),

                                 _spacer,

                                 /// --- PROFILE
                                 BarButton(
                                     width: _buttonWidth,
                                     text: Wordz.profile(context),
                                     icon: Iconz.NormalUser,
                                     iconSizeFactor: 0.7,
                                     barType: _barType,
                                     onTap: () => Nav.goToNewScreen(context, UserProfileScreen(userModel: userModel,)),
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
                       ),

                       _expander,

                       /// IOS balance container
                       if (_deviceIsIOS)
                         Container(
                           width: _circleWidth,
                           height: _circleWidth,
                           margin: const EdgeInsets.all(Ratioz.appBarPadding),
                         ),

                     ],
                   ),
                 ),
               );

               }
            );

  }
}
