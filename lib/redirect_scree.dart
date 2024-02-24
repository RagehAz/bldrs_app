// import 'package:basics/bldrs_theme/classes/colorz.dart';
// import 'package:basics/components/drawing/expander.dart';
// import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
// import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
// import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
// import 'package:flutter/material.dart';
//
// class RedirectScreen extends StatelessWidget {
//   // --------------------------------------------------------------------------
//   const RedirectScreen({
//     required this.path,
//     required this.arg,
//     super.key
//   });
//   // --------------------
//   final String? arg;
//   final String? path;
//   // --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     return MainLayout(
//       canSwipeBack: true,
//       appBarType: AppBarType.basic,
//       pyramidsAreOn: true,
//       title: const Verse(
//         id: 'Redirect',
//         translate: false,
//       ),
//       appBarRowWidgets: <Widget>[
//
//         const Expander(),
//
//         AppBarButton(
//           verse: Verse.plain(''),
//         ),
//
//       ],
//       child: Center(
//         child: BldrsBox(
//           height: 40,
//           verseScaleFactor: 0.7,
//           verse: Verse.plain(path),
//           secondLine: Verse.plain(arg),
//           color: Colorz.bloodTest,
//         ),
//       ),
//     );
//     // --------------------
//   }
//   // --------------------------------------------------------------------------
// }
