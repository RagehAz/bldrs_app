import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/a_profile_page/aaa1_user_profile_page.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/b_notes_page/aaa2_user_notes_page.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/c_follows_page/aaa3_user_following_page.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/d_settings_page/user_settings_page.dart';
import 'package:flutter/material.dart';

class UserScreenViewPages extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserScreenViewPages({
    required this.tabController,
    required this.userModel,
    super.key
  });
  /// --------------------------------------------------------------------------
  final TabController tabController;
  final UserModel? userModel;
  /// --------------------------------------------------------------------------
  static const List<Widget> pages = <Widget>[

    UserProfilePage(),

    UserNotesPage(),

    UserFollowingPage(),

    UserSettingsPage(),

  ];
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    // userModel?.blogUserModel(invoker: 'UserScreenViewPages');
    // --------------------
    return TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: pages,
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
