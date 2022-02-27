// import 'dart:async';
// import 'package:bldrs/b_views/widgets/general/chain_expander/components/bldrs_chains.dart';
// import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/b_views/z_components/layouts/navigation/unfinished_max_bounce_navigator.dart';
// import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class ExpansionTilesTest extends StatefulWidget {
//   const ExpansionTilesTest({Key key}) : super(key: key);
//
//   @override
//   _ExpansionTilesTestState createState() => _ExpansionTilesTestState();
// }
//
// class _ExpansionTilesTestState extends State<ExpansionTilesTest> {
//   // List<int> _list = <int>[1,2,3,4,5,6,7,8];
//   // int _loops = 0;
//   // Color _color = Colorz.BloodTest;
//   // SuperFlyer _flyer;
//   // bool _thing;
// // -----------------------------------------------------------------------------
//   /// --- FUTURE LOADING BLOCK
//   bool _loading = false;
//   Future<void> _triggerLoading({Function function}) async {
//     if (mounted) {
//       if (function == null) {
//         setState(() {
//           _loading = !_loading;
//         });
//       } else {
//         setState(() {
//           _loading = !_loading;
//           function();
//         });
//       }
//     }
//
//     _loading == true
//         ? blog('LOADING--------------------------------------')
//         : blog('LOADING COMPLETE--------------------------------------');
//   }
//
// // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//   }
//
// // -----------------------------------------------------------------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       _triggerLoading().then((_) async {
//         /// do Futures here
//
//         unawaited(_triggerLoading(function: () {
//           /// set new values here
//         }));
//       });
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }
// // -----------------------------------------------------------------------------
//
//   @override
//   Widget build(BuildContext context) {
// // -----------------------------------------------------------------------------
// //     double _screenWidth = Scale.superScreenWidth(context);
// //     double _screenHeight = Scale.superScreenHeight(context);
// // -----------------------------------------------------------------------------
//
//     // double _gWidth = _screenWidth * 0.4;
//     // double _gHeight = _screenWidth * 0.6;
//
//     // final double _buttonHeight = 40;
//     // final double _buttonWidth = _screenWidth - (2 * Ratioz.appBarMargin);
//
//     return MainLayout(
//       appBarType: AppBarType.basic,
//       pyramidsAreOn: true,
//       // loading: _loading,
//       appBarRowWidgets: const <Widget>[],
//       layoutWidget: Container(
//         width: 300,
//         height: Scale.superScreenHeight(context),
//         padding: const EdgeInsets.only(top: Ratioz.stratosphere),
//         child: OldMaxBounceNavigator(
//           child: ListView(
//             physics: const BouncingScrollPhysics(),
//             children: <Widget>[
//               Container(
//                 width: 300,
//                 height: Scale.superScreenHeight(context),
//                 color: Colorz.bloodTest,
//                 child: const BldrsChain(
//                   boxWidth: 300,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
