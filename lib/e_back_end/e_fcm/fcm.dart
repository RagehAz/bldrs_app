import 'dart:convert';
import 'dart:typed_data';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/target/target_progress.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/f_helpers/drafters/error_helpers.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/a_rest/rest.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';

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
  /// AWESOME NOTIFICATIONS SINGLETON
  AwesomeNotifications _awesomeNotifications;
  AwesomeNotifications get awesomeNotifications => _awesomeNotifications ??= AwesomeNotifications();
  static AwesomeNotifications getAwesomeNoots() => FCM.instance.awesomeNotifications;
  // --------------------
  /// Static dispose
  static void disposeAwesomeNoots(){
    getAwesomeNoots().dispose();
  }
  // -----------------------------------------------------------------------------
  /// LOCAL NOOT PLUGIN SINGLETON
  FlutterLocalNotificationsPlugin _localNootsPlugin;
  FlutterLocalNotificationsPlugin get localNootsPlugin => _localNootsPlugin ??= FlutterLocalNotificationsPlugin();
  static FlutterLocalNotificationsPlugin getLocalNootsPlugin() => FCM.instance.localNootsPlugin;
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

    /// NOTE : THIS PUSHES NATIVE NOTIFICATIONS PERMISSIONS SCREEN

    const List<NotificationPermission> _permissions = <NotificationPermission>[
      NotificationPermission.Alert,
      NotificationPermission.Sound,
      NotificationPermission.Badge,
      NotificationPermission.Light,
      NotificationPermission.Vibration,
      NotificationPermission.FullScreenIntent,
      NotificationPermission.PreciseAlarms,
      NotificationPermission.CriticalAlert,
      NotificationPermission.OverrideDnD,
      NotificationPermission.Provisional,
      NotificationPermission.Car,
    ];

    // final List<NotificationPermission> _allowed = await getAwesomeNoots().checkPermissionList(
    //   channelKey: ChannelModel.bldrsChannel.id,
    //   permissions: _permissions,
    // );
    //
    // blog('requestAwesomePermission : permissions are : $_allowed');

    await getAwesomeNoots().requestPermissionToSendNotifications(
      channelKey: ChannelModel.bldrsChannel.id,
      permissions: _permissions,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT : /// TASK : STILL NOT USED ANYWHERE
  static Future<bool> checkIsAwesomeNootAllowed() async {
    bool _allowed = false;

    final AwesomeNotifications _awesomeNotification = getAwesomeNoots();

    if (_awesomeNotification != null){
      _allowed = await _awesomeNotification.isNotificationAllowed();
    }

    blog('checkIsNotificationAllowed : allowed : $_allowed');

    return _allowed;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<NotificationSettings> requestFCMPermission() async {

    // blog('requestFCMPermission : START');

    // if (Platform.isIOS) {
      // iosSubscription = FirebaseMessaging.instance.onIosSettingsRegistered.listen((data) {
      //   _saveDeviceTokenToUserDocInFireStore();
      // });

    //   // await FirebaseMessaging.instance
    //   //     .setForegroundNotificationPresentationOptions(
    //   //   alert: true,
    //   //   badge: true,
    //   //   sound: true,
    //   // );

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
        channelShowBadge: true, // auto increment badge

        /// FAKES
        importance: NotificationImportance.High, // auto increment badge bardo ?
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
      invoker: 'pushGlobalNotification',
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
  /// TESTED : WORKS PERFECT
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
      color: Colorz.bloodTest, /// is icon color.. is ignored when backgroundColor is assigned

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
      customSound: Sounder.getNootFilesPath(Sounder.nicoleSaysBldrsDotNet),

      /// DATA
      payload: payloadMap,

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
  /// TESTED : WORKS PERFECT
  static Future<void> subscribeToTopic({
    String topicID
  }) async {

    /*

         Messages sent to topics should not contain sensitive or private information.
         Do not create a topic for a specific user to subscribe to.

         Topic messaging supports unlimited subscriptions for each topic.

         One app instance can be subscribed to no more than 2000 topics.

         The frequency of new subscriptions is rate-limited per project.

         If you send too many subscription requests in a short period of time,
         FCM servers will respond with a 429 RESOURCE_EXHAUSTED ("quota exceeded")
          response. Retry with an exponential backoff.

         A server integration can send a single message to multiple topics at once.
         This, however, is limited to 5 topics.

     */

    if (AuthModel.userIsSignedIn() == true){
      blog('User : ${AuthFireOps.superUserID()} subscribed to topic : $topicID');
      await FirebaseMessaging.instance.subscribeToTopic(topicID);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> unsubscribeFromTopic({
    @required String topicID,
  }) async {
    if (AuthModel.userIsSignedIn() == true){
      blog('User : ${AuthFireOps.superUserID()} unSubscribed from topic : $topicID');
      await FirebaseMessaging.instance.unsubscribeFromTopic(topicID);
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT : TASK : SHOULD BE DONE ON SERVER SIDE TO CONCEAL FCM SERVER KEY
  static Future<List<String>> readMySubscribedTopics(BuildContext context) async {

    List<String> _topics;

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    const String fcmServerKey = Standards.fcmServerKey;

    final String token = _myUserModel.device.token;

    final Response _result = await Rest.get(
      context: context,
      rawLink: 'https://iid.googleapis.com/iid/info/$token?details=true',
      headers: {
        'Authorization': 'Bearer $fcmServerKey',
        // 'Content-Type': 'application/json',
        // 'Authorization': 'key=$fcmServerKey',
      },
      showErrorDialog: true,
      invoker: 'readMySubscribedTopics',
    );

    if (_result?.body != null){

      final Map<String, dynamic> _map = json.decode(_result.body);

      final Map<String, dynamic> _topicsMap = Mapper.getMapFromInternalHashLinkedMapObjectObject(
          internalHashLinkedMapObjectObject: _map['rel']['topics'],
      );

      _topics = _topicsMap.keys.toList();

    }

    return _topics;
  }
  // -----------------------------------------------------------------------------

  /// DEVICE TOKEN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> generateToken() async {

    String _fcmToken;

    await tryAndCatch(
      invoker: 'generateToken',
      functions: () async {

        final FirebaseMessaging _fcm = FirebaseMessaging.instance;
        _fcmToken = await _fcm.getToken(
          // vapidKey:
        );

        await _fcm.setAutoInitEnabled(true);

      },
      onError: (String error) async {

        /// maybe show dialog
        // await CenterDialog.showCenterDialog(
        //     context: context,
        //     titleVerse: const Verse(
        //       text: '##Notifications are temporarily suspended',
        //       translate: true,
        //     ),
        //     onOk: (){
        //       blog('error is : $error');
        //     }
        // );

        /// error codes reference
        // https://firebase.google.com/docs/reference/fcm/rest/v1/ErrorCode
        // UNREGISTERED (HTTP 404)
        // INVALID_ARGUMENT (HTTP 400)
        // [firebase_messaging/unknown] java.io.IOException: SERVICE_NOT_AVAILABLE
        /// task : error : [firebase_messaging/unknown] java.io.IOException: SERVICE_NOT_AVAILABLE

      },

    );

    return _fcmToken;
  }
  // -----------------------------------------------------------------------------

  /// GLOBAL BADGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<int> getGlobalBadgeNumber() async {
    final int _num = await getAwesomeNoots().getGlobalBadgeCounter();
    // blog('getGlobalBadgeNumber : _num : $_num');
    return _num ?? 0;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> incrementGlobalBadgeXXX() async {
    // blog('incrementGlobalBadge : INCREMENTING 1 : ${Numeric.createUniqueID(maxDigitsCount: 4)}');
    final int _num = await getGlobalBadgeNumber();
    await setGlobalBadgeNumber(_num+1);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> decrementGlobalBadge() async {
    await getAwesomeNoots().decrementGlobalBadgeCounter();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> setGlobalBadgeNumber(int num) async {
    await getAwesomeNoots().setGlobalBadgeCounter(num);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> resetGlobalBadgeNumber() async {
    await getAwesomeNoots().resetGlobalBadge();
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
    //   //   invoker: 'notificationPushHandler',
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
