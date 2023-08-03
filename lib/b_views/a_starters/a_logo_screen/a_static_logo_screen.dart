import 'dart:async';

import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/aa_static_logo_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/a_initializer.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:flutter/material.dart';

class StaticLogoScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const StaticLogoScreen({
    // required this.error,
    // required this.loading,
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  State<StaticLogoScreen> createState() => _StaticLogoScreenState();
  /// --------------------------------------------------------------------------
}

class _StaticLogoScreenState extends State<StaticLogoScreen> with TickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  late AnimationController _scaleController;
  // final String error;
  static const int _fadeCycleDuration = 800;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _fadeCycleDuration),
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        Keyboard.closeKeyboard();

        final bool _loadApp = await Initializer.logoScreenInitialize(
          context: context,
        );

        if (_loadApp == true){
          await Nav.pushNamedAndRemoveAllBelow(
            context: context,
            goToRoute: Routing.home,
          );
        }

        /// else {
        ///   await BldrsNav.goToLogoScreenAndRemoveAllBelow(animatedLogoScreen: false);
        /// }

        await _triggerLoading(setTo: false);
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _scaleController.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    _scaleController.repeat(reverse: true, min: 0.97, max: 1);
    // --------------------
    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.non,
      skyType: SkyType.non,
      pyramidType: PyramidType.crystalYellow,
      loading: _loading,
      canGoBack: false,
      onBack: () async {

        await Nav.replaceScreen(
          context: context,
          screen: const StaticLogoScreen(),
        );

      },
      child: LogoScreenView(
        scaleController: _scaleController,
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
