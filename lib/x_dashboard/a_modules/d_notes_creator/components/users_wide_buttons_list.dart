import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_button.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class UserTileButtonsList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserTileButtonsList({
    @required this.usersModels,
    @required this.onUserTap,
    this.selectedUsers,
    this.emptyListString = 'No users found with this name',
    this.sideButton,
    this.onSideButtonTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<List<UserModel>> usersModels;
  final ValueNotifier<List<UserModel>> selectedUsers;
  final ValueChanged<UserModel> onUserTap;
  final String emptyListString;
  final String sideButton;
  final ValueChanged<UserModel> onSideButtonTap;
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
                  width: Scale.superScreenWidth(context),
                  height: Scale.superScreenHeight(context),
                  child: ListView.builder(
                    itemCount: foundUsers.length,
                    physics: const NeverScrollableScrollPhysics(),
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

                      return UserTileButton(
                        boxWidth: BldrsAppBar.width(context),
                        userModel: _user,
                        color: _buttonColor,
                        onUserTap: () => onUserTap(_user),
                        sideButton: sideButton,
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
              verse: emptyListString,
            );
          }

        }
    );

  }
}
