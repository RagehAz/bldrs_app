import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/y_views/g_user/b_0_user_screen_view_pages.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/obelisk_layout.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserProfileScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ObeliskLayout(
      isFlashing: ValueNotifier<bool>(false),
      initiallyExpanded: true,
      navModels: <NavModel>[

        ...List.generate(UserModel.userProfileTabsList.length, (index){

          final UserTab _userTab = UserModel.userProfileTabsList[index];

          return NavModel(
            title: UserModel.translateUserTab(context: context, userTab: _userTab),
            icon: UserModel.getUserTabIcon(_userTab),
            screen: UserScreenViewPages.pages[index],
          );

        }),

      ],
    );

  }
}
