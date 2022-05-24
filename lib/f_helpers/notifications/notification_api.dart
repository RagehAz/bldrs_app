import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart' as StreamChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/notifications/audioz.dart' as Audioz;
import 'package:bldrs/f_helpers/notifications/local_notification_service.dart' as LocalNotificationService;
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
//   String _ahmedURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/slidesPics%2FXmwKpOsu1RZW3YfDAkli_00.jpg?alt=media&token=a4c8a548-74d2-4086-b3db-1678f46db00a';

const String _redBldrsBanner = 'resource://drawable/res_red_bldrs';
const String _flatBldrsNotiIcon = 'resource://drawable/res_flat_logo';

// -----------------------------------------------------------------------------
/// THIS GOES BEFORE RUNNING THE BLDRS APP
Future<void> preInitializeNoti() async {
  FirebaseMessaging.onBackgroundMessage(fcmPushHandler);

  final AwesomeNotifications _awesomeNotification = AwesomeNotifications();

  await _awesomeNotification.initialize(
    _flatBldrsNotiIcon,
    <NotificationChannel>[
      basicNotificationChannel(),
      scheduledNotificationChannel(),
    ],
  );
}
// -----------------------------------------------------------------------------
/// THIS GOES IN MAIN WIDGET INIT
Future<void> initializeNoti() async {
  final RemoteMessage initialRemoteMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (initialRemoteMessage != null) {
    blogRemoteMessage(
      methodName: 'initializeNoti',
      remoteMessage: initialRemoteMessage,
    );

    // can navigate here and shit

  }

  final FirebaseMessaging _fbm = FirebaseMessaging.instance;

  await _fbm.requestPermission(
    criticalAlert: true,
    carPlay: true,
    announcement: true,
    sound: true,
    provisional: true,
    badge: true,
    alert: true,
  );

  /// when app running in foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
    final Map<String, dynamic> _msgMap = remoteMessage.data;

    receiveAndActUponNoti(msgMap: _msgMap, notiType: NotiType.onMessage);
  });

  /// when launching the app
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
    blogRemoteMessage(
      methodName: 'initializeNoti',
      remoteMessage: event,
    );

    final Map<String, dynamic> _msgMap = event.data;
    receiveAndActUponNoti(msgMap: _msgMap, notiType: NotiType.onLaunch);

    /// to display the notification while app in foreground
    LocalNotificationService.display(event);
  });

  /// when app running in background and notification tapped while having
  /// msg['data']['click_action'] == 'FLUTTER_NOTIFICATION_CLICK';
  FirebaseMessaging.onBackgroundMessage(fcmPushHandler);

  // fbm.getToken();
  await _fbm.subscribeToTopic('flyers');
}
// -----------------------------------------------------------------------------
Future<NoteModel> receiveAndActUponNoti({
  BuildContext context,
  dynamic msgMap,
  NotiType notiType,
}) async {
  blog('receiveAndActUponNoti : notiType : $notiType');

  NoteModel _noti;

  await tryAndCatch(
    context: context,
    onError: (String error) => blog(error),
    methodName: 'receiveAndActUponNoti',
    functions: () {
      _noti = NoteModel.decipherNoteModel(
        map: msgMap,
        fromJSON: false,
      );
    },
  );

  return _noti;
}
// -----------------------------------------------------------------------------
/// fcm on background
//  AndroidNotificationChannel channel;
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> fcmPushHandler(RemoteMessage message) async {
  blog('Handling a background message ${message.messageId}');

  blogRemoteMessage(
    methodName: 'fcmPushHandler',
    remoteMessage: message,
  );

  final bool _thing = await AwesomeNotifications().createNotificationFromJsonData(message.data);

  blog('thing is : $_thing');

  // if (!kIsWeb) {
  //   channel = const AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     'This channel is used for important notifications.', // description
  //     importance: Importance.high,
  //   );
  //
  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //
  //   /// Create an Android Notification Channel.
  //   ///
  //   /// We use this channel in the `AndroidManifest.xml` file to override the
  //   /// default FCM channel to enable heads up notifications.
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //       AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel);

  // /// Update the iOS foreground notification presentation options to allow
  // /// heads up notifications.
  // await FirebaseMessaging.instance
  //     .setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  // }
}
// -----------------------------------------------------------------------------
String getNotiChannelName(NoteChannel channel) {
  switch (channel) {
    case NoteChannel.basic: return 'Basic Notifications';break;
    case NoteChannel.scheduled: return 'Scheduled Notifications';break;
    default: return 'Basic Notifications';
  }
}
// -----------------------------------------------------------------------------
Future<void> createWelcomeNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: Numeric.createUniqueID(),
      channelKey: getNotiChannelName(NoteChannel.basic),
      title: '${Emojis.shape_red_triangle_pointed_up} Welcome to Bldrs.net',
      body: 'Browse Thousands of flyers and pick your choices',
      bigPicture: _redBldrsBanner,
      notificationLayout: NotificationLayout.BigPicture,
      color: Colorz.yellow255,
      backgroundColor: Colorz.bloodTest,
    ),
  );
}
// -----------------------------------------------------------------------------
Future<void> createScheduledNotification() async {

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: Numeric.createUniqueID(),
      channelKey: getNotiChannelName(NoteChannel.scheduled),
      title: '${Emojis.hotel_bellhop_bell} Alert from Bldrs.net',
      body:
          'You need to open the app now, not tomorrow, not after tomorrow, NOW !, Do I make my self clear ? or you want me to repeat What I have just wrote,, read again !',
      bigPicture: _redBldrsBanner,
      notificationLayout: NotificationLayout.BigPicture,
      color: Colorz.yellow255,
      backgroundColor: Colorz.skyDarkBlue,
    ),

    actionButtons: <NotificationActionButton>[
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
        icon: _flatBldrsNotiIcon,
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
Future<void> cancelScheduledNotification() async {
  await AwesomeNotifications().cancelAllSchedules();
}
// -----------------------------------------------------------------------------
NotificationChannel basicNotificationChannel() {
  return NotificationChannel(
    channelKey: getNotiChannelName(NoteChannel.basic),
    channelName: getNotiChannelName(NoteChannel.basic),
    channelDescription:
        'this is for testing', // this will be visible to user in android notification settings
    defaultColor: Colorz.yellow255,
    channelShowBadge: true,
    icon: _flatBldrsNotiIcon,
    ledColor: Colorz.yellow255,
    importance: NotificationImportance.High,
    locked: true,
    playSound: true,
    soundSource: 'resource://raw/res_hi', //Audioz.randomBldrsNameSoundPath(),
    enableLights: true,
    enableVibration: true,
  );
}
// -----------------------------------------------------------------------------
NotificationChannel scheduledNotificationChannel() {
  return NotificationChannel(
    channelKey: getNotiChannelName(NoteChannel.scheduled),
    channelName: getNotiChannelName(NoteChannel.scheduled),
    channelDescription:
        'This is the first scheduled notification', // this will be visible to user in android notification settings
    defaultColor: Colorz.yellow255,
    channelShowBadge: true,
    enableLights: true,
    icon: _flatBldrsNotiIcon,
    ledColor: Colorz.yellow255,
    importance: NotificationImportance.High,
    enableVibration: true,
    playSound: true,
    locked: true,
    soundSource: Audioz.randomBldrsNameSoundPath(),
  );
}
// -----------------------------------------------------------------------------
Future<void> onNotifyButtonTap(BuildContext context, Widget screenToGoToOnNotiTap) async {

  await notify();

  AwesomeNotifications().actionStream.listen((ReceivedAction receivedNoti) {
    Nav.pushAndRemoveUntil(
      context: context,
      screen: screenToGoToOnNotiTap,
    );
  });

}
// -----------------------------------------------------------------------------
Future<void> notify() async {
  // String _timeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'onNotifyTap',
      title: 'Local Notify by tap',
      body: 'this was sent by tapping a button',
      bigPicture: _redBldrsBanner,
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}
// -----------------------------------------------------------------------------
void blogRemoteMessage({
  String methodName,
  RemoteMessage remoteMessage
}) {

  final RemoteNotification remoteNotification = remoteMessage.notification;
  final String category = remoteMessage.category;
  final String collapseKey = remoteMessage.collapseKey;
  final bool contentAvailable = remoteMessage.contentAvailable;
  final String from = remoteMessage.from;
  final String messageId = remoteMessage.messageId;
  final String messageType = remoteMessage.messageType;
  final bool mutableContent = remoteMessage.mutableContent;
  final String senderId = remoteMessage.senderId;
  final DateTime sentTime = remoteMessage.sentTime;
  final String threadId = remoteMessage.threadId;
  final int ttl = remoteMessage.ttl;
  final Map<String, dynamic> data = remoteMessage.data;

  blog('blogING REMOTE MESSAGE ATTRIBUTES ------------- START -');

  blog('1 - METHOD NAMED : $methodName');
  blog('2 - remoteNotification : $remoteNotification');
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

  blog('blogING REMOTE MESSAGE ATTRIBUTES ------------- END -');
}
// -----------------------------------------------------------------------------
Widget notiStreamBuilder({
  BuildContext context,
  NotiModelsWidgetsBuilder builder,
  String userID,
}) {
  return StreamBuilder<List<NoteModel>>(
    key: const ValueKey<String>('notifications_stream_builder'),
    stream: getNotiModelsStream(context, userID),
    initialData: const <NoteModel>[],
    builder: (BuildContext ctx, AsyncSnapshot<List<NoteModel>> snapshot) {

      if (StreamChecker.connectionIsLoading(snapshot) == true) {
        blog('the shit is looooooooooooooooooooooooading');
        return const LoadingFullScreenLayer();
      }

      else {
        final List<NoteModel> notiModels = snapshot.data;
        blog('the shit is getting reaaaaaaaaaaaaaaaaaaaaaaal');
        return builder(ctx, notiModels);
      }

    },
  );
}
// -----------------------------------------------------------------------------
/// get NotiModels stream
Stream<List<NoteModel>> getNotiModelsStream(BuildContext context, String userID) {
  Stream<List<NoteModel>> _notiModelsStream;

  tryAndCatch(
      context: context,
      methodName: 'getNotiModelsStream',
      functions: () {
        final Stream<QuerySnapshot<Object>> _querySnapshots =
            Fire.streamSubCollection(
          collName: FireColl.users,
          docName: userID,
          subCollName: FireSubColl.users_user_notifications,
          orderBy: 'timeStamp', // NEVER CHANGE THIS -> OR CREATE NEW FIREBASE QUERY INDEX
          descending: true,
          field: 'dismissed', // NEVER CHANGE THIS -> OR CREATE NEW FIREBASE QUERY INDEX
          compareValue: false,
        );

        blog('getNotiModelsStream : _querySnapshots : $_querySnapshots');

        _notiModelsStream = _querySnapshots.map((QuerySnapshot<Object> qShot) =>
            qShot.docs
                .map((QueryDocumentSnapshot<Object> doc) =>
                    NoteModel.decipherNoteModel(
                      map: doc,
                      fromJSON: false,
                    ))
                .toList());

        blog('getNotiModelsStream : _notiModelsStream : $_notiModelsStream');
      });

  return _notiModelsStream;
}
// -----------------------------------------------------------------------------
typedef NotiModelsWidgetsBuilder = Widget Function(
  BuildContext context,
  List<NoteModel> notiModels,
);
// -----------------------------------------------------------------------------
