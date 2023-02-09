import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/d_user/z_components/future_user_tile_button.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/c_team_page/bz_team_page_controllers.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header_vm.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bldrs/lib/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class PendingAuthorsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PendingAuthorsBubble({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: true,
    );

    /// PENDING AUTHORS EXIST
    if (Mapper.checkCanLoopList(_bzModel.pendingAuthors) == true){

      return Bubble(
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          headlineVerse: const Verse(
            id: 'phid_pending_invitation_requests',
            translate: true,
          ),
        ),
        width: BldrsAppBar.width(context),
        // onBubbleTap: (){
        //   NoteModel.blogNotes(notes: _notes);
        // },
        columnChildren: <Widget>[

          ...List.generate(_bzModel.pendingAuthors.length, (index){

            final String _userID = _bzModel.pendingAuthors[index].userID;

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
                context: context,
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
