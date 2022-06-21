import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/d_user/a_user_profile/aaa1_user_profile_page.dart';
import 'package:bldrs/b_views/x_screens/d_user/a_user_profile/aaa2_user_status_page.dart';
import 'package:bldrs/b_views/x_screens/d_user/a_user_profile/aaa4_user_following_page.dart';
import 'package:bldrs/b_views/x_screens/d_user/a_user_profile/aaa3_user_notes_page.dart';
import 'package:bldrs/b_views/x_screens/d_user/a_user_profile/aaa5_user_settings_page.dart';
import 'package:flutter/material.dart';

class UserScreenViewPages extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserScreenViewPages({
    @required this.tabController,
    @required this.userModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TabController tabController;
  final UserModel userModel;
  /// --------------------------------------------------------------------------
  static const List<Widget> pages = <Widget>[

    UserProfilePage(showContacts: true),

    UserStatusPage(),

    UserNotesPage(),

    UserFollowingPage(),

    UserSettingsPage(),

  ];
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    userModel?.blogUserModel(methodName: 'UserScreenViewPages');

    return TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: pages,
    );
  }
}
