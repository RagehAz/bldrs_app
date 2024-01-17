import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/z_components/buttons/user_buttons/future_user_tile_button.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/c_team_page/bz_team_page_controllers.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class PendingAuthorsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PendingAuthorsBubble({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel? _bzModel = HomeProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );

    /// PENDING AUTHORS EXIST
    if (Lister.checkCanLoop(_bzModel?.pendingAuthors) == true){

      return Bubble(
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          headlineVerse: const Verse(
            id: 'phid_pending_invitation_requests',
            translate: true,
          ),
        ),
        width: BldrsAppBar.width(),
        // onBubbleTap: (){
        //   NoteModel.blogNotes(notes: _notes);
        // },
        columnChildren: <Widget>[

          if (Lister.checkCanLoop(_bzModel?.pendingAuthors) == true)
          ...List.generate(_bzModel!.pendingAuthors!.length, (index){

            final String _userID = _bzModel.pendingAuthors![index].userID;

            return FutureUserTileButton(
              boxWidth: Bubble.clearWidth(context: context),
              userID: _userID,
              color: Colorz.white10,
              bubble: false,
              sideButtonVerse: const Verse(
                id: 'phid_cancel',
                translate: true,
              ),
              onSideButtonTap: () => onCancelSentAuthorshipInvitation(
                bzModel: _bzModel,
                userID: _userID,
              ),
            );
          }),

        ],
      );

    }

    /// NO PENDING AUTHORS THERE
    else {

      return const SizedBox();

    }

  }
  /// --------------------------------------------------------------------------
}
