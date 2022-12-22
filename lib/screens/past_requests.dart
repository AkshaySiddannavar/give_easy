import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/request_data_API/request_data_firestore_api.dart';

class PastRequestsScreen extends StatefulWidget {
  static const String id = 'past_requests_screen';
  const PastRequestsScreen({Key? key}) : super(key: key);

  @override
  State<PastRequestsScreen> createState() => _PastRequestsScreenState();
}

class _PastRequestsScreenState extends State<PastRequestsScreen> {
  late Widget listViewOfInactiveRequests = Container();

  static String userID = FirebaseAuth.instance.currentUser!.uid;

  Future<Widget> renderInactiveRequests() async {
    List listOfInactiveRequests = await RequestDataAPI.getInactiveRequests(
        userID); //list of 'inactive' documents

    String requestName, goalAmount, collectedAmount;
    Map requestData;
    listViewOfInactiveRequests = ListView.builder(
      itemBuilder: ((context, index) {
        requestData = listOfInactiveRequests[index].data();
        requestName = requestData["title"];
        goalAmount = requestData["goalAmount"].toString();
        collectedAmount = (requestData["collectedAmount"] == -1)
            ? '0'
            : requestData["collectedAmount"].toString();

        return ListTile(
          leading: Text(
            'Name:\n$requestName'.substring(0, 13),
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          title: Text(
            'Goal Amount:\n$goalAmount',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          trailing: Text(
            'Collected Amount:\n$collectedAmount',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        );
      }),
      itemCount: listOfInactiveRequests.length,
    );

    return listViewOfInactiveRequests;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGiveEasyGreen,
      appBar: AppBar(
          backgroundColor: kDarkAppBarBackgroundColor,
          title: Text(
            'Past Requests',
            style: kDarkAppBarTextStyle,
          )),
      body: FutureBuilder(
          future: renderInactiveRequests(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('error'));
            } else {
              return listViewOfInactiveRequests;
            }
          }),
    );
  }
}
