import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/authorships_controllers.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/search_author_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/components/users_tile_buttons_list.dart';
import 'package:flutter/material.dart';

class AddAuthorScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AddAuthorScreenView({
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

    return ListView(
      children: <Widget>[

        const Stratosphere(bigAppBar: true),

        ValueListenableBuilder(
            valueListenable: isSearching,
            child: Bubble(
              title: 'Share invitation Link',
              width: Bubble.defaultWidth(context),
              margins: Scale.superPadding(
                context: context,
                enLeft: Ratioz.appBarMargin,
                enRight: Ratioz.appBarMargin,
              ),
              columnChildren: <Widget>[

                SizedBox(
                  width: Bubble.clearWidth(context),
                  child: const SuperVerse(
                    verse: 'This Link is available for one time use only, '
                        'to allow its reciever to be redirected to '
                        'creating new author account for your Business page',
                    weight: VerseWeight.thin,
                    maxLines: 5,
                    centered: false,
                    color: Colorz.white125,
                  ),
                ),

                const SuperVerse(
                  verse: 'Invitation link . com',
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
                      verse: 'Share',
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
                        sideButton: superPhrase(context, 'phid_invite'),
                        onSideButtonTap: (UserModel userModel) => sendAuthorshipInvitation(
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

  }
}
