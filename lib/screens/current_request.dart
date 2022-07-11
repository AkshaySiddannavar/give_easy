import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/request_data_API/request_data_firestore_api.dart';

class CurrentRequestScreen extends StatefulWidget {
  static const String id = 'current_request_screen';
  const CurrentRequestScreen({Key? key}) : super(key: key);

  @override
  State<CurrentRequestScreen> createState() => _CurrentRequestScreenState();
}

class _CurrentRequestScreenState extends State<CurrentRequestScreen> {
  late Widget listViewOfActiveRequests = Container();

  static String userID = FirebaseAuth.instance.currentUser!.uid;

  Future<Widget> renderActiveRequests() async {
    List listOfInactiveRequests = await RequestDataAPI.getActiveRequests(
        userID); //list of 'inactive' documents

    String requestName, goalAmount, collectedAmount;
    Map requestData;
    listViewOfActiveRequests = ListView.builder(
      itemBuilder: ((context, index) {
        requestData = listOfInactiveRequests[index].data();
        requestName = requestData["title"];
        goalAmount = requestData["goalAmount"].toString();
        collectedAmount = (requestData["collectedAmount"] == -1)
            ? '0'
            : requestData["collectedAmount"].toString();

        return ListTile(
          leading: Text('Name:\n$requestName'),
          title: Text('Goal Amount:\n$goalAmount'),
          trailing: Text('Collected Amount:\n$collectedAmount'),
        );
      }),
      itemCount: listOfInactiveRequests.length,
    );

    return listViewOfActiveRequests;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Current Requests')),
      body: FutureBuilder(
          future: renderActiveRequests(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('error'));
            } else {
              return listViewOfActiveRequests;
            }
          }),
    );
  }
}
