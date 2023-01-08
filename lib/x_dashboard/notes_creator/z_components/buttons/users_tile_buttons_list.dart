import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/d_user/z_components/user_tile_button.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class UserTileButtonsList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserTileButtonsList({
    @required this.usersModels,
    @required this.onUserTap,
    this.selectedUsers,
    this.emptyListString,
    this.sideButtonVerse,
    this.onSideButtonTap,
    this.deactivatedUsersIDs,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<List<UserModel>> usersModels;
  final ValueNotifier<List<UserModel>> selectedUsers;
  final ValueChanged<UserModel> onUserTap;
  final Verse emptyListString;
  final Verse sideButtonVerse;
  final ValueChanged<UserModel> onSideButtonTap;
  final List<String> deactivatedUsersIDs;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: usersModels,
        builder: (_, List<UserModel> foundUsers, Widget child){

          /// FOUND USERS
          if (Mapper.checkCanLoopList(foundUsers) == true){

            return ValueListenableBuilder(
              valueListenable: selectedUsers ?? ValueNotifier<List<UserModel>>(<UserModel>[]),
              builder: (_, List<UserModel> selectedUsers, Widget child){

                return SizedBox(
                  width: Scale.screenWidth(context),
                  height: Scale.screenHeight(context),
                  child: ListView.builder(
                    itemCount: foundUsers.length,
                    physics: const NeverScrollableScrollPhysics(),
                    // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
                    itemBuilder: (_, index){

                      final UserModel _user = foundUsers[index];
                      final bool _isSelected = UserModel.checkUsersContainUser(
                        usersModels: selectedUsers,
                        userModel: _user,
                      );
                      final bool _isMe = _user.id == AuthFireOps.superUserID();

                      final Color _buttonColor = _isSelected == true ? Colorz.green255
                          :
                      _isMe == true ? Colorz.black255
                          :
                      null;

                      final bool _isDeactivated = Stringer.checkStringsContainString(
                          strings: deactivatedUsersIDs,
                          string: _user.id,
                      );

                      return UserTileButtonOld(
                        boxWidth: BldrsAppBar.width(context),
                        userModel: _user,
                        color: _buttonColor,
                        onUserTap: () => onUserTap(_user),
                        sideButtonVerse: sideButtonVerse,
                        sideButtonDeactivated: _isDeactivated || _isMe,
                        onSideButtonTap: () => onSideButtonTap(_user),
                      );

                    },
                  ),
                );

              },
            );

          }

          /// NO USERS FOUND
          else {
            return SuperVerse(
              verse: emptyListString ?? const Verse(
                text: 'phid_no_users_found',
                pseudo: 'No users found with this name',
                translate: true,
              ),
            );
          }

        }
    );

  }
  /// --------------------------------------------------------------------------
}
