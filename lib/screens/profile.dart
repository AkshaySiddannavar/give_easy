import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/components/profile_element_tile.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/screens/profile_edit_screens/email_edit.dart';
import 'package:give_easy/screens/profile_edit_screens/gender_edit.dart';
import 'package:give_easy/screens/profile_edit_screens/organization_edit.dart';
import 'package:give_easy/screens/profile_edit_screens/phone_number_edit.dart';
import 'package:give_easy/screens/profile_edit_screens/username_edit.dart';
import 'package:give_easy/user_data/user_data_change_notifier.dart';
import 'package:give_easy/user_data/user_data_firestore_api.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //Profile screen done only edit parts are remaining

  final _auth = FirebaseAuth.instance;
  static final currentUserUID = FirebaseAuth.instance.currentUser!.uid;
  final _formKey = GlobalKey<FormState>();

  String userImageInitials = ''; //To render in circleAvatar

  static String username = 'Loading...';
  //We are using static vairable to overcome "implicit_this_reference_in_initializer"
  //Since we aren't using object of profile-screen-state at many places this can be done without having any side effects

  static int getUsernameLength() => username.length;

  int lengthOfUsername = getUsernameLength();
  //This works because both username and getUsernameLength() are static
  //Dart doesn't allow us to define instance members which depend on other instance members
  //it gives error msg : implicit_this_reference_in_initializer
  //Becuase, those both properties will be initialized in constructor when the object gets created
  //How can one be dependent on other when we're not even sure of it being created

  void renderUserImageInitials() {
    username = Provider.of<UserData>(context)
        .profileData["userName"]
        .toString(); //re-initializing username to actual value

    lengthOfUsername = getUsernameLength(); //setting length variable

    userImageInitials = username.substring(0, 1).toUpperCase() +
        username
            .substring(lengthOfUsername - 1)
            .toUpperCase(); //setting initials to be displayed on profile screen
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    renderUserImageInitials();
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 5.0,
          ),
          Consumer<UserData>(
            builder: (context, value, child) => Expanded(
              child: CircleAvatar(
                //profile picture(later if time permits) or initials
                radius: 55.0,
                backgroundColor: Color.fromARGB(
                    245,
                    (lengthOfUsername / (lengthOfUsername - 1) * 10).toInt(),
                    (lengthOfUsername / (lengthOfUsername - 3) * 50).toInt(),
                    (lengthOfUsername / (lengthOfUsername - 2) * 95).toInt()),
                child: Text(
                  userImageInitials,
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          //All widgets are wrapped in expanded widget
          //Because otherwise an overflow exception was being generated
          //When user tapped on update button in respective edit screen
          Expanded(
            child: ProfileElementTile(
                profileElementName: 'Username',
                profileElementValue: username,
                onTap: () {
                  Navigator.pushNamed(context, UsernameEditScreen.id);
                }),
          ),
          Consumer<UserData>(
            builder: (context, value, child) => Expanded(
              child: ProfileElementTile(
                  profileElementName: 'Gender',
                  profileElementValue: value.profileData["gender"],
                  onTap: () {
                    Navigator.pushNamed(context, GenderEditScreen.id);
                  }),
            ),
          ),

          Consumer<UserData>(
            builder: (context, value, child) => Expanded(
              child: ProfileElementTile(
                  profileElementName: 'Organization\nName',
                  profileElementValue: value.profileData["organizationName"],
                  onTap: () {
                    Navigator.pushNamed(context, OrganizationEditScreen.id);
                  }),
            ),
          ),
          Consumer<UserData>(
            builder: (context, value, child) => Expanded(
              child: ProfileElementTile(
                  profileElementName: 'Your Email',
                  profileElementValue: value.profileData["userEmail"],
                  onTap: () {
                    Navigator.pushNamed(context, EmailEditScreen.id);
                  }),
            ),
          ),
          Consumer<UserData>(
            builder: (context, value, child) => Expanded(
              child: ProfileElementTile(
                  profileElementName: 'Phone\nNumber',
                  profileElementValue: value.profileData["phoneNumber"],
                  onTap: () {
                    Navigator.pushNamed(context, PhoneNumberEditScreen.id);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
