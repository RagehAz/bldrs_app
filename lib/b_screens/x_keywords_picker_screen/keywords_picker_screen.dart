import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class KeywordsPickerScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const KeywordsPickerScreen({
    super.key
  });
  // --------------------
  ///
  // --------------------
  @override
  _KeywordsPickerScreenState createState() => _KeywordsPickerScreenState();
  // --------------------------------------------------------------------------
  /// PhidsPickerScreen.goPickPhid
  static Future<String?> goPickPhid({
    required FlyerType? flyerType,
    required ViewingEvent? event,
    required bool onlyUseZoneChains,
    required bool slideScreenFromEnLeftToRight,
    List<String>? selectedPhids,
  }) async {

    // final String? phid = await BldrsNav.goToNewScreen(
    //   // pageTransitionType: Nav.superHorizontalTransition(
    //   //   appIsLTR: UiProvider.checkAppIsLeftToRight(),
    //   //   enAnimatesLTR: !slideScreenFromEnLeftToRight,
    //   // ),
    //   screen: PhidsPickerScreen(
    //     chainsIDs: FlyerTyper.getChainsIDsPerViewingEvent(
    //       flyerType: flyerType,
    //       event: ViewingEvent.homeView,
    //     ),
    //     onlyUseZoneChains: onlyUseZoneChains,
    //     selectedPhids: selectedPhids,
    //     // flyerModel: ,
    //     // multipleSelectionMode: false,
    //   ),
    // );

    // return phid;
    return null;
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> goPickPhids({
    required FlyerType? flyerType,
    required ViewingEvent event,
    required bool onlyUseZoneChains,
    required bool slideScreenFromEnLeftToRight,
    List<String>? selectedPhids,
  }) async {

    // final List<String>? phids = await BldrsNav.goToNewScreen(
    //   // pageTransitionType: Nav.superHorizontalTransition(
    //   //   appIsLTR: UiProvider.checkAppIsLeftToRight(),
    //   //   enAnimatesLTR: slideScreenFromEnLeftToRight,
    //   // ),
    //   screen: PhidsPickerScreen(
    //     chainsIDs: FlyerTyper.getChainsIDsPerViewingEvent(
    //       flyerType: flyerType,
    //       event: ViewingEvent.homeView,
    //     ),
    //     onlyUseZoneChains: onlyUseZoneChains,
    //     selectedPhids: selectedPhids ?? [],
    //     // flyerModel: ,
    //     multipleSelectionMode: true,
    //   ),
    // );

    // return phids ?? [];
    return [];
  }
  // -----------------------------------------------------------------------------
}

class _KeywordsPickerScreenState extends State<KeywordsPickerScreen> {
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
    return MainLayout(
      canSwipeBack: true,
      loading: _loading,
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
