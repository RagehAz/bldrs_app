import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/tabbing/tabs_provider.dart';
import 'package:bldrs/z_components/layouts/mirage/mirage.dart';
import 'package:flutter/material.dart';

class TheHomeScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const TheHomeScreen({
    super.key
  });

  @override
  State<TheHomeScreen> createState() => _TheHomeScreenState();
}

class _TheHomeScreenState extends State<TheHomeScreen> with TickerProviderStateMixin{
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    /// TAB BAR CONTROLLER
    TabsProvider.proInitializeTabBarController(
      context: context,
      vsync: this,
    );

    /// KEYBOARD
    UiProvider.proInitializeKeyboard();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {



      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    TabsProvider.proDisposeTabBarController();
    UiProvider.disposeKeyword();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return const MirageLayout();
    // --------------------
  }
// -----------------------------------------------------------------------------
}
