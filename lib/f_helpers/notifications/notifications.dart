import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/fcm_token.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/notifications/local_note.dart';
import 'package:bldrs/f_helpers/notifications/notifications_models/fcm_channel.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Notifications {
  // -----------------------------------------------------------------------------

  const Notifications();

  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String redBldrsBanner = 'resource://drawable/res_red_bldrs';
  static const String flatBldrsNotiIcon = 'resource://drawable/res_flat_logo';
  static const String flatBldrsNotiIcon2 = 'res_flat_logo'; ///'resource://drawable/res_flat_logo'; // "@mipmap/ic_launcher"
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> preInitializeNotifications() async {

    /// THIS GOES BEFORE RUNNING THE BLDRS APP

    FirebaseMessaging.onBackgroundMessage(_pushNotificationFromRemoteMessage);

    final AwesomeNotifications _awesomeNotification = AwesomeNotifications();

    await _awesomeNotification.initialize(
      flatBldrsNotiIcon,
      <NotificationChannel>[
        basicNotificationChannel(),
        scheduledNotificationChannel(),
      ],
    );

  }
  // --------------------
  /// TESTED : ...
  static Future<void> initializeNotifications(BuildContext context) async {
    /// THIS GOES IN MAIN WIDGET INIT

    final RemoteMessage initialRemoteMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialRemoteMessage != null) {
      blogRemoteMessage(
        methodName: 'initializeNotifications',
        remoteMessage: initialRemoteMessage,
      );

      blog('can navigate here and shit');

    }

    final FirebaseMessaging _fireMessaging = FirebaseMessaging.instance;

    await _fireMessaging.requestPermission(
      criticalAlert: true,
      carPlay: true,
      announcement: true,
      sound: true,
      provisional: true,
      badge: true,
      alert: true,
    );

    /// APP IS IN FOREGROUND ( FRONT AND ACTIVE )
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
      await onReceiveNotification(
        context: context,
        remoteMessage: remoteMessage,
        callerName: 'onMessage',
      );
    });

    /// APP IS LAUNCHING ( AT STARTUP )
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {

      blog('onMessageOpenedApp : when does this fucking work exactly mesh fahem ya3ny');

      onReceiveNotification(
        context: context,
        remoteMessage: remoteMessage,
        callerName: 'onMessageOpenedApp',
      );

      /// to display the notification while app in foreground
      LocalNotification.display(remoteMessage);
    });

    /// when app running in background and notification tapped while having
    /// msg['data']['click_action'] == 'FLUTTER_NOTIFICATION_CLICK';
    FirebaseMessaging.onBackgroundMessage(_pushNotificationFromRemoteMessage);

    // fbm.getToken();
    // await _fireMessaging.subscribeToTopic('flyers');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onReceiveNotification({
    @required BuildContext context,
    @required RemoteMessage remoteMessage,
    @required String callerName,
  }) async {

    blogRemoteMessage(
      methodName: 'callerName : $callerName',
      remoteMessage: remoteMessage,
    );

    await _pushNotificationFromRemoteMessage(remoteMessage);

  }
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : ...
  static Future<void> _pushNotificationFromRemoteMessage(RemoteMessage remoteMessage) async {

    if (remoteMessage != null){

      final String body = remoteMessage?.notification?.body;
      final String title = remoteMessage?.notification?.title;
      // final AndroidNotification android = remoteMessage?.notification?.android;
      // final AppleNotification apple = remoteMessage?.notification?.apple;
      // final String analyticsLabel = remoteMessage?.notification?.web?.analyticsLabel;
      // final String image = remoteMessage?.notification?.web?.image;
      // final String link = remoteMessage?.notification?.web?.link;
      // final String bodyLocKey = remoteMessage?.notification?.bodyLocKey;
      // final List<String> bodyLocArgs = remoteMessage?.notification?.bodyLocArgs;
      // final String titleLocKey = remoteMessage?.notification?.titleLocKey;
      // final List<String> titleLocArgs = remoteMessage?.notification?.titleLocArgs;
      // final String category = remoteMessage?.category;
      // final String collapseKey = remoteMessage?.collapseKey;
      // final bool contentAvailable = remoteMessage?.contentAvailable;
      // final String from = remoteMessage?.from;
      // final String messageId = remoteMessage?.messageId;
      // final String messageType = remoteMessage?.messageType;
      // final bool mutableContent = remoteMessage?.mutableContent;
      // final String senderId = remoteMessage?.senderId;
      // final DateTime sentTime = remoteMessage?.sentTime;
      // final String threadId = remoteMessage?.threadId;
      // final int ttl = remoteMessage?.ttl;
      // final Map<String, dynamic> data = remoteMessage?.data;


      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: Numeric.createUniqueID(maxDigitsCount: 8),
          channelKey: Notifications.getNotificationChannelName(FCMChannel.basic),
          title: title,
          body: body,
          // bigPicture: Notifications.redBldrsBanner,
          // notificationLayout: NotificationLayout.BigPicture,
          // color: Colorz.yellow255,
          // backgroundColor: Colorz.bloodTest,
        ),
      );

    }

  }
  // --------------------
  /*
  static Future<void> _pushNotificationFromNote(NoteModel note) async {

    if (note != null){

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: Numeric.createUniqueID(limitDigits: 8),
          channelKey: Notifications.getNotificationChannelName(FCMChannel.basic),
          title: note.title,
          body: note.body,
          // bigPicture: Notifications.redBldrsBanner,
          // notificationLayout: NotificationLayout.BigPicture,
          // color: Colorz.yellow255,
          // backgroundColor: Colorz.bloodTest,
        ),
      );

    }

  }
   */
  // --------------------
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

  /// TOKEN AND SUBSCRIPTIONS

  // --------------------
  /// TESTED : ...
  static Future<void> updateMyUserFCMToken({
    @required BuildContext context,
  }) async {

    if (AuthModel.userIsSignedIn() == true){

      /// UNSUBSCRIBING FROM TOKEN INSTRUCTIONS
      /*
         - Unsubscribe stale tokens from topics
         Managing topics subscriptions to remove stale registration
         tokens is another consideration. It involves two steps:

         - Your app should resubscribe to topics once per month and/or
          whenever the registration token changes. This forms a self-healing
          solution, where the subscriptions reappear automatically
          when an app becomes active again.

         - If an app instance is idle for 2 months (or your own staleness window)
         you should unsubscribe it from topics using the Firebase Admin
         SDK to delete the token/topic mapping from the FCM backend.

         - The benefit of these two steps is that your fanouts will occur
         faster since there are fewer stale tokens to fan out to, and your
          stale app instances will automatically resubscribe once they are active again.

     */

      String _fcmToken;

      /// task : error : [firebase_messaging/unknown] java.io.IOException: SERVICE_NOT_AVAILABLE

      final bool _continue = await tryCatchAndReturnBool(
        context: context,
        methodName: 'updateMyUserFCMToken',
        functions: () async {

          final FirebaseMessaging _fcm = FirebaseMessaging.instance;

          if (Platform.isIOS) {
            _fcmToken = await _fcm.getToken();
          }
          else {
            _fcmToken = await _fcm.getToken();
          }

        },
        onError: (String error){

          /// error codes reference
          // https://firebase.google.com/docs/reference/fcm/rest/v1/ErrorCode
          // UNREGISTERED (HTTP 404)
          // INVALID_ARGUMENT (HTTP 400)
          // [firebase_messaging/unknown] java.io.IOException: SERVICE_NOT_AVAILABLE

          /// TASK : SHOULD DELETE THE FCM TOKEN FROM USER DOC AND GENERATE NEW TOKEN !

        },
      );

      final UserModel _myUserModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

      if (_continue == true && _fcmToken != null && _myUserModel != null){

        if (_myUserModel?.fcmToken?.token != _fcmToken){

          final FCMToken _token = FCMToken(
            token: _fcmToken,
            createdAt: DateTime.now(),
            platform: Platform.operatingSystem,
          );

          final UserModel _updated = _myUserModel.copyWith(
            fcmToken: _token,
          );

          await UserProtocols.renovateMyUserModel(
            context: context,
            newUserModel: _updated,
          );

        }

      }

    }

  }
  // --------------------
  /// TESTED : ...
  static Future<void> subscribeToTopic({
    String topicName
  }) async {

    if (AuthModel.userIsSignedIn() == true){
      final FirebaseMessaging _fireMessaging = FirebaseMessaging.instance;
      await _fireMessaging.subscribeToTopic(topicName);
    }

  }
  // --------------------
  /// TESTED : ...
  static Future<void> unsubscribeFromTopic({
    @required String topicName,
  }) async {
    if (AuthModel.userIsSignedIn() == true){
      final FirebaseMessaging _fireMessaging = FirebaseMessaging.instance;
      await _fireMessaging.unsubscribeFromTopic(topicName);
    }
  }
  // -----------------------------------------------------------------------------

  /// CANCELLATION

  // --------------------
  static Future<void> cancelScheduledNotification() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
  // -----------------------------------------------------------------------------

  /// CHANNELS

  // --------------------
  static String getNotificationChannelName(FCMChannel channel) {
    switch (channel) {
      case FCMChannel.basic: return 'Basic Notifications';break;
      case FCMChannel.scheduled: return 'Scheduled Notifications';break;
      default: return 'Basic Notifications';
    }
  }
  // --------------------
  static NotificationChannel basicNotificationChannel() {
    return NotificationChannel(
      channelKey: getNotificationChannelName(FCMChannel.basic),
      channelName: getNotificationChannelName(FCMChannel.basic),
      channelDescription: 'this is for testing', // this will be visible to user in android notification settings
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
  // --------------------
  static NotificationChannel scheduledNotificationChannel() {
    return NotificationChannel(
      channelKey: getNotificationChannelName(FCMChannel.scheduled),
      channelName: getNotificationChannelName(FCMChannel.scheduled),
      channelDescription: 'This is the first scheduled notification', // this will be visible to user in android notification settings
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
  // -----------------------------------------------------------------------------

  /// NOTIFY THING

  // --------------------
  static Future<void> onNotifyButtonTap({
    @required BuildContext context,
    @required Widget screenToGoToOnNotiTap,
  }) async {

    await notify();

    AwesomeNotifications().actionStream.listen((ReceivedAction receivedAction) {
      Nav.pushAndRemoveUntil(
        context: context,
        screen: screenToGoToOnNotiTap,
      );
    });

  }
  // --------------------
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

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogRemoteMessage({
    String methodName,
    RemoteMessage remoteMessage
  }) {

    final String body = remoteMessage?.notification?.body;
    final String title = remoteMessage?.notification?.title;
    final AndroidNotification android = remoteMessage?.notification?.android;
    final AppleNotification apple = remoteMessage?.notification?.apple;
    final String analyticsLabel = remoteMessage?.notification?.web?.analyticsLabel;
    final String image = remoteMessage?.notification?.web?.image;
    final String link = remoteMessage?.notification?.web?.link;

    final String bodyLocKey = remoteMessage?.notification?.bodyLocKey;
    final List<String> bodyLocArgs = remoteMessage?.notification?.bodyLocArgs;
    final String titleLocKey = remoteMessage?.notification?.titleLocKey;
    final List<String> titleLocArgs = remoteMessage?.notification?.titleLocArgs;

    final String category = remoteMessage?.category;
    final String collapseKey = remoteMessage?.collapseKey;
    final bool contentAvailable = remoteMessage?.contentAvailable;
    final String from = remoteMessage?.from;
    final String messageId = remoteMessage?.messageId;
    final String messageType = remoteMessage?.messageType;
    final bool mutableContent = remoteMessage?.mutableContent;
    final String senderId = remoteMessage?.senderId;
    final DateTime sentTime = remoteMessage?.sentTime;
    final String threadId = remoteMessage?.threadId;
    final int ttl = remoteMessage?.ttl;
    final Map<String, dynamic> data = remoteMessage?.data;

    blog('blogING REMOTE MESSAGE ATTRIBUTES ------------- START -');

    blog('1 - METHOD NAMED : $methodName');
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
    blog('15 - body : $body');
    blog('16 - title : $title');
    blog('17 - android : $android');
    blog('18 - apple : $apple');
    blog('19 - analyticsLabel : $analyticsLabel');
    blog('20 - image : $image');
    blog('21 - link : $link');
    blog('22 - bodyLocKey : $bodyLocKey');
    blog('23 - bodyLocArgs : $bodyLocArgs');
    blog('24 - titleLocKey : $titleLocKey');
    blog('25 - titleLocArgs : $titleLocArgs');

    // click_action : FLUTTER_NOTIFICATION_CLICK

    blog('blogING REMOTE MESSAGE ATTRIBUTES ------------- END -');
  }
  // -----------------------------------------------------------------------------

  /// OLD CODES

  // --------------------
  /*
  /// fcm on background
  //  AndroidNotificationChannel channel;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // static Future<void> createAwesomeNotificationFromRemoteMessage(RemoteMessage remoteMessage) async {
  //
  //   // blogRemoteMessage(
  //   //   methodName: 'notificationPushHandler',
  //   //   remoteMessage: remoteMessage,
  //   // );
  //
  //   await pushNotificationFromRemoteMessage(remoteMessage);
  //
  //
  //   // final bool _notificationCreated = await AwesomeNotifications().createNotificationFromJsonData(remoteMessage.data);
  //
  //   // blog('_notificationCreated : $_notificationCreated');
  //
  //   // if (!kIsWeb) {
  //   //   channel = const AndroidNotificationChannel(
  //   //     'high_importance_channel', // id
  //   //     'High Importance Notifications', // title
  //   //     'This channel is used for important notifications.', // description
  //   //     importance: Importance.high,
  //   //   );
  //   //
  //   //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   //
  //   //   /// Create an Android Notification Channel.
  //   //   ///
  //   //   /// We use this channel in the `AndroidManifest.xml` file to override the
  //   //   /// default FCM channel to enable heads up notifications.
  //   //   await flutterLocalNotificationsPlugin
  //   //       .resolvePlatformSpecificImplementation<
  //   //       AndroidFlutterLocalNotificationsPlugin>()
  //   //       ?.createNotificationChannel(channel);
  //
  //   // /// Update the iOS foreground notification presentation options to allow
  //   // /// heads up notifications.
  //   // await FirebaseMessaging.instance
  //   //     .setForegroundNotificationPresentationOptions(
  //   //   alert: true,
  //   //   badge: true,
  //   //   sound: true,
  //   // );
  //   // }
  // }
   */
  // -----------------------------------------------------------------------------
}
