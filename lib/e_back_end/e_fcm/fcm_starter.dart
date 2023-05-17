import 'package:bldrs/a_models/b_bz/sub/target/target_progress.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/background_msg_handler.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:devicer/devicer.dart';
import 'package:filers/filers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mapper/mapper.dart';

class FCMStarter {
  // -----------------------------------------------------------------------------

  const FCMStarter();

  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool canInitializeFCM(){
    if (kIsWeb == true || DeviceChecker.deviceIsWindows() == true){
      return false;
    }
    else {
      return DeviceChecker.deviceIsIOS() || DeviceChecker.deviceIsAndroid();
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> preInitializeNootsInMainFunction({
    @required ChannelModel channelModel,
  }) async {

      if (canInitializeFCM() == true) {

        /// INITIALIZE AWESOME NOTIFICATIONS
        await _initializeAwesomeNootsService(
          channel: channelModel,
        );

        /// HANDLE BACKGROUND REMOTE MESSAGE (handles while app in background)
        if (channelModel.id == ChannelModel.bldrsChannel.id){
          FirebaseMessaging.onBackgroundMessage(bldrsAppOnBackgroundMessageHandler);
        }
        if (channelModel.id == ChannelModel.bldrsDashboardChannel.id){
          FirebaseMessaging.onBackgroundMessage(bldrsDashboardOnBackgroundMessageHandler);
        }

      }

    }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initializeNootsInBldrsAppStarter({
    @required ChannelModel channelModel,
  }) async {

      if (canInitializeFCM() == true) {
        /// FCM PERMISSION
        await FCM.requestFCMPermission();

        /// INITIALIZE LOCAL NOOTS
        await _initializeLocalNootsService();

        /// INITIALIZE LISTENERS
        _initializeNootsListeners(
          channelModel: channelModel,
        );

        /// RECEIVE INITIAL MESSAGE
        await _receiveInitialRemoteMessage();
      }

    }
  // -----------------------------------------------------------------------------

  /// (AWESOME - LOCAL NOOTS) SERVICES INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _initializeAwesomeNootsService({
    @required ChannelModel channel,
  }) async {

    await FCM.getAwesomeNoots()?.initialize(

      /// NOOTS DEFAULT ICON
      FCM.fcmWhiteLogoFilePath,

      /// CHANNELS
      FCM.generateBldrsNootChannels(
        channel: channel,
      ),

      /// CHANNEL GROUPS
      channelGroups: FCM.getBldrsChannelGroups(
        channel: channel,
      ),

      /// DEBUG
      debug: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _initializeLocalNootsService() async {

    await FCM.getLocalNootsPlugin().initialize(

      /// INITIALIZATION SETTINGS
      InitializationSettings(
        android: const AndroidInitializationSettings(FCM.fcmWhiteLogoFileName),
        iOS: IOSInitializationSettings(
          // defaultPresentAlert: true,
          // defaultPresentBadge: ,
          // defaultPresentSound: ,
          onDidReceiveLocalNotification: (int integer, String a, String b, String c){
            blog('onDidReceiveLocalNotification : int $integer, String $a, String $b, String $c');
          },
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
  static void _initializeNootsListeners({
    @required ChannelModel channelModel,
  }){

      /// APP IS IN FOREGROUND ( FRONT AND ACTIVE )
      FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
        await pushGlobalNootFromRemoteMessage(
          channelModel: channelModel,
          remoteMessage: remoteMessage,
          invoker: 'initializeNoots.onMessage',
        );
      });

      /// ONCE APP STARTS AFTER NOOT TAP WHILE APP WAS IN BACKGROUND
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) async {

        blog('APP WAS IN BACKGROUND AND YOU HAVE JUST TAPPED THIS NOTIFICATION : -');

        FCM.blogRemoteMessage(
          remoteMessage: remoteMessage,
          invoker: '_initializeNootsListeners.onMessageOpenedApp',
        );

        final NoteModel _note = NoteModel.decipherRemoteMessage(
          map: remoteMessage?.data,
        );

        await CenterDialog.showCenterDialog(
          context: getMainContext(),
          titleVerse: Verse.plain('App was on background'),
          bodyVerse: Verse.plain('noteTitle is : ${_note.title}'),
          color: Colorz.green50,
          height: 400,
          confirmButtonVerse: Verse.plain('Tamam'),
        );

        // await _pushGlobalNootFromRemoteMessage(
        //   remoteMessage: remoteMessage,
        //   invoker: 'initializeNoots.onMessageOpenedApp',
        // );

        // /// to display the notification while app in foreground
        // await _pushLocalNootFromRemoteMessage(remoteMessage);
      });

      // /// when app running in background and notification tapped while having
      // /// msg['data']['click_action'] == 'FLUTTER_NOTIFICATION_CLICK';
      // FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);

    }
  // --------------------
  ///
  static Future<void> _receiveInitialRemoteMessage() async {

    final RemoteMessage initialRemoteMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialRemoteMessage != null) {

      FCM.blogRemoteMessage(
        remoteMessage: initialRemoteMessage,
        invoker: '_receiveInitialRemoteMessage',
      );

      blog('initializeNoots : can navigate here and shit');

    }

  }
  // -----------------------------------------------------------------------------

  /// PUSHING (REMOTE-MESSAGE) INTO (NOOTS)

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushGlobalNootFromRemoteMessage({
    @required ChannelModel channelModel,
    @required RemoteMessage remoteMessage,
    @required String invoker,
  }) async {

    if (remoteMessage != null){

      // final String body = remoteMessage?.notification?.body;
      // final String title = remoteMessage?.notification?.title;
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

      final NoteModel _note = NoteModel.decipherRemoteMessage(
        map: remoteMessage?.data,
      );

      // _note.blogNoteModel(
      //   invoker: '_pushGlobalNootFromRemoteMessage.$invoker',
      // );

      if (_note != null){

        // blog('should send a fucking noot title ${_note.title} : body ${_note.body}');

        await Future.wait(<Future>[

          FCM.pushGlobalNoot(
            channelModel: channelModel,
            title: _note.title,
            body: _note.body,
            largeIconURL: _note.parties.senderImageURL,
            posterURL: _note.poster.path,
            progress: Progress.generateModelFromNoteProgress(_note),
            progressBarIsLoading: _note.progress == -1,
            canBeDismissedWithoutTapping: _note.dismissible,

            /// FAKES BUTTONS IN NOOT
            // buttonsTexts: null, // _note.poll.buttons,

            payloadMap: Mapper.createStringStringMap(
              hashMap: remoteMessage?.data,
              stringifyNonStrings: false,
            ),
          ),

        ]);

      }

      else {
        blog('_pushGlobalNootFromRemoteMessage : remoteMessage.data is null');
      }

    }

  }
  // -----------------------------------------------------------------------------
}
