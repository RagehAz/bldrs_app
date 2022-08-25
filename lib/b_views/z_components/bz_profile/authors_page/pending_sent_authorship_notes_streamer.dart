import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/fire_coll_streamer.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_button.dart';
import 'package:bldrs/c_controllers/authorships_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();

    blog('a77a ba2a');

  }
// -----------------------------------------------------------------------------
  @override
  void deactivate() {
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.setPendingAuthorshipInvitations(
      notes: [],
      notify: false,
    );
    super.deactivate();
  }
// -----------------------------------------------------------------------------
  /*
  /// TAMAM
  @override
  void dispose() {
    super.dispose();
  }
   */
// -----------------------------------------------------------------------------
  void _onStreamDataChanged(List<Map<String, dynamic>> maps){

    // blog('PendingSentAuthorshipNotesStreamer : data changed');
    // Mapper.blogMaps(maps);
    //
    final List<NoteModel> _notes = NoteModel.decipherNotes(
        maps: maps,
        fromJSON: false,
    );

    if (Mapper.checkCanLoopList(_notes) == true){

      if (mounted == true){
        final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
        _bzzProvider.setPendingAuthorshipInvitations(
          notes: _notes,
          notify: true,
        );
      }

    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    return FireCollStreamer(
      queryModel: bzSentPendingAuthorshipNotesStreamQueryModel(
        bzID: _bzModel.id,
        onDataChanged: _onStreamDataChanged,
      ),
      builder: (BuildContext context, List<Map<String, dynamic>> maps){

        final List<NoteModel> _notes = NoteModel.decipherNotes(
            maps: maps,
            fromJSON: false,
        );

        if (Mapper.checkCanLoopList(_notes) == true){
          return Bubble(
            title: '##Pending Invitation requests',
            width: BldrsAppBar.width(context),
            onBubbleTap: (){
              NoteModel.blogNotes(notes: _notes);
            },
            columnChildren: <Widget>[

              ...List.generate(_notes.length, (index){

                final NoteModel _note = _notes[index];

                return FutureUserTileButton(
                  boxWidth: Bubble.clearWidth(context),
                  userID: _note.receiverID,
                  color: Colorz.white10,
                  bubble: false,
                  sideButton: '##Cancel',
                  onSideButtonTap: () => onCancelSentAuthorshipInvitation(
                    context: context,
                    note: _note,
                  ),
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
