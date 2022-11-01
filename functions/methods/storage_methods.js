// --------------------------------------------------------------------------

//  IMPORTS

// --------------------
const functions = require('firebase-functions');
const admin = require('firebase-admin');
// --------------------------------------------------------------------------

//  CALLABLES

// --------------------
// TESTED : WORKS PERFECT
const callDeleteStorageDirectory = functions.https.onCall((path, context) => {
  const result = deleteAllPathFiles(path);
  return result;
});
// --------------------------------------------------------------------------

//  METHODS

// --------------------
// TESTED : WORKS PERFECT
const deleteAllPathFiles = (data) => {
  functions.logger.log(`deleteAllPathFiles : 1 - START : data is : [${data}] : `);
  const bucket = admin.storage().bucket();
  functions.logger.log(`deleteAllPathFiles : 2 - got Bucket : path is : [${data.path}]`);
  const output = bucket.deleteFiles({
    prefix: data.path, //`users/${userId}/`
  }).then((response) => {
    functions.logger.log(`deleteAllPathFiles : 3 - SUCCESS : deleted all files in : [${data.path}]`);
    return `success : [${response}]`;
  }).catch(function(error) {
    functions.logger.log(`deleteAllPathFiles : 3 - ERROR : [${error}]`);
    return `failure : [${error}]`; 
  });
  functions.logger.log(`deleteAllPathFiles : 4 - END : output is : [${output}]`);
  return output;
};
// --------------------------------------------------------------------------

//  MODULE EXPORTS

// -------------------------------------
module.exports = {
    'callDeleteStorageDirectory': callDeleteStorageDirectory,
  };
// -------------------------------------
// firebase deploy --only functions:onNoteCreation
// firebase deploy --only functions:callDeleteStorageDirectory
// -------------------------------------
// firebase deploy --only functions
// --------------------------------------------------------------------------