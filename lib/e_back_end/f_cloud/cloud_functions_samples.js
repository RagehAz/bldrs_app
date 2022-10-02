// -----------------------------------------------------------------------------

// https://stackoverflow.com/questions/66194726/how-do-i-query-a-token-and-send-push-notifications-inside-cloud-function

// --------------------
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
const database = admin.firestore();

exports.sendNewMessageNotification = functions.firestore
  .document("messages/{message}")
  .onWrite(async (event) => {
    const query = await database
      .collection("users")
      .doc(event.after.data().uid[0])
      .collection("tokens")
      .get();

    const tokens = query.docs.map((snap) => snap.id);

    return admin.messaging().sendToDevice(tokens,
      {
        notification: {
          title: "Nieuw bericht",
          body: "Je hebt een nieuw bericht van Quick Fix Repar",
          click_action: "FLUTTER_NOTIFICATION_CLICK",
        }
      },
      {
        "priority": "high",
        "contentAvailable": true
      });
  });
// -----------------------------------------------------------------------------

// https://engineering.monstar-lab.com/2021/02/09/Use-Firebase-Cloudfunctions-To-Send-Push-Notifications

// --------------------
const payload = {
  token: FCMToken,
  notification: {
    title: 'cloud function demo',
    body: message
  },
  data: {
    body: message,
  }
};
// --------------------
admin.messaging().send(payload).then((response) => {
  // Response is a message ID string.
  console.log('Successfully sent message:', response);
  return { success: true };
}).catch((error) => {
  return { error: error.code };
});
  // -----------------------------------------------------------------------------
