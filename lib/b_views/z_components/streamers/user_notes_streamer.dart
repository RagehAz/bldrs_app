// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/b_views/z_components/streamers/fire_coll_streamer.dart';
// import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
// import 'package:bldrs/e_db/fire/fire_models/query_order_by.dart';
// import 'package:bldrs/e_db/fire/foundation/paths.dart';
// import 'package:flutter/material.dart';
//
// class BzNotesStreamer extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const BzNotesStreamer({
//     @required this.bzModel,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final BzModel bzModel;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return FireCollStreamer(
//         collName: FireColl.notes,
//         limit: 100,
//         orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
//         finders: <FireFinder>[
//
//           FireFinder(
//             field: 'receiverID',
//             comparison: FireComparison.equalTo,
//             value: superUserID(),
//           ),
//
//         ],
//         onDataChanged: (List<Map<String, dynamic>> newMaps){
//
//           final List<NoteModel> _notes = NoteModel.decipherNotesModels(
//             maps: newMaps,
//             fromJSON: false,
//           );
//
//           final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
//           _notesProvider.setUserNotes(
//               notes: _notes,
//               notify: true
//           );
//
//         },
//         builder: (_, List<Map<String, dynamic>> maps){
//
//           final List<NoteModel> _notes = NoteModel.decipherNotesModels(
//             maps: maps,
//             fromJSON: false,
//           );
//
//           final bool _noteDotIsOn = _checkNoteDotIsOn(
//             thereAreMissingFields: _thereAreMissingFields,
//             notes : _notes,
//           );
//
//           final int _notesCount = _getNotesCount(
//             thereAreMissingFields: _thereAreMissingFields,
//             notes : _notes,
//           );
//
//           return NavBarButton(
//               size: NavBar.navBarButtonWidth,
//               text: superPhrase(context, 'phid_profile'),
//               icon: Iconz.normalUser,
//               iconSizeFactor: 0.7,
//               barType: NavBar.barType,
//               notesDotIsOn: _noteDotIsOn,
//               notesCount: _notesCount,
//               onTap: () => goToMyProfileScreen(context),
//               clipperWidget: UserBalloon(
//                 size: NavBar.circleWidth,
//                 loading: false,
//                 userModel: _userModel,
//               )
//           );
//
//
//         }
//     );
//   }
// }
