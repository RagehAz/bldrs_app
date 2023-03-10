import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:flutter/material.dart';
/// TAMAM
class NootNavToProtocols {
  // -----------------------------------------------------------------------------

  const NootNavToProtocols();

  // -----------------------------------------------------------------------------

  /// ON NOOT TAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onNootTap({
    @required BuildContext context,
    @required NoteModel noteModel,
    bool startFromHome,
  }) async {

    if (noteModel != null){

      if (noteModel.navTo != null){

        final String _secondaryRouteName =
        noteModel.parties.receiverType == PartyType.bz ?
        Routing.myBzNotesPage
            :
        Routing.myUserNotesPage;

        final String _secondaryArgument =
        noteModel.parties.receiverType == PartyType.bz ?
        noteModel.parties.receiverID
            :
        null;

        final String _routeName = noteModel?.navTo?.name ?? _secondaryRouteName;
        final String _argument = noteModel?.navTo?.argument ?? _secondaryArgument;

        await Nav.autoNav(
            context: context,
            routeName: _routeName,
            arguments: _argument,
            startFromHome: startFromHome ?? _checkShouldStartFromHome(_routeName),
        );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _checkShouldStartFromHome(String routeName){

    switch (routeName){

      // case Routing.staticLogoScreen     : return true; break;
      // case Routing.animatedLogoScreen   : return true; break;
      // case Routing.home                 : return true; break;
      // case Routing.auth                 : return true; break;
      // case Routing.savedFlyers          : return true; break;
      // case Routing.news                 : return true; break;
      // case Routing.more                 : return true; break;

      case Routing.profile              : return true; break;
      case Routing.profileEditor        : return true; break;
      case Routing.search               : return true; break;
      case Routing.bzEditor             : return true; break;
      case Routing.myBzFlyersPage           : return true; break;
      case Routing.myBzNotesPage        : return true; break;
      case Routing.myBzTeamPage         : return true; break;
      case Routing.editBz               : return true; break;
      case Routing.flyerEditor          : return true; break;
      case Routing.appSettings          : return true; break;

      // case Routing.flyerScreen          : return true; break;
      // case Routing.ragehDashBoard       : return true; break;
      // case Routing.obelisk              : return true; break;
      // case Routing.dynamicLinkTest      : return true; break;

      case Routing.userPreview          : return false; break;
      case Routing.bzPreview            : return false; break;
      case Routing.countryPreview       : return false; break;
      case Routing.flyerPreview         : return false; break;
      case Routing.flyerReviews         : return false; break;
      case Routing.bldrsPreview         : return false; break;

      case Routing.myUserScreen         : return true; break;
      case Routing.myUserNotesPage      : return true; break;

      default: return true;
    }

  }
  // -----------------------------------------------------------------------------
}
