import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notiPlugin = FlutterLocalNotificationsPlugin();

  static String _flatBldrsNotiIcon = 'resource://drawable/res_flat_logo'; // "@mipmap/ic_launcher"

  static Future<void> initialize() async {

    final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings(_flatBldrsNotiIcon),
    );

    await _notiPlugin.initialize(initializationSettings);

  }

  static Future<void> display(RemoteMessage remoteMessage) async {
    final int _id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final String _title = remoteMessage.notification.title;
    final String _body = remoteMessage.notification.body;
    final NotificationDetails _notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'bldrs',
        'bldrs channel',
        'bldrs network',
        importance: Importance.max,
        priority: Priority.high,

      ),
    );

    await _notiPlugin.show(_id, _title, _body, _notificationDetails);
  }

}