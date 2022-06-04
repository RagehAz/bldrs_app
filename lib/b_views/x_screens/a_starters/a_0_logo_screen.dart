import 'dart:async';

import 'package:bldrs/b_views/y_views/a_starters/a_0_logo_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/a_0_logo_controller.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;

class LogoScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const LogoScreen({
    // @required this.error,
    // @required this.loading,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<LogoScreen> createState() => _LogoScreenState();
  /// --------------------------------------------------------------------------
}

class _LogoScreenState extends State<LogoScreen> with TickerProviderStateMixin {
// -----------------------------------------------------------------------------
  // final String error;
  // final bool loading;
  AnimationController _scaleController; /// tamam disposed
  static const int _fadeCycleDuration = 750;
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  /// HAS TO BE A FUTURE TO BE USED IN didChangeDependencies
  Future<void> _triggerLoading() async {
    if (mounted){
      _loading.value = !_loading.value;
      blogLoading(
        loading: _loading.value,
        callerName: 'LogoScreen',
      );
    }
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
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _scaleController.dispose();
    _loading.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading().then((_) async {

        await initializeLogoScreen(
          context: context,
          mounted: mounted,
        );

        await _triggerLoading();
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    _scaleController.repeat(reverse: true, min: 0.97, max: 1);

    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.non,
      loading: _loading,
      onBack: (){
        Nav.closeApp(context);
      },
      layoutWidget: LogoScreenView(
        scaleController: _scaleController,
      ),
    );
  }
}

/// TASK : NEED TO PUT THESE STATEMENTS FOR BZZ
///  - NO SUBSCRIPTION FEES
///  - NO SALES COMMISSION
///  - SHARE YOUR WORK AND YOUR SOCIAL MEDIA LINKS
///  - BLDRS COMMUNITY IS REFERRAL COMMUNITY
///  - NO VIOLATIONS ALLOWED
///  ...
