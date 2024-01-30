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
    required bool mounted,
    bool? startFromHome,
  }) async {

    if (noteModel != null){

      if (noteModel.navTo != null){

        final String _secondaryRouteName =
        noteModel.parties?.receiverType == PartyType.bz ?
        BldrsTabber.bidMyBzNotes /// WHICH_BZ_EXACTLY
            :
        BldrsTabber.bidMyNotes;

        final String? _secondaryArgument =
        noteModel.parties?.receiverType == PartyType.bz ?
        noteModel.parties?.receiverID
            :
        null;

        final String? _routeName = noteModel.navTo?.name ?? _secondaryRouteName;
        final String? _argument = noteModel.navTo?.argument ?? _secondaryArgument;

        await ScreenRouter.autoNav(
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
