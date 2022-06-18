//* Sometimes this class will be more useful and sometimes using _auth instance would be better
//* This class will act like an API which will let our app interact with user-data collection in firebase
//* implement all firebase firestore operations/triggering cloud functions for user-data collection here

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataFirestoreAPI {
  String gender;
  String organizationName;
  String phoneNumber;
  String userEmail;
  String userName;
  String uniqueID;
  UserDataFirestoreAPI(
      {required this.userName,
      required this.phoneNumber,
      this.organizationName = '', //empty string means no organization
      required this.gender,
      required this.userEmail,
      required this.uniqueID});

  //Collection Name : user-data

  //Add user's data into user-data collection on registeration

  void addUserData() {
    Map<String, dynamic> userData = {
      "gender": gender,
      "organizationName": organizationName,
      "phoneNumber": phoneNumber,
      "userEmail": userEmail,
      "userName": userName,
      "uniqueID": uniqueID,
    };

    var _firestore = FirebaseFirestore.instance;
    _firestore.collection('user-data').doc().set(userData);
  }

  //Read user's data from firestore user-data collection
  static Future<Map<String, dynamic>> readUserData() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;

    var _firestore = FirebaseFirestore.instance;

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

    return userDataMap;
  }
}

//add Account deletion feature (later)
