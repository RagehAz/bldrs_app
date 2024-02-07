import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/sub/a_initializer.dart';
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

      asyncInSync(() async {

        await Future.delayed(const Duration(milliseconds: 400));
        setState(() {
          _isInit = false; // good
        });
        await Future.delayed(const Duration(milliseconds: 700));

        await Initializer.routeAfterLoaded(mounted: mounted);

        // await Routing.goTo(route: ScreenName.home);

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
    if (_isInit == true){
      return const SizedBox();
    }
    // --------------------
    else {
      return const MainLayout(
        appBarType: AppBarType.non,
        skyType: SkyType.blackStars,
        pyramidType: PyramidType.crystalYellow,
        canSwipeBack: false,
        canGoBack: false,
      );
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
