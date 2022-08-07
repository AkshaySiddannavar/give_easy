import 'package:cloud_firestore/cloud_firestore.dart';

class DonationDataAPI {
  //add for now

  static final _firestore = FirebaseFirestore.instance;

  static void addDonationEntry(
      String donationTitle, double donationAmount, String UID) {
    _firestore
        .collection('/user-donation-data')
        .add({"title": donationTitle, "amount": donationAmount, "UID": UID});
  }
}
