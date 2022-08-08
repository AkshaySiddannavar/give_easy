import 'package:cloud_firestore/cloud_firestore.dart';

class InformationDataAPI {
  static final _firestore = FirebaseFirestore.instance;

  static Future<String> getInformation(String title) async {
    QuerySnapshot<Map<String, dynamic>> informationQuerySnapshot =
        await _firestore
            .collection('app-specific-terminology')
            .where("title", isEqualTo: title)
            .get()
            .then((value) => value, onError: (error) => print(error));

    var informationDocument = informationQuerySnapshot.docs.first;
    Map informationContent = informationDocument.data();

    return informationContent["description"];
  }
}
