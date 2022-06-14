// import 'package:bldrs/a_models/user/auth_model.dart';
// import 'package:bldrs/a_models/user/user_model.dart';
// import 'package:bldrs/b_views/z_components/artworks/blur_layer.dart';
// import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/bzz_button/a_my_bzz_nav_button.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/components/my_profile_button.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/components/nav_bar_button.dart';
// import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
// import 'package:bldrs/c_controllers/a_starters_controllers/nav_bar_controller.dart';
// import 'package:bldrs/d_providers/phrase_provider.dart';
// import 'package:bldrs/d_providers/user_provider.dart';
// import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
// import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
// import 'package:bldrs/f_helpers/drafters/shadowers.dart' as Shadowz;
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// enum BarType {
//   min,
//   max,
//   minWithText,
//   maxWithText,
// }
//
//

// class NavBar extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const NavBar({
//     this.sky = SkyType.night,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final SkyType sky;
// // -----------------------------------------------------------------------------
//   /// --- MAIN CONTROLS
//   static const double circleWidth = Ratioz.appBarButtonSize;
//   static const double navbarPaddings = Ratioz.appBarPadding * 1.5;
//   static const double navBarButtonWidth = circleWidth + (navbarPaddings * 0.5 * 2) + (navbarPaddings * 0.5 * 2);
//   static const double _textScaleFactor = 0.95;
//   static const int _textSize = 0;
//   static const double buttonCircleCorner = circleWidth * 0.5;
//   static const double _boxCorner = buttonCircleCorner + navbarPaddings;
//   static const BarType barType = BarType.minWithText;
// // -----------------------------------------------------------------------------
//   static double navBarHeight({
//     @required BuildContext context,
//     @required BarType barType,
//   }) {
//     final double _textBoxHeight = navBarTextBoxHeight(context: context, barType: barType);
//
//     final double _boxHeight = barType == BarType.maxWithText || barType == BarType.minWithText ?
//     circleWidth + (navbarPaddings * 2) + _textBoxHeight
//             :
//     circleWidth + (navbarPaddings * 2);
//
//     return _boxHeight;
//   }
// // -----------------------------------------------------------------------------
//   static double navBarWidth({
//     @required BuildContext context,
//     @required UserModel userModel,
//     @required BarType barType,
//   }) {
//
//     final int _numberOfButtons = navBarNumberOfButtons(userModel);
//     final int _numberOfSpacings = _numberOfButtons - 1;
//     const double _spacingFactor = 0.5;
//     final double _spacings = navBarButtonsSpacing(
//         context: context,
//         numberOfButtons: _numberOfButtons,
//         numberOfSpacings: _numberOfSpacings,
//         spacingFactor: _spacingFactor
//     );
//
//     final double _boxWidth = barType == BarType.maxWithText || barType == BarType.max ?
//     Scale.superScreenWidth(context)
//             :
//     (navBarButtonWidth * _numberOfButtons) + (_spacings * _numberOfSpacings);
//
//     return _boxWidth;
//   }
// // -----------------------------------------------------------------------------
//   static double navBarTextBoxHeight({
//     @required BuildContext context,
//     @required BarType barType,
//   }) {
//
//     final double _textBoxHeight = barType == BarType.maxWithText || barType == BarType.minWithText ?
//     SuperVerse.superVerseRealHeight(
//         context: context,
//         size: _textSize,
//         sizeFactor: _textScaleFactor,
//         hasLabelBox: false,
//     )
//             :
//     0;
//
//     return _textBoxHeight;
//   }
// // -----------------------------------------------------------------------------
//   static int navBarNumberOfButtons(UserModel userModel) {
//     int _numberOfButtons;
//
//     if (AuthModel.userIsSignedIn() == false) {
//       _numberOfButtons = 2;
//     } else if (UserModel.checkUserIsAuthor(userModel)) {
//       _numberOfButtons = 4;
//     } else {
//       _numberOfButtons = 3;
//     }
//
//     return _numberOfButtons;
//   }
// // -----------------------------------------------------------------------------
//   static double navBarButtonsSpacing({
//     @required BuildContext context,
//     @required int numberOfButtons,
//     @required int numberOfSpacings,
//     @required double spacingFactor,
//     BarType barType = barType,
//   }) {
//
//     final double _spacings =
//     barType == BarType.max || barType == BarType.maxWithText ?
//     (
//         (
//             Scale.superScreenWidth(context)
//             -
//             (navBarButtonWidth * numberOfButtons)
//         )
//             /
//             numberOfSpacings
//     ) * spacingFactor
//         :
//     navbarPaddings * 0;
//
//     return _spacings;
//   }
// // -----------------------------------------------------------------------------
//   static double navBarSpacerWidth(BuildContext context, UserModel userModel) {
//     final int _numberOfButtons = navBarNumberOfButtons(userModel);
//     final int _numberOfSpacings = _numberOfButtons - 1;
//     const double _spacingFactor = 0.5;
//     final double _spacings = navBarButtonsSpacing(
//         context: context,
//         numberOfButtons: _numberOfButtons,
//         numberOfSpacings: _numberOfSpacings,
//         spacingFactor: _spacingFactor);
//
//     final double _halfSpacer = _spacings * 0.5;
//
//     return _halfSpacer;
//   }
// // -----------------------------------------------------------------------------
//   static BorderRadius navBarCorners({
//     @required BuildContext context,
//     @required BarType barType,
//   }) {
//     final BorderRadius _boxBorders = barType == BarType.min ?
//     Borderers.superBorderOnly(
//             context: context,
//             enTopLeft: _boxCorner,
//             enBottomLeft: _boxCorner,
//             enBottomRight: _boxCorner,
//             enTopRight: _boxCorner
//     )
//         :
//     barType == BarType.max || barType == BarType.maxWithText ?
//
//     Borderers.superBorderOnly(
//         context: context,
//         enTopLeft: _boxCorner,
//         enBottomLeft: 0,
//         enBottomRight: 0,
//         enTopRight: _boxCorner)
//         :
//     Borderers.superBorderOnly(
//         context: context,
//         enTopLeft: _boxCorner,
//         enBottomLeft: _boxCorner * 0.5,
//         enBottomRight: _boxCorner * 0.5,
//         enTopRight: _boxCorner
//     );
//
//     return _boxBorders;
//   }
// // -----------------------------------------------------------------------------
//   static double navBarBottomOffset({
//     @required BarType barType,
//   }) {
//
//     final double _bottomOffset = barType == BarType.min || barType == BarType.minWithText ?
//     navbarPaddings
//         :
//     barType == BarType.max || barType == BarType.maxWithText ? 0 : 0;
//
//     return _bottomOffset;
//   }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
// // -----------------------------------------------------------------------------
//     final UserModel _myUserModel = UsersProvider.proGetMyUserModel(context, listen: true);
// // -----------------------------------------------------------------------------
//     final double _screenWidth = Scale.superScreenWidth(context);
//     // const double _buttonCircleCorner = buttonCircleCorner;
//     final BorderRadius _boxCorners = navBarCorners(context: context, barType: barType);
//     final double _navBarHeight = navBarHeight(context: context, barType: barType);
//     final double _bottomOffset = navBarBottomOffset(barType: barType);
// // -----------------------------------------------------------------------------
//     /// TASK : IOS back button needs revision
//     // const bool _deviceIsIOS = false; //DeviceChecker.deviceIsIOS();
// // -----------------------------------------------------------------------------
// //     final Widget _expander = _deviceIsIOS ?
// //     Expanded(child: Container(),) : Container();
// // -----------------------------------------------------------------------------
//     final double _spacerWidth = navBarSpacerWidth(context, _myUserModel);
//     final Widget _spacer = SizedBox(width: _spacerWidth,);
//     final Widget _halfSpacer = SizedBox(width: _spacerWidth * 0.5,);
//
//     final double _navBarWidth = navBarWidth(
//       context: context,
//       userModel: _myUserModel,
//       barType: barType,
//     );
//
//     // final List<String> _userBzzIDs = BzModel.getBzzIDsFromBzz(_myBzz);
//
//     // List<dynamic> _followedBzzIDs = _myUserModel != null ? _myUserModel?.followedBzzIDs : [];
//     // String _bzID = _followedBzzIDs.length > 0 ?  _followedBzzIDs[0] : '';
//     // String _bzLogo = prof.getBzByBzID(_bzID)?.bzLogo;
//
//     final bool _userIsSignedIn = AuthModel.userIsSignedIn();
//
//     return Positioned(
//       key: key,
//       bottom: _bottomOffset,
//       child: SizedBox(
//         width: _screenWidth,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//
//             // /// ios back button
//             // if (_deviceIsIOS)
//             //   DreamBox(
//             //     height: _circleWidth,
//             //     width: _circleWidth,
//             //     color: sky == SkyType.black ? Colorz.yellow50 : Colorz.white20,
//             //     corners: _buttonCircleCorner,
//             //     margins: const EdgeInsets.all(Ratioz.appBarPadding),
//             //     icon: Iconizer.superBackIcon(context),
//             //     blur: Ratioz.blur1,
//             //     onTap: () => Nav.goBack(context),
//             //   ),
//             //
//             // _expander,
//
//             /// navBar widgets
//             Container(
//               width: _navBarWidth,
//               height: _navBarHeight,
//               decoration: BoxDecoration(
//                 color: Colorz.black230,
//                 borderRadius: _boxCorners,
//                 boxShadow: Shadowz.appBarShadow,
//               ),
//               child: Stack(
//                 children: <Widget>[
//
//                   /// --- BLUR LAYER
//                   BlurLayer(
//                     width: _navBarWidth,
//                     height: _navBarHeight,
//                     borders: _boxCorners,
//                   ),
//
//                   /// BUTTONS
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       _halfSpacer,
//
//                       /// SAVED FLYERS
//                       if (_userIsSignedIn == true)
//                         NavBarButton(
//                           size: navBarButtonWidth,
//                           text: superPhrase(context, 'phid_saves'),
//                           icon: Iconz.saveOn,
//                           iconSizeFactor: 0.7,
//                           barType: barType,
//                           onTap: () => goToSavesScreen(context),
//                         ),
//
//                       _spacer,
//
//                       /// QUESTION
//                       NavBarButton(
//                         size: navBarButtonWidth,
//                         text: superPhrase(context, 'phid_question'),
//                         icon: Iconz.utPlanning,
//                         iconSizeFactor: 0.45,
//                         barType: barType,
//                         onTap: () => goToQuestionsScreen(context),
//                       ),
//
//                       _spacer,
//
//                       // /// BZZ BUTTON
//                       // if (UserModel.checkUserIsAuthor(_myUserModel) && _userIsSignedIn == true)
//                       //   const MyBzzNavButton(),
//
//                       _spacer,
//
//                       const MyProfileButton(),
//
//                       _halfSpacer,
//
//                     ],
//                   ),
//
//                 ],
//               ),
//             ),
//
//             // _expander,
//             //
//             // /// IOS balance container
//             // if (_deviceIsIOS)
//             //   Container(
//             //     width: _circleWidth,
//             //     height: _circleWidth,
//             //     margin: const EdgeInsets.all(Ratioz.appBarPadding),
//             //   ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
