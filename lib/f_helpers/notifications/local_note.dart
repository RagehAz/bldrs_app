import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/notes_test/awesome_noti_test_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNote {

  LocalNote();

// -----------------------------------------------------------------------------
  static const String _flatBldrsNotiIcon = 'res_flat_logo'; //'resource://drawable/res_flat_logo'; // "@mipmap/ic_launcher"
// -----------------------------------------------------------------------------
  static Future<void> initialize(BuildContext context) async {

    final FlutterLocalNotificationsPlugin _notiPlugin = FlutterLocalNotificationsPlugin();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings(_flatBldrsNotiIcon),
    );

    await _notiPlugin.initialize(initializationSettings,
        onSelectNotification: (String route) async {

          if (route != null) {

            blog('initializing localNotificationService : route is : $route');

            await Nav.goToNewScreen(
              context: context,
              screen: const AwesomeNotiTestScreen(),
            );

          }

        }

    );
  }
// -----------------------------------------------------------------------------
  static Future<void> display(RemoteMessage remoteMessage) async {

    final FlutterLocalNotificationsPlugin _notiPlugin = FlutterLocalNotificationsPlugin();

    try {
      final int _id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final String _title = remoteMessage.notification.title;
      final String _body = remoteMessage.notification.body;
      const NotificationDetails _notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'bldrs',
          'bldrs channel',
          // 'bldrs network',
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notiPlugin.show(
        _id,
        _title,
        _body,
        _notificationDetails,
        payload: remoteMessage.data['route'],
      );
    } on Exception catch (e) {
      blog('display : notification error caught : $e');
    }

  }
// -----------------------------------------------------------------------------
}