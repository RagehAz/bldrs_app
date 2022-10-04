import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/a_models/bz/target/target_progress.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/fcm_token.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  // --------------------
  static const String fcmWhiteLogoFilePath = 'resource://drawable/res_flat_logo';
  static const String fcmWhiteLogoFileName = 'res_flat_logo'; ///'resource://drawable/res_flat_logo'; // "@mipmap/ic_launcher"
  // --------------------
  static const String fcmColorLogoFilePath = 'resource://drawable/res_color_logo';
  static const String fcmColorLogoFileName = 'res_color_logo';
  // --------------------
  static const List<int> vibrationPatternInts = <int>[
    1000,1000,1000,1000,
    1000,1000,1000,1000,
    1000,1000,1000,1000,
    1000,1000,1000,1000,
  ];
  // -----------------------------------------------------------------------------

  /// PUSHING NOTIFICATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushGlobalNotification({
    @required String body,
    @required String title,
    String largeIconURL,
    String bannerURL,
    TargetProgress progress,
    Map<String, String> payloadMap,
  }) async {


    await tryAndCatch(
      methodName: 'pushGlobalNotification',
      functions: () async {

        await getAwesomeNotifications().createNotification(
          /// CONTENT
          content: _createNotificationContent(
            body: body,
            title: title,
            largeIconURL: largeIconURL,
            bannerURL: bannerURL,
            progress: progress,
            payloadMap: payloadMap,
            // progressBarIsLoading: false,
            // canBeDismissedWithoutTapping: true,
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
  /// TESTED : WORKS PERFECT
  static Future<void> pushLocalNotification({
    @required String title,
    @required String body,
    @required String payloadString,
    File picture,
    String subText,
    TargetProgress progress,
  }) async {

    await FlutterLocalNotificationsPlugin().show(
      /// ID
      Numeric.createUniqueID(maxDigitsCount: 8),
      /// TITLE
      title,
      /// BODY
      body,
      /// DETAILS
      NotificationDetails(
        android: _createAndroidNotificationDetails(
          largeIcon: await _getLargeIcon(picture),
          subText: subText,
          progress: progress,
          // canBeDismissedWithoutTapping: ,
          // channel: ,
          // progressBarIsLoading: ,
          // showStopWatch: ,
          // showTime: ,
        ),
        iOS: _createIOSNotificationDetails(),
        // macOS: ,
        // linux: ,
      ),
      /// PAYLOAD : data to be passed through
      payload: payloadString,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AndroidBitmap> _getLargeIcon(File file) async {
    AndroidBitmap _largeIcon;

    if (file != null){

      final String _base64 = await Floaters.getBase64FromFileOrURL(file);
      _largeIcon = ByteArrayAndroidBitmap.fromBase64String(_base64);

    }

    return _largeIcon;
  }
  // -----------------------------------------------------------------------------

  /// NOTIFICATION CONTENTS

  // --------------------
  /// TAMAM : WORKS PERFECT : TASK : (except for notification sound)
  static NotificationContent _createNotificationContent({
    @required String title,
    @required String body,
    bool canBeDismissedWithoutTapping = true,
    String largeIconURL,
    String bannerURL,
    Map<String, String> payloadMap,
    TargetProgress progress,
    bool progressBarIsLoading = false,
  }){

    blog('_createNotificationContent : START');

    int _progress;
    if (progress != null && progressBarIsLoading == false){
      _progress = ((progress.current / progress.objective) * 100).toInt();
    }

    NotificationLayout _layout;
    if (progress != null || progressBarIsLoading == true){
      _layout = NotificationLayout.ProgressBar;
    }
    else if (bannerURL != null){
      _layout = NotificationLayout.BigPicture;
    }
    else {
      _layout = NotificationLayout.BigText;
    }

    return NotificationContent(
      /// IDENTIFICATION
      id: Numeric.createUniqueID(maxDigitsCount: 8),
      channelKey: FCM.getNotificationChannelID(FCMChannel.basic),

      /// TEXT
      title: title,
      body: body,

      /// IMAGES
      notificationLayout: _layout,
      bigPicture: bannerURL, //redBldrsBanner,

      /// ICON
      icon: fcmWhiteLogoFilePath,
      backgroundColor: Colorz.black255, /// is icon color bardo , bas override color
      color: Colorz.bloodTest, /// is icon color.. is igonore when backgroundColor is assigned

      /// LARGE ICON
      largeIcon: largeIconURL, //NoteModel.bldrsLogoStaticURL,//fcmColorLogoFilePath,
      roundedLargeIcon: true,
      hideLargeIconOnExpand: false,

      /// BEHAVIOUR
      locked: !canBeDismissedWithoutTapping,
      displayOnBackground: true,
      displayOnForeground: true,
      wakeUpScreen: true,

      /// SOUND
      customSound: Sounder.getNotificationFilesPath(Sounder.nicoleSaysBldrsDotNet), // NOT WORKING

      /// DATA
      payload: payloadMap,

      /// PROGRESS
      progress: _progress,

      /// FAKES
      // roundedBigPicture: false, /// very silly
      // autoDismissible: false,
      // fullScreenIntent: false,
      // showWhen: ,
      // summary: 'wtf is this summery',
      // category: NotificationCategory.Email,
      // criticalAlert: false,
      // ticker: 'wtf is ticker',
      // groupKey: ,

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
  /// TAMAM : WORKS PERFECT : TASK : (except for notification sound)
  static AndroidNotificationDetails _createAndroidNotificationDetails({
    String subText,
    AndroidBitmap<Object> largeIcon,
    TargetProgress progress,
    FCMChannel channel = FCMChannel.basic,
    bool showStopWatch = false,
    bool showTime = true,
    bool canBeDismissedWithoutTapping = true,
    bool progressBarIsLoading = false,
  }){

    return AndroidNotificationDetails(
      /// CHANNEL
      getNotificationChannelID(channel), // channelId
      getNotificationChannelName(channel), // channelName
      channelDescription: getNotificationChannelDescription(channel),
      // channelAction: AndroidNotificationChannelAction.createIfNotExists, // default

      /// SUB TEXT
      subText: subText,

      /// ICON
      icon: fcmWhiteLogoFileName,
      color: Colorz.black255, /// is icon color

      /// PICTURE
      largeIcon: largeIcon, /// is the side picture

      /// SOUNDS
      // playSound: true, /// TASK : NOT WORKING
      sound: const RawResourceAndroidNotificationSound(Sounder.nicoleSaysBldrsDotNet), /// TASK : NOT WORKING

      /// LIGHTS
      enableLights: true,
      ledColor: Colorz.yellow255, /// NOT TESTED
      ledOffMs: 2, /// NOT IMPORTANT : NOT TESTED
      ledOnMs: 2, /// NOT IMPORTANT : NOT TESTED

      /// VIBRATION
      // enableVibration: true, // default
      vibrationPattern: _createVibration(),
      ticker: 'what is the ticker text ?',

      /// PROGRESS
      showProgress: progress != null,
      progress: progress?.current ?? 0,
      maxProgress: progress?.objective ?? 0,
      indeterminate: progressBarIsLoading,

      /// BEHAVIOUR
      // autoCancel: true, /// is auto dismiss notification on tap ,, true be default
      onlyAlertOnce: true, /// auto stop sound-ticker-vibration on show
      visibility: NotificationVisibility.public, /// is lock screen notification visibility
      ongoing: !canBeDismissedWithoutTapping,

      /// TIMING
      usesChronometer: showStopWatch,
      showWhen: showTime,
      // when: , /// is notification time stamp,, and no need to modify its default
      // timeoutAfter: , /// is millisecond to wait to cancel notification if not yet cancelled ?? weird

      /// BADGE : NOT EFFECTIVE
      // channelShowBadge: true, //showAppBadge,
      // number: 69,

      /// NO EFFECT
      colorized: true, /// background color : has no effect on local notification
      fullScreenIntent: true,
      importance: Importance.max,
      priority: Priority.max,

      /// GROUP
      // groupAlertBehavior: GroupAlertBehavior.all, /// FAKES
      // setAsGroupSummary: true, /// FAKES
      // groupKey: 'groupOfShits', /// FAKES

      /// FAKES
      // shortcutId: ,
      // styleInformation: StyleInformation,
      // additionalFlags: ,
      // category: ,
      // tag: 'fakes',

    );

  }
  // --------------------
  /// TASK : TEST THIS ON IOS
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
  // --------------------
  ///
  static Int64List _createVibration(){
    return Int64List.fromList(vibrationPatternInts);
  }
  // -----------------------------------------------------------------------------

  /// SCHEDULING

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
  static Future<void> cancelScheduledNotification() async {
    await getAwesomeNotifications().cancelAllSchedules();
  }
  // -----------------------------------------------------------------------------

  /// CHANNELS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getNotificationChannelID(FCMChannel channel) {
    switch (channel) {
      case FCMChannel.basic:      return 'basic_noti';break;
      case FCMChannel.scheduled:  return 'scheduled_noti';break;
      default:                    return 'basic_noti';
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getNotificationChannelName(FCMChannel channel) {
    switch (channel) {
      case FCMChannel.basic:      return 'إشعارات';break; /// TASK : NEED BETTER NAME
      case FCMChannel.scheduled:  return 'Scheduled Notifications';break;
      default:                    return 'Basic Notifications';
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getNotificationChannelDescription(FCMChannel channel) {
    switch (channel) {
      case FCMChannel.basic:      return 'Bldrs.net is amazing';break;
      case FCMChannel.scheduled:  return 'Bldrs.net is outstanding';break;
      default:                    return 'Bldrs.net is amazing';
    }
  }
  // --------------------
  ///
  static NotificationChannel basicNotificationChannel() {

    /// NOTE : WORKS WHEN APP IS IN FOREGROUND
    return NotificationChannel(
      channelKey: getNotificationChannelID(FCMChannel.basic),
      channelName: getNotificationChannelName(FCMChannel.basic),
      channelDescription: getNotificationChannelDescription(FCMChannel.basic), // this will be visible to user in android notification settings

      ///
      defaultColor: Colorz.green255, /// TASK : IS THIS THE YELLOW ICON ON TOP,, NOW WILL DO GREEN TO TEST
      channelShowBadge: true,
      icon: fcmWhiteLogoFilePath,
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
      icon: fcmWhiteLogoFilePath,
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
