// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
// import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/a_flyer_starter.dart';
// import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// List<int> otherFlyers = <int>[
//   0,
//   1,
//   2,
//   3,
//   4,
//   5,
//   6,
//   7,
//   8,
//   9,
// ];
//
// /// this flyers Collection is used in main layouts
// /// Grid of flyers are put in the bubble and showing one main flyer as a cover
// class FlyerCoversStack extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const FlyerCoversStack({
//     @required this.flyersDataList,
//     @required this.collectionTitle,
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final List<FlyerModel> flyersDataList;
//   final String collectionTitle;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final double screenWidth = MediaQuery.of(context).size.width;
//     const double pageMargin = Ratioz.appBarMargin * 2;
//
//     const double coverFlyerWidth = 100;
//     const double coverFlyerHeight = coverFlyerWidth * Ratioz.xxflyerZoneHeight;
//
//     const double gridSpacing = 5;
//     final double gridWidth = screenWidth - (4 * pageMargin) - gridSpacing;
//     const double gridHeight = coverFlyerHeight;
//
//     const double otherFlyersHeight = (coverFlyerHeight - gridSpacing) / 2;
//     const double otherFlyersWidth =
//         otherFlyersHeight / Ratioz.xxflyerZoneHeight;
//
//     final int gridLoopLength =
//         flyersDataList.length > 11 ? 11 : flyersDataList.length;
//
//     return Bubble(
//         centered: true,
//         bubbleColor: Colorz.white10,
//         title: collectionTitle,
//         columnChildren: <Widget>[
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//
//               SizedBox(
//                 width: coverFlyerWidth,
//                 height: coverFlyerHeight,
//                 child: FlyerStarter(
//                   minWidthFactor: FlyerBox.sizeFactorByWidth(context, coverFlyerWidth),
//                   flyerModel: flyersDataList[0],
//                 ),
//               ),
//
//               Expanded(
//                 child: SizedBox(
//                   width: gridWidth,
//                   height: gridHeight,
//                   child: Center(
//                     child: GridView(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       padding: const EdgeInsets.all(gridSpacing),
//                       gridDelegate:
//                           const SliverGridDelegateWithMaxCrossAxisExtent(
//                         crossAxisSpacing: gridSpacing,
//                         mainAxisSpacing: gridSpacing,
//                         childAspectRatio: otherFlyersWidth / otherFlyersHeight,
//                         maxCrossAxisExtent: otherFlyersWidth,
//                       ),
//                       children: <Widget>[
//
//                         for (int index = 1; index < gridLoopLength; index++)
//
//                           FlyerStarter(
//                             minWidthFactor: FlyerBox.sizeFactorByWidth(context, otherFlyersWidth),
//                             flyerModel: flyersDataList[index],
//                           ),
//
//                       ],
//
//                       // )
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ]
//     );
//   }
// }
//
// class TopFlyersStack extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const TopFlyersStack({
//     @required this.flyersDataList,
//     @required this.collectionTitle,
//     this.numberOfFlyers = 3,
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final List<FlyerModel> flyersDataList;
//   final String collectionTitle;
//   final int numberOfFlyers;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final double screenWidth = MediaQuery.of(context).size.width;
//     const double pageMargin = Ratioz.appBarMargin * 2;
//
//     const double gridSpacing = 5;
//
//     final double gridWidth = screenWidth - (4 * pageMargin);
//
//     final double flyerWidth = (gridWidth - (numberOfFlyers * gridSpacing) - gridSpacing) / numberOfFlyers;
//     final double flyerHeight = flyerWidth * Ratioz.xxflyerZoneHeight;
//
//     final double gridHeight = flyerHeight;
//
//     final int gridLoopLength = flyersDataList.length > numberOfFlyers ?
//     numberOfFlyers
//         :
//     flyersDataList.length;
//
//     return Bubble(
//         bubbleColor: Colorz.white10,
//         title: collectionTitle,
//         columnChildren: <Widget>[
//
//           Container(
//             width: gridWidth,
//             height: gridHeight,
//             alignment: Alignment.center,
//             child: Center(
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 itemExtent: flyerWidth + gridSpacing,
//                 children: <Widget>[
//                   for (int index = 0; index < gridLoopLength; index++)
//
//                     FlyerStarter(
//                       minWidthFactor: FlyerBox.sizeFactorByWidth(context, flyerWidth),
//                       flyerModel: flyersDataList[index],
//                     ),
//
//                 ],
//               ),
//             ),
//           ),
//         ]);
//   }
// }
