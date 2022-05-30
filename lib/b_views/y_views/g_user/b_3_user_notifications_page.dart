import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/notifications/note_card.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class UserNotificationsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserNotificationsPage({
    @required this.userModel,
    @required this.notes,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final List<NoteModel> notes;
  /// --------------------------------------------------------------------------
  Future<void> _dismissNotification({
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
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    if (Mapper.canLoopList(notes) == false){

      return const SizedBox();

    }

    else {

      NoteModel.blogNotes(notes: notes, methodName: 'BUILDEEEEER');


      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        itemCount: notes?.length,
        padding: const EdgeInsets.only(
          // top: Ratioz.stratosphere,
          bottom: Ratioz.horizon,
        ),
        itemBuilder: (BuildContext ctx, int index) {

          final NoteModel _notiModel = Mapper.canLoopList(notes) == true ? notes[index] : null;

          return NoteCard(
            noteModel: _notiModel,
          );

        },
      );

    }

  }
}
