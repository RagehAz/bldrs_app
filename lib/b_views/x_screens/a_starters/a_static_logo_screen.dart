import 'dart:async';

import 'package:bldrs/b_views/x_screens/a_starters/aa_static_logo_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/c_controllers/a_starters_controllers/b_logo_screen_controllers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;

/// OLD LOGO SCREEN
class OldLogoScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const OldLogoScreen({
    // @required this.error,
    // @required this.loading,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<OldLogoScreen> createState() => _OldLogoScreenState();
  /// --------------------------------------------------------------------------
}

class _OldLogoScreenState extends State<OldLogoScreen> with TickerProviderStateMixin {
// -----------------------------------------------------------------------------
  // final String error;
  // final bool loading;
  AnimationController _scaleController; /// tamam disposed
  static const int _fadeCycleDuration = 750;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
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

        // await initializeLogoScreen(
        //   context: context,
        //   mounted: mounted,
        // );

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
