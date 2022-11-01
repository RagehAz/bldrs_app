// --------------------------------------------------------------------------

// IMPORTS

// --------------------
const admin = require('firebase-admin');
// const functions = require('firebase-functions');
const fcmMethods = require('./methods/fcm_methods');
const storageMethods = require('./methods/storage_methods');
// const userMethods = require('./methods/user_methods');
// --------------------------------------------------------------------------

// INITIALIZATION

// --------------------
admin.initializeApp();
// admin.initializeApp({
//     credential: admin.credential.cert(require("./service-account-file.json")),
//     databaseURL: "https://....firebaseio.com",
//   });
// --------------------------------------------------------------------------

// EXPORTS

// --------------------
/// FCM FUNCTIONS
// --------------------
exports.callSendFCMToDevice = fcmMethods.callSendFCMToDevice;
exports.callSendFCMToDevices = fcmMethods.callSendFCMToDevices;
exports.callSendFCMsToDevices = fcmMethods.callSendFCMsToDevices;
exports.callSendFCMToTopic = fcmMethods.callSendFCMToTopic;
// --------------------
/// STORAGE FUNCTIONS
// --------------------
exports.callDeleteStorageDirectory = storageMethods.callDeleteStorageDirectory;
// --------------------------------------------------------------------------

// DEPLOYMENT

// --------------------
// firebase deploy --only functions
// firebase deploy --only functions:callSendFCMToDevice
// firebase login --reauth
// firebase functions:log --only increaseNumberOfUsersInStatistics
// --------------------------------------------------------------------------
