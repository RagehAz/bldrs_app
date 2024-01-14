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
    TabsProvider.proInitializeTabBarController(
      context: context,
      vsync: this,
    );
  }
  // --------------------
  @override
  void dispose() {
    TabsProvider.proDisposeTabBarController();
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
