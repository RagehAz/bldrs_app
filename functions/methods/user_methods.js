// --------------------------------------------------------------------------

//  IMPORTS

// -------------------------------------
const functions = require('firebase-functions');
const admin = require('firebase-admin');
// --------------------------------------------------------------------------

//  GETTERS

// -------------------------------------
const getUserModel = (userID) => {
  functions.logger.log(`getUserModel : 1 - START : with userID : [${userID}]`);
  const userDocRef = admin.firestore().collection('users').doc(userID);
  functions.logger.log('getUserModel : 2 - should start getting userModel now');
  const userModel = userDocRef.get().then((doc) => {
    if (doc.exists) {
      console.log('getUserModel : 3 - GOT userModel', doc.data());
      return doc.data();
    } else {
      console.log('getUserModel : 3 - NO userModel found');
    }
  }).catch((error) => {
    console.log('getUserModel : 3 - ERROR', error);
  });
  return userModel;
};
// --------------------------------------------------------------------------

//  FCM TOKEN

// -------------------------------------
// TESTED : WORKS
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
  'getUserModel': getUserModel,
};
// --------------------------------------------------------------------------
