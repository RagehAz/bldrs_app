

import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:flutter/material.dart';

class NootNavToProtocols {
  // -----------------------------------------------------------------------------

  const NootNavToProtocols();

  // -----------------------------------------------------------------------------

  /// ON NOOT TAP

  // --------------------
  ///
  static Future<void> onNootTap({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {

    if (noteModel != null){

      if (noteModel.navTo != null){

        await Nav.autoNav(
            context: context,
            routeName: noteModel?.navTo?.name,
            arguments: noteModel?.navTo?.argument,
            startFromHome: _checkShouldStartFromHome(noteModel?.navTo?.name),
        );

      }

    }

  }
  // --------------------
  ///
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
      case Routing.myBzScreen           : return true; break;
      case Routing.myBzNotesPage        : return true; break;
      case Routing.myBzTeamPage         : return true; break;
      case Routing.editBz               : return true; break;
      case Routing.flyerEditor          : return true; break;

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
