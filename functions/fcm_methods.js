// --------------------------------------------------------------------------

//  IMPORTS

// -------------------------------------
const functions = require('firebase-functions');
const admin = require('firebase-admin');
// --------------------------------------------------------------------------

//  INITIALIZATION

// -------------------------------------
admin.initializeApp();
// const fireFunction = functions.firestore;
// const fireMessaging = admin.messaging();
// const fireAdmin = admin.firestore();
// --------------------------------------------------------------------------

//  METHODS

// -------------------------------------
// const send_fcm_on_note_creation = fireFunction.document('notes/{note}')
// .onWrite((event) => {
//     let docID = event.after.get.id;
//     let title = event.after.get('title');
//     let content = event.after.get('');
//     var message = {
//         notification: {
//             title: title,
//             body: content,
//         },
//         'topic': 'xyz',
//     };

//     let response = await fireMessaging.send(message);
//     console.log(response);

// });
// -------------------------------------
const sendNotificationToDevice = functions.database
    .ref('/notes/{note}')
    .onWrite(async (event, context) => {
      const noteModel = event.after.val();
      const title = noteModel.title;
      const token = noteModel.token;
      const body = noteModel.body;
      const payload = {
        notification: {
          title: title,
          body: body,
          sound: 'default',
        },
      };
      return admin.messaging()
          .sendToDevice(token, payload)
          .then(function(response) {
            console.log(
                'sendNotification : message is sent successfuly',
                response,
            );
            console.log(
                response.results[0].error,
            );
          }).catch(function(error) {
            console.log(
                'sendNotification : error while sending notification',
                error,
            );
          });
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
// --------------------------------------------------------------------------

//  MODULE EXPORTS

// -------------------------------------
module.exports = {
  // 'send_fcm_on_note_creation': send_fcm_on_note_creation,
  'sendNotificationToDevice': sendNotificationToDevice,
};
// --------------------------------------------------------------------------
