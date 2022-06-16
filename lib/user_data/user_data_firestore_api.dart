//* Sometimes this class will be more useful and sometimes using _auth instance would be better
//* This class will act like an API which will let our app interact with user-data collection in firebase
//* implement all firebase firestore operations/triggering cloud functions for user-data collection here

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataFirestoreAPI {
  String gender;
  String organizationName;
  String phoneNumber;
  String userEmail;
  String userName;

  UserDataFirestoreAPI(
      {required this.userName,
      required this.phoneNumber,
      this.organizationName = '', //empty string means no organization
      required this.gender,
      required this.userEmail});

  //Collection Name : user-data

  //Add user's data into user-data collection on registeration

  void addUserData() {
    Map<String, dynamic> userData = {
      "gender": gender,
      "organizationName": organizationName,
      "phoneNumber": phoneNumber,
      "userEmail": userEmail,
      "userName": userName,
    };

    var _firestore = FirebaseFirestore.instance;
    _firestore.collection('user-data').doc().set(userData);

    print("**************\n ${userData}\n******* UPLOADED");
  }

  //TODO: Read user's data from firestore user-data collection
  void readUserData() {
    var _firestore = FirebaseFirestore.instance;
    // _firestore.collection('user-data').doc(); I need to find a document where either email = email or I could use userID for unique identification

    // print("**************\n ${}\n******* UPLOADED");
  }
}

//TODO add Account deletion feature (later)
