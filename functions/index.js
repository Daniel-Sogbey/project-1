const functions = require('firebase-functions');
const admin = require("firebase-admin");
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();

exports.makeUppercase = functions.database.ref('/posts/{pushId}/postText')
    .onCreate((snapshot, context) => {
      // Grab the current value of what was written to the Realtime Database.
      const original = snapshot.val();
      console.log(original);
      console.log('Uppercasing', context.params.pushId, original);
      const uppercase = original.toUpperCase();
      // You must return a Promise when performing asynchronous tasks inside a Functions such as
      // writing to the Firebase Realtime Database.
      // Setting an "uppercase" sibling in the Realtime Database returns a Promise.
 if (context.authType === 'ADMIN') {
         return admin.messaging().sendToTopic('posts', {notification:
             {title: 'Hello SolveSharer, have an opinion on this post?', body:original
            }});
      } else if (context.authType === 'USER') {
        return console.log(snap.val(), 'written by', context.auth.uid);
      }




      return snapshot.ref.parent.child('uppercase').set(uppercase);
    });