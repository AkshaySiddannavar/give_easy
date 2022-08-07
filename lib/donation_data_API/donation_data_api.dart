import 'package:cloud_firestore/cloud_firestore.dart';

// This will act as an API for working with user-donation-data collection in firestore

class DonationDataAPI {
  //add for now

  static final _firestore = FirebaseFirestore.instance;

  static void addDonationEntry(
      String donationTitle, double donationAmount, String UID) {
    _firestore
        .collection('/user-donation-data')
        .add({"title": donationTitle, "amount": donationAmount, "UID": UID});
  }

  static Future<List> getDonationsByUID(String UID) async {
    var queryByUID = await _firestore
        .collection('/user-donation-data')
        .where("UID", isEqualTo: UID)
        .get()
        .then((value) => value, onError: (error) => print('Error is $error'));

    List donationsByUID = queryByUID.docs;

    return donationsByUID;
  }
}
