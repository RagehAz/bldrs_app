import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/y_views/g_user/user_screen_view.dart';
import 'package:bldrs/c_controllers/g_user_screen_controller.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {

  const UserProfileScreen({

    Key key
  }) : super(key: key);



  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _tabController = TabController(
      vsync: this,
      length: userProfileTabsList.length,
      initialIndex: getInitialUserScreenTabIndex(context),
    );

    _tabController.animation.addListener(
            () => onChangeUserScreenTabIndexWhileAnimation(
          context: context,
          tabController: _tabController,
        )
    );

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidsAreOn: true,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pageTitle: 'Profile',
      layoutWidget: UserProfileScreenView(
        tabController: _tabController,
      ),

    );

  }
}
