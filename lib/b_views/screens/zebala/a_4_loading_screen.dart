// import 'dart:async';
//
// import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
// import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
// import 'package:bldrs/f_helpers/router/route_names.dart';
// import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/a_models/kw/section_class.dart' as SectionClass;
// import 'package:bldrs/a_models/user/user_model.dart';
// import 'package:bldrs/d_providers/bzz_provider.dart';
// import 'package:bldrs/d_providers/flyers_provider.dart';
// import 'package:bldrs/d_providers/general_provider.dart';
// import 'package:bldrs/d_providers/keywords_provider.dart';
// import 'package:bldrs/d_providers/user_provider.dart';
// import 'package:bldrs/b_views/widgets/general/artworks/bldrs_name_logo_slogan.dart';
// import 'package:bldrs/b_views/widgets/general/bubbles/bzz_bubble.dart';
// import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/b_views/widgets/general/loading/loading_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class LoadingScreen extends StatefulWidget {
//
//   const LoadingScreen({
//     Key key
//   }) : super(key: key);
//
//   @override
//   _LoadingScreenState createState() => _LoadingScreenState();
// }
//
// class _LoadingScreenState extends State<LoadingScreen> {
//   List<BzModel> _sponsors;
//   // bool _canContinue = false;
//   double _progress = 0;
// // -----------------------------------------------------------------------------
//   /// --- FUTURE LOADING BLOCK
//   bool _loading = false;
//   Future <void> _triggerLoading({Function function}) async {
//
//     if (function == null){
//       setState(() {
//         _loading = !_loading;
//       });
//     }
//
//     else {
//       setState(() {
//         _loading = !_loading;
//         function();
//       });
//     }
//
//     _loading == true?
//     blog('LOADING--------------------------------------') : blog('LOADING COMPLETE--------------------------------------');
//   }
// // -----------------------------------------------------------------------------
//   void _increaseProgressTo(double percent){
//     setState(() {
//       _progress = percent;
//     });
//   }
// // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//
//   }
// // -----------------------------------------------------------------------------
//   /// this method of fetching provided data allows listening true or false,
//   /// both working one  & the one with delay above in initState does not allow listening,
//   /// i will go with didChangeDependencies as init supposedly works only at start
//   ///
//   /// TASK : if device has no connection,, it should detect and notify me
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       _triggerLoading();
//
//       final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: true);
//       final UserModel _userModel = _userProvider.myUserModel;
//
//       if (FireAuthOps.userIsSignedIn() == true && _userModel != null){
//
//         final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
//         final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
//         final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
//         final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);
//
//         blog('x - fetching sponsors');
//         _triggerLoading().then((_) async {
//
//           await _generalProvider.getsetAppState(context);
//
//           await _bzzProvider.fetchSponsors(context);
//
//
//           setState(() {
//             _sponsors = _bzzProvider.sponsors;
//             _progress = 40;
//           });
//
//           await _keywordsProvider.getsetAllKeywords(context);
//
//           blog('x - fetching UserBzz');
//           await _bzzProvider.getSetMyBzz(context);
//           _increaseProgressTo(80);
//
//           // TASK : should get only first 10 saved tiny flyers,, and continue paginating when entering the savedFlyers screen
//           await _flyersProvider.getsetSavedFlyers(context);
//           _increaseProgressTo(85);
//
//           /// TASK : should get only first 10 followed tiny bzz, then paginate in all when entering followed bzz screen
//           await _bzzProvider.fetchFollowedBzz(context);
//           _increaseProgressTo(95);
//
//           /// TASK : wallahi mana 3aref hane3mel eh hena
//           final SectionClass.Section _currentSection = _generalProvider.currentSection;
//           await _flyersProvider.getsetWallFlyersBySectionAndKeyword(
//             context: context,
//             section: _currentSection,
//             kw: null,
//           );
//           _increaseProgressTo(99);
//
//
//           await _generalProvider.changeSection(
//             context: context,
//             section: _generalProvider.currentSection,
//             kw: null,
//           );
//
//           setState(() {
//             // _canContinue = true;
//             _progress = 100;
//           });
//
//           await Nav.goToRoute(context, Routez.home);
//
//           unawaited(_triggerLoading());
//
//         });
//
//
//       } else {
//
//         blog('estanna m3ana shwaya');
//
//       }
//
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }
// // -----------------------------------------------------------------------------
//
//
//   @override
//   Widget build(BuildContext context) {
//     blog('-------------- Starting Loading screen --------------');
//
//     return MainLayout(
//       key: const ValueKey<String>('mainLayout'),
//       pyramids: Iconz.pyramidzYellow,
//       appBarType: AppBarType.non,
//       loading: _loading,
//       layoutWidget: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//
//         children: <Widget>[
//
//           const Expander(),
//
//           const LogoSlogan(
//             showSlogan: true,
//             sizeFactor: 0.7,
//           ),
//
//           // Stratosphere(heightFactor: 0.5),
//
//           BzzBubble(
//             bzzModels: _sponsors,
//             numberOfColumns: 3,
//             title: 'Sponsored by',
//             scrollDirection: Axis.vertical,
//             corners: Ratioz.appBarCorner * 2,
//           ),
//
//           const Expander(),
//
//           /// PROGRESS BAR
//           // if(_progress != 0)
//           GestureDetector(
//             onTap: () => Nav.goBackToUserChecker(context),
//             child: LoadingBar(
//               progress: _progress,
//             ),
//           ),
//
//           // const PyramidsHorizon(),
//         ],
//       ),
//     );
//   }
// }
