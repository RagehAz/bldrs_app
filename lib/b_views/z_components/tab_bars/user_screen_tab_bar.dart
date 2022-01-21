import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/b_views/z_components/tab_bars/bldrs_sliver_tab_bar.dart';
import 'package:bldrs/c_controllers/g_user_screen_controller.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';


class UserScreenTabBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserScreenTabBar({
    @required this.tabController,
    @required this.currentUserTab,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TabController tabController;
  final UserTab currentUserTab;
  /// --------------------------------------------------------------------------
  bool _isSelected({
    @required BuildContext context,
    @required UserTab userTab,
  }){

    bool _isSelected = false;

    if (currentUserTab == userTab){
      _isSelected = true;
    }

    return _isSelected;
  }
// -----------------------------------------------------------------------------
  String _userTabIcon(UserTab userTab){
    switch(userTab){
      case UserTab.profile        : return Iconz.normalUser   ; break;
      case UserTab.status         : return Iconz.terms        ; break;
      case UserTab.notifications  : return Iconz.news         ; break;
      case UserTab.following      : return Iconz.follow       ; break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsSliverTabBar(
      tabController: tabController,
      tabs: <Widget>[

        /// IT HAS TO BE LIST.GENERATE ma3lesh
        ...List.generate(userProfileTabsList.length, (index){

          final UserTab _userTab = userProfileTabsList[index];
          final String _userTabString = cipherUserTabInEnglishOnly(_userTab);

          return

            TabButton(
              key: ValueKey<String>('user_tab_button_$_userTabString'),
              verse: _userTabString,
              icon: _userTabIcon(_userTab),
              isSelected: _isSelected(
                context: context,
                userTab: _userTab,
              ),
              onTap: () => onChangeUserScreenTabIndex(
                context: context,
                tabController: tabController,
                index: index,
              ),
            );

        }
        ),
      ],
    );
  }
}
