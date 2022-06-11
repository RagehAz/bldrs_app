import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/material.dart';

class UserNotesPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserNotesPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  /// --------------------------------------------------------------------------
  /*
  Future<void> _dismissNote({
    @required String id,
    @required int notiModelsLength,
  }) async {

    blog('removing noti with id : $id ---------------------------------------xxxxx ');

    // await Fire.updateSubDocField(
    //   context: context,
    //   collName: FireColl.users,
    //   docName: FireAuthOps.superUserID(),
    //   subCollName: FireSubColl.users_user_notifications,
    //   subDocName: id,
    //   field: 'dismissed',
    //   input: true,
    // );

    if (notiModelsLength == 1) {
      blog('this was the last notification and is gone khalas  --------------------------------------- oooooo ');
    }

    // setState(() {
    //   _notifications.removeWhere((notiModel) => notiModel.id == id,);
    // });

  }
   */
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<NoteModel> _userNotes = NotesProvider.proGetUserNotes(
      context: context,
      listen: true,
    );

    if (Mapper.checkCanLoopList(_userNotes) == false){

      return const SizedBox();

    }

    else {

      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        itemCount: _userNotes?.length,
        padding: Stratosphere.stratosphereSandwich,
        itemBuilder: (BuildContext ctx, int index) {

          final NoteModel _notiModel = Mapper.checkCanLoopList(_userNotes) == true ? _userNotes[index] : null;

          return NoteCard(
            noteModel: _notiModel,
            isDraftNote: false,
          );

        },
      );

    }

  }
}
