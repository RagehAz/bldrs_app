import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_button.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/query_order_by.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
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

  @override
  void dispose() {
    super.dispose();
    _sub.cancel();
  }
// -----------------------------------------------------------------------------
  List<NoteModel> _streamedNotes =<NoteModel>[];

  void _handleStreamedNotes(List<NoteModel> notesFromStream){

    if (notesFromStream != null){

      final bool _notesListsAreTheSame = NoteModel.checkNotesListsAreTheSame(
        notes1: _streamedNotes,
        notes2: notesFromStream,
      );

      if (_notesListsAreTheSame == false){
        blog('_handleStreamedNotes : note have changed baby and we could fucking catch that change');
        _streamedNotes = notesFromStream;
      }
      else {
        blog('_handleStreamedNotes : notes are the same : very weird');
      }

    }

  }

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



    return noteStreamBuilder(
        context: context,
        stream: _stream,
        builder: (_, List<NoteModel> notes){

          return Bubble(
            title: 'Pending Invitation requests',
            width: BldrsAppBar.width(context),
            columnChildren: <Widget>[

              ...List.generate(notes.length, (index){

                final NoteModel _noteModel = notes[index];

                return FutureUserTileButton(
                  boxWidth: Bubble.clearWidth(context),
                  userID: _noteModel.receiverID,
                  color: Colorz.white10,
                  bubble: false,
                  sideButton: 'Cancel',
                  onSideButtonTap: ()async {

                    final NoteModel _note = NoteModel.getFirstNoteByRecieverID(
                      notes: notes,
                      receiverID: _noteModel.receiverID,
                    );

                    if (_note != null){

                      await NoteFireOps.deleteNote(
                        context: context,
                        noteID: _note.id,
                      );

                      await TopDialog.showTopDialog(
                        context: context,
                        firstLine: 'Invitation request has been cancelled',
                        color: Colorz.green255,
                        textColor: Colorz.white255,
                      );

                    }

                  },
                );

              }),

            ],
          );

    },
    );

  }

}
