// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/a_models/secondary_models/note_model.dart';
// import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
// import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/components/note_red_dot.dart';
// import 'package:bldrs/c_controllers/a_starters_controllers/main_navigation_controllers.dart';
// import 'package:bldrs/d_providers/bzz_provider.dart';
// import 'package:bldrs/d_providers/notes_provider.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class MyBzzSelectorScreen extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const MyBzzSelectorScreen({
//     Key key}) : super(key: key);
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final List<BzModel> bzzModels = BzzProvider.proGetMyBzz(context: context, listen: true);
//     final List<NoteModel> _allBzzNotes = NotesProvider.proGetAllBzzNotes(context: context, listen: true);
//
//     return MainLayout(
//       key: const ValueKey('my_bzz_selector_screen'),
//       pyramidsAreOn: true,
//       appBarType: AppBarType.basic,
//       pageTitle: 'My Business Accounts',
//       zoneButtonIsOn: false,
//       sectionButtonIsOn: false,
//       skyType: SkyType.black,
//       layoutWidget: ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.only(
//           top: Ratioz.stratosphere,
//           bottom: Ratioz.horizon,
//         ),
//         itemCount: bzzModels.length,
//         itemBuilder: (_, index){
//
//           final BzModel _bzModel = bzzModels[index];
//
//           final List<NoteModel> _unseenNotes = NoteModel.getUnseenNotesByReceiverID(
//             notes: _allBzzNotes,
//             receiverID: _bzModel.id,
//           );
//
//           return Center(
//             child: NoteRedDotWrapper(
//               childWidth: 350,
//               redDotIsOn: _unseenNotes.isNotEmpty,
//               shrinkChild: true,
//               count: _unseenNotes.length,
//               child: DreamBox(
//                 height: 100,
//                 width: 350,
//                 verseMaxLines: 2,
//                 margins: const EdgeInsets.only(bottom: 10),
//                 verse: _bzModel.name,
//                 secondLine: BzModel.translateBzTypesIntoString(
//                   context: context,
//                   bzTypes: _bzModel.bzTypes,
//                   bzForm: _bzModel.bzForm,
//                 ),
//                 verseCentered: false,
//                 secondLineScaleFactor: 1.2,
//                 icon: _bzModel.logo,
//                 onTap: () => goToMyBzScreen(
//                   context: context,
//                   bzID: _bzModel.id,
//                 ),
//
//               ),
//             ),
//           );
//
//           /*
//           /// PLAN : CHANGE THOSE DREAM BOX BUTTONS INTO STATIC HEADERS
//           return StaticHeader(
//             flyerBoxWidth: appBarWidth(context),
//             opacity: 1,
//             bzModel: _bzModel,
//             onTap: () async {
//               await goToNewScreen(context, MyBzScreen(bzModel: _bzModel,));
//               },
//           );
//            */
//
//         },
//       ),
//     );
//
//   }
// }
