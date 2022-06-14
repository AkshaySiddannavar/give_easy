import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/components/input_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:give_easy/screens/home_screen.dart';

class RegisterationScreen extends StatefulWidget {
  static const String id = 'Registeration_screen';
  const RegisterationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final FirebaseAuth _auth = FirebaseAuth
      .instance; //The entry point of the Firebase Authentication SDK
  late String email, password, userName, phoneNumber;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  //TODO add some grey text saying that given name will be used a display name and also used in records of donations made by you
                  //TODO add some grey text saying prefer using your actual name
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 3.0),
                    child: InputTextField(
                      type: TextInputType.name,
                      hintMessage: 'Enter User Name',
                      isSensitive: false,
                      currentTextCallback: (value) {
                        //update User Name
                        userName = value;
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
                          groupValue: selectedGender,
                          onChanged: (maleSelected) {
                            selectedGender = maleSelected.toString();
                            print(maleSelected);
                            setState(() {});
                          }),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: RadioListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                          visualDensity: VisualDensity.compact,
                          title: Text(
                            'Female',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          value: 'Female',
                          groupValue: selectedGender,
                          onChanged: (femaleSelected) {
                            selectedGender = femaleSelected.toString();
                            print(femaleSelected);
                            setState(() {});
                          }),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: RadioListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                          visualDensity: VisualDensity.compact,
                          title: Text(
                            'Other',
                            style: TextStyle(fontSize: 15),
                          ),
                          value: 'Other',
                          groupValue: selectedGender,
                          onChanged: (otherSelected) {
                            selectedGender = otherSelected.toString();
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
                        phoneNumber = value;
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
                        email = value;
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
                      var currentUserCredentials =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      /*
                      If the new account was created successfully, the user is also signed in. 
                      If you are listening to changes in authentication state, a new event will be sent to your listeners.
                      source: https://firebase.flutter.dev/docs/auth/password-auth
                      */

                      Navigator.pushNamed(context, HomeScreen.id);
                    } catch (e) {
                      print('error message is $e');
                    }
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
