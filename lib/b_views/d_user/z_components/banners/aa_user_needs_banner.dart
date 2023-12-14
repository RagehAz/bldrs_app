// import 'package:basics/bldrs_theme/classes/colorz.dart';
// import 'package:basics/bubbles/bubble/bubble.dart';
// import 'package:bldrs/a_models/a_user/sub/need_model.dart';
// import 'package:bldrs/a_models/a_user/user_model.dart';
// import 'package:bldrs/b_views/d_user/b_user_editor_screen/b_need_editor_screen.dart';
// import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
// import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
// import 'package:bldrs/b_views/z_components/texting/customs/zone_line.dart';
// import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
// import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
//
// import 'package:flutter/material.dart';
// import 'package:basics/layouts/nav/nav.dart';


/// USER_NEEDS_BANNER
// class UserNeedsBanner extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const UserNeedsBanner({
//     required this.userModel,
//     this.editorMode = false,
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   final UserModel? userModel;
//   final bool editorMode;
//   /// --------------------------------------------------------------------------
//   Future<void> onGoToNeedsEditorScreen(BuildContext context) async {
//     await Nav.goToNewScreen(
//       context: context,
//       screen: const NeedEditorScreen(),
//     );
//   }
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return Bubble(
//       width: Bubble.bubbleWidth(context: context),
//       bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
//         context: context,
//         hasMoreButton: true,
//         onMoreButtonTap: editorMode == true ? () => onGoToNeedsEditorScreen(context) : null,
//       ),
//       childrenCentered: true,
//
//       columnChildren: <Widget>[
//
//         /// IM CURRENTLY
//         const BldrsText(
//           verse: Verse(
//             id: 'phid_im_currently',
//             translate: true,
//           ),
//           italic: true,
//           shadow: true,
//           margin: 5,
//         ),
//
//         /// NEED TYPE
//         BldrsText(
//           verse: Verse(
//             id: NeedModel.getNeedTypePhid(userModel?.need?.needType),
//             translate: true,
//           ),
//           margin: const EdgeInsets.symmetric(horizontal: 30),
//           size: 4,
//           color: Colorz.yellow255,
//           italic: true,
//           maxLines: 3,
//         ),
//
//         /// NEED LOCALE
//         ZoneLine(
//           zoneModel: userModel?.zone,
//           // showCity: true,
//         ),
//
//         /// NOTES
//         BldrsText(
//           verse: Verse(
//             id: userModel?.need?.notes,
//             translate: false,
//           ),
//           labelColor: Colorz.white20,
//           width: PageBubble.clearWidth(context),
//           margin: 30,
//           maxLines: 100,
//         ),
//
//         /// SPECS
//         // if (Lister.checkCanLoop(userModel?.need?.scope) == true)
//         //   SpecsBuilder(
//         //     pageWidth: PageBubble.clearWidth(context),
//         //     specs: SpecModel.generateSpecsByPhids(
//         //       phids: userModel?.need?.scope,
//         //     ),
//         //     onSpecTap: ({SpecModel value, SpecModel unit}){
//         //       blog('NEED : UserNeedsPage : onSpecTap');
//         //       value.blogSpec();
//         //       unit?.blogSpec();
//         //     },
//         //     onDeleteSpec: ({SpecModel value, SpecModel unit}){
//         //       blog('NEED : UserNeedsPage : onDeleteSpec');
//         //       value.blogSpec();
//         //       unit?.blogSpec();
//         //     },
//         //   ),
//
//       ],
//
//     );
//   }
//   /// --------------------------------------------------------------------------
// }
