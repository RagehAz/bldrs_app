// import 'package:bldrs/a_models/kw/specs/spec_model.dart';
// import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
// import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
// import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class SpecsBubble extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const SpecsBubble({
//     @required this.title,
//     @required this.specs,
//     @required this.selectedWords,
//     @required this.addButtonIsOn,
//     this.verseSize = 2,
//     this.onTap,
//     this.bubbleColor = Colorz.white20,
//     this.bubbleWidth,
//     this.margins,
//     this.corners,
//     this.passKeywordOnTap = false,
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final String title;
//   final List<SpecModel> specs;
//   final int verseSize;
//   final Function onTap;
//   final Color bubbleColor;
//   final List<dynamic> selectedWords;
//   final double bubbleWidth;
//   final dynamic margins;
//   final dynamic corners;
//   final bool passKeywordOnTap;
//   final bool addButtonIsOn;
//
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     /// the keyword bottom bubble corner when set in flyer info page
//     final double _bottomPadding = (bubbleWidth * Ratioz.xxflyerBottomCorners) -
//         Ratioz.appBarPadding -
//         Ratioz.appBarMargin;
//
//     return Bubble(
//       key: key,
//       bubbleColor: bubbleColor,
//       margins: margins,
//       corners: corners,
//       actionBtIcon: Iconz.gears,
//       title: title,
//       width: bubbleWidth,
//       bubbleOnTap: passKeywordOnTap == true ? null : onTap,
//       columnChildren: <Widget>[
//         /// STRINGS
//         if (Mapper.canLoopList(specs))
//           ...List<Widget>.generate(specs?.length, (int index) {
//             final SpecModel _spec = specs[index];
//
//             return DataStrip(
//                 dataKey: _spec.specsListID, dataValue: _spec.value);
//           }),
//
//         // if(Mapper.canLoopList(specs) && addButtonIsOn == true)
//         //   AddKeywordsButton(
//         //     onTap: passKeywordOnTap == true ? null : onTap,
//         //   ),
//
//         Container(
//           height: _bottomPadding,
//         ),
//       ],
//     );
//   }
// }
