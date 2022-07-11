//* This class will act like an API which will let our app interact with specific-request-data collection in firebase
//* implement all firebase firestore operations/triggering cloud functions for specific-request-data collection here

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RequestDataAPI {
  static final _firestore = FirebaseFirestore
      .instance; //In case we feel this isn't the best practice we can create a firestore instance in each method

  //We collection : specific-request-data
  //Unique segregator : UID of creator
  static Future<List> getInactiveRequests(String userUniqueID) async {
    final readInactiveRequestsQuery = _firestore
        .collection('specific-request-data')
        .where("creator", isEqualTo: userUniqueID)
        .where("status", isEqualTo: 'inactive');

    final resultOfQuery = await readInactiveRequestsQuery
        .get()
        .then((value) => value, onError: (e) => print(e));

    List<dynamic> listOfInactiveRequestDocuments =
        resultOfQuery.docs; //list of documents in snapshot

    return listOfInactiveRequestDocuments;
  }

  static Future<List> getActiveRequests(String userUniqueID) async {
    final readActiveRequestsQuery = _firestore
        .collection('specific-request-data')
        .where("creator", isEqualTo: userUniqueID)
        .where("status", isEqualTo: 'active');

    final resultOfQuery = await readActiveRequestsQuery
        .get()
        .then((value) => value, onError: (e) => print(e));

    List<dynamic> listOfActiveRequestDocuments =
        resultOfQuery.docs; //list of documents in snapshot

    return listOfActiveRequestDocuments;
  }
}
