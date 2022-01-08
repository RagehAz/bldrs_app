import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/widgets/specific/bz/appbar/bz_app_bar.dart';
import 'package:bldrs/b_views/y_views/f_bz_views/my_bz_screen_view.dart';
import 'package:bldrs/c_controllers/f_bz_controller.dart';
import 'package:flutter/material.dart';

class MyBzScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const MyBzScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _MyBzScreenState createState() => _MyBzScreenState();
/// --------------------------------------------------------------------------
}

class _MyBzScreenState extends State<MyBzScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _tabController = TabController(
      vsync: this,
      length: BzModel.bzPagesTabsTitles.length,
      initialIndex: getInitialMyBzScreenTabIndex(context),
    );

    _tabController.animation.addListener(
            () => onChangeMyBzScreenTabIndexWhileAnimation(
          context: context,
          tabController: _tabController,
        )
    );


    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidsAreOn: true,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      appBarRowWidgets: const <Widget>[BzAppBar(),],
      layoutWidget: MyBzScreenView(
        tabController: _tabController,
      ),

    );

  }
}
