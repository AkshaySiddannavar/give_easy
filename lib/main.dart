import 'package:flutter/material.dart';
import 'package:give_easy/screens/all_screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:give_easy/screens/create_request.dart';
import 'package:give_easy/screens/current_request.dart';
import 'package:give_easy/screens/new_category_reuest.dart';
import 'package:give_easy/screens/past_requests.dart';
import 'package:give_easy/screens/payment_screen.dart';
import 'package:give_easy/screens/profile.dart';
import 'package:give_easy/screens/profile_edit_screens/email_edit.dart';
import 'package:give_easy/screens/profile_edit_screens/gender_edit.dart';
import 'package:give_easy/screens/profile_edit_screens/organization_edit.dart';
import 'package:give_easy/screens/profile_edit_screens/phone_number_edit.dart';
import 'package:give_easy/screens/profile_edit_screens/username_edit.dart';
import 'package:give_easy/screens/request_creation_success.dart';
import 'package:give_easy/screens/validation.dart';
import 'package:give_easy/screens/your_gives.dart';
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
        PaymentScreen.id: (context) => PaymentScreen(),
        ThankYouScreen.id: (context) => ThankYouScreen(),
        CreateRequestScreen.id: (context) => CreateRequestScreen(),
        CurrentRequestScreen.id: (context) => CurrentRequestScreen(),
        PastRequestsScreen.id: (context) => PastRequestsScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        ValidationScreen.id: (context) => ValidationScreen(),
        YourGivesScreen.id: (context) => YourGivesScreen(),
        NewCategoryRequestScreen.id: (context) => NewCategoryRequestScreen(),
        RequestCreationSuccessScreen.id: (context) =>
            RequestCreationSuccessScreen(),
        EmailEditScreen.id: (context) => EmailEditScreen(),
        GenderEditScreen.id: (context) => GenderEditScreen(),
        OrganizationEditScreen.id: (context) => OrganizationEditScreen(),
        PhoneNumberEditScreen.id: (context) => PhoneNumberEditScreen(),
        UsernameEditScreen.id: (context) => UsernameEditScreen(),
        //add route to
        //becasue : - for easier debugging, for navigation
      },
    );
  }
}
