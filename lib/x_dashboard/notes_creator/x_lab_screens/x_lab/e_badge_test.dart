import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';

import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class GlobalBadgeTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const GlobalBadgeTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _GlobalBadgeTestState createState() => _GlobalBadgeTestState();
/// --------------------------------------------------------------------------
}

class _GlobalBadgeTestState extends State<GlobalBadgeTest> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
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

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  int _badgeNumber = 0;
  // --------------------
  Future<void> _getSetBadgeNumber() async {

    await NotesProvider.proRefreshBadgeNum(context);
    final int _num = NotesProvider.proGetBadgeNum(
      context: context,
      listen: false,
    );

    setState(() {
      _badgeNumber = _num;
    });

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      pageTitle: 'Global Badge Number',
      listWidgets: <Widget>[

        /// BADGE NUMBER
        SuperVerse(
          verse: Verse.plain('Badge Number : $_badgeNumber'),
          labelColor: Colorz.blue20,
          size: 4,
        ),

        /// READ BADGE AND REFRESH
        WideButton(
          verse: Verse.plain('GET NUMBER AND SET'),
          onTap: () async {
            await _getSetBadgeNumber();
          },
        ),

        /// SET TO 99
        WideButton(
          verse: Verse.plain('SET TO 99'),
          onTap: () async {

            await FCM.instance.awesomeNotifications.setGlobalBadgeCounter(99);
            await _getSetBadgeNumber();

          },
        ),

        /// SET TO zero
        WideButton(
          verse: Verse.plain('SET TO zero'),
          onTap: () async {

            await FCM.instance.awesomeNotifications.setGlobalBadgeCounter(0);
            await _getSetBadgeNumber();

          },
        ),

        /// INCREMENT
        WideButton(
          verse: Verse.plain('INCREMENT Badge number'),
          onTap: () async {

            await FCM.instance.awesomeNotifications.incrementGlobalBadgeCounter();
            await _getSetBadgeNumber();

          },
        ),

        /// DECREMENT
        WideButton(
          verse: Verse.plain('DECREMENT Badge number'),
          onTap: () async {

            await FCM.instance.awesomeNotifications.decrementGlobalBadgeCounter();
            await _getSetBadgeNumber();

          },
        ),

        /// RESET
        WideButton(
          verse: Verse.plain('Reset'),
          onTap: () async {

            await FCM.instance.awesomeNotifications.resetGlobalBadge();
            await _getSetBadgeNumber();

          },
        ),


        /// REQUEST PERMISSIONS
        WideButton(
          verse: Verse.plain('REQUEST PERMISSIONS'),
          onTap: () async {

            await FCM.requestAwesomePermission();

          },
        ),

        /// APP BADGER PLUGIN TESTS : WORKS PERFECT BUT NOT NEEDED
        /*
        // import 'package:flutter_app_badger/flutter_app_badger.dart';
        bool _appBadgerSupported;

        /// APP BADGER SUPPORTED
        SuperVerse(
          verse: Verse.plain('App Badge Supported ? $_appBadgerSupported'),
          labelColor: Colorz.blue20,
          size: 4,
        ),

        /// APP BADGER IS SUPPORTED
        WideButton(
          verse: Verse.plain('APP BADGER IS SUPPORTED ?'),
          onTap: () async {

            final bool _supported = await FlutterAppBadger.isAppBadgeSupported();

            setState(() {
              _appBadgerSupported = _supported;
            });
            blog('is supported = $_supported');

          },
        ),

        /// APP BADGER UPDATE
        WideButton(
          verse: Verse.plain('APP BADGER UPDATE to 66'),
          onTap: () async {

            await FlutterAppBadger.updateBadgeCount(66);


          },
        ),

        /// APP BADGER UPDATE
        WideButton(
          verse: Verse.plain('APP BADGER REMOVER'),
          onTap: () async {

            await FlutterAppBadger.removeBadge();


          },
        ),

         */

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
