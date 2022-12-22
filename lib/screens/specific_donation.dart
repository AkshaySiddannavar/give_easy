import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/components/title_tile.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/screens/payment_screen.dart';
//Gets title from PreviewCard
//Then fetches data from firestore and renders this screen
//Title should be unique, one to one title relation with a request (implement this constraint later on)

class SpecificDonationScreen extends StatefulWidget {
  static const id = "specific_donation_screen";

  final String donationTitle;
  final Image donationBackgroundImage;

  SpecificDonationScreen(
      {Key? key,
      this.donationTitle = 'NO DATA',
      this.donationBackgroundImage = kDefaultPreviewImage})
      : super(key: key);

  @override
  State<SpecificDonationScreen> createState() => _SpecificDonationScreenState();
}

class _SpecificDonationScreenState extends State<SpecificDonationScreen> {
  late var donationData;
  static final _firestore = FirebaseFirestore.instance;
  //later

  Future setDonationData(String title) async {
    //Sets the value of donationData variable

    print('donation data ran: \ntitle: $title');

    QuerySnapshot<Map<String, dynamic>>? donationDataQueryResult;

    try {
      donationDataQueryResult = await _firestore
          .collection("specific-request-data")
          .where("title", isEqualTo: title)
          .get()
          .then((value) {
        print('value assigned');
        return value;
      });
      //Executing query for collecting data for request having title same as given in paramters

    } catch (e) {
      print('Erroer roeoroeor \n$e\n*******************');
    }

    try {
      donationData = donationDataQueryResult!.docs.first;
    } catch (e) {
      print(
          'error in donation data docs initialzaiont\n*********$e**************');

      donationData = kDefaultRequestData;
      print(donationData);
    }

    print('ran wothout problems');

    return donationData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ActionButton(
        buttonText: 'Fund',
        textColor: Colors.black,
        buttonActionCallback: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                        organizationName: donationData["organizationName"],
                        donationDescriptionShort: (donationData["description"]
                                    .toString()
                                    .length >
                                40)
                            ? "${donationData["description"].toString().substring(0, 40)}..."
                            : donationData["description"],
                        donationTitle: donationData["title"],
                      )));
        },
        verticalPadding: 0.0,
        horizontalPadding: 0.0,
        buttonColor: kGiveEasyGreen,
      ),
      body: FutureBuilder(
          future: setDonationData(widget.donationTitle),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                      "Stack Trace ${snapshot.stackTrace.toString().split('')}"),
                  Text("Error ${snapshot.error.toString()}"),
                ],
              ));
            } else if (snapshot.hasData) {
              return Container(
                color: Colors.black,
                width: double.infinity,
                height: double.infinity,
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TitleTile(
                        title: donationData["title"],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: ListView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        children: [
                          Text(
                            donationData["description"],
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: kGiveEasyGreen),
                          ), //description ends
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Description Ends",
                            // 'Description ends\nnow it is your choice to support or not \n \n \n \n',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kGiveEasyGreen),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
