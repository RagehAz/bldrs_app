import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/notes_creator/x_lab_screens/x_lab/a_notes_lab_home.dart';
import 'package:bldrs/x_dashboard/notes_creator/note_creator_screen_view.dart';
import 'package:flutter/material.dart';

class NotesCreatorScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotesCreatorScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      pageTitleVerse: const Verse(
        text: 'Send Note to',
        translate: false,
      ),
      skyType: SkyType.black,
      appBarRowWidgets: <Widget>[

        const Expander(),

        /// NOTES LAB
        AppBarButton(
          // verse: Verse.plain('Templates'),
          icon: Iconz.lab,
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const NotesLabHome(),
          ),
        ),

      ],
      layoutWidget: const NoteCreatorScreenView(
        receiverType: PartyType.user,
        toSingleParty: true,
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
