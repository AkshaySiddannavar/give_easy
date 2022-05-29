import 'package:flutter/material.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/screens/all_screens.dart';
import 'package:give_easy/constants.dart';

class ThankYouScreen extends StatelessWidget {
  static const String id = 'thank_you_screen';
  final String ngoName;
  const ThankYouScreen({Key? key, this.ngoName = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
                fit: FlexFit.loose,
                child: Text(
                  'Thanks A Lot\nFor Your Loving Donation! 😄',
                  style: TextStyle(fontSize: 40.0),
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: 30.0,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                'We at #${ngoName} are really grateful to you for this generous donation.',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: kTaglineWidget,
            ),
            ActionButton(
                buttonText: 'Go Back To Home',
                buttonActionCallback: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
