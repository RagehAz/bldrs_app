import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/bz/invitation_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/streamers/fire_coll_streamer.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_button.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_order_by.dart';
import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class PendingSentAuthorshipNotesStreamer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PendingSentAuthorshipNotesStreamer({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _PendingSentAuthorshipNotesStreamerState createState() => _PendingSentAuthorshipNotesStreamerState();
/// --------------------------------------------------------------------------
}

class _PendingSentAuthorshipNotesStreamerState extends State<PendingSentAuthorshipNotesStreamer> {
// -----------------------------------------------------------------------------
  BzModel _bzModel;
  Stream<List<NoteModel>> _stream;
  StreamSubscription _sub;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    
    _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: false);
    
    _stream = NoteFireOps.getNoteModelsStream(
      context: context,
      limit: 10,
      orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
      // startAfter: null,
      finders: NoteFireOps.generatePendingSentAuthorshipNotesFireFinder(
          senderID: _bzModel.id,
      ),
    );

    _initStreamListener(_stream);

  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _sub.cancel();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  List<NoteModel> _streamedNotes =<NoteModel>[];

  void _handleStreamedNotes(List<NoteModel> notesFromStream){

    if (notesFromStream != null){

      final bool _notesListsAreTheSame = NoteModel.checkNotesListsAreTheSame(
        notes1: _streamedNotes,
        notes2: notesFromStream,
      );

        // setState(() {
          _streamedNotes = notesFromStream;
        // });

      if (_notesListsAreTheSame == false){
        blog('_handleStreamedNotes : note have changed baby and we could fucking catch that change');
      }
      else {
        blog('_handleStreamedNotes : notes are the same : very weird');
      }

    }

  }
// -----------------------------------------------------------------------------
  void _initStreamListener(Stream stream){

    _sub = stream.listen((dynamic data) {

      blog('stream data : $data');
      final List<NoteModel> _newNotes = data;
      _handleStreamedNotes(_newNotes);
      },

      onError: (error){
      blog('stream error : $error');
      },

      onDone: (){
      blog('Stream is DONE');
      },

      cancelOnError: false,
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    return FireCollStreamer(
      queryParameters: QueryParameters(
        collName: FireColl.authorships,
        limit: 50,
        orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
        finders: <FireFinder>[

          FireFinder(
            field: 'bzID',
            comparison: FireComparison.equalTo,
            value: _bzModel.id,
          ),

          FireFinder(
              field: 'response',
              comparison: FireComparison.equalTo,
              value: AuthorshipModel.cipherAuthorshipsResponse(AuthorshipResponse.pending),
          ),

        ],
      ),
      builder: (BuildContext context, List<Map<String, dynamic>> maps){

        final List<AuthorshipModel> _models = AuthorshipModel.decipherAuthorships(
            maps: maps,
            fromJSON: false,
        );

        if (Mapper.checkCanLoopList(_models) == true){
          return Bubble(
            title: 'Pending Invitation requests',
            width: BldrsAppBar.width(context),
            onBubbleTap: (){
              NoteModel.blogNotes(notes: _streamedNotes);
            },
            columnChildren: <Widget>[

              ...List.generate(_models.length, (index){
                final AuthorshipModel _authorship = _models[index];
                return FutureUserTileButton(
                  boxWidth: Bubble.clearWidth(context),
                  userID: _authorship.receiverID,
                  color: Colorz.white10,
                  bubble: false,
                  sideButton: 'Cancel',
                  onSideButtonTap: ()async {

                    // final NoteModel _note = NoteModel.getFirstNoteByRecieverID(
                    //   notes: notes,
                    //   receiverID: _noteModel.receiverID,
                    // );
                    //
                    // if (_note != null){
                    //
                    //   await NoteFireOps.deleteNote(
                    //     context: context,
                    //     noteID: _note.id,
                    //   );
                    //
                    //   await TopDialog.showTopDialog(
                    //     context: context,
                    //     firstLine: 'Invitation request has been cancelled',
                    //     color: Colorz.green255,
                    //     textColor: Colorz.white255,
                    //   );
                    //
                    // }

                  },
                );
              }),

            ],
          );
        }

        else {
          return const SizedBox();
        }

      },
    );

    // return noteStreamBuilder(
    //   context: context,
    //   stream: _stream,
    //   builder: (_, List<NoteModel> notes){
    //
    //     if (Mapper.checkCanLoopList(notes) == true){
    //       return Bubble(
    //         title: 'Pending Invitation requests',
    //         width: BldrsAppBar.width(context),
    //         onBubbleTap: (){
    //           NoteModel.blogNotes(notes: _streamedNotes);
    //         },
    //         columnChildren: <Widget>[
    //
    //           ...List.generate(notes.length, (index){
    //             final NoteModel _noteModel = notes[index];
    //             return FutureUserTileButton(
    //               boxWidth: Bubble.clearWidth(context),
    //               userID: _noteModel.receiverID,
    //               color: Colorz.white10,
    //               bubble: false,
    //               sideButton: 'Cancel',
    //               onSideButtonTap: ()async {
    //
    //                 final NoteModel _note = NoteModel.getFirstNoteByRecieverID(
    //                   notes: notes,
    //                   receiverID: _noteModel.receiverID,
    //                 );
    //
    //                 if (_note != null){
    //
    //                   await NoteFireOps.deleteNote(
    //                     context: context,
    //                     noteID: _note.id,
    //                   );
    //
    //                   await TopDialog.showTopDialog(
    //                     context: context,
    //                     firstLine: 'Invitation request has been cancelled',
    //                     color: Colorz.green255,
    //                     textColor: Colorz.white255,
    //                   );
    //
    //                 }
    //               },
    //             );
    //           }),
    //
    //         ],
    //       );
    //     }
    //
    //     else {
    //       return const SizedBox();
    //     }
    //
    //     },
    // );

  }

}

/// old pending notes with provider and pagination
// Consumer<NotesProvider>(
//   builder: (BuildContext ctx, NotesProvider notesProvider, Widget child) {
//
//     final List<UserModel> _notesUsers = notesProvider.pendingSentAuthorshipUsers;
//     final List<NoteModel> _notes = notesProvider.pendingSentAuthorshipNotes;
//
//     if (Mapper.canLoopList(_notesUsers) == false){
//       return const SizedBox();
//     }
//
//     else {
//
//       return Bubble(
//         title: 'Pending Invitation requests',
//         width: BldrsAppBar.width(context),
//         columnChildren: <Widget>[
//
//           ...List.generate(_notesUsers.length, (index){
//
//             final UserModel _userModel = _notesUsers[index];
//             return UserTileButton(
//               boxWidth: Bubble.clearWidth(context),
//               userModel: _userModel,
//               color: Colorz.white10,
//               bubble: false,
//               sideButton: 'Cancel',
//               onSideButtonTap: () => cancelSentAuthorshipInvitation(
//                 context: context,
//                 receiverID: _userModel.id,
//                 pendingNotes: _notes,
//               ),
//             );
//
//           }),
//
//         ],
//       );
//
//     }
//
//   },
// ),
