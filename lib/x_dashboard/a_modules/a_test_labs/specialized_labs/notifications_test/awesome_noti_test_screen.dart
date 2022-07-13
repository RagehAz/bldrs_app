import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart' as DeviceChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/notifications/notifications.dart';
import 'package:bldrs/f_helpers/notifications/notifications_models/fcm_channel.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/notifications_test/second_noti_test_screen.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class AwesomeNotiTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AwesomeNotiTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _AwesomeNotiTestScreenState createState() => _AwesomeNotiTestScreenState();
/// --------------------------------------------------------------------------
}

class _AwesomeNotiTestScreenState extends State<AwesomeNotiTestScreen> {
  //var vibrationPattern = new Int64List.fromList([1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000]);
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (mounted) {
      if (function == null) {
        setState(() {
          _loading = !_loading;
        });
      } else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  AwesomeNotifications _awesomeNotification;
  GlobalKey _scaffoldKey;
  StreamSubscription _streamSubscription;
  @override
  void initState() {
    super.initState();

    /// should be put in main
    // FirebaseMessaging.onBackgroundMessage(_firebasePushHandler)

    // final _scaffoldKey = GlobalKey<ScaffoldState>();

    _awesomeNotification = AwesomeNotifications();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _triggerLoading().then((_) async {

        final bool _isAllowed = await isNotificationAllowed();

        if (_isAllowed == false) {
          await _requestNotificationPermission();
        }

        await _listenToNotificationsStream(context);

        unawaited(_triggerLoading());
      });

      _isInit = false;
    }
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _awesomeNotification.actionSink.close();
    _awesomeNotification.createdSink.close();
    _awesomeNotification.dispose();
    _streamSubscription?.cancel();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
//   Future<void> _firebasePushHandler(RemoteMessage message){
//     blog('_firebasePushHandler : message : $message');
//
//     _awesomeNotification.createNotificationFromJsonData(message.data);
//   }
// -----------------------------------------------------------------------------
  Future<void> _requestNotificationPermission() async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Allow notifications',
      body: 'To be able to know what is going on',
      boolDialog: true,
    );

    if (_result == true) {
      await _awesomeNotification.requestPermissionToSendNotifications();
    }

  }
// -----------------------------------------------------------------------------
  Future<bool> isNotificationAllowed() async {

    bool _allowed = false;

    if (_awesomeNotification != null){
      _allowed = await _awesomeNotification.isNotificationAllowed();
    }

    blog('isNotificationAllowed : $_allowed');

    return _allowed;
  }
// -----------------------------------------------------------------------------
  Future<void> _listenToNotificationsStream(BuildContext context) async {

    blog('_listenToNotificationsStream --------- START');

    final bool _notificationsAllowed = await isNotificationAllowed();

    if (_notificationsAllowed != null) {

      _streamSubscription = _awesomeNotification.createdStream.listen((ReceivedNotification notification) async {

        blog('the FUCKING notification is aho 5ara :  Channel : ${notification.channelKey} : id : ${notification.id}');

        await TopDialog.showTopDialog(
          context: context,
          firstLine: 'Notification created',
          secondLine: 'sent on Channel : ${notification.channelKey} : id : ${notification.id}',
        );

      });

      _awesomeNotification.actionStream.listen((ReceivedAction notification) async {

        final bool _isBasicChannel = notification.channelKey == Notifications.getNotificationChannelName(FCMChannel.basic);

        final bool _isIOS = DeviceChecker.deviceIsIOS();

        if (_isBasicChannel && _isIOS) {
          final int _x = await _awesomeNotification.getGlobalBadgeCounter();
          await _awesomeNotification.setGlobalBadgeCounter(_x - 1);
        }

        await Nav.pushAndRemoveUntil(
          context: context,
          screen: const SecondNotiTestScreen(

          ),
        );

      });
    }

    blog('_listenToNotificationsStream --------- END');
  }

// -----------------------------------------------------------------------------
  Future<void> _onSendNotification() async {
    await Notifications.createWelcomeNotification();
  }
// -----------------------------------------------------------------------------
  Future<void> _onSendScheduledNotification() async {
    await Notifications.createScheduledNotification();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      scaffoldKey: _scaffoldKey,
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pageTitle: 'Awesome notification test',
      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          /// SEND NOTIFICATION
          Container(
            width: 300,
            height: 300,
            alignment: Alignment.center,
            child: DreamBox(
              height: 60,
              width: 250,
              verse: 'Send Notification Bitch !',
              verseScaleFactor: 0.7,
              color: Colorz.yellow255,
              verseColor: Colorz.black255,
              verseShadow: false,
              onTap: _onSendNotification,
            ),
          ),

          /// SEND SCHEDULED
          DreamBox(
            height: 60,
            width: 250,
            verse: 'send scheduled',
            verseScaleFactor: 0.7,
            color: Colorz.yellow255,
            verseColor: Colorz.black255,
            verseShadow: false,
            onTap: _onSendScheduledNotification,
          ),

          /// CANCEL SCHEDULED
          DreamBox(
            height: 60,
            width: 250,
            verse: 'cancel schedules',
            verseScaleFactor: 0.7,
            color: Colorz.yellow255,
            verseColor: Colorz.black255,
            verseShadow: false,
            onTap: () async {
              await Notifications.cancelScheduledNotification();
            },
          ),

          WideButton(
            verse: 'Cancel Stream',
            onTap: () async {

              if (_streamSubscription == null){
                blog('_streamSubscription is null');
              }
              else {
                await _streamSubscription.cancel();
                blog('_streamSubscription is cancelled');
              }

            },
          ),

        ],
      ),
    );

  }
}
