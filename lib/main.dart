import 'package:flutter/material.dart';
import 'package:give_easy/screens/all_screens.dart';

void main() {
  runApp(const GiveEasy());
}

class GiveEasy extends StatelessWidget {
  const GiveEasy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LandingScreen.id,
      routes: {
        LandingScreen.id: (context) => LandingScreen(),
        LoginScreen.id: ((context) => LoginScreen())
      },
      // home: LandingScreen(),
      // routes: {
      //   '/login' : Login.id,
      //   '/Registeration' : Registeration.id,
      //   '/HomePage' : HomePage.id,
      //   '/SpecificDonation' : SpecificDonation.id,
      //   '/Payment' : Payment.id,
      //   '/ThankYou' : ThankYou.id,
      // },
    );
  }
}
