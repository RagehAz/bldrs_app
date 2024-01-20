import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/a_flyers_wall_page/components/home_layout.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/bldrs_engine.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
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

    blog('init TheHomeScreen');

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
    // --------------------
    /// FIX_AFTER_HOME_ROUTE_LOGIC
    final RouteSettings? _afterHomeRoute = UiProvider.proGetAfterHomeRoute(
      context: context,
      /// this needed true for BldrsNav.restartAndRoute()
      /// it does result in rebuilding entire tree when triggering pyramid
      /// but turning this false is not the solution for that
      /// you just can't turn this false
      listen: true,
    );
    // --------------------
    /// WHEN AFTER HOME ROUTE IS DEFINED => works as loading screen until didChangedDependencies methods finish
    if (_afterHomeRoute != null){
      return MainLayout(
        canSwipeBack: false,
        onBack: () => UiProvider.proClearAfterHomeRoute(notify: true),
        child: const SizedBox(),
      );
    }
    // --------------------
    else {
      return const HomeLayout();
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
