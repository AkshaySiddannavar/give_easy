import 'package:flutter/material.dart';
import 'package:give_easy/constants.dart';
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
        // backgroundColor: Color(0xFF00FFA4), //change later if required
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: setDescription(widget.title),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${widget.title.substring(0, 1).toUpperCase() + widget.title.substring(1)}',
                        style: TextStyle(
                          fontSize: 50,
                          color: kGiveEasyGreen,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                      child: SizedBox(
                    height: 50,
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 30,
                        color: kGiveEasyGreen,
                      ),
                    ),
                  ),
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
