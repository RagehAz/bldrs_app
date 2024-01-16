import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
/// TAMAM
class NootActionProtocols {
  // -----------------------------------------------------------------------------

  const NootActionProtocols();

  // -----------------------------------------------------------------------------

  /// ON NOOT TAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onNootTap({
    required NoteModel? noteModel,
    required bool mounted,
    bool? startFromHome,
  }) async {

    if (noteModel != null){

      if (noteModel.navTo != null){

        final String _secondaryRouteName =
        noteModel.parties?.receiverType == PartyType.bz ?
        RouteName.myBzNotesPage
            :
        RouteName.myUserNotes;

        final String? _secondaryArgument =
        noteModel.parties?.receiverType == PartyType.bz ?
        noteModel.parties?.receiverID
            :
        null;

        final String? _routeName = noteModel.navTo?.name ?? _secondaryRouteName;
        final String? _argument = noteModel.navTo?.argument ?? _secondaryArgument;

        await BldrsNav.autoNav(
            routeName: _routeName,
            arguments: _argument,
            startFromHome: startFromHome ?? BldrsNav.checkNootTapStartsFromHome(_routeName),
            mounted: mounted
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
}
