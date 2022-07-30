//* Sometimes this class will be more useful and sometimes using _auth instance would be better
//* This class will act like an API which will let our app interact with user-data collection in firebase
//* implement all firebase firestore operations/triggering cloud functions for user-data collection here

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataFirestoreAPI {
  static final _firestore = FirebaseFirestore
      .instance; //In case we feel this isn't the best practice we can create a firestore instance in each method

  String gender;
  String organizationName;
  String phoneNumber;
  String userEmail;
  String userName;
  String uniqueID;
  static String? documentID; //current document ID for the current user's data
  UserDataFirestoreAPI({
    required this.userName,
    required this.phoneNumber,
    this.organizationName = '', //empty string means no organization
    required this.gender,
    required this.userEmail,
    required this.uniqueID,
  });

  //Collection Name : user-data

  static String getDocumentID() =>
      documentID != null ? documentID! : 'NO DOCUMENT ID AVAILABLE';

  //Add user's data into user-data collection on registeration
  static void addUserData(Map<String, dynamic> userData) {
    _firestore.collection('user-data').doc().set(userData);
  }

  static Future<String> getUserPhoneNumber(String userUID) async {
    QuerySnapshot<Map<String, dynamic>> resultOfQuery = await _firestore
        .collection('user-data')
        .where("uniqueID", isEqualTo: userUID)
        .get()
        .then((value) => value,
            onError: (e) =>
                print('Error in getting user with given UID $userUID'));

    var userData = resultOfQuery.docs.first.data();

    return userData["phoneNumber"];
  }

  //Read user's data from firestore user-data collection
  static Future<Map<String, dynamic>> readDBUserData() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    //as we use provider in main.dart this method is was being called on the last active user who had used this app
    //and not on the current user loggin into this app

    final userDataRef =
        _firestore.collection('user-data'); //path to user-data collection

    final readQuery =
        _firestore.collection('user-data').where("uniqueID", isEqualTo: uid);
    //I need to find a document where either email = email or I could use userID for unique identification
    //currently I am using UID for identification though in case required it can be changed to email

    final resultQuerySnapshot = await readQuery.get().then(
          (resultOfQuery) => resultOfQuery,
          onError: (error) => print('error $error'),
        ); //executing query
    //resultQuerySnapshot.docs[0].exists = true if document for given user exists which it will until and unless there has been some error during registeration

    var userDataMap =
        resultQuerySnapshot.docs[0].data(); //all the user's data is stored here

    documentID =
        resultQuerySnapshot.docs.first.id; //document ID of user's data document

    userDataMap["documentID"] =
        documentID; //adding document ID field into data map

    return userDataMap;
  }

  //1 UPDATE function for each field available
  //because: it would be more time consuming and inefficient in case we re-write whole document each time we go for updating it

  static void updateDBGender(String newGender) {
    //We only need to update "gender" field and not others
    //get ref for specific document of currentUser
    //update document at that given ref
    final currentUserDocRef = _firestore
        .collection("user-data")
        .doc(documentID); // first we need to get reference to that document

    currentUserDocRef.update({"gender": newGender}).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

  static void updateDBOrganizationName(String newOrganization) {
    final currentUserDocRef = _firestore
        .collection("user-data")
        .doc(documentID); // first we need to get reference to that document

    currentUserDocRef.update({"organizationName": newOrganization}).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

  static void updateDBphoneNumber(String newPhoneNumber) {
    final currentUserDocRef = _firestore
        .collection("user-data")
        .doc(documentID); // first we need to get reference to that document

    currentUserDocRef.update({"phoneNumber": newPhoneNumber}).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

  static void updateDBUserEmail(String newEmail) {
    final currentUserDocRef = _firestore
        .collection("user-data")
        .doc(documentID); // first we need to get reference to that document

    currentUserDocRef.update({"userEmail": newEmail}).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

  static void updateDBUsername(String newUsername) {
    //updated Data Map which we need to put into firestore

    //We only need to update "userName" field and not others
    final currentUserDocRef = _firestore
        .collection("user-data")
        .doc(documentID); // first we need to get reference to that document

    currentUserDocRef.update({"userName": newUsername}).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }
}

//add Account deletion feature (later)
