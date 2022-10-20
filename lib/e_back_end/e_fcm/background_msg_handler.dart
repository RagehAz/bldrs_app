// import 'package:bldrs/a_models/b_bz/target/target_progress.dart';
// import 'package:bldrs/a_models/e_notes/a_note_model.dart';
// import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// ///
// Future<void> _onBackgroundMessageHandlerRaw(RemoteMessage remoteMessage) async {
//   await Firebase.initializeApp();
//
//   if (remoteMessage != null){
//
//     // ------------------------------
//
//     /// REMOTE MESSAGE BREAKDOWN
//
//     // ----------
//     /*
//     final String body = remoteMessage?.notification?.body;
//     final String title = remoteMessage?.notification?.title;
//     final AndroidNotification android = remoteMessage?.notification?.android;
//     final AppleNotification apple = remoteMessage?.notification?.apple;
//     final String analyticsLabel = remoteMessage?.notification?.web?.analyticsLabel;
//     final String image = remoteMessage?.notification?.web?.image;
//     final String link = remoteMessage?.notification?.web?.link;
//     final String bodyLocKey = remoteMessage?.notification?.bodyLocKey;
//     final List<String> bodyLocArgs = remoteMessage?.notification?.bodyLocArgs;
//     final String titleLocKey = remoteMessage?.notification?.titleLocKey;
//     final List<String> titleLocArgs = remoteMessage?.notification?.titleLocArgs;
//     final String category = remoteMessage?.category;
//     final String collapseKey = remoteMessage?.collapseKey;
//     final bool contentAvailable = remoteMessage?.contentAvailable;
//     final String from = remoteMessage?.from;
//     final String messageId = remoteMessage?.messageId;
//     final String messageType = remoteMessage?.messageType;
//     final bool mutableContent = remoteMessage?.mutableContent;
//     final String senderId = remoteMessage?.senderId;
//     final DateTime sentTime = remoteMessage?.sentTime;
//     final String threadId = remoteMessage?.threadId;
//     final int ttl = remoteMessage?.ttl;
//     final Map<String, dynamic> data = remoteMessage?.data;
//      */
//     // ------------------------------
//
//     /// NOTE CREATION
//
//     // ----------
//     NoteModel _note;
//
//     if (remoteMessage?.data != null){
//
//       String get(String field){
//         return Stringer.nullifyNullString(map[field]);
//       }
//
//       bool getBool(String field){
//         return map[field] == 'true' ? true : false;
//       }
//
//       _note = NoteModel(
//         token: get('token'),
//         id: get('id'),
//         parties: NoteParties(
//           senderID: get('senderID'),
//           senderImageURL: get('senderImageURL'),
//           senderType: NoteParties.decipherPartyType(get('senderType')),
//           receiverID: get('receiverID'),
//           receiverType: NoteParties.decipherPartyType(get('receiverType')),
//         ),
//         title:
//         get('title'),
//         body: get('body'),
//         sentTime: Timers.decipherTime(time: get('sentTime'), fromJSON: true),
//         poster: PosterModel(
//           modelID: get('posterModelID'),
//           type: PosterModel.decipherPosterType(get('posterType')),
//           url: get('posterURL'),
//         ),
//         poll: PollModel(
//             buttons: PollModel.decipherButtons(get('buttons')),
//             reply: get('reply'),
//             replyTime: Timers.decipherTime(time: get('replyTime'), fromJSON: true,)
//         ),
//         sendFCM: getBool('sendFCM'),
//         sendNote: getBool('sendNote'),
//         topic: get('topic'),
//         trigger: TriggerModel(
//           name: get('triggerName'),
//           argument: get('triggerArgument'),
//           done: getBool('triggerDone'),
//         ),
//         seen: getBool('seen'),
//         progress: Numeric.transformStringToInt(get('progress')),
//         dismissible: getBool('dismissible'),
//
//       );
//
//     }
//
//     // _note.blogNoteModel(
//     //   invoker: '_pushGlobalNootFromRemoteMessage.$invoker',
//     // );
//
//     if (_note != null){
//
//       blog('should send a fucking noot title ${_note.title} : body ${_note.body}');
//
//       await Future.wait(<Future>[
//
//         FCM.incrementGlobalBadge(),
//
//         FCM.pushGlobalNoot(
//           title: _note.title,
//           body: _note.body,
//           largeIconURL: _note.parties.senderImageURL,
//           posterURL: _note.poster.url,
//           progress: Progress.generateModelFromNoteProgress(_note),
//           progressBarIsLoading: _note.progress == -1,
//           canBeDismissedWithoutTapping: _note.dismissible,
//
//           /// FAKES BUTTONS IN NOOT
//           // buttonsTexts: null, // _note.poll.buttons,
//
//           // payloadMap: ,
//         ),
//
//       ]);
//
//     }
//
//     else {
//       blog('_pushGlobalNootFromRemoteMessage : remoteMessage.data is null');
//     }
//
//   }
//
// }
// // --------------------
