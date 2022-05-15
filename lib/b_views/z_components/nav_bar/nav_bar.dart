import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/b_auth/b_0_auth_screen.dart';
import 'package:bldrs/b_views/x_screens/f_bz/f_0_my_bz_screen.dart';
import 'package:bldrs/b_views/x_screens/f_bz/f_1_my_bzz_selector_screen.dart';
import 'package:bldrs/b_views/x_screens/g_user/g_0_user_profile_screen.dart';
import 'package:bldrs/b_views/x_screens/j_questions/questions_screen.dart';
import 'package:bldrs/b_views/z_components/artworks/blur_layer.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/nav_bar/bar_button.dart';
import 'package:bldrs/b_views/z_components/nav_bar/unfinished_bzz_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/scrollers.dart' as Scrollers;
import 'package:bldrs/f_helpers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum BarType {
  min,
  max,
  minWithText,
  maxWithText,
}

class NavBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NavBar({
    this.barType = _standardBarType,
    this.sky = SkyType.night,
    // this.myBzz,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BarType barType;
  final SkyType sky;
  // final List<BzModel> myBzz;
  /// --------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  /// --- MAIN CONTROLS
  static const double _circleWidth = Ratioz.appBarButtonSize;
  static const double navbarPaddings = Ratioz.appBarPadding * 1.5;
  static const double navBarButtonWidth = _circleWidth + (navbarPaddings * 0.5 * 2) + (navbarPaddings * 0.5 * 2);
  static const double _textScaleFactor = 0.95;
  static const int _textSize = 0;
  static const double buttonCircleCorner = _circleWidth * 0.5;
  static const double _boxCorner = buttonCircleCorner + navbarPaddings;
  static const BarType _standardBarType = BarType.minWithText;
// -----------------------------------------------------------------------------
  static double navBarHeight({
    @required BuildContext context,
    BarType barType = _standardBarType,
  }) {
    final double _textBoxHeight = navBarTextBoxHeight(context: context, barType: barType);

    final double _boxHeight = barType == BarType.maxWithText || barType == BarType.minWithText ?
    _circleWidth + (navbarPaddings * 2) + _textBoxHeight
            :
    _circleWidth + (navbarPaddings * 2);

    return _boxHeight;
  }
// -----------------------------------------------------------------------------
  static double navBarWidth({
    @required BuildContext context,
    @required UserModel userModel,
    BarType barType = _standardBarType,
  }) {

    final int _numberOfButtons = navBarNumberOfButtons(userModel);
    final int _numberOfSpacings = _numberOfButtons - 1;
    const double _spacingFactor = 0.5;
    final double _spacings = navBarButtonsSpacing(
        context: context,
        numberOfButtons: _numberOfButtons,
        numberOfSpacings: _numberOfSpacings,
        spacingFactor: _spacingFactor
    );

    final double _boxWidth = barType == BarType.maxWithText || barType == BarType.max ?
    Scale.superScreenWidth(context)
            :
    (navBarButtonWidth * _numberOfButtons) + (_spacings * _numberOfSpacings);

    return _boxWidth;
  }
// -----------------------------------------------------------------------------
  static double navBarTextBoxHeight({
    @required BuildContext context,
    BarType barType = _standardBarType,
  }) {

    final double _textBoxHeight = barType == BarType.maxWithText || barType == BarType.minWithText ?
    SuperVerse.superVerseRealHeight(
        context: context,
        size: _textSize,
        sizeFactor: _textScaleFactor,
        hasLabelBox: false,
    )
            :
    0;

    return _textBoxHeight;
  }
// -----------------------------------------------------------------------------
  static int navBarNumberOfButtons(UserModel userModel) {
    int _numberOfButtons;

    if (AuthModel.userIsSignedIn() == false) {
      _numberOfButtons = 2;
    } else if (UserModel.userIsAuthor(userModel)) {
      _numberOfButtons = 4;
    } else {
      _numberOfButtons = 3;
    }

    return _numberOfButtons;
  }
// -----------------------------------------------------------------------------
  static double navBarButtonsSpacing({
    @required BuildContext context,
    @required int numberOfButtons,
    @required int numberOfSpacings,
    @required double spacingFactor,
    BarType barType = _standardBarType,
  }) {

    final double _spacings =
    barType == BarType.max || barType == BarType.maxWithText ?
    (
        (
            Scale.superScreenWidth(context)
            -
            (navBarButtonWidth * numberOfButtons)
        )
            /
            numberOfSpacings
    ) * spacingFactor
        :
    navbarPaddings * 0;

    return _spacings;
  }

// -----------------------------------------------------------------------------
  static double navBarSpacerWidth(BuildContext context, UserModel userModel) {
    final int _numberOfButtons = navBarNumberOfButtons(userModel);
    final int _numberOfSpacings = _numberOfButtons - 1;
    const double _spacingFactor = 0.5;
    final double _spacings = navBarButtonsSpacing(
        context: context,
        numberOfButtons: _numberOfButtons,
        numberOfSpacings: _numberOfSpacings,
        spacingFactor: _spacingFactor);

    final double _halfSpacer = _spacings * 0.5;

    return _halfSpacer;
  }
// -----------------------------------------------------------------------------
  static BorderRadius navBarCorners({
    @required BuildContext context,
    BarType barType = _standardBarType,
  }) {
    final BorderRadius _boxBorders = barType == BarType.min ?
    Borderers.superBorderOnly(
            context: context,
            enTopLeft: _boxCorner,
            enBottomLeft: _boxCorner,
            enBottomRight: _boxCorner,
            enTopRight: _boxCorner
    )
        :
    barType == BarType.max || barType == BarType.maxWithText ?

    Borderers.superBorderOnly(
        context: context,
        enTopLeft: _boxCorner,
        enBottomLeft: 0,
        enBottomRight: 0,
        enTopRight: _boxCorner)
        :
    Borderers.superBorderOnly(
        context: context,
        enTopLeft: _boxCorner,
        enBottomLeft: _boxCorner * 0.5,
        enBottomRight: _boxCorner * 0.5,
        enTopRight: _boxCorner
    );

    return _boxBorders;
  }
// -----------------------------------------------------------------------------
  static double navBarBottomOffset({BarType barType = _standardBarType}) {

    final double _bottomOffset = barType == BarType.min || barType == BarType.minWithText ?
    navbarPaddings
        :
    barType == BarType.max || barType == BarType.maxWithText ? 0 : 0;

    return _bottomOffset;
  }
// -----------------------------------------------------------------------------
  double _myBzzListSlideHeight(BuildContext context, List<BzModel> myBzz) {
    final double _wantedHeight = Scale.superScreenWidth(context) * 0.3 * myBzz.length;
    final double _maxHeight = Scale.superScreenHeight(context) * 0.5;

    double _finalHeight;
    if (_wantedHeight >= _maxHeight) {
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

    final double _bzzButtonsZoneHeight = BottomDialog.clearHeight(
        context: context,
        overridingDialogHeight: _sliderHeight,
        titleIsOn: true,
        draggable: true);


    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: _sliderHeight,
      title: 'My Business accounts',
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (ScrollUpdateNotification details) {
          final bool _canPageUp = Scrollers.canSlide(
            details: details,
            boxDistance: _bzzButtonsZoneHeight,
            goesBackOnly: true,
            axis: Axis.vertical,
          );

          if (_canPageUp) {
            Nav.goBackToHomeScreen(context);
          }

          return true;
        },
        child: SizedBox(
          height: _bzzButtonsZoneHeight,
          child: Scroller(
            child: ListView.builder(
              padding: const EdgeInsets.all(navbarPaddings),
              physics: const BouncingScrollPhysics(),
              // controller: _myBzzListController,
              itemCount: myBzz.length,
              itemBuilder: (BuildContext context, int index) {

                final BzModel _bzModel = myBzz[index];

                final String _bzTypesString = BzModel.generateTranslatedBzTypesString(
                  context: context,
                  bzTypes: _bzModel.bzTypes,
                );

                return Align(
                  alignment: Aligners.superCenterAlignment(context),
                  child: DreamBox(
                    height: 60,
                    width: _bzButtonWidth,
                    margins: const EdgeInsets.all(Ratioz.appBarPadding),
                    icon: _bzModel.logo,
                    verse: _bzModel.name,
                    secondLine: _bzTypesString,
                    verseScaleFactor: 0.7,
                    verseCentered: false,
                    onTap: () async {

                      blog(_bzModel.id);

                      await Nav.goToNewScreen(
                          context: context,
                          screen: MyBzScreen(
                            bzModel: _bzModel,
                          )
                      );

                      },
                  ),
                );
                },
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
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: true);
    final UserModel _myUserModel = _usersProvider.myUserModel;
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: true);
    final List<BzModel> _myBzz = _bzzProvider.myBzz;
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    const double _buttonCircleCorner = buttonCircleCorner;
    final BorderRadius _boxCorners = navBarCorners(context: context, barType: barType);
    final double _navBarHeight = navBarHeight(context: context, barType: barType);
    final double _bottomOffset = navBarBottomOffset(barType: barType);
// -----------------------------------------------------------------------------
    /// TASK : IOS back button needs revision
    const bool _deviceIsIOS = false; //DeviceChecker.deviceIsIOS();
// -----------------------------------------------------------------------------
    final Widget _expander = _deviceIsIOS ?
    Expanded(child: Container(),) : Container();
// -----------------------------------------------------------------------------
    final double _spacerWidth = navBarSpacerWidth(context, _myUserModel);
    final Widget _spacer = SizedBox(width: _spacerWidth,);
    final Widget _halfSpacer = SizedBox(width: _spacerWidth * 0.5,);

    final double _navBarWidth = navBarWidth(context: context, userModel: _myUserModel);
    final List<String> _userBzzIDs = BzModel.getBzzIDsFromBzz(_myBzz);

    // List<dynamic> _followedBzzIDs = _myUserModel != null ? _myUserModel?.followedBzzIDs : [];
    // String _bzID = _followedBzzIDs.length > 0 ?  _followedBzzIDs[0] : '';
    // String _bzLogo = prof.getBzByBzID(_bzID)?.bzLogo;

    final bool _userIsSignedIn = AuthModel.userIsSignedIn();

    return Positioned(
      key: key,
      bottom: _bottomOffset,
      child: SizedBox(
        width: _screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /// ios back button
            if (_deviceIsIOS)
              DreamBox(
                height: _circleWidth,
                width: _circleWidth,
                color: sky == SkyType.black ? Colorz.yellow50 : Colorz.white20,
                corners: _buttonCircleCorner,
                margins: const EdgeInsets.all(Ratioz.appBarPadding),
                icon: Iconizer.superBackIcon(context),
                blur: Ratioz.blur1,
                onTap: () => Nav.goBack(context),
              ),

            _expander,

            /// navBar widgets
            Container(
              width: _navBarWidth,
              height: _navBarHeight,
              decoration: BoxDecoration(
                color: Colorz.black230,
                borderRadius: _boxCorners,
                boxShadow: Shadowz.appBarShadow,
              ),
              child: Stack(
                children: <Widget>[

                  /// --- BLUR LAYER
                  BlurLayer(
                    width: _navBarWidth,
                    height: _navBarHeight,
                    borders: _boxCorners,
                  ),

                  /// BUTTONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _halfSpacer,

                      /// SAVED FLYERS
                      if (_userIsSignedIn == true)
                        BarButton(
                          width: navBarButtonWidth,
                          text: superPhrase(context, 'phid_saves'),
                          icon: Iconz.saveOn,
                          iconSizeFactor: 0.7,
                          barType: barType,
                          onTap: () => Nav.goToRoute(context, Routez.savedFlyers),
                        ),

                      _spacer,

                      /// QUESTION
                      BarButton(
                        width: navBarButtonWidth,
                        text: superPhrase(context, 'phid_question'),
                        icon: Iconz.utPlanning,
                        iconSizeFactor: 0.45,
                        barType: barType,
                        onTap: () async {

                          blog('fish');

                          await Nav.goToNewScreen(
                            context: context,
                            screen: const QScreen(),
                          );

                          },
                      ),

                      _spacer,

                      /// BZZ BUTTON
                      if (UserModel.userIsAuthor(_myUserModel) && _userIsSignedIn == true)
                        BzzButton(
                          width: navBarButtonWidth,
                          circleWidth: _circleWidth,
                          barType: barType,
                          // bzzIDs: _userBzzIDs,
                          onTap: () async {
                            blog('fish');

                            /// IF HAS ONLY ONE BZ ACCOUNT
                            if (_userBzzIDs.length == 1) {

                              await Nav.goToNewScreen(
                                  context: context,
                                  screen: MyBzScreen(
                                    // userModel: _myUserModel,
                                    bzModel: _myBzz[0],
                                  )
                              );

                            }

                            /// IF HAS MULTIPLE BZZ ACCOUNTS
                            else {
                              // await _multiBzzSlider(context, _myUserModel, _myBzz);

                              await Nav.goToNewScreen(
                                  context: context,
                                  screen: MyBzzSelectorScreen(
                                    userModel: _myUserModel,
                                    bzzModels: _myBzz,
                                  )
                              );

                            }
                          },
                        ),

                      // _spacer,
                      //
                      // /// NEWS
                      // if (_userIsSignedIn == true)
                      //   BarButton(
                      //     width: navBarButtonWidth,
                      //     text: Wordz.news(context),
                      //     icon: Iconz.news,
                      //     iconSizeFactor: 0.45,
                      //     barType: barType,
                      //     onTap: () {
                      //       Nav.goToNewScreen(
                      //           context, const NotificationsScreen());
                      //     },
                      //   ),

                      _spacer,

                      /// PROFILE
                      if (_userIsSignedIn == true)
                        BarButton(
                            width: navBarButtonWidth,
                            text: superPhrase(context, 'phid_profile'),
                            icon: Iconz.normalUser,
                            iconSizeFactor: 0.7,
                            barType: barType,
                            onTap: () => Nav.goToNewScreen(
                                context: context,
                                screen: const UserProfileScreen()
                            ),
                            clipperWidget: UserBalloon(
                              size: _circleWidth,
                              loading: false,
                              userModel: _myUserModel,
                            )),

                      if (_userIsSignedIn == false)
                        BarButton(
                          width: navBarButtonWidth,
                          text: superPhrase(context, 'phid_sign'),
                          icon: Iconz.normalUser,
                          iconSizeFactor: 0.45,
                          barType: barType,
                          notiDotIsOn: true,
                          onTap: () async {

                            await Nav.goToNewScreen(
                                context: context,
                                screen: const AuthScreen(),
                            );

                          },
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
