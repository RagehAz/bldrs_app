import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm_starter.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// TESTED : WORKS PERFECT
@pragma('vm:entry-point')
Future<void> onBackgroundMessageHandler(RemoteMessage remoteMessage) async {

  /*
    There are a few things to keep in mind about your background message handler:

    - It must not be an anonymous function.

    - It must be a top-level function
    (e.g. not a class method which requires initialization).

    - It must be annotated with @pragma('vm:entry-point')
     right above the function declaration
     (otherwise it may be removed during tree shaking for release mode).

   */

  await Firebase.initializeApp();

  FCM.blogRemoteMessage(
    remoteMessage: remoteMessage,
    invoker: 'onBackgroundMessageHandler',
  );

  await FCMStarter.pushGlobalNootFromRemoteMessage(
      remoteMessage: remoteMessage,
      invoker: '_onBackgroundMessageHandler'
  );

}
