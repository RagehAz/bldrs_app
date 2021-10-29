import 'package:bldrs/controllers/notifications/local_notification_service.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/secondary_models/error_helpers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/notifications/audioz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotiOps{
// -----------------------------------------------------------------------------
//   static String _ahmedURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/slidesPics%2FXmwKpOsu1RZW3YfDAkli_00.jpg?alt=media&token=a4c8a548-74d2-4086-b3db-1678f46db00a';

  static const String _redBldrsBanner = 'resource://drawable/res_red_bldrs';
  static const String _flatBldrsNotiIcon = 'resource://drawable/res_flat_logo';

  // -----------------------------------------------------------------------------
  /// THIS GOES BEFORE RUNNING THE BLDRS APP
  static Future<void> preInitializeNoti() async {

    FirebaseMessaging.onBackgroundMessage(fcmPushHandler);

    final AwesomeNotifications _awesomeNotification = AwesomeNotifications();

    _awesomeNotification.initialize(
      _flatBldrsNotiIcon,
      <NotificationChannel>[
        basicNotificationChannel(),
        scheduledNotificationChannel(),
      ],
    );


  }
// -----------------------------------------------------------------------------
  /// THIS GOES IN MAIN WIDGET INIT
  static Future<void> initializeNoti() async  {

    final RemoteMessage initialRemoteMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialRemoteMessage != null){

      printRemoteMessage(
        methodName: 'initializeNoti',
        remoteMessage: initialRemoteMessage,
      );

      // can navigate here and shit

    }


    final _fbm = FirebaseMessaging.instance;

    _fbm.requestPermission(
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
    FirebaseMessaging.onMessageOpenedApp.listen((event) {

      printRemoteMessage(
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
    _fbm.subscribeToTopic('flyers');


}
// -----------------------------------------------------------------------------
  static Future<NotiModel> receiveAndActUponNoti({BuildContext context, dynamic msgMap, NotiType notiType}) async {
    print('receiveAndActUponNoti : notiType : $notiType');

    NotiModel _noti;

    await tryAndCatch(
      context: context,
      onError: (error) => print(error),
      methodName: 'receiveAndActUponNoti',
      functions: (){
        _noti = NotiModel.decipherNotiModel(
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
  static Future<void> fcmPushHandler(RemoteMessage message) async {

    print('Handling a background message ${message.messageId}');

    printRemoteMessage(
      methodName: 'fcmPushHandler',
      remoteMessage: message,
    );

    final bool _thing = await AwesomeNotifications().createNotificationFromJsonData(message.data);

    print ('thing is : $_thing');

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
  static String getNotiChannelName(NotiChannel channel){
    switch (channel){
      case NotiChannel.basic: return 'Basic Notifications'; break;
      case NotiChannel.scheduled: return 'Scheduled Notifications'; break;
      default: return 'Basic Notifications';
    }
  }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  static Future<void> createWelcomeNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Numeric.createUniqueID(),
        channelKey: getNotiChannelName(NotiChannel.basic),
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
  static Future<void> createScheduledNotification() async {

    await AwesomeNotifications().createNotification(

      content: NotificationContent(
        id: Numeric.createUniqueID(),
        channelKey: getNotiChannelName(NotiChannel.scheduled),
        title: '${Emojis.hotel_bellhop_bell} Alert from Bldrs.net',
        body: 'You need to open the app now, not tomorrow, not after tomorrow, NOW !, Do I make my self clear ? or you want me to repeat What I have just wrote,, read again !',
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
  static Future<void> cancelScheduledNotification() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
// -----------------------------------------------------------------------------
  static NotificationChannel basicNotificationChannel(){
    return
      NotificationChannel(
        channelKey: getNotiChannelName(NotiChannel.basic),
        channelName: getNotiChannelName(NotiChannel.basic),
        channelDescription: 'this is for testing', // this will be visible to user in android notification settings
        defaultColor: Colorz.yellow255,
        channelShowBadge: true,
        icon: _flatBldrsNotiIcon,
        ledColor: Colorz.yellow255,
        importance: NotificationImportance.High,
        locked: true,
        playSound: true,
        soundSource: 'resource://raw/res_hi',//Audioz.randomBldrsNameSoundPath(),
        enableLights: true,
        enableVibration: true,

      );
  }
// -----------------------------------------------------------------------------
  static NotificationChannel scheduledNotificationChannel(){
    return
      NotificationChannel(
        channelKey: getNotiChannelName(NotiChannel.scheduled),
        channelName: getNotiChannelName(NotiChannel.scheduled),
        channelDescription: 'This is the first scheduled notification', // this will be visible to user in android notification settings
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
  static Future<void> onNotifyButtonTap(BuildContext context, Widget screenToGoToOnNotiTap) async {
    await notify();

    AwesomeNotifications().actionStream.listen((receivedNoti) {

      Nav.pushAndRemoveUntil(
          context: context,
          screen: screenToGoToOnNotiTap,
      );

    });

  }
// -----------------------------------------------------------------------------
  static Future<void> notify () async {

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
  static printRemoteMessage({String methodName, RemoteMessage remoteMessage}){

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

    print('PRINTING REMOTE MESSAGE ATTRIBUTES ------------- START -');

    print('1 - METHOD NAMED : $methodName');
    print('2 - remoteNotification : $remoteNotification');
    print('3 - category : $category');
    print('4 - collapseKey : $collapseKey');
    print('5 - contentAvailable : $contentAvailable');
    print('6 - from : $from');
    print('7 - messageId : $messageId');
    print('8 - messageType : $messageType');
    print('9 - mutableContent : $mutableContent');
    print('10 - senderId : $senderId');
    print('11 - sentTime : $sentTime');
    print('12 - threadId : $threadId');
    print('13 - ttl : $ttl');
    print('14 - data : $data');

    print('PRINTING REMOTE MESSAGE ATTRIBUTES ------------- END -');

  }
// -----------------------------------------------------------------------------
}

Widget notiStreamBuilder({
  BuildContext context,
  notiModelsWidgetsBuilder builder,
  String userID,
}){

  return

    StreamBuilder<List<NotiModel>>(
      key: const ValueKey<String>('notifications_stream_builder'),
      stream: getNotiModelsStream(context, userID),
      initialData: [],
      builder: (ctx, snapshot){
        if(StreamChecker.connectionIsLoading(snapshot) == true){

          print('the shit is looooooooooooooooooooooooading');

          return LoadingFullScreenLayer();
        } else {

          final List<NotiModel> notiModels = snapshot.data;

          print('the shit is getting reaaaaaaaaaaaaaaaaaaaaaaal');

          return
            builder(ctx, notiModels);
        }
        },
    );

}
// -----------------------------------------------------------------------------
/// get NotiModels stream
Stream<List<NotiModel>> getNotiModelsStream(BuildContext context, String userID) {

  Stream<List<NotiModel>> _notiModelsStream;

  tryAndCatch(
    context: context,
    methodName: 'getNotiModelsStream',
    functions: (){

      final Stream<QuerySnapshot<Object>> _querySnapshots = Fire.streamSubCollection(
        collName: FireColl.users,
        docName: userID,
        subCollName: FireSubColl.users_user_notifications,
        orderBy: 'timeStamp', // NEVER CHANGE THIS -> OR CREATE NEW FIREBASE QUERY INDEX
        descending: true,
        field: 'dismissed', // NEVER CHANGE THIS -> OR CREATE NEW FIREBASE QUERY INDEX
        compareValue: false,
      );

      print('getNotiModelsStream : _querySnapshots : ${_querySnapshots}');

      _notiModelsStream = _querySnapshots.map(
              (qShot) => qShot.docs.map((doc) =>
                  NotiModel.decipherNotiModel(
                    map: doc,
                    fromJSON: false,
                  )
          ).toList()
      );

      print('getNotiModelsStream : _notiModelsStream : ${_notiModelsStream}');

    }
  );

  return _notiModelsStream;
}
// -----------------------------------------------------------------------------

typedef notiModelsWidgetsBuilder = Widget Function(
    BuildContext context,
    List<NotiModel> notiModels,
    );
// -----------------------------------------------------------------------------
