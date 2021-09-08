// import 'package:bldrs/02_widgets/flyer/old_flyer_data.dart';
// import 'package:bldrs/02_widgets/flyer/grids/flyers_grid.dart';
// import 'package:bldrs/02_widgets/in_pyramids/in_pyramids_items/bubble.dart';
// import 'package:bldrs/02_widgets/textings/super_verse.dart';
// import 'package:bldrs/view_brain.x_ui_stuff/colorz.dart';
// import 'package:bldrs/view_brain.x_ui_stuff/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class SavedCollection extends StatelessWidget {
//   final List<FlyerData> collectionFlyers;
//   final String collectionName;
//   final List<String> keyWords;
//
//   SavedCollection({
//     @required this.collectionFlyers,
//     @required this.collectionName,
//     @required this.keyWords,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     double screenWidth = MediaQuery.of(context).size.width;
//     double pageMargin = Ratioz.ddAppBarMargin * 2;
//
//     return InPyramidsBubble(
//       centered: false,
//       columnChildren: <Widget>[
//
//         // --- COLLECTION TITLE
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: EdgeInsets.only(
//                 left: pageMargin, right: pageMargin, top: pageMargin),
//             child: SuperVerse(
//               verse: collectionName,
//               centered: false,
//               size: 3,
//               italic: true,
//               margin: screenWidth * 0.0,
//               shadow: true,
//             ),
//           ),
//         ),
//
//         // --- COLLECTION KEYWORDS
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: pageMargin),
//           child: Wrap(
//               spacing: 0,
//               runSpacing: 0,
//               alignment: WrapAlignment.start,
//               crossAxisAlignment: WrapCrossAlignment.start,
//               direction: Axis.horizontal,
//               runAlignment: WrapAlignment.start,
//               children: List<Widget>.generate(keyWords.length, (int index) {
//                 return SuperVerse(
//                   verse: keyWords[index],
//                   italic: true,
//                   shadow: false,
//                   labelColor: Colorz.BabyBlueSmoke,
//                   color: Colorz.White,
//                   weight: 'thin',
//                   size: 1,
//                 );
//               })),
//         ),
//
//         // --- FLYERS
//         FlyersGrid(
//           flyersData: collectionFlyers,
//           gridZoneWidth: screenWidth - pageMargin * 4,
//           numberOfColumns: 5,
//         ),
//
//       ],
//     );
//   }
// }
