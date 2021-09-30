import 'package:bldrs/controllers/notifications/test_screens/awesome_noti_test_screen.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notiPlugin = FlutterLocalNotificationsPlugin();

  static const String _flatBldrsNotiIcon = 'resource://drawable/res_flat_logo'; // "@mipmap/ic_launcher"

  static Future<void> initialize(BuildContext context) async {

    final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings(_flatBldrsNotiIcon),
    );

    await _notiPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String route) async {

        if (route != null){

          print('initializing localNotificationService : route is : $route');

          Nav.goToNewScreen(context, AwesomeNotiTestScreen());
        }

      }

    );

  }

  static Future<void> display(RemoteMessage remoteMessage) async {

    try {

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

      await _notiPlugin.show(
        _id,
        _title,
        _body,
        _notificationDetails,
        payload: remoteMessage.data["route"],
      );

    } on Exception catch (e){
      print ('display : notification error caught : $e');
    }

  }

}