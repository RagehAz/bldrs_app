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
  static Future<void> preInitializeNootsInMainFunction() async {

    /// INITIALIZE AWESOME NOTIFICATIONS
    await _initializeAwesomeNootsService();

    /// HANDLE BACKGROUND REMOTE MESSAGE (handles while app in background)
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initializeNootsInBldrsAppStarter(BuildContext context) async {

    /// FCM PERMISSION
    await FCM.requestFCMPermission();

    /// INITIALIZE LOCAL NOOTS
    await _initializeLocalNootsService(context);

    /// INITIALIZE LISTENERS
    _initializeNootsListeners();

    /// RECEIVE INITIAL MESSAGE
    await _receiveInitialRemoteMessage();

  }
  // -----------------------------------------------------------------------------

  /// (AWESOME - LOCAL NOOTS) SERVICES INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _initializeAwesomeNootsService() async {

    await FCM.getAwesomeNoots().initialize(

      /// NOOTS DEFAULT ICON
      FCM.fcmWhiteLogoFilePath,

      /// CHANNELS
      FCM.getBldrsNootsChannels(),

      /// CHANNEL GROUPS
      channelGroups: FCM.getBldrsChannelGroups(),

      /// DEBUG
      debug: false,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _initializeLocalNootsService(BuildContext context) async {

    await FCM.getLocalNootsPlugin().initialize(

      /// INITIALIZATION SETTINGS
      const InitializationSettings(
        android: AndroidInitializationSettings(FCM.fcmWhiteLogoFileName),
        iOS: IOSInitializationSettings(
          // defaultPresentAlert: ,
          // defaultPresentBadge: ,
          // defaultPresentSound: ,
          // onDidReceiveLocalNotification: ,
          // requestAlertPermission: ,
          // requestBadgePermission: ,
          // requestSoundPermission: ,
        ),
        // macOS: ,
        // linux: ,
      ),

      /// ON NOOT TAP
      onSelectNotification: FCM.onLocalNootTap,

    );

  }
  // -----------------------------------------------------------------------------

  /// HANDLERS & LISTENERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _onBackgroundMessageHandler(RemoteMessage remoteMessage) async {
    // await _pushGlobalNootFromRemoteMessage(
    //     remoteMessage: remoteMessage,
    //     invoker: '_onBackgroundMessageHandler'
    // );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void _initializeNootsListeners(){

    /// APP IS IN FOREGROUND ( FRONT AND ACTIVE )
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
      await _pushGlobalNootFromRemoteMessage(
        remoteMessage: remoteMessage,
        invoker: 'initializeNoots.onMessage',
      );
    });

    /// APP IS LAUNCHING ( AT STARTUP )
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) async {

      await _pushGlobalNootFromRemoteMessage(
        remoteMessage: remoteMessage,
        invoker: 'initializeNoots.onMessageOpenedApp',
      );

      // /// to display the notification while app in foreground
      // await _pushLocalNootFromRemoteMessage(remoteMessage);
    });

    /// when app running in background and notification tapped while having
    /// msg['data']['click_action'] == 'FLUTTER_NOTIFICATION_CLICK';
    FirebaseMessaging.onBackgroundMessage(
            (RemoteMessage remoteMessage) =>
            _pushGlobalNootFromRemoteMessage(
              remoteMessage: remoteMessage,
              invoker: 'initializeNoots.onBackgroundMessage',
            )
    );


  }
  // --------------------
  ///
  static Future<void> _receiveInitialRemoteMessage() async {

    final RemoteMessage initialRemoteMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialRemoteMessage != null) {

      FCM.blogRemoteMessage(
        remoteMessage: initialRemoteMessage,
        invoker: 'initializeNoots',
      );

      blog('initializeNoots : can navigate here and shit');

    }

  }
  // -----------------------------------------------------------------------------

  /// PUSHING (REMOTE-MESSAGE) INTO (NOOTS)

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _pushGlobalNootFromRemoteMessage({
    @required RemoteMessage remoteMessage,
    @required String invoker,
  }) async {

    if (remoteMessage != null){

      FCM.blogRemoteMessage(
        invoker: '_pushGlobalNootFromRemoteMessage.$invoker',
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

      await FCM.pushGlobalNoot(
        body: body,
        title: title,
        // channel: ,
        // buttonsTexts: ,
        // payloadMap: ,
        // progress: ,
        // canBeDismissedWithoutTapping: ,
        // progressBarIsLoading: ,
        // bannerURL: ,
        // largeIconURL: ,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _pushLocalNootFromRemoteMessage(RemoteMessage remoteMessage) async {

    final String _title = remoteMessage.notification.title;
    final String _body = remoteMessage.notification.body;

    /// TASK : MAKE SURE THIS FIELD NAME ('route) IS CORRECT
    final String _payload = remoteMessage.data['route'];

    await FCM.pushLocalNoot(
      title: _title,
      body: _body,
      payloadString: _payload,
      // progressBarIsLoading: ,
      // canBeDismissedWithoutTapping: ,
      // progress: ,
      // channel: ,
      // showTime: ,
      // showStopWatch: ,
      // subText: ,
      // largeIconFile: ,
    );

  }
  // -----------------------------------------------------------------------------
}
