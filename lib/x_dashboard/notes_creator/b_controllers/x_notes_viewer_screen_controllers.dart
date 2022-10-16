import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/b_parties_controllers.dart';
import 'package:flutter/material.dart';

// --------------------
///
Future<void> onNoteTap({
  @required BuildContext context,
  @required NoteModel note,
  @required ValueNotifier<bool> loading,
}) async {

  final List<Widget> _buttons = <Widget>[

    BottomDialog.wideButton(
      context: context,
      verse: Verse.plain( 'Delete'),
      onTap: () => onDeleteNote(
        context: context,
        noteModel: note,
        // notes: allNotes,
        loading: loading,
      ),
    ),

  ];

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: _buttons.length,
      titleVerse: Verse.plain('All note screen show button dialog'),
      builder: (_){
        return _buttons;
      }

  );

}
// --------------------
///
Future<void> onShowReceiverTypes({
  @required BuildContext context,
  @required Function(String receiverID, PartyType partyType, String collName) onSelect,
}) async {

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: 2,
      buttonHeight: 50,
      builder: (_){

        return <Widget>[

          /// USER
          BottomDialog.wideButton(
              context: context,
              icon: Iconz.normalUser,
              onTap: () async {

                await Nav.goBack(context: context);

                final List<UserModel> _users = await onSelectUserAsNoteReceiver(
                  context: context,
                  selectedUsers: [],
                );

                if (Mapper.checkCanLoopList(_users) == true) {

                  onSelect(_users.first.id, PartyType.user, FireColl.users);

                }

              }
          ),

          /// BZ
          BottomDialog.wideButton(
              context: context,
              icon: Iconz.bz,
              onTap: () async {

                await Nav.goBack(context: context);

                final List<BzModel> _bzz = await onSelectBzAsNoteReceiver(
                  context: context,
                  selectedBzz: [],
                );

                if (Mapper.checkCanLoopList(_bzz) == true) {

                  onSelect(_bzz.first.id, PartyType.bz, FireColl.bzz);

                }

              }
          ),

        ];

      }
  );

}

// -----------------------------------------------------------------------------

/// DELETE NOTE (ALL NOTES PAGINATOR SCREEN)

// --------------------
///
Future<void> onDeleteNote({
  @required BuildContext context,
  @required NoteModel noteModel,
  // @required ValueNotifier<List<NoteModel>> notes,
  @required ValueNotifier<bool> loading,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: Verse.plain('Delete Note ?'),
    bodyVerse: Verse.plain('Will Delete on Database and can never be recovered'),
    boolDialog: true,
  );

  if (_result == true){

    await Nav.goBack(
      context: context,
      invoker: 'onDeleteNote',
    );
    loading.value = true;

    await NoteProtocols.wipeNote(
      context: context,
      note: noteModel,
    );

    loading.value = false;

    /// SHOW CONFIRMATION DIALOG
    await TopDialog.showTopDialog(
      context: context,
      firstVerse: Verse.plain('Note Deleted'),
      secondVerse: Verse.plain('Tamam keda'),
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

}
// -----------------------------------------------------------------------------
