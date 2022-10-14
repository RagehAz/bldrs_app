// --------------------------------------------------------------------------

// IMPORTS

// -------------------------------------
const admin = require('firebase-admin');
// const functions = require('firebase-functions');
const fcmMethods = require('./methods/fcm_methods');
// const userMethods = require('./methods/user_methods');
// --------------------------------------------------------------------------

// INITIALIZATION

// -------------------------------------
admin.initializeApp();
// admin.initializeApp({
//     credential: admin.credential.cert(require("./service-account-file.json")),
//     databaseURL: "https://....firebaseio.com",
//   });
// --------------------------------------------------------------------------

// EXPORTS

// -------------------------------------
exports.callSendFCMToDevice = fcmMethods.callSendFCMToDevice;
exports.callSendFCMToDevice = fcmMethods.callSendFCMToDevices;
exports.callSendFCMToDevice = fcmMethods.callSendFCMsToDevices;
exports.callSendFCMToDevice = fcmMethods.callSendFCMToTopic;
// --------------------------------------------------------------------------

// DEPLOYMENT

// -------------------------------------
// firebase deploy --only functions
// firebase deploy --only functions:callSendFCMToDevice
// firebase login --reauth
// firebase functions:log --only increaseNumberOfUsersInStatistics
// --------------------------------------------------------------------------
