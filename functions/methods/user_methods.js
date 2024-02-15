// --------------------------------------------------------------------------

//  IMPORTS

// -------------------------------------
const functions = require('firebase-functions');
const admin = require('firebase-admin');
// --------------------------------------------------------------------------

//  GETTERS

// -------------------------------------
// TESTED : WORKS PERFECT
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
// TESTED : WORKS PERFECT
const deleteUserToken = (userID) => {
  functions.logger.log(`deleteUserToken : 1 - START : with userID : [${userID}]`);
  const userDocRef = admin.firestore().collection('users').doc(userID);
  functions.logger.log('deleteUserToken : 2 - should start deleting device field now');
  userDocRef.update({
    device: admin.firestore.FieldValue.delete(),
  }).then(function(response) {
    functions.logger.log(
        'deleteUserToken : 3 - just finished deleting and',
        `response : [${response}]`,
    );
  }).catch(function(error) {
    functions.logger.log(
        'deleteUserToken : 3 - could not delete user device field',
        `error : [${error}]`,
    );
  });
  functions.logger.log('deleteUserToken : 4 - END');
};
// --------------------------------------------------------------------------

//  FIREBASE AUTHENTICATION

// -------------------------------------
// TESTED : WORKS PERFECT
async function getAuthUsers(nextPageTokenMap) {

  let nextPageToken = nextPageTokenMap && nextPageTokenMap.nextPageToken ? nextPageTokenMap.nextPageToken : null;
  functions.logger.log(`a. getAuthUsers: START - nextPageToken: [${nextPageToken}]`);

  try {
    let allUsers = [];

    async function getAllUsers(token) {
      const listUsersResult = await admin.auth().listUsers(1000, token);

      listUsersResult.users.forEach(userRecord => {
        allUsers.push(userRecord.toJSON());
      });

      if (listUsersResult.pageToken) {
        functions.logger.log(`a2. getAuthUsers: token : [${nextPageToken}]`);
        await getAllUsers(listUsersResult.pageToken);
      }
    }

    if (nextPageToken) {
      await getAllUsers(nextPageToken);
    } else {
      await getAllUsers();
    }

    functions.logger.log(`b. getAuthUsers: Retrieved ${allUsers.length} users.`);

    return allUsers;
  } catch (error) {
    functions.logger.error(`c. getAuthUsers: Error - ${error}`);
  }
}
// --------------------------------------------------------------------------

//  CALLABLES

// --------------------
// TESTED : WORKS PERFECT
const callGetAuthUsers = functions.https.onCall((nextPageTokenMap, context) => {
  const result = getAuthUsers(nextPageTokenMap);
  return result;
});
// --------------------------------------------------------------------------

//  MODULE EXPORTS

// -------------------------------------
module.exports = {
  'deleteUserToken': deleteUserToken,
  'getUserModel': getUserModel,
  'callGetAuthUsers': callGetAuthUsers,
};
// --------------------------------------------------------------------------
