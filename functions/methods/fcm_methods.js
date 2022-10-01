// --------------------------------------------------------------------------

//  IMPORTS

// -------------------------------------
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const userMethods = require('./user_methods');
// --------------------------------------------------------------------------

//  METHODS

// -------------------------------------
// TESTED : WORKS
const onNoteCreation = functions.firestore
    .document('notes/{note}')
    .onCreate((snapshot, context) => {
      const noteModel = snapshot.data();
      functions.logger.log(`onNoteCreation : 1 - START : senderID is : [${noteModel.senderID}]`);
      const token = noteModel.token;
      functions.logger.log(`onNoteCreation : 2 - token is : [${token}]`);
      const noteTitle = noteModel.notification.notification.title;
      functions.logger.log(`onNoteCreation : 3 - noteTitle is : [${noteTitle}]`);
      const body = noteModel.notification.notification.body;
      functions.logger.log(`onNoteCreation : 4 - body is : [${body}]`);
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
      functions.logger.log('onNoteCreation : 5 - just before fcm is sent');
      if (noteModel.sendFCM == true) {
        admin.messaging().send(map)
            .then(function(response) {
              functions.logger.log(
                  'onNoteCreation : 6 - message is sent SUCCESSFULLY and response is :',
                  response,
              );
            }).catch(function(error) {
              functions.logger.log(
                  'onNoteCreation : 6 - some wise error is preventing shit from going loud',
                  `code : [${error.errorInfo.code}]`,
                  `message : [${error.errorInfo.message}]`,
                  `codePrefix : [${error.codePrefix}]`,
              );
              if (noteModel.receiverType == 'user') {
                if (error.errorInfo.code == 'messaging/registration-token-not-registered') {
                  userMethods.deleteUserToken(noteModel.receiverID);
                }
              }
            });
      }
      functions.logger.log('onNoteCreation : 9 - END : FCM should have been sent by now');
      return noteModel;
    });
// -------------------------------------
// firebase deploy --only functions:onNoteCreation
// firebase deploy --only functions
// --------------------------------------------------------------------------

//  MODULE EXPORTS

// -------------------------------------
module.exports = {
  // 'send_fcm_on_note_creation': send_fcm_on_note_creation,
  'onNoteCreation': onNoteCreation,
};
// --------------------------------------------------------------------------
