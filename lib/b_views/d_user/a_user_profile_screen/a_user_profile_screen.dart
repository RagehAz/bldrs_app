import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/x_ui/tabs/user_tabber.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/aa_user_screen_view_pages.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserProfileScreen({
    this.userTab = UserTab.profile,
    Key key
  }) : super(key: key);

  final UserTab userTab;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final UserModel _user = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );
    _user?.blogUserModel(invoker: 'UserProfileScreen');
    // --------------------
    return ObeliskLayout(
      initiallyExpanded: true,
      canGoBack: true,
      initialIndex: UserTabber.getUserTabIndex(userTab),
      navModels: <NavModel>[

        ...List.generate(UserTabber.userProfileTabsList.length, (index){

          final UserTab _userTab = UserTabber.userProfileTabsList[index];

          return NavModel(
            id: NavModel.getUserTabNavID(_userTab),
            titleVerse: UserTabber.translateUserTab(context: context, userTab: _userTab),
            icon: UserTabber.getUserTabIcon(_userTab),
            screen: UserScreenViewPages.pages[index],
          );

        }),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
