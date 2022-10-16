import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/note_creator_screen_view.dart';
import 'package:flutter/material.dart';

class CreateNoteToOneUser extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CreateNoteToOneUser({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitleVerse: const Verse(
        text: 'Send To one user',
        translate: false,
      ),
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      onBack: () async {
        await Dialogs.goBackDialog(
          context: context,
          goBackOnConfirm: true,
        );
      },
      layoutWidget: const NoteCreatorScreenView(
        receiverType: PartyType.user,
        toSingleParty: true,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
