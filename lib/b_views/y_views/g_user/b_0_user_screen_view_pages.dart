import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/y_views/g_user/b_1_user_profile_page.dart';
import 'package:bldrs/b_views/y_views/g_user/b_2_user_status_page.dart';
import 'package:bldrs/b_views/y_views/g_user/b_3_user_following_page.dart';
import 'package:bldrs/b_views/y_views/g_user/b_3_user_notifications_page.dart';
import 'package:flutter/material.dart';

class UserScreenViewPages extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserScreenViewPages({
    @required this.tabController,
    @required this.userModel,
    @required this.notes,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TabController tabController;
  final UserModel userModel;
  final List<NoteModel> notes;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    userModel?.blogUserModel(methodName: 'UserScreenViewPages');

    return TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: <Widget>[

        UserProfilePage(
          userModel: userModel,
        ),

        UserStatusPage(
          userModel: userModel,
        ),

        UserNotificationsPage(
          userModel: userModel,
          notes: notes,
        ),

        UserFollowingPage(
          userModel: userModel,
        ),

      ],
    );
  }
}
