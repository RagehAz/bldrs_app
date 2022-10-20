import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
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
      addPostFrameCallBack: false,
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      pageTitle: 'Global Badge Number',
      listWidgets: <Widget>[

        SuperVerse(
          verse: Verse.plain('Badge Number : $_badgeNumber'),
          labelColor: Colorz.blue20,
          size: 4,
        ),

        /// READ BADGE AND REFRESH
        WideButton(
          verse: Verse.plain('GET NUMBER AND SET'),
          onTap: () async {

            final int _num = await FCM.instance.awesomeNotifications.getGlobalBadgeCounter();

            setState(() {
              _badgeNumber = _num;
            });

          },
        ),

        /// SET TO 99
        WideButton(
          verse: Verse.plain('refresh Badge number : $_badgeNumber}'),
          onTap: () async {

            await FCM.instance.awesomeNotifications.setGlobalBadgeCounter(99);

            blog('should be _num : 99');
            // setState(() {
            //   _badgeNumber = _num;
            // });

          },
        ),

        /// INCREMENT
        WideButton(
          verse: Verse.plain('refresh Badge number : $_badgeNumber}'),
          onTap: () async {

            final int _num = await FCM.instance.awesomeNotifications.incrementGlobalBadgeCounter();

            blog('should be _num : $_num');
            // setState(() {
            //   _badgeNumber = _num;
            // });

          },
        ),

        /// DECREMENT
        WideButton(
          verse: Verse.plain('refresh Badge number : $_badgeNumber}'),
          onTap: () async {

            final int _num = await FCM.instance.awesomeNotifications.decrementGlobalBadgeCounter();

            blog('should be _num : $_num');
            // setState(() {
            //   _badgeNumber = _num;
            // });

          },
        ),

        /// RESET
        WideButton(
          verse: Verse.plain('Reset}'),
          onTap: () async {

            await FCM.instance.awesomeNotifications.resetGlobalBadge();

            blog('badge number has been RESET');

          },
        ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
