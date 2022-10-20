// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:bldrs/a_models/a_user/auth_model.dart';
// import 'package:bldrs/a_models/b_bz/target/target_progress.dart';
// import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
// import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
// import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
// import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
// import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
// import 'package:bldrs/f_helpers/drafters/floaters.dart';
// import 'package:bldrs/f_helpers/drafters/mappers.dart';
// import 'package:bldrs/f_helpers/drafters/numeric.dart';
// import 'package:bldrs/f_helpers/drafters/sounder.dart';
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class OLDLocalNootsMethods {
//
//   const OLDLocalNootsMethods();
//
//   // --------------------
//   /// DEPRECATED
//   /*
//   static Future<void> _pushLocalNootFromRemoteMessage(RemoteMessage remoteMessage) async {
//
//     final String _title = remoteMessage.notification.title;
//     final String _body = remoteMessage.notification.body;
//
//     // OLD_TASK : MAKE SURE THIS FIELD NAME ('route) IS CORRECT
//     final String _payload = remoteMessage.data['route'];
//
//     await FCM.pushLocalNoot(
//       title: _title,
//       body: _body,
//       payloadString: _payload,
//       // progressBarIsLoading: ,
//       // canBeDismissedWithoutTapping: ,
//       // progress: ,
//       // channel: ,
//       // showTime: ,
//       // showStopWatch: ,
//       // subText: ,
//       // largeIconFile: ,
//     );
//
//   }
//   */
//   // --------------------
//   /*
//   /// TESTED : WORKS PERFECT
//   static Future<void> pushLocalNoot({
//     @required String title,
//     @required String body,
//     @required String payloadString,
//     File largeIconFile,
//     Progress progress,
//     bool progressBarIsLoading = false,
//     bool canBeDismissedWithoutTapping = true,
//     /// special fields in flutter local notification package
//     String subText,
//     bool showStopWatch = false,
//     bool showTime = true,
//   }) async {
//
//     await FCM.getLocalNootsPlugin().show(
//       /// ID
//       Numeric.createUniqueID(maxDigitsCount: 8),
//       /// TITLE
//       title,
//       /// BODY
//       body,
//       /// DETAILS
//       NotificationDetails(
//         android: _createLocalNootAndroidDetails(
//           largeIcon: await _getLocalNootLargeIcon(largeIconFile),
//           subText: subText,
//           progress: progress,
//           canBeDismissedWithoutTapping: canBeDismissedWithoutTapping,
//           progressBarIsLoading: progressBarIsLoading,
//           showStopWatch: showStopWatch,
//           showTime: showTime,
//         ),
//         iOS: _createLocalNootIOSDetails(),
//         // macOS: ,
//         // linux: ,
//       ),
//       /// PAYLOAD : data to be passed through
//       payload: payloadString,
//     );
//
//   }
//    */
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<AndroidBitmap> _getLocalNootLargeIcon(File file) async {
//     AndroidBitmap _largeIcon;
//
//     if (file != null){
//
//       final String _base64 = await Floaters.getBase64FromFileOrURL(file);
//       _largeIcon = ByteArrayAndroidBitmap.fromBase64String(_base64);
//
//     }
//
//     return _largeIcon;
//   }
//
//   // --------------------
//   /// --- TAMAM : WORKS PERFECT
//   static AndroidNotificationDetails _createLocalNootAndroidDetails({
//     String subText,
//     AndroidBitmap<Object> largeIcon,
//     Progress progress,
//     bool showStopWatch = false,
//     bool showTime = true,
//     bool canBeDismissedWithoutTapping = true,
//     bool progressBarIsLoading = false,
//   }){
//
//     return AndroidNotificationDetails(
//       /// CHANNEL
//       ChannelModel.bldrsChannel.id, // channelId
//       ChannelModel.bldrsChannel.name, // channelName
//       channelDescription: ChannelModel.bldrsChannel.description,
//       // channelAction: AndroidNotificationChannelAction.createIfNotExists, // default
//
//       /// GROUP
//       groupKey: ChannelModel.bldrsChannel.group, /// FAKES
//       setAsGroupSummary: true,
//       // groupAlertBehavior: GroupAlertBehavior.all, /// FAKES
//
//       /// SUB TEXT
//       subText: subText,
//
//       /// ICON
//       icon: FCM.fcmWhiteLogoFileName,
//       color: Colorz.black255, // is icon color
//
//       /// PICTURE
//       largeIcon: largeIcon, // is the side picture
//
//       /// SOUNDS
//       // playSound: true, /// true by default - TASK : NOT WORKING
//       sound: const RawResourceAndroidNotificationSound(Sounder.nicoleSaysBldrsDotNet), /// TASK : NOT WORKING
//
//       /// LIGHTS
//       enableLights: true,
//       ledColor: Colorz.yellow255, // NOT TESTED
//       ledOffMs: 2, // NOT IMPORTANT : NOT TESTED
//       ledOnMs: 2, // NOT IMPORTANT : NOT TESTED
//
//       /// VIBRATION
//       // enableVibration: true, // default
//       vibrationPattern: FCM.createLocalNootVibration(),
//       ticker: 'what is the ticker text ?',
//
//       /// PROGRESS
//       showProgress: progress != null,
//       progress: progress?.current ?? 0,
//       maxProgress: progress?.objective ?? 0,
//       indeterminate: progressBarIsLoading,
//
//       /// BEHAVIOUR
//       // autoCancel: true, /// is auto dismiss notification on tap ,, true be default
//       onlyAlertOnce: true, /// auto stop sound-ticker-vibration on show
//       visibility: NotificationVisibility.public, /// is lock screen notification visibility
//       ongoing: !canBeDismissedWithoutTapping,
//
//       /// TIMING
//       usesChronometer: showStopWatch,
//       showWhen: showTime,
//       // when: , /// is notification time stamp,, and no need to modify its default
//       // timeoutAfter: , /// is millisecond to wait to cancel notification if not yet cancelled ?? weird
//
//       /// BADGE : NOT EFFECTIVE
//       // channelShowBadge: true, // showAppBadge - true by default,
//       // number: 69,
//
//       /// NO EFFECT
//       colorized: true, /// background color : has no effect on local notification
//       fullScreenIntent: true,
//       importance: Importance.max,
//       priority: Priority.max,
//
//       /// FAKES
//       // shortcutId: ,
//       // styleInformation: StyleInformation,
//       // additionalFlags: ,
//       // category: ,
//       // tag: 'fakes',
//
//     );
//
//   }
//   // --------------------
//   /// TASK : TEST THIS ON IOS
//   static IOSNotificationDetails _createLocalNootIOSDetails(){
//     return null;
//     // return IOSNotificationDetails(
//     //   sound: ,
//     //   attachments: ,
//     //   badgeNumber: ,
//     //   presentAlert: ,
//     //   presentBadge: ,
//     //   presentSound: ,
//     //   subtitle: ,
//     //   threadIdentifier: ,
//     // );
//   }
//
// }
