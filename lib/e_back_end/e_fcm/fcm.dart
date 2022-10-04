import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:bldrs/a_models/b_bz/target/target_progress.dart';
import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/a_models/e_notes/note_model.dart';
import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/e_notes/fcm_token.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
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
  FCM.singleton();
  // --------------------
  /// Singleton instance
  static final FCM _singleton = FCM.singleton();
  // --------------------
  /// Singleton accessor
  static FCM get instance => _singleton;
  // -----------------------------------------------------------------------------
  /// local instance
  AwesomeNotifications _awesomeNotifications;
  // --------------------
  /// instance getter
  AwesomeNotifications get awesomeNotifications {
    return _awesomeNotifications ??= AwesomeNotifications();
  }
  // --------------------
  /// static instance getter
  static AwesomeNotifications getAwesomeNoots() {
    return FCM.instance.awesomeNotifications;
  }
  // --------------------
  /// Static dispose
  static void disposeAwesomeNoots(){
    getAwesomeNoots().dispose();
  }
  // -----------------------------------------------------------------------------
  /// local instance
  FlutterLocalNotificationsPlugin _localNootsPlugin;
  // --------------------
  /// instance getter
  FlutterLocalNotificationsPlugin get localNootsPlugin {
    return _localNootsPlugin ??= FlutterLocalNotificationsPlugin();
  }
  // --------------------
  /// static instance getter
  static FlutterLocalNotificationsPlugin getLocalNootsPlugin() {
    return FCM.instance.localNootsPlugin;
  }
  // --------------------
  /*
  /// Static dispose
  static void dispose(){
    FlutterLocalNotificationsPlugin().dispose();
  }
   */
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

  /// PERMISSIONS

  // --------------------
  ///
  static Future<void> requestAwesomePermission() async {
    await getAwesomeNoots().requestPermissionToSendNotifications(
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

    blog('requestFCMPermission : START');

    final NotificationSettings _settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    FCM.blogNootSettings(
      settings: _settings,
      invoker: 'requestFCMPermission',
    );

    blog('requestFCMPermission : END');

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

  /// PUSHING NOTIFICATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushGlobalNoot({
    @required String title,
    @required String body,
    Map<String, String> payloadMap,
    String largeIconURL,
    TargetProgress progress,
    bool progressBarIsLoading = false,
    bool canBeDismissedWithoutTapping = true,
    FCMChannel channel = FCMChannel.basic,
    /// special fields in awesome notification package
    String bannerURL,
    List<String> buttonsTexts,
  }) async {


    await tryAndCatch(
      methodName: 'pushGlobalNotification',
      functions: () async {

        await getAwesomeNoots().createNotification(
          /// CONTENT
          content: _createGlobalNootContent(
            body: body,
            title: title,
            largeIconURL: largeIconURL,
            bannerURL: bannerURL,
            progress: progress,
            payloadMap: payloadMap,
            progressBarIsLoading: progressBarIsLoading,
            canBeDismissedWithoutTapping: canBeDismissedWithoutTapping,
            channel: channel,
          ),
          /// BUTTONS
          actionButtons: _createGlobalNootActionButtons(
            buttonsTexts: buttonsTexts,
          ),
          /// SCHEDULE
          // schedule: _createNootSchedule(),
        );

      },
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushLocalNoot({
    @required String title,
    @required String body,
    @required String payloadString,
    File largeIconFile,
    TargetProgress progress,
    bool progressBarIsLoading = false,
    bool canBeDismissedWithoutTapping = true,
    FCMChannel channel = FCMChannel.basic,
    /// special fields in flutter local notification package
    String subText,
    bool showStopWatch = false,
    bool showTime = true,
  }) async {

    await FCM.getLocalNootsPlugin().show(
      /// ID
      Numeric.createUniqueID(maxDigitsCount: 8),
      /// TITLE
      title,
      /// BODY
      body,
      /// DETAILS
      NotificationDetails(
        android: _createLocalNootAndroidDetails(
          largeIcon: await _getLocalNootLargeIcon(largeIconFile),
          subText: subText,
          progress: progress,
          canBeDismissedWithoutTapping: canBeDismissedWithoutTapping,
          progressBarIsLoading: progressBarIsLoading,
          showStopWatch: showStopWatch,
          showTime: showTime,
          channel: channel,
        ),
        iOS: _createLocalNootIOSDetails(),
        // macOS: ,
        // linux: ,
      ),
      /// PAYLOAD : data to be passed through
      payload: payloadString,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AndroidBitmap> _getLocalNootLargeIcon(File file) async {
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
  static NotificationContent _createGlobalNootContent({
    @required String title,
    @required String body,
    bool canBeDismissedWithoutTapping = true,
    String largeIconURL,
    String bannerURL,
    Map<String, String> payloadMap,
    TargetProgress progress,
    bool progressBarIsLoading = false,
    FCMChannel channel = FCMChannel.basic,
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
      channelKey: FCM.getNootChannelID(channel),

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
      customSound: Sounder.getNootFilesPath(Sounder.nicoleSaysBldrsDotNet), /// TASK NOT WORKING

      /// DATA
      payload: payloadMap, /// TASK : NOT WORKING

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
  /// TESTED : WORKS PERFECT
  static List<NotificationActionButton> _createGlobalNootActionButtons({
    @required List<String> buttonsTexts,
  }){

    /// BUTTONS ARE DEFINED
    if (Mapper.checkCanLoopList(buttonsTexts) == true){

      final List<NotificationActionButton> _nootButtons = [];

      for (final String buttonText in buttonsTexts) {
        _nootButtons.add(_createGlobalNootActionButton(
          text: buttonText,
        ));
      }

      return _nootButtons;

    }

    /// NO BUTTONS GIVEN
    else {
      return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static NotificationActionButton _createGlobalNootActionButton({
    @required String text,
    Color textColor = Colorz.black255,
  }){
    return NotificationActionButton(
      /// ID
      key: Numeric.createUniqueID(maxDigitsCount: 8).toString(),

      /// BUTTON TEXT
      label: text,
      color: textColor,

      /// CAN TAP BUTTON ?
      enabled: true,
      /// DISMISS NOTIFICATION ON BUTTON TAP
      autoDismissible: true,
      /// MAKES TEXT RED
      isDangerousOption: false,

      /// NOT WORKING - NOT IMPACTFUL
      icon: NoteModel.bldrsLogoStaticURL,
      showInCompactView: true,
      // buttonType: ActionButtonType.Default, // ActionButtonType.Default is default

    );
  }
  // --------------------
  /// --- TAMAM : WORKS PERFECT : TASK : (except for notification sound)
  static AndroidNotificationDetails _createLocalNootAndroidDetails({
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
      getNootChannelID(channel), // channelId
      getNootChannelName(channel), // channelName
      channelDescription: getNootChannelDescription(channel),
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
      vibrationPattern: _createLocalNootVibration(),
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
  static IOSNotificationDetails _createLocalNootIOSDetails(){
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
  /// --- FAKES NOW
  static Int64List _createLocalNootVibration(){
    return Int64List.fromList(vibrationPatternInts);
  }
  // -----------------------------------------------------------------------------

  /// TAPPING

  // --------------------
  ///
  static Future<void> onLocalNootTap(String payload) async {

    if (payload != null) {

      /// ROUTE IS NOTIFICATION [PAYLOAD] BABY
      blog('onLocalNootTap : route is : $payload');
      // await Nav.goToNewScreen(
      //   context: context, // context is bitch
      //   screen: const AwesomeNotiTestScreen(),
      // );

    }

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

    getAwesomeNoots().actionStream.listen((ReceivedAction receivedAction) {
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

    await getAwesomeNoots().createNotification(
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

  /// CHANNELS

  // --------------------
  ///
  static List<NotificationChannel> getBldrsNootsChannels(){

    return <NotificationChannel>[
      FCM.basicNootChannel(),
    ];

  }
  // --------------------
  ///
  static List<NotificationChannelGroup> getBldrsChannelGroups(){

    return <NotificationChannelGroup>[

      // NotificationChannelGroup(
      //   channelGroupkey: ,
      //   channelGroupName: ,
      // ),

    ];

  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getNootChannelID(FCMChannel channel) {
    switch (channel) {
      case FCMChannel.basic:      return 'basic_noot';break;
      case FCMChannel.scheduled:  return 'scheduled_noot';break;
      default:                    return 'basic_noot';
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getNootChannelName(FCMChannel channel) {
    switch (channel) {
      case FCMChannel.basic:      return 'إشعارات';break; /// TASK : NEED BETTER NAME
      case FCMChannel.scheduled:  return 'Scheduled Notifications';break;
      default:                    return 'Basic Notifications';
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getNootChannelDescription(FCMChannel channel) {
    switch (channel) {
      case FCMChannel.basic:      return 'Bldrs.net is amazing';break;
      case FCMChannel.scheduled:  return 'Bldrs.net is outstanding';break;
      default:                    return 'Bldrs.net is amazing';
    }
  }
  // --------------------
  ///
  static NotificationChannel basicNootChannel() {

    /// NOTE : WORKS WHEN APP IS IN FOREGROUND
    return NotificationChannel(
      channelKey: getNootChannelID(FCMChannel.basic),
      channelName: getNootChannelName(FCMChannel.basic),
      channelDescription: getNootChannelDescription(FCMChannel.basic), // this will be visible to user in android notification settings

      ///
      defaultColor: Colorz.green255, /// TASK : IS THIS THE YELLOW ICON ON TOP,, NOW WILL DO GREEN TO TEST
      channelShowBadge: true,
      icon: fcmWhiteLogoFilePath,
      ledColor: Colorz.facebook, /// TASK : IS THIS THE YELLOW ICON ON TOP,, NOW WILL DO facebook color TO TEST
      importance: NotificationImportance.High,
      locked: true,
      playSound: true,
      soundSource: Sounder.getNootFilesPath(Sounder.nicoleSaysBldrsDotNet),
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
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  ///
  static Future<bool> checkIsNootAllowed() async {
    bool _allowed = false;

    final AwesomeNotifications _awesomeNotification = getAwesomeNoots();

    if (_awesomeNotification != null){
      _allowed = await _awesomeNotification.isNotificationAllowed();
    }

    blog('checkIsNotificationAllowed : allowed : $_allowed');

    return _allowed;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogRemoteMessage({
    String invoker,
    RemoteMessage remoteMessage
  }) {

    blog('blogRemoteMessage : $invoker : START');

    blog('remoteMessage?.notification?.body                : ${remoteMessage?.notification?.body}');
    blog('remoteMessage?.notification?.title               : ${remoteMessage?.notification?.title}');
    blog('remoteMessage?.notification?.android             : ${remoteMessage?.notification?.android}');
    blog('remoteMessage?.notification?.apple               : ${remoteMessage?.notification?.apple}');
    blog('remoteMessage?.notification?.web?.analyticsLabel : ${remoteMessage?.notification?.web?.analyticsLabel}');
    blog('remoteMessage?.notification?.web?.image          : ${remoteMessage?.notification?.web?.image}');
    blog('remoteMessage?.notification?.web?.link           : ${remoteMessage?.notification?.web?.link}');
    blog('remoteMessage?.notification?.bodyLocKey          : ${remoteMessage?.notification?.bodyLocKey}');
    blog('remoteMessage?.notification?.bodyLocArgs         : ${remoteMessage?.notification?.bodyLocArgs}');
    blog('remoteMessage?.notification?.titleLocKey         : ${remoteMessage?.notification?.titleLocKey}');
    blog('remoteMessage?.notification?.titleLocArgs        : ${remoteMessage?.notification?.titleLocArgs}');
    blog('remoteMessage?.category                          : ${remoteMessage?.category}');
    blog('remoteMessage?.collapseKey                       : ${remoteMessage?.collapseKey}');
    blog('remoteMessage?.contentAvailable                  : ${remoteMessage?.contentAvailable}');
    blog('remoteMessage?.from                              : ${remoteMessage?.from}');
    blog('remoteMessage?.messageId                         : ${remoteMessage?.messageId}');
    blog('remoteMessage?.messageType                       : ${remoteMessage?.messageType}');
    blog('remoteMessage?.mutableContent                    : ${remoteMessage?.mutableContent}');
    blog('remoteMessage?.senderId                          : ${remoteMessage?.senderId}');
    blog('remoteMessage?.sentTime                          : ${remoteMessage?.sentTime}');
    blog('remoteMessage?.threadId                          : ${remoteMessage?.threadId}');
    blog('remoteMessage?.ttl                               : ${remoteMessage?.ttl}');
    blog('remoteMessage?.data                              : ${remoteMessage?.data}');

    blog('blogRemoteMessage : $invoker : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogNootSettings({
    @required NotificationSettings settings,
    @required String invoker,
  }){

    blog('blogNootSettings : $invoker : START');

    if (settings == null){
      blog('blogNootSettings : settings are null');
    }

    else {

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

    }

    blog('blogNootSettings : $invoker : END');

  }
  // -----------------------------------------------------------------------------

  /// SCHEDULING : FAKES FOR NOW

  // --------------------
  /// FAKES NOW
  /*
  static NotificationSchedule _createNootSchedule(){

    return null;

    // return NotificationSchedule(
    //   preciseAlarm: ,
    //   timeZone: ,
    //   repeats: ,
    //   allowWhileIdle: ,
    // );

  }
   */
  // --------------------
  /// FAKES NOW
  /*
  static Future<void> cancelScheduledNoots() async {
    await getAwesomeNotifications().cancelAllSchedules();
  }
   */
  // --------------------
  /// FAKES NOW
  /*
  static NotificationChannel scheduledNootChannel() {
    return NotificationChannel(
      channelKey: getNootChannelName(FCMChannel.scheduled),
      channelName: getNootChannelName(FCMChannel.scheduled),
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
      soundSource: Sounder.getNootFilesPath(Sounder.justinaSaysBldrsDotNet),
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
   */
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
    //   //   flutterLocalNotificationsPlugin = FCM.getLocalNootsPlugin()();
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
}
