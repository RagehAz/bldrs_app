// import 'package:bldrs/models/bz/bz_model.dart';
// import 'package:bldrs/models/flyer/flyer_model.dart';
// import 'package:bldrs/models/flyer/tiny_flyer.dart';
// import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
// import 'package:flutter/material.dart';
//
// class Flyer extends StatelessWidget {
//   final double flyerZoneWidth;
//   final FlyerModel flyerModel;
//   final TinyFlyer tinyFlyer;
//   final int initialSlideIndex;
//   final Function onSwipeFlyer;
//   final bool goesToEditor;
//   final bool inEditor; // vs inView
//   final BzModel bzModel;
//   final String flyerID;
//   final Key key;
//
//   Flyer({
//     @required this.flyerZoneWidth,
//     this.flyerModel,
//     this.tinyFlyer,
//     this.initialSlideIndex = 0,
//     this.onSwipeFlyer,
//     this.goesToEditor = false,
//     this.inEditor = false,
//     this.bzModel,
//     this.flyerID,
//     this.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return FinalFlyer(
//     flyerZoneWidth: flyerZoneWidth,
//     flyerModel: flyerModel,
//     tinyFlyer: tinyFlyer,
//     initialSlideIndex: initialSlideIndex,
//     onSwipeFlyer: onSwipeFlyer,
//     goesToEditor: goesToEditor,
//     inEditor: inEditor,
//     bzModel: bzModel,
//     flyerID: flyerID,
//     key: key,
//     );
//
//   }
// }
