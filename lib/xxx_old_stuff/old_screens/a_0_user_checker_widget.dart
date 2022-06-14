// import 'dart:async';
// import 'package:bldrs/a_models/user/user_model.dart';
// import 'package:bldrs/b_views/widgets/general/artworks/bldrs_name_logo_slogan.dart';
// import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/d_providers/ui_provider.dart';
// import 'package:bldrs/e_db/fire/ops/old_auth_ops.dart' as FireAuthOps;
// import 'package:bldrs/f_helpers/drafters/tracers.dart' as Tracer;
// import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// /// TASK : if appNeedsUpdate = true ? goTO(AppStore) : check the user as you wish
// /// TASK : if device is offline
// /// and we get this value from database and to be controlled from dashboard
// class UserChecker extends StatefulWidget {
//   const UserChecker({Key key}) : super(key: key);
//
//   @override
//   _UserCheckerState createState() => _UserCheckerState();
// }
//
// class _UserCheckerState extends State<UserChecker> {
//   bool _isInit = true;
//   bool _logoIsShown = false;
// // -----------------------------------------------------------------------------
// //   /// --- FUTURE LOADING BLOCK
// //   bool _loading = false;
// //   Future <void> _triggerLoading({Function function}) async {
// //
// //     if (mounted){
// //
// //       if (function == null){
// //         setState(() {
// //           _loading = !_loading;
// //         });
// //       }
// //
// //       else {
// //         setState(() {
// //           _loading = !_loading;
// //           function();
// //         });
// //       }
// //
// //     }
// //
// //     _loading == true?
// //     blog('LOADING--------------------------------------') : blog('LOADING COMPLETE--------------------------------------');
// //   }
// // -----------------------------------------------------------------------------
//   UiProvider _uiProvider;
//   @override
//   void initState() {
//     _uiProvider = Provider.of<UiProvider>(context, listen: false);
//
//     super.initState();
//   }
//
// // -----------------------------------------------------------------------------
//   @override
//   void didChangeDependencies() {
//     if (_isInit && mounted) {
//       blog('userChecker 1 : trigger loading');
//       _uiProvider.triggerLoading();
//
//       _showLogo().then((_) async {
//         blog('User is signed in : ${FireAuthOps.userIsSignedIn()}');
//
//         //     /// A - if user is signed in
//         //     if (FireAuthOps.userIsSignedIn() == true) {
//         //
//         //       final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
//         //       await _userProvider.getsetMyUserModel(context: context);
//         //       final UserModel _userModel = _userProvider.myUserModel;
//         //
//         //       /// B -  if user has a userModel
//         //       if (_userModel != null && mounted == true) {
//         //
//         //         /// fetch and set country and zone
//         //         final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
//         //         await zoneProvider.getsetCurrentZoneAndCountryAndCity(context: context, zone: _userModel.zone);
//         //         await zoneProvider.getsetUserCountryAndCity(context: context, zone: _userModel.zone);
//         //         await zoneProvider.getsetContinentByCountryID(context: context, countryID: _userModel.zone.countryID);
//         //
//         //         /// check if user model is properly completed
//         //         final List<String> _missingFields = UserModel.missingFields(_userModel);
//         //         blog(' _missingFields : $_missingFields');
//         //
//         //         /// C - if userModel is completed
//         //         if (_missingFields.isEmpty) {
//         //           unawaited(_triggerLoading());
//         //
//         //           /// XX - userModel is completed : go to LoadingScreen()
//         //           blog('userModel is completed : go to LoadingScreen()');
//         //           // var _result = await Nav.goToNewScreen(context, LoadingScreen(), transitionType: PageTransitionType.fade);
//         //           await Nav.goToNewScreen(context, const LoadingScreen(), transitionType: PageTransitionType.fade);
//         //
//         //           blog('user has a completed userModel and was in home screen and came back to user checker, and this should not happen, at home page you can not go back to userChecker or loading screen man');
//         //           /// so we loop once more to user check
//         //           await Nav.pushNamedAndRemoveAllBelow(context, Routez.userChecker);
//         //         }
//         //
//         //         /// C - if userModel is not completed
//         //         else {
//         //           unawaited(_triggerLoading());
//         //
//         //           /// pop a dialog
//         //           await CenterDialog.showCenterDialog(
//         //             context: context,
//         //             title: 'Ops!',
//         //             body: 'You have to complete your profile info\n ${_missingFields.toString()}',
//         //           );
//         //
//         //           /// route to complete profile missing data
//         //           await Nav.goToNewScreen(context, EditProfileScreen(
//         //             user: _userModel,),);
//         //
//         //           /// after returning from edit profile, we go to LoadingScreen()
//         //           blog('user has completed profile and good to go to LoadingScreen()');
//         //           // var _result = await Nav.goToNewScreen(context, LoadingScreen(), transitionType: PageTransitionType.fade);
//         //           await Nav.goToNewScreen(context, const LoadingScreen(), transitionType: PageTransitionType.fade);
//         //
//         //         }
//         //
//         //       }
//         //
//         //       /// B - if user has no userModel
//         //       else {
//         //
//         //       unawaited(_triggerLoading());
//         //
//         //       /// route to complete profile missing data
//         //       await Nav.goToNewScreen(context, EditProfileScreen(
//         //         user: _userModel, firstTimer: true,),);
//         //
//         //       /// after returning from creating profile, we go to LoadingScreen()
//         //       final dynamic _result = await Nav.goToNewScreen(context, const LoadingScreen(), transitionType: PageTransitionType.fade);
//         //       blog('user has created profile and good to go to LoadingScreen() : _result : $_result');
//         //
//         //     }
//         //
//         // }
//         //
//         //     /// A - if user is not signed in
//         //     else {
//         //       unawaited(_triggerLoading());
//         //
//         //       /// route to sign in
//         //       final dynamic _result = await Nav.goToNewScreen(context, const StartingScreen(), transitionType: PageTransitionType.fade);
//         //
//         //       blog('just came back from starting screen : _result : $_result');
//         //
//         //       /// and we loop again in userChecker
//         //       await Nav.pushNamedAndRemoveAllBelow(context, Routez.userChecker);
//         //
//         //     }
//       });
//     }
//
//     _isInit = false;
//     super.didChangeDependencies();
//   }
//
// // -----------------------------------------------------------------------------
//   Future<void> _showLogo() async {
//     setState(() {
//       _logoIsShown = true;
//     });
//   }
// // -----------------------------------------------------------------------------
// //   void _exitApp(BuildContext context) {
// //     Nav.goBack(context);
// //   }
//
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     final UserModel _userProvided = Provider.of<UserModel>(context);
//     // List<String> _missingFields = UserModel.missingFields(_userProvided);
//
//     Tracer.traceWidgetBuild(
//         widgetName: 'UserChecker',
//         varName: 'userID',
//         varValue: _userProvided?.id);
//     return Container(
//       key: widget.key,
//       child: MainLayout(
//         key: const ValueKey<String>('mainLayout'),
//         loading: true,
//         pyramids: Iconz.pyramidzYellow,
//         appBarType: AppBarType.non,
//         layoutWidget: _logoIsShown == true
//             ? const Center(child: LogoSlogan(sizeFactor: 0.8))
//             : Container(),
//       ),
//     );
//
//     // /// when the user is null after sign out, or did not auth yet
//     //   _userProvided?.userID == null ?
//     //   WillPopScope(
//     //     onWillPop: () => Future.value(true),
//     //     child: StartingScreen(
//     //       // exitApp: () =>_exitApp(context),
//     //     ),
//     //   )
//     //
//     //   // :
//     //   //
//     //   // /// when user has his account not finished
//     //   // _missingFields.length != 0 ?
//     //   // EditProfileScreen(user: _userProvided, firstTimer: false,)
//     //
//     //       :
//     //
//     //   /// when user is valid to enter home screen, start loading screen then home
//     //   LoadingScreen();
//
//     // }
//   }
// }
