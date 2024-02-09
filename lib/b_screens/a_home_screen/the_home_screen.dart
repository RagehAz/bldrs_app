import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/a_flyers_wall_page/components/home_layout.dart';
import 'package:bldrs/c_protocols/a_bldrs_engine/bldrs_engine.dart';
import 'package:flutter/material.dart';

class TheHomeScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const TheHomeScreen({
    super.key
  });
  // --------------------
  @override
  State<TheHomeScreen> createState() => _TheHomeScreenState();
  // --------------------------------------------------------------------------
}

class _TheHomeScreenState extends State<TheHomeScreen> with TickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    super.initState();

    BldrsEngine.homePreInit(
      vsync: this,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await BldrsEngine.homeInit(
          context: context,
          mounted: mounted,
        );

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    BldrsEngine.homeDispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

      return const HomeLayout();

    // --------------------
  }
  // -----------------------------------------------------------------------------
}
