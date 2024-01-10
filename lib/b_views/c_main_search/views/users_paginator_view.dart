import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/z_components/users_list.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:fire/super_fire.dart';

import 'package:flutter/material.dart';

class UsersPaginatorView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const UsersPaginatorView({
    required this.paginationController,
    required this.fireQueryModel,
    this.onUserTap,
    super.key
  });
  // --------------------
  final FireQueryModel? fireQueryModel;
  final PaginationController paginationController;
  final Function(UserModel userModel)? onUserTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return  FireCollPaginator(
        paginationQuery: fireQueryModel,
        paginationController: paginationController,
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget? child){

          final List<UserModel> _users = UserModel.decipherUsers(
              maps: maps,
              fromJSON: false,
          );

          return UsersList(
            width: Bubble.bubbleWidth(context: context),
            users: _users,
            scrollController: paginationController.scrollController,
            scrollPadding: Stratosphere.getStratosphereSandwich(
                context: context,
                appBarType: AppBarType.search,
            ),
            onTap: onUserTap,
          );

        },
      );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
