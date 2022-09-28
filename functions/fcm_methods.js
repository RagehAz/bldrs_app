// --------------------------------------------------------------------------

//  NOTES

// -------------------------------------
// const dummyRealTimeOnCreateMethod = functions.database
//     .ref('/collName/{docID}')
//     .onWrite(async (event, context) => {
//        const docMap = event.after.val();
//       return stuff;
//     });
// -------------------------------------
// const dummyFireOnCreateMethod = functions.firestore
//     .document('/collName/{docID}')
//     .onWrite((snapshot, context) => {
//        const docMap = change.data();
//       return stuff;
//     });
// --------------------------------------------------------------------------

//  IMPORTS

// -------------------------------------
const functions = require('firebase-functions');
const admin = require('firebase-admin');
// --------------------------------------------------------------------------

//  INITIALIZATION

// -------------------------------------
admin.initializeApp();
// admin.initializeApp(functions.config().firebase);
// const fireFunction = functions.firestore;
// const fireMessaging = admin.messaging();
// const fireAdmin = admin.firestore();
// --------------------------------------------------------------------------

//  METHODS

// -------------------------------------
// TESTED : WORKS
const onNoteCreation = functions.firestore
    .document('notes/{note}')
    .onCreate((snapshot, context) => {
      functions.logger.log('onNoteCreation : START');
      const noteModel = snapshot.data();
      const token = noteModel.token;
      const noteTitle = noteModel.notification.notification.title;
      const body = noteModel.notification.notification.body;
      const map = {
        token: token,
        notification: {
          body: body,
          title: noteTitle,
        },
        data: {
          hello: 'world',
          click_action: 'FLUTTER_NOTIFICATION_CLICK',
        },
        // Set Android priority to "high"
        android: {
          priority: 'high',
        },
        // Add APNS (Apple) config
        apns: {
          payload: {
            aps: {
              contentAvailable: true,
            },
          },
          headers: {
            'apns-push-type': 'background',
            'apns-priority': '5', // Must be `5` when `contentAvailable` is set to true.
            'apns-topic': 'io.flutter.plugins.firebase.messaging', // bundle identifier
          },
        },
      };
      functions.logger.log('onNoteCreation : isa works');
      if (noteModel.sendFCM == true) {
        if (noteModel.topic == null) {
          admin.messaging().send(map);
        } else {
          admin.messaging().sendToTopic(noteModel.topic, map);
        }
      }
      functions.logger.log('onNoteCreation : END');
      return noteModel;
    });
// -------------------------------------
// const x_myFunction = fireFunction
// .document('flyers/{flyer}')
// .onCreate((snapshot, context) => {
//   return fireMessaging.sendToTopic('flyers', {
//     notification: {
//       title: snapshot.data().username,
//       body: snapshot.data().text,
//       clickAction: 'FLUTTER_NOTIFICATION_CLICK',
//     },
//   });
// });
// -------------------------------------
// const oldFcmToDevice = functions.firestore
//     .document('notes/{note}')
//     .onCreate((snapshot, context) => {
//       functions.logger.log(
//           'fcmToDevice : START',
//       );
//       const noteModel = snapshot.data();
//       const token = noteModel.token;
//       const noteTitle = noteModel.notification.notification.title;
//       const body = noteModel.notification.notification.body;
//       const payload = {
//         notification: {
//           title: noteTitle,
//           body: body,
//           sound: 'default',
//           badge: '1',
//           clickAction: 'FLUTTER_NOTIFICATION_CLICK',
//           data: 'bitch',
//         },
//         data: {
//           to: token,
//           // mutable_content: true,
//           // content_available: true,
//           priority: 'high',
//           data: {
//             content: {
//               id: noteModel.id,
//               title: noteTitle,
//               body: body,
//               // showWhen: true,
//               // autoDismissible: true,
//               privacy: 'Private',
//             },
//           },
//         },
//       };
//       const options = {
//         priority: 'high',
//       };
//       functions.logger.log(
//           'fcmToDevice : this will work isa 2ool yarab',
//       );
//       admin.messaging().send(token, payload, options);
//       functions.logger.log(
//           'fcmToDevice : END',
//       );
//       return noteModel;
//     });
// -------------------------------------
// const sendNotificationToDevice = functions.firestore
//     .document('notes/{note}')
//     .onCreate((snapshot, context) => {
//       const noteModel = snapshot.data();
//       const title = noteModel.title;
//       const token = noteModel.token;
//       const body = noteModel.body;
//       const payload = {
//         notification: {
//           title: title,
//           body: body,
//           sound: 'default',
//           badge: '1',
//         },
//       };
//       const options = {
//         priority: 'high',
//       };
//       functions.logger.log(
//           'testing this fucking function why is not working sendNotificationToDevice',
//       );
//       try {
//         const response = admin.messaging()
//             .sendToDevice(token, payload, options);
//         functions.logger.log(
//             'sendNotification : message sent successfuly',
//             response);
//         functions.logger.log(
//             response.results[0].error);
//         return 'Notification send: ', response;
//       } catch (error) {
//         functions.logger.log(
//             'sendNotification : error sending notification',
//             error);
//         throw ('Notification sent: ', error);
//       }
//     });
// --------------------------------------------------------------------------

//  MODULE EXPORTS

// -------------------------------------
module.exports = {
  // 'send_fcm_on_note_creation': send_fcm_on_note_creation,
  'onNoteCreation': onNoteCreation,
};
// --------------------------------------------------------------------------
