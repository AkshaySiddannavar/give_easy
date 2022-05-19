import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/components/input_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterationScreen extends StatefulWidget {
  static const String id = 'Registeration_screen';
  const RegisterationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final FirebaseAuth _auth = FirebaseAuth
      .instance; //The entry point of the Firebase Authentication SDK
  late String email, password;
  @override
  void initState() {
    super.initState();
  }

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
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                SizedBox(
                  height: 5.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                  buttonText: 'Register',
                  buttonActionCallback: () {
                    _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
