import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/page_bubble.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/g_users_manager/users_manager_controller.dart';
import 'package:bldrs/x_dashboard/b_widgets/user_button.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UsersPage({
    @required this.screenHeight,
    @required this.usersModels,
    @required this.scrollController,
    @required this.pageController,
    @required this.selectedUser,
    @required this.selectedUserZone,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final ValueNotifier<List<UserModel>> usersModels;
  final ScrollController scrollController;
  final PageController pageController;
  final ValueNotifier<UserModel> selectedUser;
  final ValueNotifier<ZoneModel> selectedUserZone;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return PageBubble(
      key: const ValueKey<String>('UsersManagerScreen_UsersPage'),
      screenHeightWithoutSafeArea: screenHeight,
      appBarType: AppBarType.search,
      child: ValueListenableBuilder(
        valueListenable: usersModels,
        builder: (_, List<UserModel> users, Widget child){

          return ListView.builder(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: users.length,
            padding: const EdgeInsets.only(bottom: Ratioz.grandHorizon),
            itemExtent: 70,
            itemBuilder: (BuildContext context, int index) {
              return DashboardUserButton(
                width: PageBubble.clearWidth(context),
                userModel: users[index],
                index: index,
                onTap: () => onSelectUser(
                  context: context,
                  userModel: users[index],
                  pageController: pageController,
                  selectedUserModel: selectedUser,
                  selectedUserZone: selectedUserZone,
                ),
              );

            },
          );

        },
      ),
    );
  }
}
