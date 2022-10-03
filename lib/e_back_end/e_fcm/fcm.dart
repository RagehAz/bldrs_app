import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import 'package:bldrs/a_models/user/fcm_token.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';

enum FCMChannel {
  basic,
  scheduled,
}

/// AWESOME NOTIFICATIONS PUSHER
class FCM {
  // -----------------------------------------------------------------------------

  /// AWESOME NOTIFICATIONS SINGLETON

  // --------------------
  /// private constructor to create instances of this class only in itself
  FCM._thing();
  // --------------------
  /// Singleton instance
  static final FCM _singleton = FCM._thing();
  // --------------------
  /// Singleton accessor
  static FCM get instance => _singleton;
  // --------------------
  /// local instance
  AwesomeNotifications _awesomeNotifications;
  // --------------------
  /// instance getter
  AwesomeNotifications get awesomeNotifications {
    return _awesomeNotifications ??= AwesomeNotifications();
  }
  // --------------------
  /// static instance getter
  static AwesomeNotifications getAwesomeNotifications() {
    return FCM.instance.awesomeNotifications;
  }
  // --------------------
  /// Static dispose
  static void dispose(){
    getAwesomeNotifications().dispose();
  }
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String redBldrsBanner = 'resource://drawable/res_red_bldrs';
  static const String fcmIconFlat = 'resource://drawable/res_flat_logo';
  static const String fcmIconFlat2 = 'res_flat_logo'; ///'resource://drawable/res_flat_logo'; // "@mipmap/ic_launcher"
  // -----------------------------------------------------------------------------

  /// PUSHING NOTIFICATION

  // --------------------
  /// TESTED : ...
  static Future<void> pushGlobalNotification({
    @required String body,
    @required String title,
  }) async {

    await tryAndCatch(
      methodName: 'pushGlobalNotification',

      functions: () async {

        await getAwesomeNotifications().createNotification(
          /// CONTENT
          content: _createNotificationContent(
            body: body,
            title: title,
          ),
          /// BUTTONS
          actionButtons: _createNotificationActionButtons(),
          /// SCHEDULE
          schedule: _createNotificationSchedule(),
        );

      },
    );

  }
  // --------------------
  /// TESTED : ...
  static Future<void> pushLocalNotification({
    @required String title,
    @required String body,
    @required String payload,
  }) async {

    final NotificationDetails _notificationDetails = NotificationDetails(
      android: _createAndroidNotificationDetails(),
      iOS: _createIOSNotificationDetails(),
      // macOS: ,
      // linux: ,
    );

    await FlutterLocalNotificationsPlugin().show(
      Numeric.createUniqueID(maxDigitsCount: 8),
      title,
      body,
      _notificationDetails,
      payload: payload,
    );

  }
  // -----------------------------------------------------------------------------

  /// NOTIFICATION CONTENTS

  // --------------------
  ///
  static NotificationContent _createNotificationContent({
    @required String title,
    @required String body,
  }){
    return NotificationContent(
      /// IDENTIFICATION
      id: Numeric.createUniqueID(maxDigitsCount: 8),
      channelKey: FCM.getNotificationChannelName(FCMChannel.basic),
      // groupKey: ,

      /// TEXT
      title: title,
      body: body,

      /// LAYOUT
      // notificationLayout: NotificationLayout.BigPicture,
      // wakeUpScreen: ,

      /// IMAGES
      // bigPicture: Notifications.redBldrsBanner,
      // roundedBigPicture: ,
      // largeIcon: ,
      // roundedLargeIcon: ,
      // icon: ,

      /// COLORS
      // color: Colorz.yellow255,
      // backgroundColor: Colorz.bloodTest,

      /// BEHAVIOUR
      // autoDismissible: ,
      // displayOnBackground: ,
      // displayOnForeground: ,
      // fullScreenIntent: ,
      // locked: ,
      // hideLargeIconOnExpand: ,
      // showWhen: ,

      /// SOUND
      // customSound: ,

      /// DATA
      // payload: ,
      // summary: ,
      // category: ,

      /// UN-CLASSIFIED
      // criticalAlert: ,
      // progress: ,
      // ticker: ,
    );


  }
  // --------------------
  ///
  static List<NotificationActionButton> _createNotificationActionButtons({
    List<String> buttons,
  }){

    if (Mapper.checkCanLoopList(buttons) == true){
      return
        <NotificationActionButton>[
          // NotificationActionButton(
          // icon: ,
          // autoDismissible: ,
          // color: ,
          // buttonType: ,
          // enabled: ,
          // isDangerousOption: ,
          // key: ,
          // label: ,
          // showInCompactView: ,
          // ),
        ];

    }
    else {
      return null;
    }


  }
  // --------------------
  ///
  static NotificationSchedule _createNotificationSchedule(){

    return null;

    // return NotificationSchedule(
    //   preciseAlarm: ,
    //   timeZone: ,
    //   repeats: ,
    //   allowWhileIdle: ,
    // );

  }
  // --------------------
  ///
  static AndroidNotificationDetails _createAndroidNotificationDetails(){

    return const AndroidNotificationDetails(
      'bldrs',
      'bldrs channel',
      // 'bldrs network',
      importance: Importance.max,
      priority: Priority.high,
      // color: ,
      // icon: ,
      // ticker: ,
      // showWhen: ,
      // progress: ,
      // largeIcon: ,
      // groupKey: ,
      // fullScreenIntent: ,
      // category: ,
      // additionalFlags: ,
      // autoCancel: ,
      // channelAction: ,
      // channelDescription: ,
      // channelShowBadge: ,
      // colorized: ,
      // enableLights: ,
      // enableVibration: ,
      // groupAlertBehavior: ,
      // indeterminate: ,
      // ledColor: ,
      // ledOffMs: ,
      // ledOnMs: ,
      // maxProgress: ,
      // number: ,
      // ongoing: ,
      // onlyAlertOnce: ,
      // playSound: ,
      // setAsGroupSummary: ,
      // shortcutId: ,
      // showProgress: ,
      // sound: ,
      // styleInformation: ,
      // subText: ,
      // tag: ,
      // timeoutAfter: ,
      // usesChronometer: ,
      // vibrationPattern: ,
      // visibility: ,
      // when: ,
    );

  }
  // --------------------
  ///
  static IOSNotificationDetails _createIOSNotificationDetails(){
    return null;
    // return IOSNotificationDetails(
    //   sound: ,
    //   attachments: ,
    //   badgeNumber: ,
    //   presentAlert: ,
    //   presentBadge: ,
    //   presentSound: ,
    //   subtitle: ,
    //   threadIdentifier: ,
    // );
  }
  // -----------------------------------------------------------------------------

  /// CANCELLATION

  // --------------------
  ///
  static Future<void> cancelScheduledNotification() async {
    await getAwesomeNotifications().cancelAllSchedules();
  }
  // -----------------------------------------------------------------------------

  /// CHANNELS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getNotificationChannelName(FCMChannel channel) {
    switch (channel) {
      case FCMChannel.basic:      return 'Basic Notifications';break;
      case FCMChannel.scheduled:  return 'Scheduled Notifications';break;
      default:                    return 'Basic Notifications';
    }
  }
  // --------------------
  ///
  static NotificationChannel basicNotificationChannel() {

    /// NOTE : WORKS WHEN APP IS IN FOREGROUND
    return NotificationChannel(
      channelKey: getNotificationChannelName(FCMChannel.basic),
      channelName: getNotificationChannelName(FCMChannel.basic),
      channelDescription: 'Bldrs.net notification', // this will be visible to user in android notification settings

      ///
      defaultColor: Colorz.green255, /// TASK : IS THIS THE YELLOW ICON ON TOP,, NOW WILL DO GREEN TO TEST
      channelShowBadge: true,
      icon: fcmIconFlat,
      ledColor: Colorz.facebook, /// TASK : IS THIS THE YELLOW ICON ON TOP,, NOW WILL DO facebook color TO TEST
      importance: NotificationImportance.High,
      locked: true,
      playSound: true,
      soundSource: Sounder.getNotificationFilesPath(Sounder.nicoleSaysBldrsDotNet),
      enableLights: true,
      enableVibration: true,
      // groupKey: ,
      // vibrationPattern: ,
      // onlyAlertOnce: ,
      // ledOnMs: ,
      // ledOffMs: ,
      // groupAlertBehavior: ,
      // channelGroupKey: ,
      // criticalAlerts: ,
      // defaultPrivacy: ,
      // defaultRingtoneType: ,
      // groupSort: ,
    );

  }
  // --------------------
  ///
  static NotificationChannel scheduledNotificationChannel() {
    return NotificationChannel(
      channelKey: getNotificationChannelName(FCMChannel.scheduled),
      channelName: getNotificationChannelName(FCMChannel.scheduled),
      channelDescription: 'This is the first scheduled notification', // this will be visible to user in android notification settings
      defaultColor: Colorz.yellow255,
      channelShowBadge: true,
      enableLights: true,
      icon: fcmIconFlat,
      ledColor: Colorz.yellow255,
      importance: NotificationImportance.High,
      enableVibration: true,
      playSound: true,
      locked: true,
      soundSource: Sounder.getNotificationFilesPath(Sounder.justinaSaysBldrsDotNet),
      // groupSort: ,
      // defaultRingtoneType: ,
      // defaultPrivacy: ,
      // criticalAlerts: ,
      // channelGroupKey: ,
      // groupAlertBehavior: ,
      // ledOffMs: ,
      // ledOnMs: ,
      // onlyAlertOnce: ,
      // vibrationPattern: ,
      // groupKey: ,
    );
  }
  // -----------------------------------------------------------------------------

  /// NOTIFY THING

  // --------------------
  ///
  static Future<void> onNotifyButtonTap({
    @required BuildContext context,
    @required Widget screenToGoToOnNotiTap,
  }) async {

    await notify();

    getAwesomeNotifications().actionStream.listen((ReceivedAction receivedAction) {
      Nav.pushAndRemoveUntil(
        context: context,
        screen: screenToGoToOnNotiTap,
      );
    });

  }
  // --------------------
  ///
  static Future<void> notify() async {
    // String _timeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    await getAwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'onNotifyTap',
        title: 'Local Notify by tap',
        body: 'this was sent by tapping a button',
        bigPicture: redBldrsBanner,
        notificationLayout: NotificationLayout.BigPicture,
        // groupKey: ,
        // color: ,
        // autoDismissible: ,
        // criticalAlert: ,
        // customSound: ,
        // displayOnBackground: ,
        // displayOnForeground: ,
        // hideLargeIconOnExpand: ,
        // locked: ,
        // payload: ,
        // roundedBigPicture: ,
        // roundedLargeIcon: ,
        // summary: ,
        // wakeUpScreen: ,
        // icon: ,
        // ticker: ,
        // showWhen: ,
        // progress: ,
        // largeIcon: ,
        // fullScreenIntent: ,
        // category: ,
        // backgroundColor: ,
      ),
    );
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  ///
  static Future<bool> checkIsNotificationAllowed() async {
    bool _allowed = false;

    final AwesomeNotifications _awesomeNotification = getAwesomeNotifications();

    if (_awesomeNotification != null){
      _allowed = await _awesomeNotification.isNotificationAllowed();
    }

    blog('checkIsNotificationAllowed : allowed : $_allowed');

    return _allowed;
  }
  // -----------------------------------------------------------------------------

  /// PERMISSIONS

  // --------------------
  ///
  static Future<void> requestAwesomePermission() async {
    await getAwesomeNotifications().requestPermissionToSendNotifications(
      // channelKey: ,
      // permissions: <NotificationPermission>[
      //   NotificationPermission.Alert,
      //   NotificationPermission.Sound,
      //   NotificationPermission.Badge,
      //   NotificationPermission.Light,
      //   NotificationPermission.Vibration,
      //   NotificationPermission.FullScreenIntent,
      //   NotificationPermission.PreciseAlarms,
      //   NotificationPermission.CriticalAlert,
      //   NotificationPermission.OverrideDnD,
      //   NotificationPermission.Provisional,
      //   NotificationPermission.Car,
      // ],
    );
  }
  // --------------------
  ///
  static Future<void> requestFCMPermission() async {
    final NotificationSettings _settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    FCM.blogNotificationSettings(_settings);

  }
  // -----------------------------------------------------------------------------

  /// TOKEN

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
        onError: (String error) async {

          await CenterDialog.showCenterDialog(
              context: context,
              titleVerse: const Verse(
                text: '##Notifications are temporarily suspended',
                translate: true,
              ),
              onOk: (){
                blog('error is : $error');
              }
          );

          /// error codes reference
          // https://firebase.google.com/docs/reference/fcm/rest/v1/ErrorCode
          // UNREGISTERED (HTTP 404)
          // INVALID_ARGUMENT (HTTP 400)
          // [firebase_messaging/unknown] java.io.IOException: SERVICE_NOT_AVAILABLE

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

          _token.blogToken();

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
  // -----------------------------------------------------------------------------

  /// TOPICS

  // --------------------
  /// TESTED : ...
  static Future<void> subscribeToTopic({
    String topicName
  }) async {

    if (AuthModel.userIsSignedIn() == true){
      await FirebaseMessaging.instance.subscribeToTopic(topicName);
    }

  }
  // --------------------
  /// TESTED : ...
  static Future<void> unsubscribeFromTopic({
    @required String topicName,
  }) async {
    if (AuthModel.userIsSignedIn() == true){
      await FirebaseMessaging.instance.unsubscribeFromTopic(topicName);
    }
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogNotificationSettings(NotificationSettings settings){

    if (settings == null){
      blog('blogNotificationSettings : settings are null');
    }
    else {
      blog('blogNotificationSettings : -------------START');

      blog('alert               : ${settings.alert.index} : ${settings.alert.name}');
      blog('announcement        : ${settings.announcement.index} : ${settings.announcement.name}');
      blog('authorizationStatus : ${settings.authorizationStatus.index} : ${settings.authorizationStatus.name}');
      blog('badge               : ${settings.badge.index} : ${settings.badge.name}');
      blog('carPlay             : ${settings.carPlay.index} : ${settings.carPlay.name}');
      blog('lockScreen          : ${settings.lockScreen.index} : ${settings.lockScreen.name}');
      blog('notificationCenter  : ${settings.notificationCenter.index} : ${settings.notificationCenter.name}');
      blog('showPreviews        : ${settings.showPreviews.index} : ${settings.showPreviews.name}');
      blog('sound               : ${settings.sound.index} : ${settings.sound.name}');
      blog('timeSensitive       : ${settings.timeSensitive.index} : ${settings.timeSensitive.name}');


      blog('blogNotificationSettings : -------------END');
    }

  }
  // -----------------------------------------------------------------------------
}
