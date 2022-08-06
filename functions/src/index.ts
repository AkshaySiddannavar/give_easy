// Entry point for defining all cloud functions
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
// used to access Admin SDK functionality

admin.initializeApp();

const db = admin.firestore();

/**
 *
 */
export const updateCollectedAmount = functions.firestore.
    document("/user-donation-data/{documentId}").
    onCreate(async (snap, context) =>{
      const donationData = snap.data();

      console.log(donationData);

      const donationTitle: string = donationData["title"];
      const donationAmount: number = donationData["amount"];

      const requestDataQuery = db.collection("/specific-request-data").
          where("title", "==", donationTitle).
          where("status", "==", "active").get();

      const documentData = (await requestDataQuery).docs[0];

      const requestData = documentData.data();
      const requestDocumentID = documentData.id;


      const originalCollectedAmount
        :number =
        requestData["collectedAmount"];

      const newCollectedAmount
        :number =
        originalCollectedAmount +
        donationAmount;

      return db.
          doc(`/specific-request-data/${requestDocumentID}`).
          update({"collectedAmount": newCollectedAmount}).
          then(
              ()=>console.log("update ran")
          ).
          catch((error)=>{
            console.log(error);
            return 0;
          });
    }
    );


console.log("after function");

export const updateStatus = functions.firestore.
    document("/specific-request-data/{documentID}").
    onWrite((snap, context)=>{
      if (snap.before.exists == false) {
      // create
        const requestData = snap.after.data();
        const requestDataID = snap.after.id;

        if (
        requestData!["status"] == "active" &&
        requestData!["collectedAmount"]>=requestData!["goalAmount"]) {
          return db.
              doc(`/specific-request-data/${requestDataID}`).
              update({"status": "inactive"}).
              then(()=>console.log("status is made inactive")).
              catch((error)=>console.log(error));
        } else {
          console.log("status is in proper state");
          return 0;
        }
      } else if (snap.after.exists == true) {
        // update
        const requestData = snap.after.data();
        const requestDataID = snap.before.id;

        if (requestData!["status"] == "active" &&
      requestData!["collectedAmount"]>=requestData!["goalAmount"]) {
          return db.
              doc(`/specific-request-data/${requestDataID}`).
              update({"status": "inactive"}).
              then(()=>console.log("status is made inactive")).
              catch((error)=>console.log(error));
        } else {
          console.log("status is in proper state");
          return 0;
        }
      } else if (snap.after.exists == false) {
        // delete
        console.log("document deleted");
        return 0;
        // for now
        // only possible manually
      } else {
        // To handle
        // all other cases
        console.log(
            `Error is of type\n${context.eventType}`
        );
        return 0;
      }
    });
