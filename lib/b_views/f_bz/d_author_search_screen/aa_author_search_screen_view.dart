import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/c_team_page/bz_team_page_controllers.dart';
import 'package:bldrs/b_views/f_bz/d_author_search_screen/x_author_search_controllers.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/buttons/user_buttons/users_tile_buttons_list.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class AuthorSearchScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorSearchScreenView({
    required this.bzModel,
    required this.foundUsers,
    required this.isSearching,
    required this.isLoading,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BzModel? bzModel;
  final ValueNotifier<List<UserModel>?> foundUsers;
  final ValueNotifier<bool> isSearching;
  final ValueNotifier<bool> isLoading;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    // final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: true);
    // final List<String> _pendingInvitations = _bzzProvider.pendingAuthorsIDs;
    // --------------------
    return ListView(
      children: <Widget>[

        const Stratosphere(bigAppBar: true),

        ValueListenableBuilder(
            valueListenable: isSearching,
            child: const InviteAuthorByLinkBubble(),
            builder: (_, bool _isSearching, Widget? inviteAuthorByLinkBubble){

              return ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (_, bool _isLoading, Widget? childB){

                  /// SEARCHING
                  if (_isSearching == true){

                    /// LOADING
                    if (_isLoading == true){
                      return const Center(
                        child: Loading(loading: true),
                      );
                    }

                    /// NOT LOADING
                    else {

                      return UserTileButtonsList(
                        usersModels: foundUsers,
                        selectedUsers: null,
                        onUserTap: (UserModel userModel) => onShowUserDialog(
                          userModel: userModel,
                        ),
                        sideButtonVerse: const Verse(
                          id: 'phid_invite',
                          translate: true,
                        ),
                        deactivatedUsersIDs: <String>[
                          ...AuthorModel.getAuthorsIDsFromAuthors(authors: bzModel?.authors),
                          ... PendingAuthor.getPendingsUsersIDs(bzModel?.pendingAuthors)
                        ],
                        onSideButtonTap: (UserModel userModel) => onSendAuthorshipInvitation(
                          selectedUser: userModel,
                          bzModel: bzModel,
                        ),
                      );

                    }

                  }

                  /// NOT SEARCHING
                  else {

                    return const SizedBox(); //inviteAuthorByLinkBubble;

                  }

                },
              );


            },
        ),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}

class InviteAuthorByLinkBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InviteAuthorByLinkBubble({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: const Verse(
          id: 'phid_share_invitation_link',
          translate: true,
        ),
      ),
      width: Bubble.bubbleWidth(context: context),
      margin: Scale.constantHorizontal10,
      columnChildren: <Widget>[

        SizedBox(
          width: Bubble.clearWidth(context: context),
          child: const BldrsText(
            verse: Verse(
              pseudo: 'This Link is available for one time use only, '
                  'to allow its reciever to be redirected to '
                  'creating new author account for your Business page',
              id: 'phids_author_invitation_link_description',
              translate: true,
            ),
            weight: VerseWeight.thin,
            maxLines: 5,
            centered: false,
            color: Colorz.white125,
          ),
        ),

        const BldrsText(
          verse: Verse(
            id: 'phid_invitation_link_com',
            translate: true,
            pseudo: 'Invitation link . com',
          ),
          maxLines: 2,
          margin: 10,
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.cyan255,
        ),

        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            BldrsBox(
              height: 50,
              color: Colorz.yellow255,
              icon: Iconz.share,
              iconSizeFactor: 0.5,
              iconColor: Colorz.black230,
              verse: Verse(
                id: 'phid_share',
                translate: true,
              ),
              verseColor: Colorz.black230,
              verseScaleFactor: 1.2,
            ),
          ],
        ),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
