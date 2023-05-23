import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/a_models/x_ui/tabs/user_tabber.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/user_screen_view_pages.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout.dart';
import 'package:flutter/material.dart';

class ObeliskTestScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ObeliskLayout(
      canGoBack: true,
      navModels: <NavModel>[

        ...List.generate(UserTabber.userProfileTabsList.length, (index){
          final UserTab _userTab = UserTabber.userProfileTabsList[index];
          return NavModel(
            id: NavModel.getMainNavIDString(navID: MainNavModel.profile),
            titleVerse: UserTabber.translateUserTab(context: context, userTab: _userTab),
            icon: UserTabber.getUserTabIcon(_userTab),
            screen: UserScreenViewPages.pages[index],
          );
        }),

        ],
    );

  }
/// --------------------------------------------------------------------------
}
