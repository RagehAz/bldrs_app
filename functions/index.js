const functions = require("firebase-functions");

exports.myFunction = functions.firestore
    .document('flyers/{flyer}')
    .onCreate(
        (change, context) => {

                console.log(change.after.data());

            }
      );