const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = functions.firestore;
const fbm = admin.messaging();

// COLLECTION PATHS
// const flyerDoc = "flyers/{flyerID}";
// const userDoc = "users/{userID}";

// http request 1
exports.randomNumber = functions.https.onRequest((request, response) => {
  const number = Math.round(Math.random() * 100);
  console.log("The Random Number is : " + number);
  response.send(number.toString());
});

// http request 2
exports.toBlackHole = functions.https.onRequest((request, response) => {
  response.redirect("https://www.google.com");
});

// http callable function
exports.sayHello = functions.https.onCall((data, context) => {
  return "hello, Bldrs";
});

exports.myFunction = db
    .document("flyers/{flyer}")
    .onCreate((snapshot, context) => {
      return fbm.sendToTopic("flyers", {
        notification: {
          title: snapshot.data().username,
          body: snapshot.data().text,
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      });
    });


// exports.newUserSignedUp = db.document(userDoc).onCreate(doc, context) => {
// return fbm.sendToTopic
// }

// exports.notifyBzOnFlyerReview = functions.firestore
//     .document("flyers/{flyerID}/reviews/{reviewID}")
//     .onCreate((snapshot, context) => {
//       return fbm.sendToTopic("flyers", {
//         notification: {
//           title: snapshot.data().username,
//           body: snapshot.data().text,
//           clickAction: "FLUTTER_NOTIFICATION_CLICK",
//         },
//       });
//     });

// firebase deploy --only functions
