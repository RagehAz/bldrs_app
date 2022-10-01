// --------------------------------------------------------------------------

//  INITIALIZATION

// -------------------------------------
// admin.initializeApp();
// admin.initializeApp(functions.config().firebase);
// const fireFunction = functions.firestore;
// const fireMessaging = admin.messaging();
// const fireAdmin = admin.firestore();
// --------------------------------------------------------------------------

//  NOTES

// -------------------------------------
// const dummyRealTimeOnCreateMethod = functions.database
//     .ref('/collName/{docID}')
//     .onWrite(async (event, context) => {
//        const docMap = event.after.val();
//       return stuff;
//     });
// -------------------------------------
// const dummyFireOnCreateMethod = functions.firestore
//     .document('/collName/{docID}')
//     .onWrite((snapshot, context) => {
//        const docMap = change.data();
//       return stuff;
//     });
// const x_myFunction = fireFunction
// .document('flyers/{flyer}')
// .onCreate((snapshot, context) => {
//   return fireMessaging.sendToTopic('flyers', {
//     notification: {
//       title: snapshot.data().username,
//       body: snapshot.data().text,
//       clickAction: 'FLUTTER_NOTIFICATION_CLICK',
//     },
//   });
// });
// -------------------------------------
// const oldFcmToDevice = functions.firestore
//     .document('notes/{note}')
//     .onCreate((snapshot, context) => {
//       functions.logger.log(
//           'fcmToDevice : START',
//       );
//       const noteModel = snapshot.data();
//       const token = noteModel.token;
//       const noteTitle = noteModel.notification.notification.title;
//       const body = noteModel.notification.notification.body;
//       const payload = {
//         notification: {
//           title: noteTitle,
//           body: body,
//           sound: 'default',
//           badge: '1',
//           clickAction: 'FLUTTER_NOTIFICATION_CLICK',
//           data: 'bitch',
//         },
//         data: {
//           to: token,
//           // mutable_content: true,
//           // content_available: true,
//           priority: 'high',
//           data: {
//             content: {
//               id: noteModel.id,
//               title: noteTitle,
//               body: body,
//               // showWhen: true,
//               // autoDismissible: true,
//               privacy: 'Private',
//             },
//           },
//         },
//       };
//       const options = {
//         priority: 'high',
//       };
//       functions.logger.log(
//           'fcmToDevice : this will work isa 2ool yarab',
//       );
//       admin.messaging().send(token, payload, options);
//       functions.logger.log(
//           'fcmToDevice : END',
//       );
//       return noteModel;
//     });
// -------------------------------------
// const sendNotificationToDevice = functions.firestore
//     .document('notes/{note}')
//     .onCreate((snapshot, context) => {
//       const noteModel = snapshot.data();
//       const title = noteModel.title;
//       const token = noteModel.token;
//       const body = noteModel.body;
//       const payload = {
//         notification: {
//           title: title,
//           body: body,
//           sound: 'default',
//           badge: '1',
//         },
//       };
//       const options = {
//         priority: 'high',
//       };
//       functions.logger.log(
//           'testing this fucking function why is not working sendNotificationToDevice',
//       );
//       try {
//         const response = admin.messaging()
//             .sendToDevice(token, payload, options);
//         functions.logger.log(
//             'sendNotification : message sent successfuly',
//             response);
//         functions.logger.log(
//             response.results[0].error);
//         return 'Notification send: ', response;
//       } catch (error) {
//         functions.logger.log(
//             'sendNotification : error sending notification',
//             error);
//         throw ('Notification sent: ', error);
//       }
//     });
// --------------------------------------------------------------------------

// DOCS / PATHS

// -------------------------------------
// const flyerDoc = 'flyers/{flyerID}';
// const userDoc = 'users/{userID}';
// const docStatistics = fireAdmin.collection('admin').doc('statistics');
// --------------------------------------------------------------------------

// TRACERS

// -------------------------------------
// T001 : DB / admin / statistics.numberOfUsers increment 1
// exports.t001_onCreateNewFirebaseUser = functions.auth.user().onCreate(
//     (user) => {
//       console.log(`T001 : firebase new user CREATED : ${user.uid}`);
//       return docStatistics.update({
//         numberOfUsers: admin.firestore.FieldValue.increment(1),
//       });
//     });
// -------------------------------------
// T002 : DB / admin / statistics.numberOfUsers increment -1
// exports.t002_onDeleteFirebaseUser = functions.auth.user().onDelete(
//     (user) => {
//       console.log(`T002 : firebase user DELETED : ${user.uid}`);
//       return docStatistics.update({
//         numberOfUsers: admin.firestore.FieldValue.increment(-1),
//       });
//     });
// -------------------------------------
// T003 : DB / admin / statistics.numberOfCountries increment 1
// exports.t003_onCreateNewCountry =
// fireFunction.document('countries/{countryID}')
//     .onCreate(
//         (snapshot, context) => {
//           const map = snapshot.data();
//           console.log(`T003 : new Country ADDED : ${map.iso3}`);
//           return docStatistics.update({
//             numberOfCountries: admin.firestore.FieldValue.increment(1),
//           });
//         }
//     );
// -------------------------------------
// T004 : DB / admin / statistics.numberOfCountries increment -1
// exports.t004_onDeleteCountry = fireFunction.document('countries/{countryID}')
//     .onDelete(
//         (snapshot, context) => {
//           const map = snapshot.data();
//           console.log(`T004 : new Country DELETED : ${map.iso3}`);
//           return docStatistics.update({
//             numberOfCountries: admin.firestore.FieldValue.increment(-1),
//           });
//         }
//     );
// -------------------------------------
// T005 : DB / admin / statistics.numberOfBzz increment 1
// exports.t005_onCreateNewBz = fireFunction.document('bzz/{bzID}')
//     .onCreate(
//         (snapshot, context) => {
//           const map = snapshot.data();
//           console.log(`T005 : new Bz ADDED : ${map.bzID}`);
//           return docStatistics.update({
//             numberOfBzz: admin.firestore.FieldValue.increment(1),
//           });
//         }
//     );
// -------------------------------------
// T006 : DB / admin / statistics.numberOfBzz increment -1
// exports.t006_onDeleteBz = fireFunction.document('bzz/{bzID}')
//     .onDelete(
//         (snapshot, context) => {
//           const map = snapshot.data();
//           console.log(`T006 : Bz DELETED : ${map.bzID}`);
//           return docStatistics.update({
//             numberOfBzz: admin.firestore.FieldValue.increment(-1),
//           });
//         }
//     );
// -------------------------------------
// T007 : DB / admin / statistics.numberOfBzz increment 1
// exports.t007_onCreateNewFlyer = fireFunction.document('flyers/{id}')
//     .onCreate(
//         (snap, context) => {
//           const slides = snap.data().slides;
//           const slidesCount = slides.length;
//           console.log(`T007 : new flyer ADDED : slidesCount : ${slidesCount}`);
//           return Promise.all([
//             docStatistics.update({
//               numberOfFlyers: admin.firestore.FieldValue.increment(1),
//               numberOfSlides: admin.firestore.FieldValue.increment(slidesCount),
//             }),
//             fireAdmin.collection('admin').doc('test').update({
//               key2: 'it works aho halawa',
//             }),
//           ]);
//         }
//     );
// -------------------------------------
// T008 : DB / admin / statistics.numberOfBzz increment -1
// exports.t008_onDeleteFlyer = fireFunction.document('flyers/{id}')
//     .onDelete(
//         (snap, context) => {
//           const slides = snap.data().slides;
//           const slidesCount = slides.length;
//           console.log(`T008 : flyer DELETED : slidesCount : ${slidesCount}`);
//           return docStatistics.update({
//             numberOfFlyers: admin.firestore.FieldValue.increment(-1),
//             numberOfSlides: admin.firestore.FieldValue.increment(-slidesCount),
//           });
//         }
//     );
// -------------------------------------
// http request 1
// exports.x_randomNumber = functions.https.onRequest((request, response) => {
//   const number = Math.round(Math.random() * 100);
//   console.log('The Random Number is : ' + number);
//   response.send(number.toString());
// });
// -------------------------------------
// // http request 2
// exports.toBlackHole = functions.https.onRequest((request, response) => {
//   response.redirect('https://www.google.com');
// });
// -------------------------------------
// http callable function
// exports.x_sayHello = functions.https.onCall((data, context) => {
//   const name = data.name +
//   'xx this string added inside the callable function xx';
//   return `hello, Bldrs, welcome Mr ${name}`;
// });
// -------------------------------------
// to call a function for any db change u can say '/{collection}/{id}'
// exports.x_logEverything = fireFunction.document('{collection}/{id}')
//     .onCreate((snap, context) => {
//       console.log(snap.data());

//       const collection = context.params.collection;
//       const id = context.params.id;

//       const activities = admin.firestore().collection('activities');

//       if (collection === 'users') {
//         return activities.add({text: `a new user is created : ${id}`});
//       }
//       if (collection === 'flyers') {
//         return activities.add({text: `a new flyer is created : ${id}`});
//       }
//       if (collection === 'bzz') {
//         return activities.add({text: `a new bz is created : ${id}`});
//       }

//       return null;
//     });
// -------------------------------------
// exports.onUserCreation = db.document('/users/{userID}')
//     .onCreate((snap, context) => {
//       const collection = context.params
//   });
// -------------------------------------
// auth trigger (background trigger)
// exports.userDeleted = functions.auth.user().onDelete((user) => {
//  console.log(
//      `user Deleted account : userID : ${user.uid} : email : ${user.email}`
//  );
//
//  const doc = fire.collection('users').doc(user.uid);
//  return doc.delete;
// });
// -------------------------------------
// exports.newUserSignedUp = db.document(userDoc).onCreate(doc, context) => {
// return fbm.sendToTopic
// }
// -------------------------------------
// exports.notifyBzOnFlyerReview = functions.firestore
//     .document('flyers/{flyerID}/reviews/{reviewID}')
//     .onCreate((snapshot, context) => {
//       return fbm.sendToTopic('flyers', {
//         notification: {
//           title: snapshot.data().username,
//           body: snapshot.data().text,
//           clickAction: 'FLUTTER_NOTIFICATION_CLICK',
//         },
//       });
//     });
