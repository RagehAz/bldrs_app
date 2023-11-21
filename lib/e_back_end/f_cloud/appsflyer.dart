import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class AppsFlyering {

  const AppsFlyering();

  // super link logic
  /*
  1- create dynamic link
  2- create short link
  3- user clicks the link
  4 user clicks the link goes to bldrs.net
  5- bldrs web index checks if the link is dynamic link
  6- if dynamic link, then checks if user has the app installed
  7- if user has the app installed, then opens the app
  8- if user doesn't have the app installed, then opens the app store, and stores a device
  signature along with the link in the database
  9- when user installs the app, the app checks if there is a device signature in the database
  10- if there is a device signature in the database, then the app opens the link
  11- if there is no device signature in the database, then the app opens the app normally
  12- if the user clicks the link and the app is already installed, then the app opens the link
   */


}


class AppsFlyerTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AppsFlyerTestScreen({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  _AppsFlyerTestScreenState createState() => _AppsFlyerTestScreenState();
  /// --------------------------------------------------------------------------
}

class _AppsFlyerTestScreenState extends State<AppsFlyerTestScreen> {
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
    return FloatingLayout(
      canSwipeBack: true,
      skyType: SkyType.blackStars,
      titleVerse: Verse.plain('Appsflyer test screen'),
      columnChildren: <Widget>[

        WideButton(
          verse: Verse.plain('~~~~~~~~~test~~~~~~~~~~'),
          onTap: () async {
            blog('~~~~~~~~~test~~~~~~~~~~ onTap');
          },
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
