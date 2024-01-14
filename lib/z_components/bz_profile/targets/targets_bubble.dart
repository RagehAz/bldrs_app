// import 'package:basics/bldrs_theme/classes/colorz.dart';
// import 'package:bldrs/a_models/b_bz/sub/target/target_model.dart';
// import 'package:bldrs/z_components/bz_profile/targets/dialog_of_target_achievement.dart';
// import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
// import 'package:bldrs/z_components/bz_profile/targets/target_bubble.dart';
// import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
// import 'package:bldrs/f_helpers/theme/targetz.dart' as Targetz;
// import 'package:flutter/material.dart';
//
// class TargetsBubble extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const TargetsBubble({
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   static List<TargetModel> getAllTargets() {
//     final List<TargetModel> _allTargets =
//         Targetz.insertTargetsProgressIntoTargetsModels(
//       allTargets: Targetz.allTargets(),
//       targetsProgress: Targetz.dummyTargetsProgress(),
//     );
//
//     return _allTargets;
//   }
//   // -----------------------------------------------------------------------------
//   Future<void> _onClaimTap({
//     required BuildContext context,
//     required TargetModel target
//   }) async {
//     await DialogOfTargetAchievement.show(
//       context: context,
//       target: target,
//     );
//   }
//   // --------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final List<TargetModel> _allTargets = getAllTargets();
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Column(
//         children: <Widget>[
//
//           const BldrsText(
//             verse: Verse(
//               id: 'phid_targets_main_description',
//               translate: true,
//               pseudo: 'Achieving the below targets will put you on track, '
//                   'and will give you an idea how to use Bldrs.net to acquire '
//                   'new customers and boost potential sales.',
//             ),
//             maxLines: 10,
//             centered: false,
//             margin: 10,
//             color: Colorz.yellow255,
//             weight: VerseWeight.thin,
//           ),
//
//           ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: _allTargets.length,
//               shrinkWrap: true,
//               padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
//               itemBuilder: (ctx, index) {
//                 final TargetModel _target = _allTargets[index];
//
//                 return TargetCard(
//                   target: _target,
//                   onClaimTap: () => _onClaimTap(
//                       context: context,
//                       target: _target
//                   ),
//                 );
//
//               }),
//
//         ],
//       ),
//     );
//
//   }
//   // -----------------------------------------------------------------------------
// }
