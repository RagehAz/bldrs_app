import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/a_flyers_wall_page/components/home_screen_view.dart';
import 'package:bldrs/z_components/layouts/custom_layouts/app_bar_holder.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class FlyersWallPage extends StatefulWidget {
  // --------------------------------------------------------------------------
  const FlyersWallPage({
    super.key
  });
  // --------------------
  ///
  // --------------------
  @override
  _FlyersWallPageState createState() => _FlyersWallPageState();
  // --------------------------------------------------------------------------
}

class _FlyersWallPageState extends State<FlyersWallPage> {
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
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _triggerLoading(setTo: true);
        /// GO BABY GO
        await _triggerLoading(setTo: false);

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
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return const AppBarHolder(
      appBarType: AppBarType.main,
      listenToHideLayout: true,
      child: HomeFlyersGrid(),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
