import 'package:flutter/material.dart';
import 'package:give_easy/information_data_API/information_data_api.dart';

class InformationScreen extends StatefulWidget {
  final String title;

  const InformationScreen({
    Key? key,
    this.title = 'NO TITLE',
  }) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  String description = 'NO DESCR';

  Future setDescription(String title) async {
    description = await InformationDataAPI.getInformation(title);

    return description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: setDescription(widget.title),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(description),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("Error is ${snapshot.error.toString()}");
            } else {
              return Text('none');
            }
          },
        ));
  }
}
