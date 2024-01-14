// import 'package:basics/bldrs_theme/classes/colorz.dart';
// import 'package:basics/bldrs_theme/classes/iconz.dart';
// import 'package:basics/components/bubbles/bubble/bubble.dart';
// import 'package:basics/helpers/space/borderers.dart';
// import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
// import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
// import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
// import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
// import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
// import 'package:flutter/material.dart';
//
// class TargetProgressBar extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const TargetProgressBar({
//     required this.target,
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   final TargetModel target;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     final double _bubbleClearWidth = Bubble.clearWidth(context: context) - 10;
//     const double _titleBoxHeight = 30;
//     final double _progressBoxWidth = _bubbleClearWidth / 2 - 30;
//     const double _barHeight = 12;
//     const double _iconsHeight = 15;
//     const EdgeInsets _barMargin = EdgeInsets.only(top: 9);
//     final Progress _progress = target.progress;
//     // --------------------
//     return Container(
//       width: _progressBoxWidth,
//       height: _titleBoxHeight,
//       alignment: Alignment.center,
//       margin: const EdgeInsets.all(5),
//       child: Stack(
//
//         children: <Widget>[
//
//           /// BAR
//           Align(
//             child: Stack(
//               alignment: Alignment.center,
//               children: <Widget>[
//                 /// BASE BAR
//                 Container(
//                   width: _progressBoxWidth,
//                   height: _barHeight,
//                   margin: _barMargin,
//                   decoration: const BoxDecoration(
//                     color: Colorz.white20,
//                     borderRadius: Borderers.constantCornersAll5,
//                   ),
//                 ),
//
//                 /// PROGRESS BAR
//                 Align(
//                   alignment: BldrsAligners.superCenterAlignment(context),
//                   child: Container(
//                     width: _progressBoxWidth *
//                         (_progress.current / _progress.objective),
//                     height: _barHeight,
//                     margin: _barMargin,
//                     decoration: const BoxDecoration(
//                       color: Colorz.yellow255,
//                       borderRadius: Borderers.constantCornersAll5,
//                     ),
//                   ),
//                 ),
//
//                 /// PROGRESS TEXT
//                 Container(
//                   width: _progressBoxWidth,
//                   height: _barHeight,
//                   margin: const EdgeInsets.only(top: 9, left: 3, right: 3),
//                   child: BldrsText(
//                     verse: Verse.plain('${_progress?.current}/${_progress?.objective}'),
//                     size: 1,
//                     scaleFactor: 0.8,
//                     color: Colorz.black255,
//                     centered: false,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           /// ICONS
//           Align(
//             alignment: Alignment.topCenter,
//             child: SizedBox(
//               width: _progressBoxWidth,
//               height: _iconsHeight,
//               // color: Colorz.Black255,
//               child: Row(
//                 children: <Widget>[
//
//                   /// SLIDES
//                   BldrsBox(
//                     height: _iconsHeight,
//                     icon: Iconz.flyer,
//                     verse: Verse.plain('${target.reward.slides} ${word('phid_slides')}'),
//                     iconSizeFactor: 0.75,
//                     verseScaleFactor: 0.55,
//                     verseWeight: VerseWeight.thin,
//                     verseItalic: true,
//                     bubble: false,
//                   ),
//
//                   /// ANKHS
//                   BldrsBox(
//                     height: _iconsHeight,
//                     icon: Iconz.save,
//                     verse: Verse.plain('${target.reward.ankh} ${word('phid_ankhs')}'),
//                     iconSizeFactor: 0.75,
//                     verseScaleFactor: 0.55,
//                     verseWeight: VerseWeight.thin,
//                     verseItalic: true,
//                     bubble: false,
//                   ),
//
//                 ],
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     );
//     // --------------------
//   }
// /// --------------------------------------------------------------------------
// }
