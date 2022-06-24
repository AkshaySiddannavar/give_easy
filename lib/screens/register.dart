import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/components/input_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:give_easy/screens/home_screen.dart';
import 'package:give_easy/user_data/user_data_change_notifier.dart';
import 'package:give_easy/user_data/user_data_firestore_api.dart';
import 'package:provider/provider.dart';

class RegisterationScreen extends StatefulWidget {
  static const String id = 'Registeration_screen';
  const RegisterationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  static final FirebaseAuth _auth = FirebaseAuth
      .instance; //The entry point of the Firebase Authentication SDK

  late String password;

  Map<String, dynamic> newUserData = {
    "gender": 'NO DATA',
    "organizationName": 'NO DATA',
    "phoneNumber": 'NO DATA',
    "userEmail": 'NO DATA',
    "userName": 'NO DATA',
    "uniqueID": 'NO DATA',
  }; //This will be send to API

  //upload this user's data into cloud firestore using the user-data API

  //TODO: add constraints on fields(later)
  @override
  Widget build(BuildContext context) {
    return Consumer<userData>(
      builder: (context, userDataObject, child) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Hero(
                      tag: 'appIconTransition',
                      child: SizedBox(
                        height: 200.0,
                        child: Image.asset('assets/images/handshake.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Expanded(
                    //TODO: add some grey text saying that given name will be used a display name and also used in records of donations made by you
                    //TODO: add some grey text saying prefer using your actual name
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 3.0),
                      child: InputTextField(
                        type: TextInputType.name,
                        hintMessage: 'Enter User Name',
                        isSensitive: false,
                        currentTextCallback: (value) {
                          //update User Name
                          newUserData["userName"] = value;
                        },
                      ),
                    ),
                  ),
                  Text(
                    'Select Your Gender',
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 0.0),
                            visualDensity: VisualDensity.compact,
                            title: Text(
                              'Male',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            value: 'Male',
                            groupValue: newUserData["gender"],
                            onChanged: (maleSelected) {
                              newUserData["gender"] = maleSelected.toString();
                              print(maleSelected);
                              setState(() {});
                            }),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                            dense: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 5.0),
                            visualDensity: VisualDensity.compact,
                            title: Text(
                              'Female',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            value: 'Female',
                            groupValue: newUserData["gender"],
                            onChanged: (femaleSelected) {
                              newUserData["gender"] = femaleSelected.toString();
                              print(femaleSelected);
                              setState(() {});
                            }),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                            dense: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 5.0),
                            visualDensity: VisualDensity.compact,
                            title: Text(
                              'Other',
                              style: TextStyle(fontSize: 15),
                            ),
                            value: 'Other',
                            groupValue: newUserData["gender"],
                            onChanged: (otherSelected) {
                              newUserData["gender"] = otherSelected.toString();
                              print(otherSelected);
                              setState(() {});
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 3.0),
                      child: InputTextField(
                        type: TextInputType.phone,
                        hintMessage: 'Enter Phone Number',
                        isSensitive: false,
                        currentTextCallback: (value) {
                          newUserData["phoneNumber"] = value;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 3.0),
                      child: InputTextField(
                        type: TextInputType.emailAddress,
                        hintMessage: 'Enter Email',
                        isSensitive: false,
                        currentTextCallback: (value) {
                          newUserData["userEmail"] = value;
                          // print(email);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 3.0),
                      child: InputTextField(
                        hintMessage: 'Enter Password',
                        isSensitive: true,
                        currentTextCallback: (value) {
                          password = value;
                          // print(password);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ActionButton(
                    verticalPadding: 10.0,
                    horizontalPadding: 20.0,
                    buttonText: 'Register',
                    buttonActionCallback: () async {
                      try {
                        // ignore: unused_local_variable
                        var newUserCredentials =
                            await _auth.createUserWithEmailAndPassword(
                                email: newUserData["userEmail"],
                                password: password);

                        /*
                        If the new account was created successfully, the user is also signed in. 
                        If you are listening to changes in authentication state, a new event will be sent to your listeners.
                        source: https://firebase.flutter.dev/docs/auth/password-auth
                        */

                        newUserData["uniqueID"] = newUserCredentials.user!.uid;
                        //TODO make button inactive till user hasn't selected gender (later)

                        if (!mounted) {
                          //This will run when there's a problem in build context
                          //Problem - Mounted - False
                          //No Problem - Mounted - True

                          newUserData =
                              kDefaultUserData; //setting back to default value for easier debugging

                          return;
                        }

                        UserDataFirestoreAPI.addUserData(
                            newUserData); //adding user's data in firestore
                        userDataObject.profileData =
                            newUserData; //setting values locally

                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                      } catch (e) {
                        print('error message is $e');
                      }
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
