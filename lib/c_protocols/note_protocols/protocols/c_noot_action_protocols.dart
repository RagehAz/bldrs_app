import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
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
  }) async {

    if (noteModel != null){

      if (noteModel.navTo != null){

        final String _secondaryRouteName =
        noteModel.parties?.receiverType == PartyType.bz ?
        TabName.bid_MyBz_Notes
            :
        TabName.bid_My_Notes;

        final String? _secondaryArgument =
        noteModel.parties?.receiverType == PartyType.bz ?
        noteModel.parties?.receiverID
            :
        null;

        final String? _routeName = noteModel.navTo?.name ?? _secondaryRouteName;
        final String? _argument = noteModel.navTo?.argument ?? _secondaryArgument;

        await Routing.restartToAfterHomeRoute(
            routeName: _routeName,
            arguments: _argument,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
}
