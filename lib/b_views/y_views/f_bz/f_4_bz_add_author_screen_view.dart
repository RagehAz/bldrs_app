import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_button.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/invite_authors_controller.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
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
            builder: (_, bool _isSearching, Widget child){

              return ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (_, bool _isLoading, Widget child){

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

                      return ValueListenableBuilder(
                          valueListenable: foundUsers,
                          builder: (_, List<UserModel> _users, Widget child){

                            if (Mapper.canLoopList(_users) == true){

                              return SizedBox(
                                width: Scale.superScreenWidth(context),
                                height: Scale.superScreenHeight(context),
                                child: ListView.builder(
                                  itemCount: _users.length,
                                  itemBuilder: (_, index){

                                    final UserModel _user = _users[index];

                                    return UserTileButton(
                                      userModel: _user,
                                      inviteButtonIsOn: true,
                                      onUserTap: () => onShowUserDialog(
                                        context: context,
                                        userModel: _user,
                                      ),
                                      onInviteTap: () => onInviteUserButtonTap(
                                        context: context,
                                        userModel: _user,
                                        bzModel: bzModel,
                                      ),
                                    );

                                  },
                                ),
                              );

                            }
                            else {
                              return const SuperVerse(
                                verse: 'No users found with this name',
                              );
                            }

                          }
                      );

                    }

                  }

                  /// NOT SEARCHING
                  else {

                    return child;

                  }

                },
              );


            },
        ),

      ],
    );

  }
}
