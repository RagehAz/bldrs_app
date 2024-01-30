import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
import 'package:flutter/material.dart';

class LogoScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const LogoScreen({
    super.key
  });
  // --------------------
  ///
  // --------------------
  @override
  _LogoScreenState createState() => _LogoScreenState();
  // --------------------------------------------------------------------------
}

class _LogoScreenState extends State<LogoScreen> {
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await Future.delayed(const Duration(milliseconds: 50));
        await ScreenRouter.goTo(routeSettingsName: ScreenName.home, args: null);

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return const MainLayout(
      appBarType: AppBarType.non,
      skyType: SkyType.blackStars,
      pyramidType: PyramidType.crystalYellow,
      canSwipeBack: false,
      canGoBack: false,
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
