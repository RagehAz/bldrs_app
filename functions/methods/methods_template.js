// // --------------------------------------------------------------------------

// //  IMPORTS

// // --------------------
// const functions = require('firebase-functions');
// const admin = require('firebase-admin');
// // --------------------------------------------------------------------------

// //  CALLABLES

// // --------------------
// // TESTED : WORKS PERFECT
// const doStuff = functions.https.onCall((dataToPass, context) => {
//     const result = doTheThing(dataToPass);
//     return result;
//   });
// // --------------------------------------------------------------------------

// //  METHODS

// // --------------------
// // TESTED : WORKS PERFECT
// const doTheThing = (dataToPass) => {
//     functions.logger.log(`doTheThing : 1 - START : stuff is : [${dataToPass}]`);
//     const output = dataToPass;
//     functions.logger.log(`sendFCMToDevice : 3 - END : output is : [${output}]`);
//     return output;
//   };
// // --------------------------------------------------------------------------

// //  MODULE EXPORTS

// // -------------------------------------
// module.exports = {
//     'doStuff': doStuff,
//   };
//   // -------------------------------------
//   // firebase deploy --only functions:onNoteCreation
//   // firebase deploy --only functions:callSendFCMToDevice
//   // -------------------------------------
//   // firebase deploy --only functions
//   // --------------------------------------------------------------------------
