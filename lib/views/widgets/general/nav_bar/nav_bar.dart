import 'package:bldrs/controllers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/drafters/iconizers.dart' as Iconizer;
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
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/bzz_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/user_provider.dart';
import 'package:bldrs/views/screens/d_more/d_0_more_screen.dart';
import 'package:bldrs/views/screens/f_bz/f_0_my_bz_screen.dart';
import 'package:bldrs/views/screens/g_user/g_0_profile_screen.dart';
import 'package:bldrs/views/screens/h_notifications/g_1_notifications_screen.dart';
import 'package:bldrs/views/widgets/general/artworks/blur_layer.dart';
import 'package:bldrs/views/widgets/general/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/general/nav_bar/bar_button.dart';
import 'package:bldrs/views/widgets/general/nav_bar/bzz_button.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum BarType{
  min,
  max,
  minWithText,
  maxWithText,
}

class NavBar extends StatelessWidget {
  final BarType barType;
  final SkyType sky;
  // final List<BzModel> myBzz;

  NavBar({
    this.barType = _standardBarType,
    this.sky = SkyType.Night,
    // this.myBzz,
    Key key
}) : super (key: key);
// -----------------------------------------------------------------------------
  /// --- MAIN CONTROLS
  static const double _circleWidth = Ratioz.appBarButtonSize;
  static const double navbarPaddings = Ratioz.appBarPadding * 1.5;
  static const double navBarButtonWidth =_circleWidth + (navbarPaddings * 0.5 * 2) + (navbarPaddings * 0.5 * 2);
  static const double _textScaleFactor = 0.95;
  static const int _textSize = 0;
  static const double buttonCircleCorner = _circleWidth * 0.5;
  static const double _boxCorner = buttonCircleCorner + navbarPaddings;
  static const BarType _standardBarType = BarType.minWithText;
// -----------------------------------------------------------------------------
  static double navBarHeight({
    @required BuildContext context,
    BarType barType = _standardBarType,
  }){

    final double _textBoxHeight = navBarTextBoxHeight(context: context, barType: barType);

    final double _boxHeight =
    barType == BarType.maxWithText || barType == BarType.minWithText ?
    _circleWidth + ( navbarPaddings * 2) + (_textBoxHeight)
        :
    _circleWidth + ( navbarPaddings * 2);

    return _boxHeight;
  }
// -----------------------------------------------------------------------------
  static double navBarWidth({
    @required BuildContext context,
    @required UserModel userModel,
    BarType barType = _standardBarType,
  }){
    final int _numberOfButtons = navBarNumberOfButtons(userModel);
    final int _numberOfSpacings = _numberOfButtons - 1;
    const double _spacingFactor = 0.5;
    final double _spacings = navBarButtonsSpacing(
        context: context,
        numberOfButtons : _numberOfButtons,
        numberOfSpacings : _numberOfSpacings,
        spacingFactor : _spacingFactor
    );

    final double _boxWidth =
    barType == BarType.maxWithText || barType == BarType.max ?
    Scale.superScreenWidth(context)
        :
    ( navBarButtonWidth * _numberOfButtons ) + (_spacings * _numberOfSpacings) ;

    return _boxWidth;
  }
// -----------------------------------------------------------------------------
  static double navBarTextBoxHeight({
    @required BuildContext context,
    BarType barType = _standardBarType,
  }){
    final double _textBoxHeight =
    barType == BarType.maxWithText || barType == BarType.minWithText ?
    SuperVerse.superVerseRealHeight(context, _textSize, _textScaleFactor, null) : 0;

    return _textBoxHeight;
  }
// -----------------------------------------------------------------------------
  static int navBarNumberOfButtons(UserModel userModel) {
    final int _numberOfButtons = UserModel.userIsAuthor(userModel) ? 5 : 4;
    return _numberOfButtons;
  }
// -----------------------------------------------------------------------------
  static double navBarButtonsSpacing({
    @required BuildContext context,
    @required int numberOfButtons,
    @required int numberOfSpacings,
    @required double spacingFactor,
    BarType barType = _standardBarType,
  }){

    final double _spacings =
    barType == BarType.max || barType == BarType.maxWithText ?
    ((Scale.superScreenWidth(context) - (navBarButtonWidth * numberOfButtons) ) / numberOfSpacings) * spacingFactor
        :
    navbarPaddings * 0
    ;
    return _spacings;

  }
// -----------------------------------------------------------------------------
  static double navBarSpacerWidth(BuildContext context, UserModel userModel){
    final int _numberOfButtons = navBarNumberOfButtons(userModel);
    final int _numberOfSpacings = _numberOfButtons - 1;
    const double _spacingFactor = 0.5;
    final double _spacings = navBarButtonsSpacing(
        context :  context,
        numberOfButtons :  _numberOfButtons,
        numberOfSpacings :  _numberOfSpacings,
        spacingFactor :  _spacingFactor
    );

    final double _halfSpacer = _spacings * 0.5;

    return _halfSpacer;
  }
// -----------------------------------------------------------------------------
  static BorderRadius navBarCorners({@required BuildContext context, BarType barType = _standardBarType,}){
    final BorderRadius _boxBorders =
    barType == BarType.min ?
    Borderers.superBorderOnly(context: context, enTopLeft: _boxCorner, enBottomLeft: _boxCorner, enBottomRight: _boxCorner, enTopRight: _boxCorner)
        :
    barType == BarType.max  || barType == BarType.maxWithText?
    Borderers.superBorderOnly(context: context, enTopLeft: _boxCorner, enBottomLeft: 0, enBottomRight: 0, enTopRight: _boxCorner)
        :
    Borderers.superBorderOnly(context: context, enTopLeft: _boxCorner, enBottomLeft: _boxCorner * 0.5, enBottomRight: _boxCorner * 0.5, enTopRight: _boxCorner)
    ;

    return _boxBorders;

  }
// -----------------------------------------------------------------------------
  static double navBarBottomOffset({BarType barType = _standardBarType}){
    final double _bottomOffset =
    barType == BarType.min || barType == BarType.minWithText ? navbarPaddings :
    barType == BarType.max || barType == BarType.maxWithText ? 0 : 0;
    return _bottomOffset;
  }

  double _myBzzListSlideHeight(BuildContext context, List<BzModel> myBzz){
    final double _wantedHeight = (Scale.superScreenWidth(context) * 0.3 * myBzz.length);
    final double _maxHeight = Scale.superScreenHeight(context) * 0.5;
    double _finalHeight;
    if(_wantedHeight >= _maxHeight){
      _finalHeight = _maxHeight;
    } else {
      _finalHeight = _wantedHeight;
    }
    return _finalHeight;
  }
// -----------------------------------------------------------------------------
  Future<void> _multiBzzSlider(BuildContext context, UserModel userModel, List<BzModel> myBzz) async {

    final double _sliderHeight = _myBzzListSlideHeight(context, myBzz);
    // double _sliderHeightRatio = _sliderHeight / Scale.superScreenHeight(context);
    final double _bzButtonWidth = Scale.superScreenWidth(context) - BottomDialog.draggerZoneHeight(draggable: true) * 2;

    // int _titleSize = 2;
    // double _titleMargin = 5;
    // double _titleZoneHeight = superVerseRealHeight(context, _titleSize, 1, null) + (_titleMargin * 2);

    final double _bzzButtonsZoneHeight = BottomDialog.dialogClearHeight(context: context, overridingDialogHeight: _sliderHeight, titleIsOn: true, draggable: true);

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: _sliderHeight,
      title: 'My Business accounts',
      child: Container(
        // height: 100,
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: (ScrollUpdateNotification details){

            final bool _canPageUp = Scrollers.canSlide(
              details: details,
              boxDistance: _bzzButtonsZoneHeight,
              goesBackOnly: true,
              axis: Axis.vertical,
            );

            if(_canPageUp){
              Nav.goBackToHomeScreen(context);
            }

            return true;
            },
          child: Container(
            height: _bzzButtonsZoneHeight,
            child: Scroller(
              child: ListView.builder(
                padding: const EdgeInsets.all(navbarPaddings),
                physics: const BouncingScrollPhysics(),
                // controller: _myBzzListController,
                itemCount: myBzz.length,
                itemBuilder: (BuildContext context, int index){

                  final BzModel _bzModel = myBzz[index];

                  return Align(
                    alignment: Aligners.superCenterAlignment(context),
                    child: DreamBox(
                      height: 60,
                      width: _bzButtonWidth,
                      margins: const EdgeInsets.all(Ratioz.appBarPadding),
                      icon: _bzModel.logo,
                      verse: _bzModel.name,
                      secondLine: TextGen.bzTypeSingleStringer(context, _bzModel.bzType),
                      iconSizeFactor: 1,
                      verseScaleFactor: 0.7,
                      bubble: true,
                      color: Colorz.nothing,
                      verseCentered: false,
                      onTap: () async {
                        print('${_bzModel.id}');

                        final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
                        final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
                        await _bzzProvider.setActiveBz(_bzModel);
                        await _flyersProvider.getsetActiveBzFlyers(context: context, bzID: _bzModel.id);

                        await Nav.goToNewScreen(context,
                            MyBzScreen(
                              userModel: userModel,
                              bzModel: _bzModel,
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
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: true);
    final UserModel _myUserModel = _usersProvider.myUserModel;
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: true);
    final List<BzModel> _myBzz = _bzzProvider.myBzz;
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    const double _buttonCircleCorner = buttonCircleCorner;
    final BorderRadius _boxCorners = navBarCorners(context: context, barType: barType);
    final double _boxHeight = navBarHeight(context: context, barType: barType);
    final double _bottomOffset = navBarBottomOffset(barType: barType);
// -----------------------------------------------------------------------------
    /// TASK : IOS back button needs revision
    const bool _deviceIsIOS = false;//DeviceChecker.deviceIsIOS();
// -----------------------------------------------------------------------------
    final Widget _expander = _deviceIsIOS ? Expanded(child: Container(),) : Container();
// -----------------------------------------------------------------------------

    final double _spacerWidth = navBarSpacerWidth(context, _myUserModel);
    final Widget _spacer = SizedBox(width: _spacerWidth,);
    final Widget _halfSpacer = SizedBox(width: _spacerWidth * 0.5,);

    final double _boxWidth = navBarWidth(context: context, userModel: _myUserModel);

    final List<String> _userBzzIDs = BzModel.getBzzIDsFromBzz(_myBzz);

    // List<dynamic> _followedBzzIDs = _myUserModel != null ? _myUserModel?.followedBzzIDs : [];
    // String _bzID = _followedBzzIDs.length > 0 ?  _followedBzzIDs[0] : '';
    // String _bzLogo = prof.getBzByBzID(_bzID)?.bzLogo;


    return

      Positioned(
        key: key,
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
                  color: sky == SkyType.Black ? Colorz.yellow50 : Colorz.white20,
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
                  color: Colorz.black230,
                  borderRadius: _boxCorners,
                  boxShadow: Shadowz.appBarShadow,
                ),
                child: Stack(
                  children: <Widget>[

                    /// --- BLUR LAYER
                    BlurLayer(
                      width: _boxWidth,
                      height: _boxHeight,
                      blur: Ratioz.blur1,
                      borders: _boxCorners,
                    ),

                    /// BUTTONS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        _halfSpacer,

                        /// SAVED FLYERS
                        BarButton(
                          width: navBarButtonWidth,
                          text: 'Choices',
                          icon: Iconz.SaveOn,
                          iconSizeFactor: 0.7,
                          barType: barType,
                          onTap: () => Nav.goToRoute(context, Routez.SavedFlyers),
                        ),


                        _spacer,

                        /// MORE
                        BarButton(
                          width: navBarButtonWidth,
                          text: Wordz.more(context),
                          icon: Iconz.More,
                          iconSizeFactor: 0.45,
                          barType: barType,
                          onTap: (){
                            print('fish');
                            Nav.goToNewScreen(context, MoreScreen(userModel: _myUserModel));
                          },
                        ),

                        _spacer,

                        /// BZZ BUTTON
                        if (UserModel.userIsAuthor(_myUserModel))
                          BzzButton(
                            width: navBarButtonWidth,
                            circleWidth: _circleWidth,
                            barType: barType,
                            // bzzIDs: _userBzzIDs,
                            onTap: (){
                              print('fish');

                              if (_userBzzIDs.length == 1){
                                Nav.goToNewScreen(context, MyBzScreen(
                                  userModel: _myUserModel,
                                  bzModel: _myBzz[0],
                                ));
                              } else {
                                _multiBzzSlider(context, _myUserModel, _myBzz);
                              }


                            },
                          ),

                        _spacer,

                        /// NEWS
                        BarButton(
                          width: navBarButtonWidth,
                          text: Wordz.news(context),
                          icon: Iconz.News,
                          iconSizeFactor: 0.45,
                          barType: barType,
                          onTap: () {
                            Nav.goToNewScreen(context, const NotificationsScreen());
                          },
                        ),

                        _spacer,

                        /// PROFILE
                        BarButton(
                            width: navBarButtonWidth,
                            text: Wordz.profile(context),
                            icon: Iconz.NormalUser,
                            iconSizeFactor: 0.7,
                            barType: barType,
                            onTap: () => Nav.goToNewScreen(context, UserProfileScreen(userModel: _myUserModel,)),
                            clipperWidget : UserBalloon(
                              balloonWidth: _circleWidth,
                              loading: false,
                              userModel: _myUserModel,
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
}
