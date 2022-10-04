import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class FCMStarter {
  // -----------------------------------------------------------------------------

  const FCMStarter();

  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> preInitializeNotifications() async {

    /// THIS GOES BEFORE RUNNING THE BLDRS APP
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);

    await FCM.getAwesomeNotifications().initialize(
      FCM.fcmWhiteLogoFilePath, // defaultIcon
      <NotificationChannel>[
        FCM.basicNotificationChannel(),
        FCM.scheduledNotificationChannel(),
      ],
      // channelGroups: <NotificationChannelGroup>[
      //   NotificationChannelGroup(
      //     channelGroupkey: ,
      //     channelGroupName: ,
      //   ),
      // ], // channelGroups
      // debug: true,
    );

  }
  // --------------------
  ///
  static Future<void> initializeNotifications(BuildContext context) async {

    /// NOTE : THIS GOES IN MAIN WIDGET INIT

    blog('1 - initializeNotifications : START');

    await _initializeLocalNotificationService(context);

    final RemoteMessage initialRemoteMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialRemoteMessage != null) {

      FCM.blogRemoteMessage(
        methodName: '2 - initializeNotifications.initialRemoteMessage',
        remoteMessage: initialRemoteMessage,
      );

      blog('3 - initializeNotifications : can navigate here and shit');

    }

    await FirebaseMessaging.instance.requestPermission(
      criticalAlert: true,
      carPlay: true,
      announcement: true,
      sound: true,
      provisional: true,
      badge: true,
      alert: true,
    );

    blog('4 - initializeNotifications : permission requested ');

    /// APP IS IN FOREGROUND ( FRONT AND ACTIVE )
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
      await _pushGlobalNotificationFromRemoteMessage(
        remoteMessage: remoteMessage,
        invoker: '5 - onMessage',
      );
    });

    /// APP IS LAUNCHING ( AT STARTUP )
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) async {

      await _pushGlobalNotificationFromRemoteMessage(
        remoteMessage: remoteMessage,
        invoker: '6 - onMessageOpenedApp',
      );

      /// to display the notification while app in foreground
      await _pushLocalNotificationFromRemoteMessage(remoteMessage);
    });

    /// when app running in background and notification tapped while having
    /// msg['data']['click_action'] == 'FLUTTER_NOTIFICATION_CLICK';
    FirebaseMessaging.onBackgroundMessage(
            (RemoteMessage remoteMessage) =>
                _pushGlobalNotificationFromRemoteMessage(
                  remoteMessage: remoteMessage,
                  invoker: '7 - onBackgroundMessage',
                )
    );

  }
  // --------------------
  ///
  static Future<void> _initializeLocalNotificationService(BuildContext context) async {

    final FlutterLocalNotificationsPlugin _notiPlugin = FlutterLocalNotificationsPlugin();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings(FCM.fcmWhiteLogoFileName),
    );

    await _notiPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {

          if (payload != null) {

            /// ROUTE IS NOTIFICATION [PAYLOAD] BABY
            blog('initializing localNotificationService : route is : $payload');

            // await Nav.goToNewScreen(
            //   context: context, // context is bitch
            //   screen: const AwesomeNotiTestScreen(),
            // );

          }

        }

    );
  }
  // -----------------------------------------------------------------------------

  /// REMOTE MESSAGE PUSHING TO NOTIFICATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _onBackgroundMessageHandler(RemoteMessage remoteMessage) async {
    await _pushGlobalNotificationFromRemoteMessage(
        remoteMessage: remoteMessage,
        invoker: 'preInitializeNotifications.onBackgroundMessage'
    );
  }
  // --------------------
  ///
  static Future<void> _pushGlobalNotificationFromRemoteMessage({
    @required RemoteMessage remoteMessage,
    @required String invoker,
  }) async {

    if (remoteMessage != null){

      FCM.blogRemoteMessage(
        methodName: 'pushNotificationFromRemoteMessage.$invoker',
        remoteMessage: remoteMessage,
      );

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

      await FCM.pushGlobalNotification(
        body: body,
        title: title,
      );

    }

  }
  // --------------------
  ///
  static Future<void> _pushLocalNotificationFromRemoteMessage(RemoteMessage remoteMessage) async {

    final String _title = remoteMessage.notification.title;
    final String _body = remoteMessage.notification.body;
    final String _payload = remoteMessage.data['route'];

    await FCM.pushLocalNotification(
      body: _body,
      title: _title,
      payloadString: _payload,
    );

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
  //   // final bool _notificationCreated = await getAwesomeNotifications().createNotificationFromJsonData(remoteMessage.data);
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
  // --------------------
  /// NOT TESTED
  /*
  static Future<void> pushScheduledNotification({
    @required String title,
    @required String body,
  }) async {

    await getAwesomeNotifications().createNotification(
      /// CONTENT
      content: _createNotificationContent(
        title: title,
        body: body,
      ),
      /// ACTION BUTTONS
      actionButtons: _createNotificationActionButtons(),
      /// SCHEDULE
      schedule: _createNotificationSchedule(),
    );

  }
   */
  // -----------------------------------------------------------------------------
}
