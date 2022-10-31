// --------------------------------------------------------------------------

//  IMPORTS

// --------------------
const functions = require('firebase-functions');
const admin = require('firebase-admin');
// --------------------------------------------------------------------------

//  CALLABLES

// --------------------
//
const deleteStorageDirectory = functions.https.onCall((path, context) => {
    const result = deleteAllPathFiles(path);
    return result;
  });
// --------------------------------------------------------------------------

//  METHODS

// --------------------
// 
const deleteAllPathFiles = (path) => {
    functions.logger.log(`deleteAllPathFiles : 1 - START : path is : [${path}]`);
    const bucket = admin.storage().bucket();
    return bucket.deleteFiles({
        prefix: path, //`users/${userId}/`
      }, function(err) {
        if (err) {
            functions.logger.log(`deleteAllPathFiles : 2 - END : error : [${err}]`);
        } else {
            functions.logger.log(`deleteAllPathFiles : 2 - END : success : deleted all files in : [${path}]`);
        }
      });
    
  };
// --------------------------------------------------------------------------

//  MODULE EXPORTS

// -------------------------------------
module.exports = {
    'deleteStorageDirectory': deleteStorageDirectory,
  };
// -------------------------------------
// firebase deploy --only functions:onNoteCreation
// firebase deploy --only functions:callSendFCMToDevice
// -------------------------------------
// firebase deploy --only functions
// --------------------------------------------------------------------------