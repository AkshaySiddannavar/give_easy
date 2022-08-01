// Entry point for defining all cloud functions
import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
// used to access Admin SDK functionality

admin.initializeApp() //Initialize an admin app instance from which Cloud Firestore changes can be made

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});

/**
 * 
 * 1. Writing Cloud Functions

 * Syntax for Cloud Functions:

   export const functionName = functions.firestore.document('/messages/{documentId}')
    .onCreate((snap, context) => {
      // Grab the current value of what was written to Firestore.
      const original = snap.data().original;

      // Access the parameter `{documentId}` with `context.params`
      functions.logger.log('Uppercasing', context.params.documentId, original);
      
      const uppercase = original.toUpperCase();
      
      // You must return a Promise when performing asynchronous tasks inside a Functions such as
      // writing to Firestore.
      // Setting an 'uppercase' field in Firestore document returns a Promise.
      return snap.ref.set({uppercase}, {merge: true});
    });

    2. Deploying 
    
    - When we deploy a cloud function it is better if we use [firebase deploy --debug --only functions]

    After deploying we get a function URL using which we can trigger that function
 */