// import 'package:bldrs/controllers/drafters/borderers.dart';
// import 'package:bldrs/controllers/drafters/scalers.dart';
// import 'package:bldrs/controllers/drafters/text_shapers.dart';
// import 'package:bldrs/controllers/theme/colorz.dart';
// import 'package:bldrs/controllers/theme/flyer_keyz.dart';
// import 'package:bldrs/controllers/theme/iconz.dart';
// import 'package:bldrs/controllers/theme/ratioz.dart';
// import 'package:bldrs/views/widgets/buttons/dream_box.dart';
// import 'package:bldrs/views/widgets/layouts/dream_list.dart';
// import 'package:bldrs/views/widgets/nav_bar/bar_button.dart';
// import 'package:bldrs/views/widgets/nav_bar/nav_bar.dart';
// import 'package:bldrs/views/widgets/textings/super_verse.dart';
// import 'package:flutter/material.dart';
//
// class FlyersBrowser extends StatefulWidget {
//   const FlyersBrowser({Key key}) : super(key: key);
//
//   @override
//   _FlyersBrowserState createState() => _FlyersBrowserState();
// }
//
// class _FlyersBrowserState extends State<FlyersBrowser> {
//   List<String> _keywords = [];
//   bool _browserIsOn = false;
//   String _currentFilter;
//   ScrollController _scrollController = new ScrollController();
// // -----------------------------------------------------------------------------
//   void _triggerBrowser() {
//     setState(() {
//       _browserIsOn = !_browserIsOn;
//     });
//   }
// // -----------------------------------------------------------------------------
//
//   @override
//   Widget build(BuildContext context) {
//
//     double _buttonPadding = _browserIsOn == true ? Ratioz.ddAppBarPadding * 1.5 : Ratioz.ddAppBarPadding * 1.5;
//
//     double _browserMinZoneHeight = 40 + _buttonPadding * 2 + superVerseRealHeight(context, 0, 0.95, null);
//     double _browserMaxZoneHeight = Scale.superScreenHeight(context) * 0.38;
//
//     double _browserMinZoneWidth = 40 + _buttonPadding * 2;
//     double _browserMaxZoneWidth = Scale.superScreenWidth(context);
//
//     double _browserZoneHeight = _browserIsOn == true ? _browserMaxZoneHeight : _browserMinZoneHeight;
//     double _browserZoneWidth = _browserIsOn == true ? _browserMaxZoneWidth : _browserMinZoneWidth;
//     double _browserZoneMargins = _browserIsOn == true ? 0 : _buttonPadding;
//     BorderRadius _browserZoneCorners = _browserIsOn == true ? null : Borderers.superBorderAll(context, Ratioz.ddAppBarCorner);
//
//     double _browserScrollZoneWidth = _browserIsOn == true ? _browserZoneWidth - _buttonPadding * 2 : _browserMinZoneWidth;
//     double _browserScrollZoneHeight = _browserZoneHeight - _buttonPadding * 2;
//
//
//     double _filtersZoneWidth = _browserIsOn == true ? (_browserZoneWidth - (_buttonPadding * 3)) / 2 : 10;
//
//     print('_filtersZoneWidth : $_filtersZoneWidth');
//
//     List<Map<String, dynamic>> _filters = Keywordz.propertyFilters;
//
//     // Map<String, dynamic> _currentFilterMap = _filters.singleWhere((filterMap) => filterMap['title'] == _currentFilter, orElse: () => null);
//     // List<String> _currentFilterList = _currentFilterMap == null ? [] : _currentFilterMap['list'];
//
//     return Positioned(
//       bottom: 0,
//       left: 0,
//       child: GestureDetector(
//         onTap: _triggerBrowser,
//         child: AnimatedContainer(
//             height: _browserZoneHeight,
//             width: _browserZoneWidth,
//             duration: Duration(seconds: 1),
//
//             curve: Curves.easeInOut,
//             decoration: BoxDecoration(
//               borderRadius: _browserZoneCorners,
//               color: Colorz.BloodRedZircon,
//
//             ),
//             margin: EdgeInsets.all(_browserZoneMargins),
//             alignment: Alignment.center,
//             child:
//
//         ),
//       ),
//     );
//   }
// }
