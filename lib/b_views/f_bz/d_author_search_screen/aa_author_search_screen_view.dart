import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/c_team_page/bz_team_page_controllers.dart';
import 'package:bldrs/b_views/f_bz/d_author_search_screen/x_author_search_controllers.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/notes_creator/z_components/buttons/users_tile_buttons_list.dart';
import 'package:flutter/material.dart';

class AuthorSearchScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorSearchScreenView({
    @required this.bzModel,
    @required this.foundUsers,
    @required this.isSearching,
    @required this.isLoading,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final ValueNotifier<List<UserModel>> foundUsers;
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
            child: Bubble(
              bubbleHeaderVM: const BubbleHeaderVM(
                headlineVerse: Verse(
                  text: 'phid_share_invitation_link',
                  translate: true,
                ),
              ),
              width: Bubble.bubbleWidth(context),
              margin: Scale.constantHorizontal10,
              columnChildren: <Widget>[

                SizedBox(
                  width: Bubble.clearWidth(context),
                  child: const SuperVerse(
                    verse: Verse(
                      pseudo: 'This Link is available for one time use only, '
                          'to allow its reciever to be redirected to '
                          'creating new author account for your Business page',
                      text: 'phids_author_invitation_link_description',
                      translate: true,
                    ),
                    weight: VerseWeight.thin,
                    maxLines: 5,
                    centered: false,
                    color: Colorz.white125,
                  ),
                ),

                const SuperVerse(
                  verse: Verse(
                    text: 'phid_invitation_link_com',
                    translate: true,
                    pseudo: 'Invitation link . com',
                  ),
                  maxLines: 2,
                  margin: 10,
                  weight: VerseWeight.thin,
                  italic: true,
                  color: Colorz.cyan255,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[
                    DreamBox(
                      height: 50,
                      color: Colorz.yellow255,
                      icon: Iconz.share,
                      iconSizeFactor: 0.5,
                      iconColor: Colorz.black230,
                      verse: Verse(
                        text: 'phid_share',
                        translate: true,
                      ),
                      verseColor: Colorz.black230,
                      verseScaleFactor: 1.2,
                    ),
                  ],
                ),

              ],
            ),
            builder: (_, bool _isSearching, Widget childA){

              return ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (_, bool _isLoading, Widget childB){

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
                        onUserTap: (UserModel userModel) => onShowUserDialog(
                          context: context,
                          userModel: userModel,
                        ),
                        sideButtonVerse: const Verse(
                          text: 'phid_invite',
                          translate: true,
                        ),
                        deactivatedUsersIDs: <String>[
                          ...AuthorModel.getAuthorsIDsFromAuthors(authors: bzModel.authors),
                          ... PendingAuthor.getPendingsUsersIDs(bzModel.pendingAuthors)
                        ],
                        onSideButtonTap: (UserModel userModel) => onSendAuthorshipInvitation(
                          context: context,
                          selectedUser: userModel,
                          bzModel: bzModel,
                        ),
                      );

                    }

                  }

                  /// NOT SEARCHING
                  else {

                    return childA;

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
