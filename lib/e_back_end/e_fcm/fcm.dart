import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/error_helpers.dart';
import 'package:basics/helpers/classes/checks/object_check.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/files/floaters.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/target/target_progress.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm_starter.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_sounder.dart';
import 'package:fire/super_fire.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/mediator/sounder/sounder.dart';
import 'package:basics/helpers/classes/rest/rest.dart';
import 'dart:io';

/*

Egyptian Salary for 3 years of experience
rate 1 : 25000 EGP / Month / 20 days / 8 hours = 156 EGP/hour
but should increase rate for freelance jobs

/// INTERNATIONAL EGYPTIAN COMPETITIVE RATE "less than 40$ per hour"
rate 2 : min 18$ - max 30$ = 450 - 750 EGP/hour => can not be used locally with local contracts

/// DURATION REQUIRED TO CREATE THE CODE FOR THE FIRST TIME
initial build & learning duration : 34 days * 10 hours = 340 hours

/// EXPECTED DURATION REQUIRED TO INSTALL THE CODE ON NEW PROJECT
expected implementation duration : 100 hours

/// CONCLUDED PRICE FOR THE ENTIRE JOB
total : 156 EGP/HOUR * 100 hours = 15600 EGP

 */

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
  AwesomeNotifications? _awesomeNotifications;

  AwesomeNotifications get awesomeNotifications =>
      _awesomeNotifications ??= AwesomeNotifications();

  static AwesomeNotifications? getAwesomeNoots() {
    if (kIsWeb == true || DeviceChecker.deviceIsWindows() == true) {
      return null;
    }
    else {
      return FCM.instance.awesomeNotifications;
    }
  }

  // --------------------
  /// Static dispose
  static void disposeAwesomeNoots() {
    getAwesomeNoots()?.dispose();
  }

  // -----------------------------------------------------------------------------
  /// LOCAL NOOT PLUGIN SINGLETON
  FlutterLocalNotificationsPlugin? _localNootsPlugin;

  FlutterLocalNotificationsPlugin get localNootsPlugin =>
      _localNootsPlugin ??= FlutterLocalNotificationsPlugin();

  static FlutterLocalNotificationsPlugin getLocalNootsPlugin() =>
      FCM.instance.localNootsPlugin;

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
  static const String fcmWhiteLogoFileName = 'res_flat_logo';

  ///'resource://drawable/res_flat_logo'; // "@mipmap/ic_launcher"
  // --------------------
  static const String fcmColorLogoFilePath = 'resource://drawable/res_color_logo';
  static const String fcmColorLogoFileName = 'res_color_logo';

  // --------------------
  static const List<int> vibrationPatternInts = <int>[
    1000, 1000, 1000, 1000,
    1000, 1000, 1000, 1000,
    1000, 1000, 1000, 1000,
    1000, 1000, 1000, 1000,
  ];

  // -----------------------------------------------------------------------------

  /// PERMISSIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> requestAwesomePermission({
    required ChannelModel channel,
  }) async {

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

    // final List<NotificationPermission> _allowed = await getAwesomeNoots()?.checkPermissionList(
    //   channelKey: ChannelModel.bldrsChannel.id,
    //   permissions: _permissions,
    // );
    //
    // blog('requestAwesomePermission : permissions are : $_allowed');

    await getAwesomeNoots()?.requestPermissionToSendNotifications(
      channelKey: channel.id,
      permissions: _permissions,
    );
  }

  // --------------------
  /// TESTED : WORKS PERFECT : /// TASK : STILL NOT USED ANYWHERE
  static Future<bool> checkIsAwesomeNootAllowed() async {
    bool _allowed = false;

    final AwesomeNotifications? _awesomeNotification = getAwesomeNoots();

    if (_awesomeNotification != null) {
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
    //   iosSubscription = FirebaseMessaging.instance.onIosSettingsRegistered.listen((data) {
    //     _saveDeviceTokenToUserDocInFireStore();
    //   });

    // await FirebaseMessaging.instance
    //     .setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );

    // }

    final NotificationSettings _settings = await FirebaseMessaging.instance
        .requestPermission(
      // alert: true,
      // badge: true,
      // provisional: false,
      // sound: true,
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
  static List<NotificationChannel> generateBldrsNootChannels({
    required ChannelModel channel,
  }) {
    final List<NotificationChannel> _channels = <NotificationChannel>[

      NotificationChannel(

        /// CHANNEL
        channelKey: channel.id,
        channelName: channel.name,

        /// this will be visible to user in android notification settings
        channelDescription: channel.description,

        /// GROUP
        channelGroupKey: channel.group,
        groupKey: channel.group,
        groupSort: GroupSort.Asc,

        /// ICON
        icon: fcmWhiteLogoFilePath,
        defaultColor: Colorz.black255,

        /// SOUND
        playSound: true,
        soundSource: Sounder.getFCMSoundFilePath(
            BldrsSounder.nicoleSaysBldrsDotNet),
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
        locked: false,
        //  = !canBeDismissedWithoutTapping,
        channelShowBadge: true,
        // auto increment badge

        /// FAKES
        importance: NotificationImportance.High,
        // auto increment badge bardo ?
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
  static List<NotificationChannelGroup> getBldrsChannelGroups({
    required ChannelModel channel,
  }) {
    return <NotificationChannelGroup>[

      /// GENERAL
      NotificationChannelGroup(
        channelGroupKey: channel.id,
        channelGroupName: channel.group,
      ),

    ];
  }

  // -----------------------------------------------------------------------------

  /// PUSHING NOTIFICATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushGlobalNoot({
    required ChannelModel? channelModel,
    required String? title,
    required String? body,
    Map<String, String>? payloadMap,
    String? largeIconURL,
    Progress? progress,
    bool progressBarIsLoading = false,
    bool canBeDismissedWithoutTapping = true,

    /// special fields in awesome notification package
    String? posterURL,
    List<String>? buttonsTexts,
  }) async {

    final String? _largeIconURL = await getNootPicURLIfNotURL(largeIconURL);
    final String? _posterURL = await getNootPicURLIfNotURL(posterURL);

    await tryAndCatch(
      invoker: 'pushGlobalNotification',
      functions: () async {

        final NotificationContent? _content = createGlobalNootContent(
          channelModel: channelModel,
          body: body,
          title: title,
          nootIcon: _largeIconURL,
          posterURL: _posterURL,
          progress: progress,
          payloadMap: payloadMap,
          progressBarIsLoading: progressBarIsLoading,
          canBeDismissedWithoutTapping: canBeDismissedWithoutTapping,
        );

        if (_content != null) {
          await getAwesomeNoots()?.createNotification(

            /// CONTENT
            content: _content,

            /// BUTTONS
            actionButtons: createGlobalNootActionButtons(
              buttonsTexts: buttonsTexts,
            ),

            /// SCHEDULE
            // schedule: _createNootSchedule(),
          );
        }
      },
    );
  }

  // --------------------
  ///
  static Future<String?> getNootPicURLIfNotURL(String? urlOrPath) async {
    String? _url;

    if (TextCheck.isEmpty(urlOrPath) == false) {

      /// IS A URL ALREADY
      if (ObjectCheck.isAbsoluteURL(urlOrPath) == true) {
        _url = urlOrPath;
      }

      /// IS PIC PATH
      else if (ObjectCheck.objectIsPicPath(urlOrPath) == true) {
        _url = await Storage.createURLByPath(
          path: urlOrPath,
        );
      }

      /// OTHERWISE
      else {
        _url = urlOrPath;
      }
    }

    // blog('the bitch ass fucking url isssss :$_url');

    return _url;
  }

  // ----------------------------------------------------------------------------

  /// NOTIFICATION CONTENTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static NotificationContent? createGlobalNootContent({
    required ChannelModel? channelModel,
    required String? title,
    required String? body,
    bool canBeDismissedWithoutTapping = true,
    String? nootIcon,
    String? posterURL,
    Map<String, String>? payloadMap,
    Progress? progress,
    bool progressBarIsLoading = false,
  }) {
    blog('_createNotificationContent : START');

    int? _progress;
    if (
    progress != null
        &&
        progressBarIsLoading == false
        &&
        progress.objective != null
        &&
        progress.current != null
        &&
        channelModel != null
    ) {
      _progress = ((progress.current! / progress.objective!) * 100).toInt();
    }

    NotificationLayout _layout;
    if (DeviceChecker.deviceIsIOS() == true) {
      _layout = NotificationLayout.BigText;
    }
    else if (progress != null || progressBarIsLoading == true) {
      _layout = NotificationLayout.ProgressBar;
    }
    else if (posterURL != null) {
      _layout = NotificationLayout.BigPicture;
    }
    else {
      _layout = NotificationLayout.BigText;
    }

    return NotificationContent(

      /// IDENTIFICATION
      id: Numeric.createUniqueID(maxDigitsCount: 8),

      /// CHANNEL
      channelKey: channelModel!.id,
      summary: channelModel.description,
      groupKey: channelModel.group,

      /// TEXT
      title: title,
      body: body,

      /// IMAGES
      notificationLayout: _layout,

      /// NOOT POSTER
      bigPicture: posterURL,
      // redBldrsBanner,
      /// NOOT ICON
      largeIcon: nootIcon,
      //NoteParties.bldrsLogoStaticURL,
      hideLargeIconOnExpand: posterURL == null,
      // in-effective anyways

      /// DEVICE STATUS BAR ICON
      icon: fcmWhiteLogoFilePath,
      backgroundColor: Colorz.black255,

      /// is icon color bardo , bas override color
      color: Colorz.bloodTest,

      /// is icon color.. is ignored when backgroundColor is assigned


      /// BEHAVIOUR
      locked: !canBeDismissedWithoutTapping,
      // displayOnBackground: true,
      // displayOnForeground: true,
      wakeUpScreen: true,

      /// SOUND
      customSound: Sounder.getFCMSoundFilePath(
          BldrsSounder.nicoleSaysBldrsDotNet),

      /// DATA
      payload: payloadMap,

      /// PROGRESS
      progress: _progress,

      /// FAKES
      // showWhen: true,

      // autoDismissible: ,
      // category: ,
      // criticalAlert: ,
      fullScreenIntent: true,
      // ticker: ,
    );
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NotificationActionButton>? createGlobalNootActionButtons({
    required List<String>? buttonsTexts,
  }) {

    /// BUTTONS ARE DEFINED
    if (Lister.checkCanLoop(buttonsTexts) == true) {
      final List<NotificationActionButton> _nootButtons = [];

      for (final String buttonText in buttonsTexts!) {
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
    required String text,
    Color textColor = Colorz.black255,
  }) {
    return NotificationActionButton(

      /// ID
      key: Numeric.createUniqueID(maxDigitsCount: 8).toString(),

      /// BUTTON TEXT
      label: text,
      color: textColor,

      /// CAN TAP BUTTON ?
      // enabled: true,
      // On Android, deactivates the button. On iOS, the button disappear
      /// DISMISS NOTIFICATION ON BUTTON TAP
      // autoDismissible: true,
      /// MAKES TEXT RED
      // isDangerousOption: false,

      /// NOT WORKING - NOT IMPACTFUL
      icon: redBldrsBanner,
      //NoteParties.bldrsLogoStaticURL,
      showInCompactView: true,
      // buttonType: ActionButtonType.Default, // ActionButtonType.Default is default

      // requireInputText: false, // TASK : not tested
    );
  }

  // --------------------
  /// --- FAKES NOW
  static Int64List createLocalNootVibration() {
    return Int64List.fromList(vibrationPatternInts);
  }

  // -----------------------------------------------------------------------------

  /// TAPPING

  // --------------------
  ///
  static Future<void> onLocalNootTap(NotificationResponse? payload) async {
    FCM.blogNotificationResponse(payload);

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
    required BuildContext context,
    required Widget screenToGoToOnNotiTap,
  }) async {

    await notify();

    getAwesomeNoots()?.actionStream.listen((ReceivedAction receivedAction) {
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

    await getAwesomeNoots()?.createNotification(
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
    String? topicID
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

    final UserModel? _user = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    if (Authing.userIsSignedUp(_user?.signInMethod) == true &&
        _user?.device?.token != null) {
      // blog('User : ${Authing.getUserID()} subscribed to topic : $topicID');
      if (FCMStarter.canInitializeFCM() == true && topicID != null) {
        await tryAndCatch(
          invoker: 'FCM.subscribeToTopic',
          functions: () async {
            await FirebaseMessaging.instance.subscribeToTopic(topicID);
          },
        );
      }
    }
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> unsubscribeFromTopic({
    required String? topicID,
  }) async {
    final UserModel? _user = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    if (Authing.userIsSignedUp(_user?.signInMethod) == true &&
        _user?.device?.token != null) {
      // blog('User : ${Authing.getUserID()} unSubscribed from topic : $topicID');
      if (FCMStarter.canInitializeFCM() == true && topicID != null) {
        await tryAndCatch(
          invoker: 'FCM.unsubscribeFromTopic',
          functions: () async {
            await FirebaseMessaging.instance.unsubscribeFromTopic(topicID);
          },
        );
      }
    }
  }

  // --------------------
  /// TESTED : WORKS PERFECT : TASK : SHOULD BE DONE ON SERVER SIDE TO CONCEAL FCM SERVER KEY
  static Future<List<String>?> readMySubscribedTopics(BuildContext context) async {
    List<String>? _topics;

    final UserModel? _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    const String fcmServerKey = BldrsKeys.fcmServerKey;

    final String? token = _myUserModel?.device?.token;

    if (token != null) {
      final Response? _result = await Rest.get(
        rawLink: 'https://iid.googleapis.com/iid/info/$token?details=true',
        headers: {
          'Authorization': 'Bearer $fcmServerKey',
          // 'Content-Type': 'application/json',
          // 'Authorization': 'key=$fcmServerKey',
        },
        invoker: 'readMySubscribedTopics',
      );

      if (_result?.body != null) {
        final Map<String, dynamic> _map = json.decode(_result!.body);

        final Map<String, dynamic>? _topicsMap = Mapper.getMapFromIHLMOO(
          ihlmoo: _map['rel']['topics'],
        );

        _topics = _topicsMap?.keys.toList();
      }
    }

    return _topics;
  }
  // -----------------------------------------------------------------------------

  /// DEVICE TOKEN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> generateToken() async {
    String? _fcmToken;

    if (FCMStarter.canInitializeFCM() == true) {
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
          //       text: '#!#Notifications are temporarily suspended',
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
    }

    return _fcmToken;
  }

  // -----------------------------------------------------------------------------

  /// GLOBAL BADGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<int> getGlobalBadgeNumber() async {
    final int? _num = await getAwesomeNoots()?.getGlobalBadgeCounter();
    // blog('getGlobalBadgeNumber : _num : $_num');
    return _num ?? 0;
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> incrementGlobalBadgeXXX() async {
    // blog('incrementGlobalBadge : INCREMENTING 1 : ${Numeric.createUniqueID(maxDigitsCount: 4)}');
    final int _num = await getGlobalBadgeNumber();
    await setGlobalBadgeNumber(_num + 1);
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> decrementGlobalBadge() async {
    await getAwesomeNoots()?.decrementGlobalBadgeCounter();
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> setGlobalBadgeNumber(int num) async {
    await getAwesomeNoots()?.setGlobalBadgeCounter(num);
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> resetGlobalBadgeNumber() async {
    await getAwesomeNoots()?.resetGlobalBadge();
  }

  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogRemoteMessage({
    required RemoteMessage? remoteMessage,
    required String invoker,
  }) {
    blog('blogRemoteMessage : $invoker : START');

    blog('remoteMessage?.notification?.body                : ${remoteMessage
        ?.notification?.body}');
    blog('remoteMessage?.notification?.title               : ${remoteMessage
        ?.notification?.title}');
    blog('remoteMessage?.notification?.android             : ${remoteMessage
        ?.notification?.android}');
    blog('remoteMessage?.notification?.apple               : ${remoteMessage
        ?.notification?.apple}');
    blog('remoteMessage?.notification?.web?.analyticsLabel : ${remoteMessage
        ?.notification?.web?.analyticsLabel}');
    blog('remoteMessage?.notification?.web?.image          : ${remoteMessage
        ?.notification?.web?.image}');
    blog('remoteMessage?.notification?.web?.link           : ${remoteMessage
        ?.notification?.web?.link}');
    blog('remoteMessage?.notification?.bodyLocKey          : ${remoteMessage
        ?.notification?.bodyLocKey}');
    blog('remoteMessage?.notification?.bodyLocArgs         : ${remoteMessage
        ?.notification?.bodyLocArgs}');
    blog('remoteMessage?.notification?.titleLocKey         : ${remoteMessage
        ?.notification?.titleLocKey}');
    blog('remoteMessage?.notification?.titleLocArgs        : ${remoteMessage
        ?.notification?.titleLocArgs}');
    blog('remoteMessage?.category                          : ${remoteMessage
        ?.category}');
    blog('remoteMessage?.collapseKey                       : ${remoteMessage
        ?.collapseKey}');
    blog('remoteMessage?.contentAvailable                  : ${remoteMessage
        ?.contentAvailable}');
    blog('remoteMessage?.from                              : ${remoteMessage
        ?.from}');
    blog('remoteMessage?.messageId                         : ${remoteMessage
        ?.messageId}');
    blog('remoteMessage?.messageType                       : ${remoteMessage
        ?.messageType}');
    blog('remoteMessage?.mutableContent                    : ${remoteMessage
        ?.mutableContent}');
    blog('remoteMessage?.senderId                          : ${remoteMessage
        ?.senderId}');
    blog('remoteMessage?.sentTime                          : ${remoteMessage
        ?.sentTime}');
    blog('remoteMessage?.threadId                          : ${remoteMessage
        ?.threadId}');
    blog('remoteMessage?.ttl                               : ${remoteMessage
        ?.ttl}');

    // Mapper.blogMap(remoteMessage?.data, invoker: invoker);

    blog('blogRemoteMessage : $invoker : END');
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogNootSettings({
    required NotificationSettings? settings,
    required String invoker,
  }) {
    blog('blogNootSettings : $invoker : START');

    if (settings == null) {
      blog('blogNootSettings : settings are null');
    }

    else {
      blog('alert               : ${settings.alert.index} : ${settings.alert
          .name}');
      blog('announcement        : ${settings.announcement.index} : ${settings
          .announcement.name}');
      blog('authorizationStatus : ${settings.authorizationStatus
          .index} : ${settings.authorizationStatus.name}');
      blog('badge               : ${settings.badge.index} : ${settings.badge
          .name}');
      blog('carPlay             : ${settings.carPlay.index} : ${settings.carPlay
          .name}');
      blog('lockScreen          : ${settings.lockScreen.index} : ${settings
          .lockScreen.name}');
      blog('notificationCenter  : ${settings.notificationCenter
          .index} : ${settings.notificationCenter.name}');
      blog('showPreviews        : ${settings.showPreviews.index} : ${settings
          .showPreviews.name}');
      blog('sound               : ${settings.sound.index} : ${settings.sound
          .name}');
      blog('timeSensitive       : ${settings.timeSensitive.index} : ${settings
          .timeSensitive.name}');
    }

    blog('blogNootSettings : $invoker : END');
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogNotificationResponse(NotificationResponse? res) {
    if (res == null) {
      blog('blogNotificationResponse : response is null');
    }
    else {
      blog('blogNotificationResponse : res.id : ${res.id}');
      blog('blogNotificationResponse : res.input : ${res.input}');
      blog('blogNotificationResponse : res.actionId : ${res.actionId}');
      blog('blogNotificationResponse : res.notificationResponseType : ${res
          .notificationResponseType}');
      blog('blogNotificationResponse : res.payload : ${res.payload}');
    }
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushLocalNoot({
    required String title,
    required String body,
    required String payloadString,
    File? largeIconFile,
    Progress? progress,
    bool progressBarIsLoading = false,
    bool canBeDismissedWithoutTapping = true,

    /// special fields in flutter local notification package
    String? subText,
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
  /// --- TAMAM : WORKS PERFECT
  static AndroidNotificationDetails _createLocalNootAndroidDetails({
    String? subText,
    AndroidBitmap<Object>? largeIcon,
    Progress? progress,
    bool showStopWatch = false,
    bool showTime = true,
    bool canBeDismissedWithoutTapping = true,
    bool progressBarIsLoading = false,
  }) {
    return AndroidNotificationDetails(

      /// CHANNEL
      ChannelModel.bldrsChannel.id, // channelId
      ChannelModel.bldrsChannel.name, // channelName
      channelDescription: ChannelModel.bldrsChannel.description,
      // channelAction: AndroidNotificationChannelAction.createIfNotExists, // default

      /// GROUP
      groupKey: ChannelModel.bldrsChannel.group,

      /// FAKES
      setAsGroupSummary: true,
      // groupAlertBehavior: GroupAlertBehavior.all, /// FAKES

      /// SUB TEXT
      subText: subText,

      /// ICON
      icon: fcmWhiteLogoFileName,
      color: Colorz.black255,
      // is icon color

      /// PICTURE
      largeIcon: largeIcon,
      // is the side picture

      /// SOUNDS
      // playSound: true, /// true by default - TASK : NOT WORKING
      // sound: const RawResourceAndroidNotificationSound(Standards.nicoleSaysBldrsDotNet), /// TASK : NOT WORKING

      /// LIGHTS
      enableLights: true,
      ledColor: Colorz.yellow255,
      // NOT TESTED
      ledOffMs: 2,
      // NOT IMPORTANT : NOT TESTED
      ledOnMs: 2,
      // NOT IMPORTANT : NOT TESTED

      /// VIBRATION
      // enableVibration: true, // default
      // vibrationPattern: _createLocalNootVibration(),
      ticker: 'what is the ticker text ?',

      /// PROGRESS
      showProgress: progress != null,
      progress: progress?.current ?? 0,
      maxProgress: progress?.objective ?? 0,
      indeterminate: progressBarIsLoading,

      /// BEHAVIOUR
      // autoCancel: true, /// is auto dismiss notification on tap ,, true be default
      onlyAlertOnce: true,

      /// auto stop sound-ticker-vibration on show
      visibility: NotificationVisibility.public,

      /// is lock screen notification visibility
      ongoing: !canBeDismissedWithoutTapping,

      /// TIMING
      usesChronometer: showStopWatch,
      showWhen: showTime,
      // when: , /// is notification time stamp,, and no need to modify its default
      // timeoutAfter: , /// is millisecond to wait to cancel notification if not yet cancelled ?? weird

      /// BADGE : NOT EFFECTIVE
      // channelShowBadge: true, // showAppBadge - true by default,
      // number: 69,

      /// NO EFFECT
      colorized: true,

      /// background color : has no effect on local notification
      fullScreenIntent: true,
      importance: Importance.max,
      priority: Priority.max,

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
  static DarwinNotificationDetails _createLocalNootIOSDetails() {
    // return null;
    return const DarwinNotificationDetails(
      // sound: ,
      // attachments: ,
      // badgeNumber: ,
      // presentAlert: ,
      // presentBadge: ,
      // presentSound: ,
      // subtitle: ,
      // threadIdentifier: ,
    );
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AndroidBitmap<Object>?> _getLocalNootLargeIcon(
      File? file) async {
    AndroidBitmap<Object>? _largeIcon;

    if (file != null) {
      final String? _base64 = await Floaters.getBase64FromFileOrURL(file);
      if (_base64 != null) {
        _largeIcon = ByteArrayAndroidBitmap.fromBase64String(_base64);
      }
    }


    return _largeIcon;
  }
// -----------------------------------------------------------------------------}
}
