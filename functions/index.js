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
// --------------------------------------------------------------------------

// EXPORTS

// -------------------------------------
exports.onNoteCreation = fcmMethods.onNoteCreation;
// --------------------------------------------------------------------------

// DEPLOYMENT

// -------------------------------------
// firebase deploy --only functions
// firebase deploy --only functions:t007_onCreateNewFlyer
// firebase login --reauth
// firebase functions:log --only increaseNumberOfUsersInStatistics
// --------------------------------------------------------------------------
