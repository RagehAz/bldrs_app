// import 'package:basics/bldrs_theme/classes/colorz.dart';
// import 'package:bldrs/a_models/b_bz/sub/target/target_model.dart';
// import 'package:bldrs/z_components/bz_profile/targets/dialog_of_slides_and_ankhs.dart';
// import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
// import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
// import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
// import 'package:flutter/material.dart';
//
// class DialogOfTargetAchievement extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const DialogOfTargetAchievement({
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   static Future<void> show({
//     required BuildContext context,
//     required TargetModel target
//   }) async {
//
//     await CenterDialog.showCenterDialog(
//       titleVerse: const Verse(
//         id: 'phid_congrats',
//         translate: true,
//       ),
//       bodyVerse: Verse(
//         pseudo: 'You have achieved the ${target.name} target and your account increased\n${target.reward.slides} Slides & ${target.reward.ankh} Ankhs',
//         id: 'phid_target_achievement_congrats_description',
//         translate: true,
//         variables: [target.name, target.reward.slides, target.reward.ankh]
//       ),
//       confirmButtonVerse: const Verse(
//         id: 'phid_claim',
//         translate: true,
//       ),
//       child: Column(
//         children: <Widget>[
//           BldrsText(
//             verse: const Verse(
//               pseudo: 'To know more about Slides and Ankhs\nTap here',
//               id: 'phid_know_more_about_slides_and_ankhs',
//               translate: true,
//             ),
//             maxLines: 3,
//             weight: VerseWeight.thin,
//             italic: true,
//             size: 1,
//             color: Colorz.blue255,
//             labelColor: Colorz.white10,
//             onTap: () async {
//               await DialogOfSlidesAndAnkhs.show(
//                 context: context,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return Column(
//       children: <Widget>[
//         BldrsText(
//           verse: const Verse(
//             pseudo: 'To know more about Slides and Ankhs\nTap here',
//             id: 'phid_know_more_about_slides_and_ankhs',
//             translate: true,
//           ),
//           maxLines: 3,
//           weight: VerseWeight.thin,
//           italic: true,
//           size: 1,
//           color: Colorz.blue255,
//           labelColor: Colorz.white10,
//           onTap: () async {
//             await DialogOfSlidesAndAnkhs.show(
//               context: context,
//             );
//           },
//         ),
//       ],
//     );
//
//   }
//   /// --------------------------------------------------------------------------
// }
