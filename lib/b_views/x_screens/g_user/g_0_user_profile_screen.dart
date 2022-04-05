import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/y_views/g_user/a_user_screen_view.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/g_user_controllers/user_screen_controller.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const UserProfileScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
/// --------------------------------------------------------------------------
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
      pageTitle: superPhrase(context, 'phid_my_account'),
      appBarRowWidgets: <Widget>[

        const Expander(),

        DreamBox(
          height: Ratioz.appBarButtonSize,
          width: Ratioz.appBarButtonSize,
          icon: Iconz.more,
          iconSizeFactor: 0.6,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          onTap: () => onMoreOptionsTap(context),
        ),

      ],
      layoutWidget: UserScreenView(
        tabController: _tabController,
      ),

    );

  }
}
