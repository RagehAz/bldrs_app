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
  const userDocRef = admin.firestore().collection('users').doc(userID);
  functions.logger.log('deleteUserToken : 2 - should start deleting fcmToken field now');
  userDocRef.update({
    fcmToken: admin.firestore.FieldValue.delete(),
  }).then(function(response) {
    functions.logger.log(
        'deleteUserToken : 3 - just finished deleting and',
        `response : [${response}]`,
    );
  }).catch(function(error) {
    functions.logger.log(
        'deleteUserToken : 3 - could not delete user token',
        `error : [${error}]`,
    );
  });
  functions.logger.log('deleteUserToken : 4 - END');
};
// --------------------------------------------------------------------------

//  MODULE EXPORTS

// -------------------------------------
module.exports = {
  'deleteUserToken': deleteUserToken,
};
// --------------------------------------------------------------------------
