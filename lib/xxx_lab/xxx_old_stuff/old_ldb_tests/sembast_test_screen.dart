// import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
// import 'package:bldrs/b_views/widgets/general/layouts/testing_layout.dart';
// import 'package:bldrs/b_views/widgets/general/textings/unfinished_super_verse.dart';
// import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
// import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
// import 'package:bldrs/e_db/ldb/sembast_api.dart';
// import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
// import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/xxx_dashboard/ldb_manager/ldb_viewer_screen.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// class SembastReaderTestScreen extends StatefulWidget {
//   const SembastReaderTestScreen({Key key}) : super(key: key);
//
//   @override
//   _SembastReaderTestScreenState createState() => _SembastReaderTestScreenState();
// }
//
// class _SembastReaderTestScreenState extends State<SembastReaderTestScreen> {
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
//     super.didChangeDependencies();
//
//     if (_isInit) {
//       _triggerLoading().then((_) async {
//         await _readSembast();
//       });
//     }
//     _isInit = false;
//   }
//
// // -----------------------------------------------------------------------------
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
// // -----------------------------------------------------------------------------
//   Future<void> _search() async {
//     final List<Map<String, dynamic>> _result = await LDBOps.searchTrigram(
//         searchValue: 'Cairo', docName: LDBDoc.cities, lingoCode: 'en');
//
//     Mapper.printMaps(_result);
//   }
//
// // -----------------------------------------------------------------------------
//   List<Map<String, Object>> _tinyFlyersMaps;
//   Future<void> _readSembast() async {
//     final List<Map<String, Object>> _maps = await Sembast.readAll(
//       docName: LDBDoc.cities,
//     );
//
//     setState(() {
//       _tinyFlyersMaps = _maps;
//       _loading = false;
//     });
//   }
//
// // -----------------------------------------------------------------------------
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return TestingLayout(
//       screenTitle: 'Sembast test',
//       appbarButtonVerse: 'thing',
//       appbarButtonOnTap: () {
//         blog('fuck this bobo');
//       },
//       listViewWidgets: <Widget>[
//         /// LDB Buttons
//         Row(
//           children: <Widget>[
//             /// READ AL  LDB
//             SmallFuckingButton(
//               verse: 'read all',
//               onTap: _readSembast,
//             ),
//
//             /// REPLACE FROM LDB
//             SmallFuckingButton(
//               verse: 'Search',
//               onTap: _search,
//             ),
//           ],
//         ),
//
//         if (Mapper.canLoopList(_tinyFlyersMaps))
//           ...LDBViewerScreen.rows(
//             context: context,
//             color: Colorz.green125,
//             primaryKey: 'flyerID',
//             maps: _tinyFlyersMaps,
//             onRowTap: null,
//           ),
//       ],
//     );
//   }
// }
//
// class SmallFuckingButton extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const SmallFuckingButton({
//     @required this.verse,
//     @required this.onTap,
//     Key key,
//   }) : super(key: key);
//
//   /// --------------------------------------------------------------------------
//   final String verse;
//   final Function onTap;
//
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     final double _screenWidth = Scale.superScreenWidth(context);
//     final double _buttonWidth = _screenWidth / 8;
//
//     return DreamBox(
//       height: 30,
//       width: _buttonWidth,
//       color: Colorz.blue80,
//       margins: const EdgeInsets.symmetric(horizontal: 1),
//       verse: verse,
//       verseScaleFactor: 0.4,
//       verseWeight: VerseWeight.thin,
//       verseMaxLines: 2,
//       onTap: onTap,
//     );
//   }
//
//   /// --------------------------------------------------------------------------
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(StringProperty('verse', verse));
//     properties.add(DiagnosticsProperty<Function>('onTap', onTap));
//   }
//
//   /// --------------------------------------------------------------------------
// }
