const functions = require("firebase-functions");
const sgMail = require("@sendgrid/mail");

/* eslint-disable no-unused-vars */

// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
const {onRequest} = require("firebase-functions/v2/https");
const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");

// The Firebase Admin SDK to access Firestore.
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");

/* eslint-enable no-unused-vars */


admin.initializeApp();


admin.getAuth()
    .getUserByEmail(admin.email)
    .then((userRecord) => {
    // See the UserRecord reference doc for the contents of userRecord.
      console.log(`Successfully fetched user data: ${userRecord.toJSON()}`);
    })
    .catch((error) => {
      console.log("Error fetching user data:", error);
    });


sgMail.setApiKey(functions.config().sendgrid.key);

const msg = {
  to: "receiver@gmail.com", // Change to your recipient
  from: "sender@gmail.com", // Change to your sender
  subject: "Welcome to your account",
  text: "This is your first email triggered by Cloud Functions",
};

exports.sendEmailToUser = functions.https.onRequest((req, res) => {
  sgMail
      .send(msg)
      .then((response) => {
        console.log(response[0].statusCode);
        console.log(response[0].headers);
      })
      .catch((error) => {
        console.error(`Unable to send email. Error: ${error}`);
        throw new functions.https.HttpsError("aborted", "Unable to send email");
      });
});
