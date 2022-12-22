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
        color: Colors.black,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
                fit: FlexFit.loose,
                child: Text(
                  'Thanks A Lot\nFor Your Loving Donation! 😄',
                  style: kDarkAppBarTextStyle.copyWith(fontSize: 35),
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: 30.0,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'We at ${ngoName} are really grateful to you for this generous donation.',
                  style: kDarkAppBarTextStyle.copyWith(fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: kDarkThemeTaglineWidget,
            ),
            ActionButton(
              buttonText: 'Go Back To Home',
              buttonActionCallback: () {
                Navigator.pushNamed(context, HomeScreen.id);
              },
              textColor: Colors.black,
              buttonColor: kGiveEasyGreen,
            ),
          ],
        ),
      ),
    );
  }
}
