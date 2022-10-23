import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/aa_user_screen_view_pages.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/nav_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserProfileScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final UserModel _user = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );
    _user?.blogUserModel(methodName: 'UserProfileScreen');
    // --------------------
    return ObeliskLayout(
      initiallyExpanded: true,
      canGoBack: true,
      navModels: <NavModel>[

        ...List.generate(UserModel.userProfileTabsList.length, (index){

          final UserTab _userTab = UserModel.userProfileTabsList[index];

          return NavModel(
            id: NavModel.getUserTabNavID(_userTab),
            titleVerse: UserModel.translateUserTab(context: context, userTab: _userTab),
            icon: UserModel.getUserTabIcon(_userTab),
            screen: UserScreenViewPages.pages[index],
          );

        }),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
