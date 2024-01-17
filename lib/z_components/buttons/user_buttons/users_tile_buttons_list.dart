// ignore_for_file: unused_element
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/z_components/buttons/user_buttons/user_tile_button_old.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class UserTileButtonsList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserTileButtonsList({
    required this.usersModels,
    required this.onUserTap,
    required this.selectedUsers,
    this.emptyListString,
    this.sideButtonVerse,
    this.onSideButtonTap,
    this.deactivatedUsersIDs,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<List<UserModel>?> usersModels;
  final ValueNotifier<List<UserModel>?>? selectedUsers;
  final ValueChanged<UserModel>? onUserTap;
  final Verse? emptyListString;
  final Verse? sideButtonVerse;
  final ValueChanged<UserModel>? onSideButtonTap;
  final List<String>? deactivatedUsersIDs;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: usersModels,
        builder: (_, List<UserModel>? users, Widget? child){

          /// FOUND USERS
          if (Lister.checkCanLoop(users) == true){

            blog('UserTileButtonsList: found users (${users!.length})');

            /// SELECTION MODE
            if (selectedUsers == null){
              return _UsersButtons(
                deactivatedUsersIDs: deactivatedUsersIDs ?? const <String>[],
                onSideButtonTap: onSideButtonTap,
                onUserTap: onUserTap,
                selectedUsers: const <UserModel>[],
                sideButtonVerse: sideButtonVerse,
                users: users,
              );          }

            /// NO SELECTION
            else {
              return ValueListenableBuilder(
                valueListenable: selectedUsers!,
                builder: (_, List<UserModel>? selectedUsers, Widget? child){

                  return _UsersButtons(
                    deactivatedUsersIDs: deactivatedUsersIDs ?? const <String>[],
                    onSideButtonTap: onSideButtonTap,
                    onUserTap: onUserTap,
                    selectedUsers: selectedUsers ?? const <UserModel>[],
                    sideButtonVerse: sideButtonVerse,
                    users: users,
                  );

                  },
              );
            }

          }

          /// NO USERS FOUND
          else {
            return BldrsText(
              verse: emptyListString ?? const Verse(
                id: 'phid_no_users_found',
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

class _UsersButtons extends StatelessWidget {

  const _UsersButtons({
    required this.users,
    required this.selectedUsers,
    required this.deactivatedUsersIDs,
    required this.onUserTap,
    required this.sideButtonVerse,
    required this.onSideButtonTap,
    super.key
  });

  final List<UserModel> users;
  final List<UserModel> selectedUsers;
  final List<String> deactivatedUsersIDs;
  final Function(UserModel)? onUserTap;
  final Verse? sideButtonVerse;
  final Function(UserModel)? onSideButtonTap;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: Scale.screenWidth(context),
      height: Scale.screenHeight(context),
      child: ListView.builder(

        itemCount: users.length,
        physics: const NeverScrollableScrollPhysics(),
        // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
        itemBuilder: (_, index){

          final UserModel _user = users[index];
          final bool _isSelected = UserModel.checkUsersContainUser(
            usersModels: selectedUsers,
            userModel: _user,
          );
          final bool _isMe = _user.id == Authing.getUserID();
          final Color? _buttonColor = _isSelected == true ? Colorz.green255
              :
          _isMe == true ? Colorz.black255
              :
          null;
          final bool _isDeactivated = Stringer.checkStringsContainString(
            strings: deactivatedUsersIDs,
            string: _user.id,
          );

          return UserTileButtonOld(
            boxWidth: BldrsAppBar.width(),
            userModel: _user,
            color: _buttonColor,
            onUserTap: () => onUserTap?.call(_user),
            sideButtonVerse: sideButtonVerse,
            sideButtonDeactivated: _isDeactivated || _isMe,
            onSideButtonTap: () => onSideButtonTap?.call(_user),
          );
          },
      ),
    );
  }

}
