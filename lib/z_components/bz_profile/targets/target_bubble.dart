// import 'package:basics/bldrs_theme/classes/colorz.dart';
// import 'package:basics/bubbles/bubble/bubble.dart';
// import 'package:basics/helpers/classes/space/borderers.dart';
// import 'package:bldrs/a_models/b_bz/sub/target/target_model.dart';
// import 'package:bldrs/a_models/b_bz/sub/target/target_progress.dart';
// import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
// import 'package:bldrs/z_components/bz_profile/targets/target_progress_bar.dart';
// import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
// import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
// import 'package:flutter/material.dart';
// import 'package:basics/helpers/classes/space/scale.dart';
//
// class TargetCard extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const TargetCard({
//     required this.target,
//     required this.onClaimTap,
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   final TargetModel target;
//   final Function onClaimTap;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     final double _bubbleClearWidth = Bubble.clearWidth(context: context) - 10;
//     // final double _titleBoxWidth = _bubbleClearWidth / 2 + 20;
//     // const double _titleBoxHeight = 30;
//     final Progress _progress = target.progress;
//     final bool _targetReached = _progress.current == _progress.objective;
//     // --------------------
//     return Container(
//       width: _bubbleClearWidth,
//       decoration: const BoxDecoration(
//         color: Colorz.white20,
//         borderRadius: Borderers.constantCornersAll20,
//       ),
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//
//           /// TITLE
//           BldrsText(
//             verse: Verse(
//               id: target.name,
//               translate: true,
//             ),
//             centered: false,
//             margin: 5,
//             color: Colorz.yellow255,
//             size: 3,
//             maxLines: 2,
//           ),
//
//           /// DESCRIPTION
//           BldrsText(
//             verse: Verse(
//               id: target.description,
//               translate: true,
//             ),
//             centered: false,
//             weight: VerseWeight.thin,
//             maxLines: 10,
//             margin: 5,
//           ),
//
//           /// PROGRESS
//           TargetProgressBar(
//             target: target,
//           ),
//
//
//           /// INSTRUCTIONS
//           if (
//           target.instructions != null &&
//               target.instructions.isNotEmpty &&
//               _targetReached == false
//           )
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//
//                 const BldrsText(
//                   verse: Verse(
//                     id: 'phid_instructions',
//                     translate: true,
//                   ),
//                   size: 3,
//                   color: Colorz.blue255,
//                   italic: true,
//                   weight: VerseWeight.thin,
//                   margin: 10,
//                 ),
//
//                 ListView.builder(
//                     itemCount: target.instructions.length,
//                     physics: const NeverScrollableScrollPhysics(),
//                     padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
//                     shrinkWrap: true,
//
//                     itemBuilder: (_, index) {
//                       return BldrsText(
//                         verse: Verse(
//                           id: target.instructions[index],
//                           translate: true,
//                         ),
//                         leadingDot: true,
//                         centered: false,
//                         maxLines: 5,
//                         margin: 2,
//                         weight: VerseWeight.thin,
//                         italic: true,
//                         color: Colorz.blue255,
//                       );
//                     }),
//
//               ],
//             ),
//
//           /// CLAIM BUTTON
//           if (_targetReached == true)
//             Align(
//               child: BldrsBox(
//                 width: _bubbleClearWidth,
//                 height: 70,
//                 verse: Verse(
//                   id: '#!# CLAIM ${target.reward.slides} Slides ',
//                   translate: true,
//                   variables: target.reward.slides,
//                 ),
//                 verseWeight: VerseWeight.black,
//                 verseItalic: true,
//                 color: Colorz.yellow255,
//                 verseColor: Colorz.black255,
//                 onTap: onClaimTap,
//               ),
//             ),
//         ],
//       ),
//     );
//     // --------------------
//   }
// /// --------------------------------------------------------------------------
// }
