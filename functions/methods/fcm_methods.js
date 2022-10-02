// --------------------------------------------------------------------------

//  IMPORTS

// --------------------
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const userMethods = require('./user_methods');
// --------------------------------------------------------------------------

//  LISTENERS

// --------------------
// TESTED : WORKS PERFECT
// const onNoteCreation = functions.firestore
//    .document('notes/{note}')
//    .onCreate((snapshot, context) => {
//      const noteModel = snapshot.data();
//      const result = sendFCMToDevice(noteModel);
//      return result;
//    });
// --------------------------------------------------------------------------

//  CALLABLES

// --------------------
// TESTED : WORKS PERFECT
const callSendFCMToDevice = functions.https.onCall((noteModel, context) => {
  const result = sendFCMToDevice(noteModel);
  return result;
});
// --------------------------------------------------------------------------

//  SENDING FCM

// --------------------
// TESTED : WORKS
const sendFCMToDevice = (noteModel) => {
  functions.logger.log(`sendFCMToDevice : 1 - START : senderID is : [${noteModel.senderID}]`);
  const token = noteModel.token;
  functions.logger.log(`sendFCMToDevice : 2 - token is : [${token}]`);
  const noteTitle = noteModel.notification.notification.title;
  functions.logger.log(`sendFCMToDevice : 3 - noteTitle is : [${noteTitle}]`);
  const body = noteModel.notification.notification.body;
  functions.logger.log(`sendFCMToDevice : 4 - body is : [${body}]`);
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
  functions.logger.log('sendFCMToDevice : 5 - just before fcm is sent');
  const result = admin.messaging().send(map)
      .then(function(response) {
        functions.logger.log(
            'sendFCMToDevice : 6 - END : FCM is sent SUCCESSFULLY and response is :',
            `[${response}]`,
        );
        return true;
      }).catch(function(error) {
        if (error != null) {
          functions.logger.log(
              'sendFCMToDevice : 6 - END : could not send FCM',
              `code : [${error.errorInfo.code}]`,
              `message : [${error.errorInfo.message}]`,
              `codePrefix : [${error.codePrefix}]`,
          );
          if (noteModel.receiverType == 'user') {
            if (error.errorInfo.code == 'messaging/registration-token-not-registered') {
              userMethods.deleteUserToken(noteModel.receiverID);
            }
          }
          return false;
        }
      });
  return result;
};
// --------------------
// const sendFCMToTopic = (noteModel) => {
// };
// --------------------------------------------------------------------------

//  MODULE EXPORTS

// -------------------------------------
module.exports = {
// 'send_fcm_on_note_creation': send_fcm_on_note_creation,
//  'onNoteCreation': onNoteCreation,
  'callSendFCMToDevice': callSendFCMToDevice,
};
// firebase deploy --only functions:onNoteCreation
// firebase deploy --only functions:callSendFCMToDevice
// firebase deploy --only functions
// --------------------------------------------------------------------------
