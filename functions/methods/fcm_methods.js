// --------------------------------------------------------------------------

//  IMPORTS

// --------------------
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const userMethods = require('./user_methods');
// --------------------------------------------------------------------------

//  PAYLOAD

// --------------------
// TESTED : WORKS PERFECT
const createFCMPayload = (noteModel) => {
  functions.logger.log(`createFCMPayload : 1 - START : note title : [${noteModel.title}]`);
  const map = {
    token: `${noteModel.token}`,
    // this lets FireBaseMessaging force a notification
    // but we are already handling it by AwesomeNotification package
//    notification: {
//      title: `${noteModel.title}`,
//      body: `${noteModel.body}`,
//    },
    // the below data map is a <String, String> map 
    // and does not take bools or ints or else ...
    // so values like ('33') or ('null') or ('true') strings
    // are deciphered to their data types on client
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
      sendNote: `${noteModel.sendNote}`,
      topic: `${noteModel.topic}`,
      functionName: `${noteModel.functionName}`,
      functionArgument: `${noteModel.functionArgument}`,
      functionDone: `${noteModel.functionDone}`,
      navToName: `${noteModel.navToName}`,
      navToArgument: `${noteModel.navToArgument}`,
      // navToDone: `${noteModel.navToDone}`, // no need to use this, it should always fire
      seen: `${noteModel.seen}`,
      progress: `${noteModel.progress}`,
      dismissible: `${noteModel.dismissible}`,
    },
    // Set Android priority to "high"
    android: {
      priority: 'high',
      // ttl: '86400s',
      // notification: {
        // click_action: 'OPEN_ACTIVITY_1',
        // badge: 0,
      //  }
    },
    // Add APNS (Apple) config
    apns: {
      payload: {
        aps: {
          contentAvailable: true,
          category: 'NEW_MESSAGE_CATEGORY',
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
// --------------------------------------------------------------------------

//  SENDING FCM

// --------------------
// TESTED : WORKS PERFECT
const sendFCMToDevice = (noteModel) => {
  functions.logger.log(`sendFCMToDevice : 1 - START : senderID is : [${noteModel.senderID}]`);
  const map = createFCMPayload(noteModel);
  functions.logger.log(`sendFCMToDevice : 2 - send fcm to userID : [${noteModel.receiverID}]`);
  const output = admin.messaging().send(map)
      .then(function(response) {
        const success = onFCMSuccess(response);
        return success;
      }).catch(function(error) {
        const failure = onFCMError(error, noteModel);
        return failure;
      });
  functions.logger.log(`sendFCMToDevice : 3 - END : output is : [${output}]`);
  return output;
};
// --------------------
//
const sendFCMToDevices = (mapOfNoteModelAndTokens) => {
  // max 500 tokens at once
  functions.logger.log(`sendFCMToDevices : 1 - START : senderID is : [${noteModel.senderID}]`);
  const map = createFCMPayload(mapOfNoteModelAndTokens.noteModel);
  map.token = null;
  map.tokens = mapOfNoteModelAndTokens.tokens;
  // const message = {
  //   data: {score: '850', time: '2:45'},
  //   tokens: registrationTokens,
  // };
  functions.logger.log(`sendFCMToDevices : 2 - token is : [${map.token}] : tokens are : [${map.tokens}]`);
  const output = admin.messaging().sendMulticast(map)
    .then((response) => {
        analyzeSuccessRate(response, mapOfNoteModelAndTokens.tokens);
        const success = onFCMSuccess(response);
        return success;
      }).catch(function(error) {
        const failure = onFCMError(error, mapOfNoteModelAndTokens.noteModel);
        return failure;
    });
  functions.logger.log(`sendFCMToDevices : 3 - END : output is : [${output}]`);
  return output;
}
// --------------------
//
const sendFCMsToDevices = (notesModels) => {
  functions.logger.log(`sendFCMsToDevices : 1 - START : sending : [${notesModels.length}] notes`);
  const maps = [];
  const tokens = [];
  notesModels.forEach((note, index) => {
    const map = createFCMPayload(note);
    maps.push(map);
    tokens.push(map.token);
  });
  functions.logger.log(`sendFCMsToDevices : 2 : created : [${maps.length}] maps`);
  const output = admin.messaging().sendAll(maps)
    .then((response) => {
        analyzeSuccessRate(response, tokens);
        const success = onFCMSuccess(response);
        return success;
      }).catch(function(error) {
        // should loop and delete token for each device separatly
        const failure = onFCMError(error, null);
        return failure;
    });
  functions.logger.log(`sendFCMsToDevices : 3 - END : output is : [${output}]`);
  return output;
}
// --------------------
// TESTED : WORKS PERFECT
const sendFCMToTopic = (noteModel) => {
  functions.logger.log(`sendFCMToTopic : 1 - START : senderID is : [${noteModel.senderID}]`);
  const map = createFCMPayload(noteModel);
  map.token = null;
  map.topic = noteModel.topic;
  functions.logger.log(`sendFCMToTopic : 2 - token : [${map.token}] : topic : [${map.topic}]`);
  const output = admin.messaging().send(map)
  .then(function(response) {
    const success = onFCMSuccess(response);
    return success;
  }).catch(function(error) {
    const failure = onFCMError(error, noteModel);
    return failure;
  });
  functions.logger.log(`sendFCMToTopic : 3 - END : output is : [${output}]`);
  return output;
};
// --------------------------------------------------------------------------

//  RESPONSE

// --------------------
// TESTED : WORKS PERFECT
const onFCMSuccess = (response) => {
  functions.logger.log(
    'onFCMSuccess : o - FCM is sent SUCCESSFULLY and response is :',
    `[${response}]`,
  );
  // return { success: true };
  return true;
}
// --------------------
// 
const analyzeSuccessRate = (response, tokens) => {
  functions.logger.log(`analyzeSuccessRate : 1 - failureCount : [${response.failureCount}] : successCount : [${response.successCount}]`);
  if (response.failureCount > 0) {
    const failedTokens = [];
    response.responses.forEach((res, index) => {
     if (!res.success) {
       failedTokens.push(tokens[index]);
      }
    });
    functions.logger.log(`analyzeSuccessRate : 2 - failedTokens : [${failedTokens}]`);
  }
  functions.logger.log(`analyzeSuccessRate : 3 - successRate : [ ${(response.successCount/tokens.length)*100} % ]`);
}
// --------------------
// 
const onFCMError = (error, noteModel) => {
  if (error != null) {
    functions.logger.log(
        'onFCMError : x - could not send FCM',
        `code : [${error.errorInfo?.code}]`,
        `message : [${error.errorInfo?.message}]`,
        `codePrefix : [${error.codePrefix}]`,
    );
    if (noteModel?.receiverType == 'user') {
      if (error.errorInfo.code == 'messaging/registration-token-not-registered') {
        userMethods.deleteUserToken(noteModel.receiverID);
      }
      if (error.errorInfo.code == 'messaging/registration-token-not-registered') {
        userMethods.deleteUserToken(noteModel.receiverID);
      }
    }
    // throw new functions.https.HttpsError('invalid-argument', "some message");
    // return { error: error.code };
    return false;
  }
}
// --------------------------------------------------------------------------

//  CALLABLES

// --------------------
// TESTED : WORKS PERFECT
const callSendFCMToDevice = functions.https.onCall((noteModel, context) => {
  const result = sendFCMToDevice(noteModel);
  return result;
});
// --------------------
// 
const callSendFCMToDevices = functions.https.onCall((noteModel, context) => {
  const result = sendFCMToDevices(noteModel);
  return result;
});
// --------------------
// 
const callSendFCMsToDevices = functions.https.onCall((noteModel, context) => {
  const result = sendFCMsToDevices(noteModel);
  return result;
});
// --------------------
// TESTED : WORKS PERFECT
const callSendFCMToTopic = functions.https.onCall((noteModel, context) => {
  const result = sendFCMToTopic(noteModel);
  return result;
});
// --------------------------------------------------------------------------

//  MODULE EXPORTS

// -------------------------------------
module.exports = {
  'callSendFCMToDevice': callSendFCMToDevice,
  'callSendFCMToDevices': callSendFCMToDevices,
  'callSendFCMsToDevices': callSendFCMsToDevices,
  'callSendFCMToTopic': callSendFCMToTopic,
};
// -------------------------------------
// firebase deploy --only functions:onNoteCreation
// firebase deploy --only functions:callSendFCMToDevice
// -------------------------------------
// firebase deploy --only functions
// --------------------------------------------------------------------------
