import 'dart:async';
// import 'package:bldrs/c_controllers/a_starters_controllers/x_logo_screen_controllers.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/aa_static_logo_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/x_logo_screen_controllers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:flutter/material.dart';

/// OLD LOGO SCREEN
class StaticLogoScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const StaticLogoScreen({
    // @required this.error,
    // @required this.loading,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<StaticLogoScreen> createState() => _StaticLogoScreenState();
  /// --------------------------------------------------------------------------
}

class _StaticLogoScreenState extends State<StaticLogoScreen> with TickerProviderStateMixin {
// -----------------------------------------------------------------------------
  // final String error;
  // final bool loading;
  AnimationController _scaleController;
  static const int _fadeCycleDuration = 800;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'OldLogoScreen',);
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
  /// TAMAM
  @override
  void dispose() {
    _scaleController.dispose();
    _loading.dispose();
    super.dispose();
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

        await Nav.pushNamedAndRemoveAllBelow(
          context: context,
          goToRoute: Routez.home,
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
