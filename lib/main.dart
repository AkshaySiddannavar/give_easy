import 'package:flutter/material.dart';
import 'package:give_easy/screens/all_screens.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        LoginScreen.id: (context) => LoginScreen(),
        RegisterationScreen.id: (context) => RegisterationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        SpecificDonationScreen.id: (context) => SpecificDonationScreen(),
        //add route to SpecificDonationScreen
        //becasue : - for easier debugging, for navigation from a preview card tap to respeective specific donation screen
      },
    );
  }
}
