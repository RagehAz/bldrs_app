const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = functions.firestore;
const fbm = admin.messaging();
const fire = admin.firestore();

// COLLECTION PATHS
// const flyerDoc = "flyers/{flyerID}";
// const userDoc = "users/{userID}";

// http request 1
exports.randomNumber = functions.https.onRequest((request, response) => {
  const number = Math.round(Math.random() * 100);
  console.log("The Random Number is : " + number);
  response.send(number.toString());
});

// // http request 2
// exports.toBlackHole = functions.https.onRequest((request, response) => {
//   response.redirect("https://www.google.com");
// });

// http callable function
exports.sayHello = functions.https.onCall((data, context) => {
  const name = data.name +
  "xx this string added inside the callable function xx";
  return `hello, Bldrs, welcome Mr ${name}`;
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

// to call a function for any db change u can say "/{collection}/{id}"
exports.logEverything = functions.firestore.document("/{collection}/{id}")
    .onCreate((snap, context) => {
      console.log(snap.data());

      const collection = context.params.collection;
      const id = context.params.id;

      const activities = admin.firestore().collection("activities");

      if (collection === "users") {
        return activities.add({text: `a new user is created : ${id}`});
      }
      if (collection === "flyers") {
        return activities.add({text: `a new flyer is created : ${id}`});
      }
      if (collection === "bzz") {
        return activities.add({text: `a new bz is created : ${id}`});
      }

      return null;
    });

// exports.onUserCreation = db.document("/users/{userID}")
//     .onCreate((snap, context) => {
//       const collection = context.params
//   });

// DB / admin / statistics.numberOfUsers increment 1
exports.increaseNumberOfUsersInStatistics = functions.auth.user().onCreate(
    (user) => {
      const docReference = fire.collection("admin").doc("statistics");
      console.log(`aho yabn el weskha : ${user.uid}`);
      return docReference.update({
        numberOfUsers: admin.firestore.FieldValue.increment(1),
      });
    });

// DB / admin / statistics.numberOfUsers increment -1
exports.decreaseNumberOfUsersInStatistics = functions.auth.user().onDelete(
    (user) => {
      const docReference = fire.collection("admin").doc("statistics");
      console.log(`aho yabn el a7ba : ${user.uid}`);
      return docReference.update({
        numberOfUsers: admin.firestore.FieldValue.increment(-1),
      });
    });

// auth trigger (background trigger)
exports.userDeleted = functions.auth.user().onDelete((user) => {
  console.log(
      `user Deleted account : userID : ${user.uid} : email : ${user.email}`
  );

  const doc = fire.collection("users").doc(user.uid);
  return doc.delete;
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
// firebase deploy --only functions:decreaseNumberOfUsersInStatistics
// firebase login --reauth
// firebase functions:log --only increaseNumberOfUsersInStatistics
