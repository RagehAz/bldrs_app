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
/// TESTED :
const createFCMPayload = (noteModel) => {
  functions.logger.log(`createFCMPayload : 1 - START : note title : [${noteModel.title}]`);
  const map = {
    token: `${noteModel.token}`,
    // this lets FireBaseMessaging force a notification
    // but we are already handling it by AwesomeNotification package
    // notification: {
    //   body: body,
    //   title: noteTitle,
    // },
    data: {
      click_action: 'FLUTTER_NOTIFICATION_CLICK',
      token: `${noteModel.token}`,
      id: `${noteModel.id}`,
      senderID: `${noteModel.senderID}`,
      senderImageURL: `${noteModel.senderImageURL}`,
      senderType: `${noteModel.senderType}`,
      receiverID: `${noteModel.receiverID}`,
      receiverType: `${noteModel.receiverType}`,
      title: `${noteModel.title}`,
      body: `${noteModel.body}`,
      sentTime: `${noteModel.sentTime}`,
      posterModelID: `${noteModel.posterModelID}`,
      posterType: `${noteModel.posterType}`,
      posterURL: `${noteModel.posterURL}`,
      buttons: `${noteModel.buttons}`,
      reply: `${noteModel.reply}`,
      replyTime: `${noteModel.replyTime}`,
      sendFCM: `${noteModel.sendFCM}`,
      topic: `${noteModel.topic}`,
      triggerName: `${noteModel.triggerName}`,
      triggerArgument: `${noteModel.triggerArgument}`,
      seen: `${noteModel.seen}`,
      progress: `${noteModel.progress}`,
      dismissible: `${noteModel.dismissible}`,
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
  functions.logger.log(`createFCMPayload : 2 - END : note topic : [${noteModel.topic}]`, `token : [${noteModel.token}]`);
  return map;
}
// --------------------
// TESTED : WORKS
const sendFCMToDevice = (noteModel) => {
  functions.logger.log(`sendFCMToDevice : 1 - START : senderID is : [${noteModel.senderID}]`);
  const map = createFCMPayload(noteModel);
  functions.logger.log(`sendFCMToDevice : 2 - send fcm to userID : [${noteModel.receiverID}]`);
  const result = admin.messaging().send(map)
      .then(function(response) {
        functions.logger.log(
            'sendFCMToDevice : 3 - END : FCM is sent SUCCESSFULLY and response is :',
            `[${response}]`,
        );
        // return { success: true };
        return true;
      }).catch(function(error) {
        if (error != null) {
          functions.logger.log(
              'sendFCMToDevice : 3 - END : could not send FCM',
              `code : [${error.errorInfo.code}]`,
              `message : [${error.errorInfo.message}]`,
              `codePrefix : [${error.codePrefix}]`,
          );
          if (noteModel.receiverType == 'user') {
            if (error.errorInfo.code == 'messaging/registration-token-not-registered') {
              userMethods.deleteUserToken(noteModel.receiverID);
            }
          }
          // throw new functions.https.HttpsError('invalid-argument', "some message");
          // return { error: error.code };
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
// -------------------------------------
// firebase deploy --only functions:onNoteCreation
// firebase deploy --only functions:callSendFCMToDevice
// -------------------------------------
// firebase deploy --only functions
// --------------------------------------------------------------------------
