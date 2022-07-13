import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/f_helpers/notifications/local_note.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/notifications/notifications_models/fcm_channel.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Notifications {

  Notifications();

  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // -----------------------------------
  //   String _ahmedURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/slidesPics%2FXmwKpOsu1RZW3YfDAkli_00.jpg?alt=media&token=a4c8a548-74d2-4086-b3db-1678f46db00a';
  static const String redBldrsBanner = 'resource://drawable/res_red_bldrs';
  static const String flatBldrsNotiIcon = 'resource://drawable/res_flat_logo';
  static const String flatBldrsNotiIcon2 = 'res_flat_logo'; //'resource://drawable/res_flat_logo'; // "@mipmap/ic_launcher"
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // -----------------------------------
  /// THIS GOES BEFORE RUNNING THE BLDRS APP
  static Future<void> preInitializeNotifications() async {
    FirebaseMessaging.onBackgroundMessage(notificationPushHandler);

    final AwesomeNotifications _awesomeNotification = AwesomeNotifications();

    await _awesomeNotification.initialize(
      flatBldrsNotiIcon,
      <NotificationChannel>[
        basicNotificationChannel(),
        scheduledNotificationChannel(),
      ],
    );
  }
  // -----------------------------------
  /// THIS GOES IN MAIN WIDGET INIT
  static Future<void> initializeNotifications(BuildContext context) async {
    final RemoteMessage initialRemoteMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialRemoteMessage != null) {
      blogRemoteMessage(
        methodName: 'initializeNoti',
        remoteMessage: initialRemoteMessage,
      );

      // can navigate here and shit

    }

    final FirebaseMessaging _fbm = FirebaseMessaging.instance;

    await _fbm.requestPermission(
      criticalAlert: true,
      carPlay: true,
      announcement: true,
      sound: true,
      provisional: true,
      badge: true,
      alert: true,
    );

    /// when app running in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {

      final Map<String, dynamic> _msgMap = remoteMessage.data;

      await onReceiveNotification(
        context: context,
        msgMap: _msgMap,
        // FCMTiming: FCMTiming.onMessage,
      );

    });

    /// when launching the app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {

      blogRemoteMessage(
        methodName: 'initializeNoti',
        remoteMessage: event,
      );

      final Map<String, dynamic> _msgMap = event.data;

      onReceiveNotification(
        context: context,
        msgMap: _msgMap,
        // FCMTiming: FCMTiming.onLaunch,
      );

      /// to display the notification while app in foreground
      LocalNotification.display(event);
    });

    /// when app running in background and notification tapped while having
    /// msg['data']['click_action'] == 'FLUTTER_NOTIFICATION_CLICK';
    FirebaseMessaging.onBackgroundMessage(notificationPushHandler);

    // fbm.getToken();
    await _fbm.subscribeToTopic('flyers');
  }
  // -----------------------------------
  static Future<NoteModel> onReceiveNotification({
    @required BuildContext context,
    @required dynamic msgMap,
    // @required FCMTiming FCMTiming,
  }) async {

    // blog('receiveAndActUponNoti : FCMTiming : $FCMTiming');

    NoteModel _noti;

    await tryAndCatch(
      context: context,
      onError: (String error) => blog(error),
      methodName: 'receiveAndActUponNoti',
      functions: () {
        _noti = NoteModel.decipherNote(
          map: msgMap,
          fromJSON: false,
        );
        },
    );

    return _noti;
  }
  // -----------------------------------------------------------------------------

  /// FCM

  // -----------------------------------
  /// fcm on background
  //  AndroidNotificationChannel channel;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static Future<void> notificationPushHandler(RemoteMessage message) async {

    blog('Handling a background message ${message.messageId}');

    blogRemoteMessage(
      methodName: 'fcmPushHandler',
      remoteMessage: message,
    );

    final bool _thing = await AwesomeNotifications().createNotificationFromJsonData(message.data);

    blog('thing is : $_thing');

    // if (!kIsWeb) {
    //   channel = const AndroidNotificationChannel(
    //     'high_importance_channel', // id
    //     'High Importance Notifications', // title
    //     'This channel is used for important notifications.', // description
    //     importance: Importance.high,
    //   );
    //
    //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    //
    //   /// Create an Android Notification Channel.
    //   ///
    //   /// We use this channel in the `AndroidManifest.xml` file to override the
    //   /// default FCM channel to enable heads up notifications.
    //   await flutterLocalNotificationsPlugin
    //       .resolvePlatformSpecificImplementation<
    //       AndroidFlutterLocalNotificationsPlugin>()
    //       ?.createNotificationChannel(channel);

    // /// Update the iOS foreground notification presentation options to allow
    // /// heads up notifications.
    // await FirebaseMessaging.instance
    //     .setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
    // }
  }
  // -----------------------------------------------------------------------------

  /// CREATION

  // -----------------------------------
  static Future<void> createWelcomeNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Numeric.createUniqueID(),
        channelKey: Notifications.getNotificationChannelName(FCMChannel.basic),
        title: '${Emojis.shape_red_triangle_pointed_up} Welcome to Bldrs.net',
        body: 'Browse Thousands of flyers and pick your choices',
        bigPicture: Notifications.redBldrsBanner,
        notificationLayout: NotificationLayout.BigPicture,
        color: Colorz.yellow255,
        backgroundColor: Colorz.bloodTest,
      ),
    );
  }
  // -----------------------------------
  static Future<void> createScheduledNotification() async {

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Numeric.createUniqueID(),
        channelKey: Notifications.getNotificationChannelName(FCMChannel.scheduled),
        title: '${Emojis.hotel_bellhop_bell} Alert from Bldrs.net',
        body: 'You need to open the app now, not tomorrow, not after tomorrow, NOW !, Do I make my self clear ? or you want me to repeat What I have just wrote,, read again !',
        bigPicture: Notifications.redBldrsBanner,
        notificationLayout: NotificationLayout.BigPicture,
        color: Colorz.yellow255,
        backgroundColor: Colorz.skyDarkBlue,
      ),
      actionButtons: <NotificationActionButton>[
        NotificationActionButton(
          key: 'MARK_DONE',
          label: 'Mark Done',
          icon: flatBldrsNotiIcon2,
          buttonType: ActionButtonType.KeepOnTop,
          // autoCancel: false,
          enabled: true,
        ),
      ],
      schedule: NotificationCalendar(
        repeats: true,
        weekday: 1,
        hour: 5,
        minute: 10,
        second: 10,
        millisecond: 10,
        month: 8,
        // timeZone:
        // weekOfMonth:,
        // weekOfYear: ,
        // year: ,
        // day: ,
        // allowWhileIdle: ,
        // era: ,
        // timeZone: ,
      ),
      // NotificationSchedule(
      //   allowWhileIdle: true,
      //   // crontabSchedule:
      //   initialDateTime: DateTime.now(),
      //   preciseSchedules: <DateTime>[
      //     DateTime.now(),
      //   ],
      // ),
    );
  }
  // -----------------------------------------------------------------------------

  /// CANCELLATION

  // -----------------------------------
  static Future<void> cancelScheduledNotification() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
  // -----------------------------------------------------------------------------

  /// CHANNELS

  // -----------------------------------
  static String getNotificationChannelName(FCMChannel channel) {
    switch (channel) {
      case FCMChannel.basic: return 'Basic Notifications';break;
      case FCMChannel.scheduled: return 'Scheduled Notifications';break;
      default: return 'Basic Notifications';
    }
  }
  // -----------------------------------
  static NotificationChannel basicNotificationChannel() {
    return NotificationChannel(
      channelKey: getNotificationChannelName(FCMChannel.basic),
      channelName: getNotificationChannelName(FCMChannel.basic),
      channelDescription:
      'this is for testing', // this will be visible to user in android notification settings
      defaultColor: Colorz.yellow255,
      channelShowBadge: true,
      icon: flatBldrsNotiIcon,
      ledColor: Colorz.yellow255,
      importance: NotificationImportance.High,
      locked: true,
      playSound: true,
      soundSource: 'resource://raw/res_hi', //Audioz.randomBldrsNameSoundPath(),
      enableLights: true,
      enableVibration: true,
    );
  }
  // -----------------------------------
  static NotificationChannel scheduledNotificationChannel() {
    return NotificationChannel(
      channelKey: getNotificationChannelName(FCMChannel.scheduled),
      channelName: getNotificationChannelName(FCMChannel.scheduled),
      channelDescription:
      'This is the first scheduled notification', // this will be visible to user in android notification settings
      defaultColor: Colorz.yellow255,
      channelShowBadge: true,
      enableLights: true,
      icon: flatBldrsNotiIcon,
      ledColor: Colorz.yellow255,
      importance: NotificationImportance.High,
      enableVibration: true,
      playSound: true,
      locked: true,
      soundSource: Sounder.randomBldrsNameSoundPath(),
    );
  }
  // -----------------------------------

  /// GETTERS

  // -----------------------------------------------------------------------------
  static Future<void> onNotifyButtonTap({
    @required BuildContext context,
    @required Widget screenToGoToOnNotiTap,
  }) async {

    await notify();

    AwesomeNotifications().actionStream.listen((ReceivedAction receivedNoti) {
      Nav.pushAndRemoveUntil(
        context: context,
        screen: screenToGoToOnNotiTap,
      );
    });

  }
  // -----------------------------------------------------------------------------
  static Future<void> notify() async {
    // String _timeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'onNotifyTap',
        title: 'Local Notify by tap',
        body: 'this was sent by tapping a button',
        bigPicture: redBldrsBanner,
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // -----------------------------------
  static void blogRemoteMessage({
    String methodName,
    RemoteMessage remoteMessage
  }) {

    final RemoteNotification remoteNotification = remoteMessage.notification;
    final String category = remoteMessage.category;
    final String collapseKey = remoteMessage.collapseKey;
    final bool contentAvailable = remoteMessage.contentAvailable;
    final String from = remoteMessage.from;
    final String messageId = remoteMessage.messageId;
    final String messageType = remoteMessage.messageType;
    final bool mutableContent = remoteMessage.mutableContent;
    final String senderId = remoteMessage.senderId;
    final DateTime sentTime = remoteMessage.sentTime;
    final String threadId = remoteMessage.threadId;
    final int ttl = remoteMessage.ttl;
    final Map<String, dynamic> data = remoteMessage.data;

    blog('blogING REMOTE MESSAGE ATTRIBUTES ------------- START -');

    blog('1 - METHOD NAMED : $methodName');
    blog('2 - remoteNotification : $remoteNotification');
    blog('3 - category : $category');
    blog('4 - collapseKey : $collapseKey');
    blog('5 - contentAvailable : $contentAvailable');
    blog('6 - from : $from');
    blog('7 - messageId : $messageId');
    blog('8 - messageType : $messageType');
    blog('9 - mutableContent : $mutableContent');
    blog('10 - senderId : $senderId');
    blog('11 - sentTime : $sentTime');
    blog('12 - threadId : $threadId');
    blog('13 - ttl : $ttl');
    blog('14 - data : $data');

    blog('blogING REMOTE MESSAGE ATTRIBUTES ------------- END -');
  }
// -----------------------------------------------------------------------------
}
