import 'dart:typed_data';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/b_bz/target/target_progress.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static Future<NotificationSettings> requestFCMPermission() async {

    // blog('requestFCMPermission : START');

    // if (Platform.isIOS) {
      // iosSubscription = FirebaseMessaging.instance.onIosSettingsRegistered.listen((data) {
      //   _saveDeviceTokenToUserDocInFireStore();
      // });
    // }

    final NotificationSettings _settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    // FCM.blogNootSettings(
    //   settings: _settings,
    //   invoker: 'requestFCMPermission',
    // );

    // blog('requestFCMPermission : END');

    return _settings;
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
    Progress progress,
    bool progressBarIsLoading = false,
    bool canBeDismissedWithoutTapping = true,
    /// special fields in awesome notification package
    String posterURL,
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
            bannerURL: posterURL,
            progress: progress,
            payloadMap: payloadMap,
            progressBarIsLoading: progressBarIsLoading,
            canBeDismissedWithoutTapping: canBeDismissedWithoutTapping,
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
  // -----------------------------------------------------------------------------

  /// NOTIFICATION CONTENTS

  // --------------------
  /// TAMAM : WORKS PERFECT
  static NotificationContent _createGlobalNootContent({
    @required String title,
    @required String body,
    bool canBeDismissedWithoutTapping = true,
    String largeIconURL,
    String bannerURL,
    Map<String, String> payloadMap,
    Progress progress,
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

      /// CHANNEL
      channelKey: ChannelModel.bldrsChannel.id,
      summary: ChannelModel.bldrsChannel.description,
      groupKey: ChannelModel.bldrsChannel.group,

      /// ACTION
      // actionType: ActionType.Default,

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
      // hideLargeIconOnExpand: false,

      /// BEHAVIOUR
      locked: !canBeDismissedWithoutTapping,
      // displayOnBackground: true,
      // displayOnForeground: true,
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
      // showWhen: null,
      // category: NotificationCategory.Email,
      // criticalAlert: false,
      // ticker: 'wtf is ticker',


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
      // enabled: true,
      /// DISMISS NOTIFICATION ON BUTTON TAP
      // autoDismissible: true,
      /// MAKES TEXT RED
      // isDangerousOption: false,

      /// NOT WORKING - NOT IMPACTFUL
      icon: NoteParties.bldrsLogoStaticURL,
      showInCompactView: true,
      // buttonType: ActionButtonType.Default, // ActionButtonType.Default is default

      // requireInputText: false, // TASK : not tested
    );
  }
  // --------------------
  /// --- FAKES NOW
  static Int64List createLocalNootVibration(){
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
  /*
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
   */
  // --------------------
  /*
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
   */
  // -----------------------------------------------------------------------------

  /// TOPICS

  // --------------------
  /// TESTED : ...
  static Future<void> subscribeToTopic({
    String topicName
  }) async {

    if (AuthModel.userIsSignedIn() == true){
      blog('User : ${AuthFireOps.superUserID()} subscribed to topic : $topicName');
      await FirebaseMessaging.instance.subscribeToTopic(topicName);
    }

  }
  // --------------------
  /// TESTED : ...
  static Future<void> unsubscribeFromTopic({
    @required String topicName,
  }) async {
    if (AuthModel.userIsSignedIn() == true){
      blog('User : ${AuthFireOps.superUserID()} unSubscribed from topic : $topicName');
      await FirebaseMessaging.instance.unsubscribeFromTopic(topicName);
    }
  }
  // -----------------------------------------------------------------------------

  /// CHANNELS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NotificationChannel> generateBldrsNootChannels(){

    final List<NotificationChannel> _channels = <NotificationChannel>[

      NotificationChannel(
        /// CHANNEL
        channelKey: ChannelModel.bldrsChannel.id,
        channelName: ChannelModel.bldrsChannel.name,
        /// this will be visible to user in android notification settings
        channelDescription: ChannelModel.bldrsChannel.description,

        /// GROUP
        channelGroupKey: ChannelModel.bldrsChannel.group,
        groupKey: ChannelModel.bldrsChannel.group,
        groupSort: GroupSort.Asc,

        /// ICON
        icon: fcmWhiteLogoFilePath,
        defaultColor: Colorz.black255,

        /// SOUND
        playSound: true,
        soundSource: Sounder.getNootFilesPath(Sounder.nicoleSaysBldrsDotNet),
        defaultRingtoneType: DefaultRingtoneType.Notification,

        /// LIGHTS
        enableLights: true,
        ledColor: Colorz.yellow255,
        // ledOnMs: 2, /// NOT IMPORTANT : NOT TESTED
        // ledOffMs: 2, /// NOT IMPORTANT : NOT TESTED

        /// VIBRATION
        enableVibration: true,
        vibrationPattern: createLocalNootVibration(),

        /// BEHAVIOUR
        locked: false, //  = !canBeDismissedWithoutTapping,
        channelShowBadge: true,

        /// FAKES
        importance: NotificationImportance.High,
        defaultPrivacy: NotificationPrivacy.Public,
        onlyAlertOnce: true,
        // groupAlertBehavior: GroupAlertBehavior(),
        // criticalAlerts: ,

      ),

    ];


    return _channels;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NotificationChannelGroup> getBldrsChannelGroups(){

    return <NotificationChannelGroup>[

      /// GENERAL
      NotificationChannelGroup(
        channelGroupkey: ChannelModel.bldrsChannel.group,
        channelGroupName: ChannelModel.bldrsChannel.group,
      ),

    ];

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
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
    @required RemoteMessage remoteMessage,
    @required String invoker,
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

    Mapper.blogMap(remoteMessage?.data, invoker: invoker);

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
