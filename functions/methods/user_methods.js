// --------------------------------------------------------------------------

//  IMPORTS

// -------------------------------------
const functions = require('firebase-functions');
const admin = require('firebase-admin');
// --------------------------------------------------------------------------

//  FCM TOKEN

// -------------------------------------
const deleteUserToken = (userID) => {
  functions.logger.log(`deleteUserToken : 1 - START : with userID : [${userID}]`);
  const userDoc = admin.firestore().collection('users').doc('userID');
  functions.logger.log(`deleteUserToken : 2 - got user doc : [${userDoc}]`);
  userDoc.update({
    token: null,
  });
  functions.logger.log('deleteUserToken : 3 - END : user token should have been assigned as null');
};
// --------------------------------------------------------------------------

//  MODULE EXPORTS

// -------------------------------------
module.exports = {
  'deleteUserToken': deleteUserToken,
};
// --------------------------------------------------------------------------
