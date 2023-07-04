import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
/// TAMAM
class NootNavToProtocols {
  // -----------------------------------------------------------------------------

  const NootNavToProtocols();

  // -----------------------------------------------------------------------------

  /// ON NOOT TAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onNootTap({
    required NoteModel? noteModel,
    bool? startFromHome,
  }) async {

    if (noteModel != null){

      if (noteModel.navTo != null){

        final String _secondaryRouteName =
        noteModel.parties?.receiverType == PartyType.bz ?
        Routing.myBzNotesPage
            :
        Routing.myUserNotesPage;

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
            startFromHome: startFromHome ?? _checkShouldStartFromHome(_routeName),
        );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _checkShouldStartFromHome(String? routeName){

    switch (routeName){

      // case Routing.staticLogoScreen     : return true; break;
      // case Routing.animatedLogoScreen   : return true; break;
      // case Routing.home                 : return true; break;
      // case Routing.auth                 : return true; break;
      // case Routing.savedFlyers          : return true; break;
      // case Routing.news                 : return true; break;
      // case Routing.more                 : return true; break;

      case Routing.profile              : return true;
      case Routing.profileEditor        : return true;
      case Routing.search               : return true;
      case Routing.bzEditor             : return true;
      case Routing.myBzFlyersPage       : return true;
      case Routing.myBzNotesPage        : return true;
      case Routing.myBzTeamPage         : return true;
      case Routing.editBz               : return true;
      case Routing.flyerEditor          : return true;
      case Routing.appSettings          : return true;

      // case Routing.flyerScreen          : return true; break;
      // case Routing.ragehDashBoard       : return true; break;
      // case Routing.obelisk              : return true; break;
      // case Routing.dynamicLinkTest      : return true; break;

      case Routing.userPreview          : return false;
      case Routing.bzPreview            : return false;
      case Routing.countryPreview       : return false;
      case Routing.flyerPreview         : return false;
      case Routing.flyerReviews         : return false;
      case Routing.bldrsPreview         : return false;

      case Routing.myUserScreen         : return true;
      case Routing.myUserNotesPage      : return true;

      default: return true;
    }

  }
  // -----------------------------------------------------------------------------
}
