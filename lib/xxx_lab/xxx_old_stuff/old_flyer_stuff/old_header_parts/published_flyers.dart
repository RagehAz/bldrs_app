// import 'package:bldrs/02_widgets/flyer/grids/old_flyers_grid.dart';
// import 'package:bldrs/02_widgets/flyer/header/mini_header/mini_header_items/mini_header_strip/mini_header_strip_items/labels/old_author_label.dart';
// import 'package:bldrs/view_brain.x_ui_stuff/colorz.dart';
// import 'package:flutter/material.dart';
//
// import '../../../old_flyer_data.dart';
//
// class PublishedFlyers extends StatelessWidget {
//   final double flyerBoxWidth;
//   final bool bzPageIsOn;
//   final String authorPic;
//   final String authorName;
//   final String authorTitle;
//   final int authorFlyersCount;
//   final int galleryCount;
//   final int bzConnects;
//   final String authorID;
//   // final List<FlyerData> flyersData;
//
//   PublishedFlyers({
//     @required this.flyerBoxWidth,
//     @required this.bzPageIsOn,
//     @required this.authorPic,
//     @required this.authorName,
//     @required this.authorTitle,
//     @required this.authorFlyersCount,
//     @required this.galleryCount,
//     @required this.bzConnects,
//     @required this.authorID,
//     // @required this.flyersData,
// });
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return
//     Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//
//         // --- AUTHOR LABEL
//         bzPageIsOn == false ? Container() :
//         Container(
//           width: flyerBoxWidth,
//           height: flyerBoxWidth * 0.2,
//           color: Colorz.bzPageBGColor,
//           alignment: Alignment.center,
//           child: AuthorLabel(
//             bzPageIsOn: bzPageIsOn,
//             flyerBoxWidth: flyerBoxWidth,
//             authorPic: authorPic,
//             authorName: authorName,
//             authorTitle: authorTitle,
//             flyerShowsAuthor: true,
//             followersCount: 0,
//             galleryCount: galleryCount,
//             bzConnects: bzConnects,
//             authorFlyers: 111111,
//             authorID: authorID,
//           ),
//         ),
//
//         // bzPageIsOn == false ? Container() :
//         // FlyersGrid(
//         //   gridZoneWidth: flyerBoxWidth,
//         //   flyersData: flyersData,
//         // ),
//
//       ],
//     )
//     ;
//   }
// }
