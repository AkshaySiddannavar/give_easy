import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_easy/donation_data_API/donation_data_api.dart';

import '../request_data_API/request_data_firestore_api.dart';

class YourGivesScreen extends StatefulWidget {
  static const String id = 'your_gives_screen';
  const YourGivesScreen({Key? key}) : super(key: key);

  @override
  State<YourGivesScreen> createState() => _YourGivesScreenState();
}

class _YourGivesScreenState extends State<YourGivesScreen> {
  Widget listViewOfUsersDonations = Container();

  static String userID = FirebaseAuth.instance.currentUser!.uid;

  Future<Widget> renderUserDonationData() async {
    List listOfUsersDonations = await DonationDataAPI.getDonationsByUID(userID);
    //list of documents where current user is donor
    int length = listOfUsersDonations.length;
    String requestName, donationAmount;
    Map requestData;

    listViewOfUsersDonations = ListView.builder(
      itemBuilder: ((context, index) {
        requestData = listOfUsersDonations[length - (index + 1)].data();
        requestName = requestData["title"];
        donationAmount = requestData["amount"].toString();

        return ListTile(
          leading: Text('Title:\n$requestName'),
          trailing: Text('Donated Amount:\n$donationAmount'),
        );
      }),
      itemCount: length,
    );

    return listViewOfUsersDonations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Gives')),
      body: FutureBuilder(
          future: renderUserDonationData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('error'));
            } else {
              return listViewOfUsersDonations;
            }
          }),
    );
  }
}
