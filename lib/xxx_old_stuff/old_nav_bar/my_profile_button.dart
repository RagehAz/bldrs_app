// import 'package:bldrs/a_models/secondary_models/note_model.dart';
// import 'package:bldrs/a_models/user/auth_model.dart';
// import 'package:bldrs/a_models/user/user_model.dart';
// import 'package:bldrs/b_views/x_screens/b_auth/b_0_auth_screen.dart';
// import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/components/nav_bar_button.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/nav_bar_methods.dart';
// import 'package:bldrs/b_views/z_components/streamers/fire_coll_streamer.dart';
// import 'package:bldrs/c_controllers/a_starters_controllers/main_navigation_controllers.dart';
// import 'package:bldrs/d_providers/notes_provider.dart';
// import 'package:bldrs/d_providers/phrase_provider.dart';
// import 'package:bldrs/d_providers/user_provider.dart';
// import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
// import 'package:bldrs/e_db/fire/fire_models/query_order_by.dart';
// import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
// import 'package:bldrs/e_db/fire/foundation/paths.dart';
// import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
// import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
// import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
// import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class MyProfileButton extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const MyProfileButton({
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   bool _checkNoteDotIsOn({
//     @required bool thereAreMissingFields,
//     @required List<NoteModel> notes,
//   }){
//
//     bool _isOn = false;
//
//     if (thereAreMissingFields == true){
//       _isOn = true;
//     }
//     else {
//
//       if (Mapper.checkCanLoopList(notes) == true){
//         _isOn = NoteModel.checkThereAreUnSeenNotes(notes);
//       }
//
//     }
//
//     return _isOn;
//   }
// // -----------------------------------------------------------------------------
//   int _getNotesCount({
//     @required bool thereAreMissingFields,
//     @required List<NoteModel> notes,
// }){
//     int _count;
//
//     if (thereAreMissingFields == false){
//       if (Mapper.checkCanLoopList(notes) == true){
//         _count = NoteModel.getNumberOfUnseenNotes(notes);
//       }
//     }
//
//     return _count;
// }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final bool _userIsSignedIn = AuthModel.userIsSignedIn();
//
//     /// SIGNED IN
//     if (_userIsSignedIn == true){
//
//       final UserModel _userModel = UsersProvider.proGetMyUserModel(context, listen: true);
//       final bool _thereAreMissingFields = UserModel.checkMissingFields(_userModel);
//
//       return FireCollStreamer(
//           queryParameters: QueryParameters(
//           collName: FireColl.notes,
//           limit: 100,
//           orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
//           finders: <FireFinder>[
//
//             FireFinder(
//               field: 'receiverID',
//               comparison: FireComparison.equalTo,
//               value: superUserID(),
//             ),
//
//           ],
//           onDataChanged: (List<Map<String, dynamic>> newMaps){
//
//             final List<NoteModel> _notes = NoteModel.decipherNotesModels(
//               maps: newMaps,
//               fromJSON: false,
//             );
//
//             final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
//             _notesProvider.setUserUnseenNotes(
//                 notes: _notes,
//                 notify: true
//             );
//
//           },
//
//         ),
//           loadingWidget: NavBarButton(
//               size: NavBar.navBarButtonWidth,
//               text: superPhrase(context, 'phid_profile'),
//               icon: Iconz.normalUser,
//               iconSizeFactor: 0.7,
//               barType: NavBar.barType,
//               onTap: () => goToMyProfileScreen(context),
//               clipperWidget: UserBalloon(
//                 size: NavBar.circleWidth,
//                 loading: false,
//                 userModel: _userModel,
//               )
//           ),
//           builder: (_, List<Map<String, dynamic>> maps){
//
//             final List<NoteModel> _notes = NoteModel.decipherNotesModels(
//                 maps: maps,
//                 fromJSON: false,
//             );
//
//             final bool _noteDotIsOn = _checkNoteDotIsOn(
//               thereAreMissingFields: _thereAreMissingFields,
//               notes : _notes,
//             );
//
//             final int _notesCount = _getNotesCount(
//               thereAreMissingFields: _thereAreMissingFields,
//               notes : _notes,
//             );
//
//             return NavBarButton(
//                 size: NavBar.navBarButtonWidth,
//                 text: superPhrase(context, 'phid_profile'),
//                 icon: Iconz.normalUser,
//                 iconSizeFactor: 0.7,
//                 barType: NavBar.barType,
//                 notesDotIsOn: _noteDotIsOn,
//                 notesCount: _notesCount,
//                 onTap: () => goToMyProfileScreen(context),
//                 clipperWidget: UserBalloon(
//                   size: NavBar.circleWidth,
//                   loading: false,
//                   userModel: _userModel,
//                 )
//             );
//
//
//           }
//       );
//
//     }
//
//     /// NOT SIGNED IN
//     else {
//
//       return NavBarButton(
//         size: NavBar.navBarButtonWidth,
//         text: superPhrase(context, 'phid_sign'),
//         icon: Iconz.normalUser,
//         iconSizeFactor: 0.45,
//         barType: NavBar.barType,
//         notesDotIsOn: true,
//         onTap: () async {
//           await Nav.goToNewScreen(
//             context: context,
//             screen: const AuthScreen(),
//           );
//         },
//       );
//
//     }
//
//   }
// }
