import 'package:flutter/material.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/components/title_tile.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/screens/payment_screen.dart';

class SpecificDonationScreen extends StatelessWidget {
  static const id = "specific_donation_screen";
  final String donationTitle;
  final String donationDescription;
  final Image donationBackgroundImage;
  const SpecificDonationScreen(
      {Key? key,
      this.donationTitle = 'no title given',
      this.donationDescription = 'no description given',
      this.donationBackgroundImage = kDefaultPreviewImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ActionButton(
        buttonText: 'Fund',
        buttonActionCallback: () {
          Navigator.pushNamed(context, PaymentScreen.id);
        },
        verticalPadding: 0.0,
        horizontalPadding: 0.0,
        buttonColor: Colors.greenAccent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        //   color: Colors.amber,
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: TitleTile(
                title: donationTitle,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: ListView(
                children: [
                  Text(
                    donationDescription,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Description ends\nnow it is your choice to support or not \n \n \n \n',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
